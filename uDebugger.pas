unit uDebugger;

{$I SynEdit.inc}

interface

uses
  Windows, Classes;

type
  TDebuggerState = (dsStopped, dsRunning, dsPaused);

  TDebuggerLineInfo = (dlCurrentLine, dlBreakpointLine, dlExecutableLine);
  TDebuggerLineInfos = set of TDebuggerLineInfo;

  TBreakpointChangeEvent = procedure(Sender: TObject; ALine: integer) of object;
  TDebuggerStateChangeEvent = procedure(Sender: TObject;
    OldState, NewState: TDebuggerState) of object;

  TDebugger = class(TObject)
  private
    fBreakpoints: TList;
    fCurrentLine: integer;
    fDebuggerState: TDebuggerState;
    fLineToStop: integer;
    fNextInstruction: integer;
    fWantedState: TDebuggerState;
    fOnBreakpointChange: TBreakpointChangeEvent;
    fOnCurrentLineChange: TNotifyEvent;
    fOnStateChange: TDebuggerStateChangeEvent;
    fOnYield: TNotifyEvent;
    function CurrentLineIsBreakpoint: boolean;
    procedure DoOnBreakpointChanged(ALine: integer);
    procedure DoCurrentLineChanged;
    procedure DoStateChange;
    procedure DoYield;
  public
    constructor Create;
    destructor Destroy; override;

    function CanGotoCursor(ALine: integer): boolean;
    function CanPause: boolean;
    function CanRun: boolean;
    function CanStep: boolean;
    function CanStop: boolean;
    procedure ClearAllBreakpoints;
    function GetLineInfos(ALine: integer): TDebuggerLineInfos;
    procedure GotoCursor(ALine: integer);
    function HasBreakpoints: boolean;
    function IsBreakpointLine(ALine: integer): boolean;
    function IsExecutableLine(ALine: integer): boolean;
    function IsRunning: boolean;
    procedure Pause;
    procedure Run;
    procedure Step;
    procedure Stop;
    procedure ToggleBreakpoint(ALine: integer);
  public
    property CurrentLine: integer read fCurrentLine;
    property OnBreakpointChange: TBreakpointChangeEvent read fOnBreakpointChange
      write fOnBreakpointChange;
    property OnCurrentLineChange: TNotifyEvent read fOnCurrentLineChange
      write fOnCurrentLineChange;
    property OnStateChange: TDebuggerStateChangeEvent read fOnStateChange
      write fOnStateChange;
    property OnYield: TNotifyEvent read fOnYield write fOnYield;
  end;

const
  SampleSource =
{  1 }  'program Test;'#13#10 +
{  2 }  ''#13#10 +
{  3 }  'procedure TestProc;'#13#10 +
{  4 }  'begin'#13#10 +
{  5 }  '  DoNothing;'#13#10 +
{  6 }  'end;'#13#10 +
{  7 }  ''#13#10 +
{  8 }  'var'#13#10 +
{  9 }  '  i: integer;'#13#10 +
{ 10 }  ''#13#10 +
{ 11 }  'begin'#13#10 +
{ 12 }  '  while TRUE do'#13#10 +
{ 13 }  '    TestProc;'#13#10 +
{ 14 }  'end.';

type
  TSampleExecutableLine = record
    Line: integer;
    Delta: integer; // to change the array index
  end;

const
  SampleCode: array[0..7] of TSampleExecutableLine = (
    (Line: 11; Delta: 1), (Line: 12; Delta: 1),
    (Line: 13; Delta: 1), (Line:  4; Delta: 1),
    (Line:  5; Delta: 1), (Line:  6; Delta: -4),
    (Line: 14; Delta: 1), (Line: -1; Delta: 0));
  ExecutableLines: array[0..6] of integer = (4, 5, 6, 11, 12, 13, 14);

implementation

{ TDebugger }

constructor TDebugger.Create;
begin
  inherited Create;
  fBreakpoints := TList.Create;
  fCurrentLine := -1;
  fDebuggerState := dsStopped;
  fNextInstruction := Low(SampleCode);
end;

destructor TDebugger.Destroy;
begin
  fBreakpoints.Free;
  inherited Destroy;
end;

function TDebugger.CanGotoCursor(ALine: integer): boolean;
begin
  Result := (fDebuggerState <> dsRunning) and IsExecutableLine(ALine);
end;

function TDebugger.CanPause: boolean;
begin
  Result := fDebuggerState = dsRunning;
end;

function TDebugger.CanRun: boolean;
begin
  Result := fDebuggerState <> dsRunning;
end;

function TDebugger.CanStep: boolean;
begin
  Result := fDebuggerState <> dsRunning;
end;

function TDebugger.CanStop: boolean;
begin
  Result := fDebuggerState <> dsStopped;
end;

function TDebugger.CurrentLineIsBreakpoint: boolean;
begin
  Result := (fCurrentLine = fLineToStop)
    or ((fBreakpoints.Count > 0) and IsBreakpointLine(fCurrentLine));
end;

procedure TDebugger.DoOnBreakpointChanged(ALine: integer);
begin
  if Assigned(fOnBreakpointChange) then
    fOnBreakpointChange(Self, ALine);
end;

procedure TDebugger.DoCurrentLineChanged;
begin
  if Assigned(fOnCurrentLineChange) then
    fOnCurrentLineChange(Self);
end;

procedure TDebugger.DoStateChange;
begin
  if fDebuggerState <> fWantedState then begin
    if fWantedState = dsStopped then
      fCurrentLine := -1;
    if Assigned(fOnStateChange) then
      fOnStateChange(Self, fDebuggerState, fWantedState);
    fDebuggerState := fWantedState;
    if fWantedState <> dsRunning then
      fLineToStop := -1;
    DoCurrentLineChanged;
  end;
end;

procedure TDebugger.DoYield;
begin
  if Assigned(fOnYield) then
    fOnYield(Self);
end;

procedure TDebugger.ClearAllBreakpoints;
begin
  if fBreakpoints.Count > 0 then begin
    fBreakpoints.Clear;
    DoOnBreakpointChanged(-1);
  end;
end;

function TDebugger.GetLineInfos(ALine: integer): TDebuggerLineInfos;
begin
  Result := [];
  if ALine > 0 then begin
    if ALine = fCurrentLine then
      Include(Result, dlCurrentLine);
    if IsExecutableLine(ALine) then
      Include(Result, dlExecutableLine);
    if IsBreakpointLine(ALine) then
      Include(Result, dlBreakpointLine);
  end;
end;

procedure TDebugger.GotoCursor(ALine: integer);
begin
  fLineToStop := ALine;
  Run;
end;

function TDebugger.HasBreakpoints: boolean;
begin
  Result := fBreakpoints.Count > 0;
end;

function TDebugger.IsBreakpointLine(ALine: integer): boolean;
var
  i: integer;
begin
  Result := FALSE;
  if ALine > 0 then begin
    i := fBreakpoints.Count - 1;
    while i >= 0 do begin
      if integer(fBreakpoints[i]) = ALine then begin
        Result := TRUE;
        break;
      end;
      Dec(i);
    end;
  end;
end;

function TDebugger.IsExecutableLine(ALine: integer): boolean;
var
  i: integer;
begin
  Result := FALSE;
  if ALine > 0 then begin
    i := High(ExecutableLines);
    while i >= Low(ExecutableLines) do begin
      if ALine = ExecutableLines[i] then begin
        Result := TRUE;
        break;
      end;
      Dec(i);
    end;
  end;
end;

function TDebugger.IsRunning: boolean;
begin
  Result := fDebuggerState = dsRunning;
end;

procedure TDebugger.Pause;
begin
  if fDebuggerState = dsRunning then
    fWantedState := dsPaused;
end;

procedure TDebugger.Run;
var
  dwTime: DWORD;
begin
  fWantedState := dsRunning;
  DoStateChange;
  dwTime := GetTickCount + 100;
  repeat
    if GetTickCount >= dwTime then begin
      DoYield;
      dwTime := GetTickCount + 100;
    end;
    Step;
    if fWantedState <> fDebuggerState then
      DoStateChange;
  until fDebuggerState <> dsRunning;
  fLineToStop := -1;
end;

procedure TDebugger.Step;
begin
  if fDebuggerState = dsStopped then begin
    fNextInstruction := Low(SampleCode);
    fCurrentLine := SampleCode[fNextInstruction].Line;
    fWantedState := dsPaused;
    DoStateChange;
  end else begin
    Sleep(50);
    fNextInstruction := fNextInstruction + SampleCode[fNextInstruction].Delta;
    fCurrentLine := SampleCode[fNextInstruction].Line;
    case fDebuggerState of
      dsRunning:
        begin
          if CurrentLineIsBreakpoint then
            fWantedState := dsPaused;
        end;
    else
      DoCurrentLineChanged;
    end;
  end;
end;

procedure TDebugger.Stop;
begin
  fWantedState := dsStopped;
  DoStateChange;
end;

procedure TDebugger.ToggleBreakpoint(ALine: integer);
var
  SetBP: boolean;
  i: integer;
begin
  if ALine > 0 then begin
    SetBP := TRUE;
    for i := 0 to fBreakpoints.Count - 1 do begin
      if integer(fBreakpoints[i]) = ALine then begin
        fBreakpoints.Delete(i);
        SetBP := FALSE;
        break;
      end else if integer(fBreakpoints[i]) > ALine then begin
        fBreakpoints.Insert(i, pointer(ALine));
        SetBP := FALSE;
        break;
      end;
    end;
    if SetBP then
      fBreakpoints.Add(pointer(ALine));
    DoOnBreakpointChanged(ALine);
  end;
end;

end.

