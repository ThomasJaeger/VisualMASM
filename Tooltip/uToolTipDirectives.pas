unit uToolTipDirectives;

interface

uses
  Windows, Classes, Menus, ActnList, SysUtils, ShellApi, Forms, Registry,
  WinTypes, GraphUtil, Graphics, uHTML, uToolTipItem, uToolTip;

type
  TDirectives = class(TToolTip)
    private
      procedure Initialize;
      procedure CreateToolTips;
    public
      constructor Create; overload;
      constructor Create (Name: string); overload;
  end;

implementation

procedure TDirectives.Initialize;
begin
  CreateToolTips;
end;

constructor TDirectives.Create;
begin
  inherited Create;
  Initialize;
end;

constructor TDirectives.Create(Name: string);
begin
  inherited Create;
  Initialize;
end;

procedure TDirectives.CreateToolTips;
var
  toolTipItem: TToolTipItem;
begin
  toolTipItem := TToolTipItem.Create('.386','');
  toolTipItem.Text := TokenTitle(toolTipItem.Token)+
              'Enables assembly of nonprivileged instructions for the 80386 processor;'+BR+
              'disables assembly of instructions introduced with later processors.'+BR2+
              'Also enables 80387 instructions.';
  FList.AddObject(toolTipItem.Token, toolTipItem);

  toolTipItem := TToolTipItem.Create('.code','');
  toolTipItem.Text := TokenTitle(toolTipItem.Token, '[[name]]')+
              'When used with .MODEL, indicates the start of a code segment.'+BR2+
              SubTitle('Parameters')+BR+
              TableHeader('Parameter        Description                                                                                        ')+
                          'name             Optional parameter that specifies the name of the code segment. The default name is _TEXT for tiny,'+BR+
                          '                 small, compact, and flat models. The default name is modulename_TEXT for other models.';
  FList.AddObject(toolTipItem.Token, toolTipItem);

  toolTipItem := TToolTipItem.Create('.data','');
  toolTipItem.Text := TokenTitle(toolTipItem.Token)+
              'When used with .MODEL, starts a near data segment for initialized data (segment name _DATA).';
  FList.AddObject(toolTipItem.Token, toolTipItem);

  toolTipItem := TToolTipItem.Create('.dosseg','');
  toolTipItem.Text := TokenTitle(toolTipItem.Token)+
              'Orders the segments according to the MS-DOS segment convention:'+BR+
              'CODE first, then segments not in DGROUP, and then segments in DGROUP.'+BR2+
              SubTitle('Remarks')+
              'The segments in DGROUP follow this order: segments not in BSS or STACK, then'+BR+
              'BSS segments, and finally STACK segments. Primarily used for ensuring'+BR+
              'CodeView support in MASM stand-alone programs. Same as DOSSEG.';
  FList.AddObject(toolTipItem.Token, toolTipItem);

  toolTipItem := TToolTipItem.Create('.model','');
  toolTipItem.Text := TokenTitle(toolTipItem.Token, 'memorymodel [[, langtype]] [[, stackoption]]')+
                      'Initializes the program memory model.'+BR2+
                      SubTitle('Parameters')+
                      '<i>memorymodel</i>'+BR+
                      INDENT+'Required parameter that determines the size of code and data pointers.'+BR2+
                      '<i>'+'langtype'+'</i>'+BR+
                      INDENT+'Optional parameter that sets the calling and naming conventions for procedures and public symbols.'+BR2+
                      '<i>'+'stackoption'+'</i>'+BR+
                      INDENT+'Optional parameter.'+BR+
                      INDENT+'stackoption is not used if memorymodel is FLAT.'+BR+
                      INDENT+'Specifying NEARSTACK groups the stack segment into a single physical segment (DGROUP) along with data. The stack segment register (SS) is assumed'+BR+
                      INDENT+'to hold the same address as the data segment register (DS). FARSTACK does not group the stack with DGROUP; thus SS does not equal DS.'+BR2+
                      SubTitle('Remarks')+
                      '.MODEL is not used in MASM for x64 (ml64.exe).'+BR+
                      'The following table lists the possible values for each parameter when targeting 16-bit and 32-bit platforms:'+BR2+
                      TableHeader('Parameter        32-bit values     16-bit values (support for earlier 16-bit development)')+
                      'memorymodel      FLAT              TINY, SMALL, COMPACT, MEDIUM, LARGE, HUGE, FLAT'+BR+
                      'stackoption      Not used          NEARSTACK, FARSTACK';
  FList.AddObject(toolTipItem.Token, toolTipItem);

  toolTipItem := TToolTipItem.Create('include','');
  toolTipItem.Text := TokenTitle(toolTipItem.Token, 'filename')+
                      'Inserts source code from the source file given by filename into the current source file during assembly.'+BR2+
                      SubTitle('Remarks')+
                      'The filename must be enclosed in angle brackets if it includes a backslash, semicolon, greater-than symbol,'+BR+
                      'less-than symbol, single quotation mark, or double quotation mark.';
  FList.AddObject(toolTipItem.Token, toolTipItem);

  toolTipItem := TToolTipItem.Create('includelib','');
  toolTipItem.Text := TokenTitle(toolTipItem.Token, 'libraryname')+
                      'Informs the linker that the current module should be linked with libraryname.'+BR2+
                      SubTitle('Remarks')+
                      'The libraryname must be enclosed in angle brackets if it includes a backslash, semicolon, greater-than symbol, less-than symbol,'+BR+
                      'single quotation mark, or double quotation mark.';
  FList.AddObject(toolTipItem.Token, toolTipItem);

  toolTipItem := TToolTipItem.Create('invoke','');
  toolTipItem.Text := TokenTitle(toolTipItem.Token, 'expression [[, arguments]]')+
                      'Calls the procedure at the address given by expression, passing the arguments on the stack or '+BR+
                      'in registers according to the standard calling conventions of the language type.'+BR2+
                      SubTitle('Remarks')+
                      'Each argument passed to the procedure may be an expression, a register pair, or an address expression'+BR+
                      '(an expression preceded by ADDR).';
  FList.AddObject(toolTipItem.Token, toolTipItem);

  toolTipItem := TToolTipItem.Create('local','');
  toolTipItem.Text := TokenTitle(toolTipItem.Token, 'localname [[, localname]]...')+
                      TokenTitle(toolTipItem.Token, 'label [[ [count ] ]] [[:type]] [[, label [[ [count] ]] [[type]]]]...')+
                      'In the first directive, within a macro, LOCAL defines labels that are unique to each instance of the macro.'+BR2+
                      SubTitle('Remarks')+
                      'In the second directive, within a procedure definition (PROC), LOCAL creates stack-based variables that exist for the duration'+BR+
                      'of the procedure. The label may be a simple variable or an array containing count elements.';
  FList.AddObject(toolTipItem.Token, toolTipItem);

  toolTipItem := TToolTipItem.Create('macro','');
  toolTipItem.Text := Usage('name MACRO [[parameter [[:REQ | :=default | :VARARG]]]]...')+FONT_NORMAL+
                      INDENT+Usage('statements')+
                      INDENT+Usage('ENDM [[value]]')+
                      'Marks a macro block called name and establishes parameter placeholders for arguments passed when the macro is called.'+BR2+
                      SubTitle('Remarks')+
                      'A macro function returns value to the calling statement.';
  FList.AddObject(toolTipItem.Token, toolTipItem);

  toolTipItem := TToolTipItem.Create('name','');
  toolTipItem.Text := TokenTitle(toolTipItem.Token, '')+
                      'Ignored.';
  FList.AddObject(toolTipItem.Token, toolTipItem);

  toolTipItem := TToolTipItem.Create('option','');
  toolTipItem.Text := TokenTitle(toolTipItem.Token, 'optionlist')+
                      'Enables and disables features of the assembler.'+BR2+
                      SubTitle('Remarks')+
                      'Available options include:'+BR2+
                      Table('CASEMAP      CASEMAP      DOTNAME      NODOTNAME')+
                      Table('NOEMULATOR   EPILOGUE     EXPR16       EXPR32')+
                      Table('LANGUAGE     LJMP         NOLJMP       M510')+
                      Table('NOM510       NOKEYWORD    NOSIGNEXTEND OFFSET')+
                      Table('OLDMACROS    NOOLDMACROS  OLDSTRUCTS   NOOLDSTRUCTS')+
                      Table('PROC         PROLOGUE     READONLY     NOREADONLY')+
                      Table('SCOPED       NOSCOPED     SEGMENT      SETIF2.')+
                      FONT_E+FONT_NORMAL+BR+
                      'The syntax for LANGUAGE is OPTION LANGUAGE:x, where x is one of C, SYSCALL, STDCALL, PASCAL, FORTRAN, or BASIC.'+BR+
                      'SYSCALL, PASCAL, FORTRAN, and BASIC are not supported with used with .MODEL FLAT.';
  FList.AddObject(toolTipItem.Token, toolTipItem);

  toolTipItem := TToolTipItem.Create('.startup','');
  toolTipItem.Text := TokenTitle(toolTipItem.Token)+
              'Generates program start-up code.';
  FList.AddObject(toolTipItem.Token, toolTipItem);
end;

end.
