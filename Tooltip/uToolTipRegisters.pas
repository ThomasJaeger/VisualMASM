unit uToolTipRegisters;

interface

uses
  Windows, Classes, Menus, ActnList, SysUtils, ShellApi, Forms, Registry,
  WinTypes, GraphUtil, Graphics, uHTML, uToolTipItem, uToolTip;

type
  TRegisters = class(TToolTip)
    private
      procedure Initialize;
      procedure CreateToolTips;
    public
      constructor Create; overload;
      constructor Create (Name: string); overload;
  end;

implementation

procedure TRegisters.Initialize;
begin
  CreateToolTips;
end;

constructor TRegisters.Create;
begin
  inherited Create;
  Initialize;
end;

constructor TRegisters.Create(Name: string);
begin
  inherited Create;
  Initialize;
end;

procedure TRegisters.CreateToolTips;
var
  toolTipItem: TToolTipItem;
begin
  toolTipItem := TToolTipItem.Create('al','');
  toolTipItem.Text := TitleRegister(toolTipItem.Token,'Accumulator, Low Half of AX')+
              '8-bit Register (1 Byte Size)'+BR2+
              'Accumulator for operands and results data, multiply/divide, string load & store'+BR+
              'Used in arithmetic operations.';
  FList.AddObject(toolTipItem.Token, toolTipItem);

  toolTipItem := TToolTipItem.Create('ah','');
  toolTipItem.Text := TitleRegister(toolTipItem.Token,'Accumulator, High Half of AX')+
              '8-bit Register (1 Byte Size)'+BR2+
              'Accumulator for operands and results data, multiply/divide, string load & store'+BR+
              'Used in arithmetic operations.';
  FList.AddObject(toolTipItem.Token, toolTipItem);

  toolTipItem := TToolTipItem.Create('ax','');
  toolTipItem.Text := TitleRegister(toolTipItem.Token,'Accumulator')+
              '16-bit Register'+BR2+
              'Accumulator for operands and results data, multiply/divide, string load & store'+BR+
              'Used in arithmetic operations.';
  FList.AddObject(toolTipItem.Token, toolTipItem);

  toolTipItem := TToolTipItem.Create('eax','');
  toolTipItem.Text := TitleRegister(toolTipItem.Token,'Accumulator')+
              '32-bit Register'+BR2+
              'Accumulator for operands and results data, multiply/divide, string load & store'+BR+
              'Used in arithmetic operations.';
  FList.AddObject(toolTipItem.Token, toolTipItem);

  toolTipItem := TToolTipItem.Create('rax','');
  toolTipItem.Text := TitleRegister(toolTipItem.Token,'Accumulator')+
              '64-bit Register'+BR2+
              'Accumulator for operands and results data, multiply/divide, string load & store'+BR+
              'Used in arithmetic operations.';
  FList.AddObject(toolTipItem.Token, toolTipItem);

  toolTipItem := TToolTipItem.Create('r0','');
  toolTipItem.Text := TitleRegister(toolTipItem.Token,'Accumulator')+
              '64-bit Register'+BR2+
              'Accumulator for operands and results data, multiply/divide, string load & store'+BR+
              'Used in arithmetic operations.';
  FList.AddObject(toolTipItem.Token, toolTipItem);

  toolTipItem := TToolTipItem.Create('bl','');
  toolTipItem.Text := TitleRegister(toolTipItem.Token,'Base, Low Half of BX')+
              '8-bit Register (1 Byte Size)'+BR2+
              'Pointer to data in the DS segment (when in segmented mode), index register for MOV';
  FList.AddObject(toolTipItem.Token, toolTipItem);

  toolTipItem := TToolTipItem.Create('bh','');
  toolTipItem.Text := TitleRegister(toolTipItem.Token,'Base, High Half of BX')+
              '8-bit Register (1 Byte Size)'+BR2+
              'Pointer to data in the DS segment (when in segmented mode), index register for MOV';
  FList.AddObject(toolTipItem.Token, toolTipItem);

  toolTipItem := TToolTipItem.Create('bx','');
  toolTipItem.Text := TitleRegister(toolTipItem.Token,'Base')+
              '16-bit Register'+BR2+
              'Pointer to data in the DS segment (when in segmented mode), index register for MOV';
  FList.AddObject(toolTipItem.Token, toolTipItem);

  toolTipItem := TToolTipItem.Create('ebx','');
  toolTipItem.Text := TitleRegister(toolTipItem.Token,'Base')+
              '32-bit Register'+BR2+
              'Pointer to data in the DS segment (when in segmented mode), index register for MOV';
  FList.AddObject(toolTipItem.Token, toolTipItem);

  toolTipItem := TToolTipItem.Create('rbx','');
  toolTipItem.Text := TitleRegister(toolTipItem.Token,'Base')+
              '64-bit Register'+BR2+
              'Pointer to data in the DS segment (when in segmented mode), index register for MOV';
  FList.AddObject(toolTipItem.Token, toolTipItem);

  toolTipItem := TToolTipItem.Create('r3','');
  toolTipItem.Text := TitleRegister(toolTipItem.Token,'Base')+
              '64-bit Register'+BR2+
              'Pointer to data in the DS segment (when in segmented mode), index register for MOV';
  FList.AddObject(toolTipItem.Token, toolTipItem);

  toolTipItem := TToolTipItem.Create('cl','');
  toolTipItem.Text := TitleRegister(toolTipItem.Token,'Counter, Low Half of CX')+
              '8-bit Register (1 Byte Size)'+BR2+
              'Counter for strings, loops, and shift/rotate operations';
  FList.AddObject(toolTipItem.Token, toolTipItem);

  toolTipItem := TToolTipItem.Create('ch','');
  toolTipItem.Text := TitleRegister(toolTipItem.Token,'Counter, High Half of CX')+
              '8-bit Register (1 Byte Size)'+BR2+
              'Counter for strings, loops, and shift/rotate operations';
  FList.AddObject(toolTipItem.Token, toolTipItem);

  toolTipItem := TToolTipItem.Create('cx','');
  toolTipItem.Text := TitleRegister(toolTipItem.Token,'Counter')+
              '16-bit Register'+BR2+
              'Counter for strings, loops, and shift/rotate operations';
  FList.AddObject(toolTipItem.Token, toolTipItem);

  toolTipItem := TToolTipItem.Create('ecx','');
  toolTipItem.Text := TitleRegister(toolTipItem.Token,'Counter')+
              '32-bit Register'+BR2+
              'Counter for strings, loops, and shift/rotate operations';
  FList.AddObject(toolTipItem.Token, toolTipItem);

  toolTipItem := TToolTipItem.Create('rcx','');
  toolTipItem.Text := TitleRegister(toolTipItem.Token,'Counter')+
              '64-bit Register'+BR2+
              'Counter for strings, loops, and shift/rotate operations';
  FList.AddObject(toolTipItem.Token, toolTipItem);

  toolTipItem := TToolTipItem.Create('r1','');
  toolTipItem.Text := TitleRegister(toolTipItem.Token,'Counter')+
              '64-bit Register'+BR2+
              'Counter for strings, loops, and shift/rotate operations';
  FList.AddObject(toolTipItem.Token, toolTipItem);

  toolTipItem := TToolTipItem.Create('dl','');
  toolTipItem.Text := TitleRegister(toolTipItem.Token, 'Data, Low Half of DX')+
              '8-bit Register (1 Byte Size)'+BR2+
              'I/O pointer, port address for IN and OUT, and arithmetic operations';
  FList.AddObject(toolTipItem.Token, toolTipItem);

  toolTipItem := TToolTipItem.Create('dh','');
  toolTipItem.Text := TitleRegister(toolTipItem.Token, 'Data, High Half of DX')+
              '8-bit Register (1 Byte Size)'+BR2+
              'I/O pointer, port address for IN and OUT, and arithmetic operations';
  FList.AddObject(toolTipItem.Token, toolTipItem);

  toolTipItem := TToolTipItem.Create('dx','');
  toolTipItem.Text := TitleRegister(toolTipItem.Token, 'Data')+
              '16-bit Register'+BR2+
              'I/O pointer, port address for IN and OUT, and arithmetic operations';
  FList.AddObject(toolTipItem.Token, toolTipItem);

  toolTipItem := TToolTipItem.Create('edx','');
  toolTipItem.Text := TitleRegister(toolTipItem.Token, 'Data')+
              '32-bit Register'+BR2+
              'I/O pointer, port address for IN and OUT, and arithmetic operations';
  FList.AddObject(toolTipItem.Token, toolTipItem);

  toolTipItem := TToolTipItem.Create('rdx','');
  toolTipItem.Text := TitleRegister(toolTipItem.Token, 'Data')+
              '64-bit Register'+BR2+
              'I/O pointer, port address for IN and OUT, and arithmetic operations';
  FList.AddObject(toolTipItem.Token, toolTipItem);

  toolTipItem := TToolTipItem.Create('r2','');
  toolTipItem.Text := TitleRegister(toolTipItem.Token, 'Data')+
              '64-bit Register'+BR2+
              'I/O pointer, port address for IN and OUT, and arithmetic operations';
  FList.AddObject(toolTipItem.Token, toolTipItem);

  toolTipItem := TToolTipItem.Create('si','');
  toolTipItem.Text := TitleRegister(toolTipItem.Token, 'Source')+
              '16-bit Register'+BR2+
              'Pointer to data in the segment pointed to by the DS register;'+BR+
              'source pointer for string operations;'+BR+
              'points to a source in stream operations';
  FList.AddObject(toolTipItem.Token, toolTipItem);

  toolTipItem := TToolTipItem.Create('esi','');
  toolTipItem.Text := TitleRegister(toolTipItem.Token, 'Source')+
              '32-bit Register'+BR2+
              'Pointer to data in the segment pointed to by the DS register;'+BR+
              'source pointer for string operations;'+BR+
              'points to a source in stream operations';
  FList.AddObject(toolTipItem.Token, toolTipItem);

  toolTipItem := TToolTipItem.Create('rsi','');
  toolTipItem.Text := TitleRegister(toolTipItem.Token, 'Source')+
              '64-bit Register'+BR2+
              'Pointer to data in the segment pointed to by the DS register;'+BR+
              'source pointer for string operations;'+BR+
              'points to a source in stream operations';
  FList.AddObject(toolTipItem.Token, toolTipItem);

  toolTipItem := TToolTipItem.Create('r6','');
  toolTipItem.Text := TitleRegister(toolTipItem.Token, 'Source')+
              '64-bit Register'+BR2+
              'Pointer to data in the segment pointed to by the DS register;'+BR+
              'source pointer for string operations;'+BR+
              'points to a source in stream operations';
  FList.AddObject(toolTipItem.Token, toolTipItem);

  toolTipItem := TToolTipItem.Create('di','');
  toolTipItem.Text := TitleRegister(toolTipItem.Token, 'Destination')+
              '16-bit Register'+BR2+
              'Pointer to data (or destination) in the segment pointed to by the ES register;'+BR+
              'destination pointer for string operations, memory array copying'+BR+
              'and setting far pointer addressing with the ES like video memory addressing or'+BR+
              'points to a destination in stream operations';
  FList.AddObject(toolTipItem.Token, toolTipItem);

  toolTipItem := TToolTipItem.Create('edi','');
  toolTipItem.Text := TitleRegister(toolTipItem.Token, 'Destination')+
              '32-bit Register'+BR2+
              'Pointer to data (or destination) in the segment pointed to by the ES register;'+BR+
              'destination pointer (Destination Index = DI) for string operations, memory array copying'+BR+
              'and setting far pointer addressing with the ES like video memory addressing or'+BR+
              'points to a destination in stream operations';
  FList.AddObject(toolTipItem.Token, toolTipItem);

  toolTipItem := TToolTipItem.Create('rdi','');
  toolTipItem.Text := TitleRegister(toolTipItem.Token, 'Destination')+
              '64-bit Register'+BR2+
              'Pointer to data (or destination) in the segment pointed to by the ES register;'+BR+
              'destination pointer (Destination Index = DI) for string operations, memory array copying'+BR+
              'and setting far pointer addressing with the ES like video memory addressing or'+BR+
              'points to a destination in stream operations';
  FList.AddObject(toolTipItem.Token, toolTipItem);

  toolTipItem := TToolTipItem.Create('r7','');
  toolTipItem.Text := TitleRegister(toolTipItem.Token, 'Destination')+
              '64-bit Register'+BR2+
              'Pointer to data (or destination) in the segment pointed to by the ES register;'+BR+
              'destination pointer (Destination Index = DI) for string operations, memory array copying'+BR+
              'and setting far pointer addressing with the ES like video memory addressing or'+BR+
              'points to a destination in stream operations';
  FList.AddObject(toolTipItem.Token, toolTipItem);

  toolTipItem := TToolTipItem.Create('sp','');
  toolTipItem.Text := TitleRegister(toolTipItem.Token, 'Stack Pointer')+
              '16-bit Register'+BR2+
              'Stack pointer (in the SS segment), points to the top of stack';
  FList.AddObject(toolTipItem.Token, toolTipItem);

  toolTipItem := TToolTipItem.Create('esp','');
  toolTipItem.Text := TitleRegister(toolTipItem.Token, 'Stack Pointer')+
              '32-bit Register'+BR2+
              'Stack pointer (in the SS segment), points to the top of stack';
  FList.AddObject(toolTipItem.Token, toolTipItem);

  toolTipItem := TToolTipItem.Create('rsp','');
  toolTipItem.Text := TitleRegister(toolTipItem.Token, 'Stack Pointer')+
              '64-bit Register'+BR2+
              'Stack pointer (in the SS segment), points to the top of stack';
  FList.AddObject(toolTipItem.Token, toolTipItem);

  toolTipItem := TToolTipItem.Create('r4','');
  toolTipItem.Text := TitleRegister(toolTipItem.Token, 'Stack Pointer')+
              '64-bit Register'+BR2+
              'Stack pointer (in the SS segment), points to the top of stack';
  FList.AddObject(toolTipItem.Token, toolTipItem);

  toolTipItem := TToolTipItem.Create('bp','');
  toolTipItem.Text := TitleRegister(toolTipItem.Token, 'Stack Base Pointer')+
              '16-bit Register'+BR2+
              'Pointer to data on the stack (in the SS segment, points to base (bottom) of the stack frame)';
  FList.AddObject(toolTipItem.Token, toolTipItem);

  toolTipItem := TToolTipItem.Create('ebp','');
  toolTipItem.Text := TitleRegister(toolTipItem.Token, 'Stack Base Pointer')+
              '32-bit Register'+BR2+
              'Pointer to data on the stack (in the SS segment, points to base (bottom) of the stack frame)';
  FList.AddObject(toolTipItem.Token, toolTipItem);

  toolTipItem := TToolTipItem.Create('rbp','');
  toolTipItem.Text := TitleRegister(toolTipItem.Token, 'Stack Base Pointer')+
              '64-bit Register'+BR2+
              'Pointer to data on the stack (in the SS segment, points to base (bottom) of the stack frame)';
  FList.AddObject(toolTipItem.Token, toolTipItem);

  toolTipItem := TToolTipItem.Create('r5','');
  toolTipItem.Text := TitleRegister(toolTipItem.Token, 'Stack Base Pointer')+
              '64-bit Register'+BR2+
              'Pointer to data on the stack (in the SS segment, points to base (bottom) of the stack frame)';
  FList.AddObject(toolTipItem.Token, toolTipItem);

  toolTipItem := TToolTipItem.Create('ip','');
  toolTipItem.Text := TitleRegister(toolTipItem.Token, 'Instruction Pointer (IP)')+
              '16-bit Register'+BR2+
              'The IP register points to the memory offset of the next instruction in the'+BR+
              'code segment (it points to the first byte of the instruction).'+BR+
              'The IP register cannot be accessed by the programmer directly.';
  FList.AddObject(toolTipItem.Token, toolTipItem);

  // http://programmersheaven.com/discussion/357735/get-the-value-of-eip#357740
  toolTipItem := TToolTipItem.Create('eip','');
  toolTipItem.Text := TitleRegister(toolTipItem.Token, 'Extra Instruction Pointer (EIP)')+
              '32-bit Register'+BR2+
              'The EIP register points to the memory offset of the next instruction in the'+BR+
              'code segment (it points to the first byte of the instruction).'+BR+
              'The EIP register cannot be accessed by the programmer directly.'+BR2+
              'To get the value of eip, you can try this:'+BR2+
              Table('get_eip: mov eax, [esp]')+
              Table('         ret')+BR+FONT_NORMAL+
              'Then, to get the value of EIP in EAX, simply:'+BR2+
              Table('         call get_eip');
  FList.AddObject(toolTipItem.Token, toolTipItem);

  toolTipItem := TToolTipItem.Create('cs','');
  toolTipItem.Text := TitleRegister(toolTipItem.Token, 'Code Segment')+
              '16-bit Segment'+BR2+
              'Pointer to the code. Machine instructions exist at some offset into a code segment.'+BR+
              'The segment address of the code segment of the currently executing instruction is contained in CS.'+BR2+
              SubTitle('Remarks')+
              'Most applications on most modern operating systems like Microsoft Windows use a memory model that points nearly'+BR+
              'all segment registers to the same place (and uses paging instead), effectively disabling their use.';
  FList.AddObject(toolTipItem.Token, toolTipItem);

  toolTipItem := TToolTipItem.Create('ds','');
  toolTipItem.Text := TitleRegister(toolTipItem.Token, 'Data Segment')+
              '16-bit Segment'+BR2+
              'Pointer to the data. Variables and other data exist at some offset into a data segment.'+BR+
              'There may be many data segments, but the CPU may only use one at a time, by placing the segment address of that segment in the register DS.'+BR2+
              SubTitle('Remarks')+
              'Most applications on most modern operating systems like Microsoft Windows use a memory model that points nearly'+BR+
              'all segment registers to the same place (and uses paging instead), effectively disabling their use.';
  FList.AddObject(toolTipItem.Token, toolTipItem);

  toolTipItem := TToolTipItem.Create('ss','');
  toolTipItem.Text := TitleRegister(toolTipItem.Token, 'Stack Segment')+
              '16-bit Segment'+BR2+
              'Pointer to the stack.'+BR2+
              SubTitle('Remarks')+
              'Most applications on most modern operating systems like Microsoft Windows use a memory model that points nearly'+BR+
              'all segment registers to the same place (and uses paging instead), effectively disabling their use.';
  FList.AddObject(toolTipItem.Token, toolTipItem);

  toolTipItem := TToolTipItem.Create('es','');
  toolTipItem.Text := TitleRegister(toolTipItem.Token, 'Extra Segment')+
              '16-bit Segment'+BR2+
              'Pointer to extra data. The extra segment is exactly that: a spare segment that may be used for specifying a location in memory.'+BR2+
              SubTitle('Remarks')+
              'Most applications on most modern operating systems like Microsoft Windows use a memory model that points nearly'+BR+
              'all segment registers to the same place (and uses paging instead), effectively disabling their use.';
  FList.AddObject(toolTipItem.Token, toolTipItem);
end;

end.
