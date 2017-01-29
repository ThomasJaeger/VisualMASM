unit uToolTipMnemonics;

interface

uses
  Windows, Classes, Menus, ActnList, SysUtils, ShellApi, Forms, Registry,
  WinTypes, GraphUtil, Graphics, uHTML, uToolTipItem, uToolTip;

type
  TMnemonics = class(TToolTip)
    private
      procedure Initialize;
      procedure CreateToolTips;
    public
      constructor Create; overload;
      constructor Create (Name: string); overload;
  end;

implementation

procedure TMnemonics.Initialize;
begin
  CreateToolTips;
end;

constructor TMnemonics.Create;
begin
  inherited Create;
  Initialize;
end;

constructor TMnemonics.Create(Name: string);
begin
  inherited Create;
  Initialize;
end;

procedure TMnemonics.CreateToolTips;
var
  toolTipItem: TToolTipItem;
begin
  toolTipItem := TToolTipItem.Create('aaa','');
  toolTipItem.Text := TitleMnemonic(toolTipItem.Token,'Ascii Adjust for Addition')+
              'Original 8086/8088 instruction'+BR2+
              SubTitle('Usage')+
              Table(TAB+'aaa')+BR+FONT_NORMAL+
              SubTitle('Modifies Flags')+
              Table(TAB+'AF CF (OF,PF,SF,ZF undefined)')+BR+FONT_NORMAL+
              SubTitle('Remarks')+
              'Changes contents of AL to valid unpacked decimal.'+BR+
              'The high order nibble is zeroed.';
  FList.AddObject(toolTipItem.Token, toolTipItem);

  toolTipItem := TToolTipItem.Create('aad','');
  toolTipItem.Text := TitleMnemonic(toolTipItem.Token,'Ascii Adjust for Division')+
              'Original 8086/8088 instruction'+BR2+
              SubTitle('Usage')+
              Table(TAB+'aad')+BR+FONT_NORMAL+
              SubTitle('Modifies Flags')+
              Table(TAB+'SF ZF PF (AF,CF,OF undefined)')+BR+FONT_NORMAL+
              SubTitle('Remarks')+
              'Used before dividing unpacked decimal numbers.'+BR+
              'Multiplies AH by 10 and the adds result into AL. Sets AH to zero.'+BR+
              'This instruction is also known to have an undocumented behavior.';
  FList.AddObject(toolTipItem.Token, toolTipItem);

  toolTipItem := TToolTipItem.Create('aam','');
  toolTipItem.Text := TitleMnemonic(toolTipItem.Token,'Ascii Adjust for Multiplication')+
              'Original 8086/8088 instruction'+BR2+
              SubTitle('Usage')+
              Table(TAB+'aam')+BR+FONT_NORMAL+
              SubTitle('Modifies Flags')+
              Table(TAB+'PF SF ZF (AF,CF,OF undefined)')+BR+FONT_NORMAL+
              SubTitle('Remarks')+
              'Used after multiplication of two unpacked decimal numbers, this'+BR+
              'instruction adjusts an unpacked decimal number. The high order'+BR+
              'nibble of each byte must be zeroed before using this instruction.'+BR+
              'This instruction is also known to have an undocumented behavior.';
  FList.AddObject(toolTipItem.Token, toolTipItem);

  toolTipItem := TToolTipItem.Create('aam','');
  toolTipItem.Text := TitleMnemonic(toolTipItem.Token,'Ascii Adjust for Subtraction')+
              'Original 8086/8088 instruction'+BR2+
              SubTitle('Usage')+
              Table(TAB+'aas')+BR+FONT_NORMAL+
              SubTitle('Modifies Flags')+
              Table(TAB+'AF CF (OF,PF,SF,ZF undefined)')+BR+FONT_NORMAL+
              SubTitle('Remarks')+
              'Corrects result of a previous unpacked decimal subtraction in AL.'+BR+
              'High order nibble is zeroed.';
  FList.AddObject(toolTipItem.Token, toolTipItem);

  toolTipItem := TToolTipItem.Create('adc','');
  toolTipItem.Text := TitleMnemonic(toolTipItem.Token,'Add With Carry')+
              'Original 8086/8088 instruction'+BR2+
              SubTitle('Usage')+
              Table(TAB+'adc'+TAB+'dest,src')+BR+FONT_NORMAL+
              SubTitle('Modifies Flags')+
              Table(TAB+'AF CF OF SF PF ZF')+BR+FONT_NORMAL+
              SubTitle('Remarks')+
              'Sums two binary operands placing the result in the destination.'+BR+
              'If CF is set, a 1 is added to the destination.';
  FList.AddObject(toolTipItem.Token, toolTipItem);

  toolTipItem := TToolTipItem.Create('add','');
  toolTipItem.Text := TitleMnemonic(toolTipItem.Token,'Arithmetic Addition')+
              'Original 8086/8088 instruction'+BR2+
              SubTitle('Usage')+
              Table(TAB+'add'+TAB+'dest,src')+BR+FONT_NORMAL+
              SubTitle('Modifies Flags')+
              Table(TAB+'AF CF OF PF SF ZF')+BR+FONT_NORMAL+
              SubTitle('Remarks')+
              'Adds "src" to "dest" and replacing the original contents of "dest".'+BR+
              'Both operands are binary.';
  FList.AddObject(toolTipItem.Token, toolTipItem);

  toolTipItem := TToolTipItem.Create('and','');
  toolTipItem.Text := TitleMnemonic(toolTipItem.Token,'Logical And')+
              'Original 8086/8088 instruction'+BR2+
              SubTitle('Usage')+
              Table(TAB+'and'+TAB+'dest,src')+BR+FONT_NORMAL+
              SubTitle('Modifies Flags')+
              Table(TAB+'CF OF PF SF ZF (AF undefined)')+BR+FONT_NORMAL+
              SubTitle('Remarks')+
              'Performs a logical AND of the two operands replacing the destination with the result.';
  FList.AddObject(toolTipItem.Token, toolTipItem);

  toolTipItem := TToolTipItem.Create('arpl','');
  toolTipItem.Text := TitleMnemonic(toolTipItem.Token,'Adjusted Requested Privilege Level of Selector')+
              '286+ protected mode'+BR2+
              SubTitle('Usage')+
              Table(TAB+'arpl'+TAB+'dest,src')+BR+FONT_NORMAL+
              SubTitle('Modifies Flags')+
              Table(TAB+'ZF')+BR+FONT_NORMAL+
              SubTitle('Remarks')+
              'Compares the RPL bits of "dest" against "src". If the RPL bits'+BR+
              'of "dest" are less than "src", the destination RPL bits are set'+BR+
              'equal to the source RPL bits and the Zero Flag is set. Otherwise'+BR+
              'the Zero Flag is cleared.';
  FList.AddObject(toolTipItem.Token, toolTipItem);

  toolTipItem := TToolTipItem.Create('bound','');
  toolTipItem.Text := TitleMnemonic(toolTipItem.Token,'Array Index Bound Check')+
              '80188+'+BR2+
              SubTitle('Usage')+
              Table(TAB+'bound'+TAB+'src,limit')+BR+FONT_NORMAL+
              SubTitle('Modifies Flags')+
              Table(TAB+'None')+BR+FONT_NORMAL+
              SubTitle('Remarks')+
              'Array index in source register is checked against upper and lower'+BR+
              'bounds in memory source. The first word located at "limit" is'+BR+
              'the lower boundary and the word at "limit+2" is the upper array bound.'+BR+
              'Interrupt 5 occurs if the source value is less than or higher than the source.';
  FList.AddObject(toolTipItem.Token, toolTipItem);

  toolTipItem := TToolTipItem.Create('bsf','');
  toolTipItem.Text := TitleMnemonic(toolTipItem.Token,'Bit Scan Forward')+
              '386+ only'+BR2+
              SubTitle('Usage')+
              Table(TAB+'bsf'+TAB+'dest,src')+BR+FONT_NORMAL+
              SubTitle('Modifies Flags')+
              Table(TAB+'ZF')+BR+FONT_NORMAL+
              SubTitle('Remarks')+
              'Scans source operand for first bit set. Sets ZF if a bit is found'+BR+
              'set and loads the destination with an index to first set bit. Clears'+BR+
              'ZF is no bits are found set. BSF scans forward across bit pattern'+BR+
              '(0-n) while BSR scans in reverse (n-0).';
  FList.AddObject(toolTipItem.Token, toolTipItem);

  toolTipItem := TToolTipItem.Create('bsr','');
  toolTipItem.Text := TitleMnemonic(toolTipItem.Token,'Bit Scan Reverse')+
              '386+ only'+BR2+
              SubTitle('Usage')+
              Table(TAB+'bsr'+TAB+'dest,src')+BR+FONT_NORMAL+
              SubTitle('Modifies Flags')+
              Table(TAB+'ZF')+BR+FONT_NORMAL+
              SubTitle('Remarks')+
              'Scans source operand for first bit set. Sets ZF if a bit is found'+BR+
              'set and loads the destination with an index to first set bit. Clears'+BR+
              'ZF is no bits are found set. BSF scans forward across bit pattern'+BR+
              '(0-n) while BSR scans in reverse (n-0).';
  FList.AddObject(toolTipItem.Token, toolTipItem);

  toolTipItem := TToolTipItem.Create('bt','');
  toolTipItem.Text := TitleMnemonic(toolTipItem.Token,'Bit Test')+
              '386+ only'+BR2+
              SubTitle('Usage')+
              Table(TAB+'bt'+TAB+'dest,src')+BR+FONT_NORMAL+
              SubTitle('Modifies Flags')+
              Table(TAB+'CF')+BR+FONT_NORMAL+
              SubTitle('Remarks')+
              'The destination bit indexed by the source value is copied into the Carry Flag.';
  FList.AddObject(toolTipItem.Token, toolTipItem);

  toolTipItem := TToolTipItem.Create('btc','');
  toolTipItem.Text := TitleMnemonic(toolTipItem.Token,'Bit Test with Compliment')+
              '386+ only'+BR2+
              SubTitle('Usage')+
              Table(TAB+'btc'+TAB+'dest,src')+BR+FONT_NORMAL+
              SubTitle('Modifies Flags')+
              Table(TAB+'CF')+BR+FONT_NORMAL+
              SubTitle('Remarks')+
              'The destination bit indexed by the source value is copied into the'+BR+
              'Carry Flag after being complimented (inverted).';
  FList.AddObject(toolTipItem.Token, toolTipItem);

  toolTipItem := TToolTipItem.Create('btr','');
  toolTipItem.Text := TitleMnemonic(toolTipItem.Token,'Bit Test with Reset')+
              '386+ only'+BR2+
              SubTitle('Usage')+
              Table(TAB+'btr'+TAB+'dest,src')+BR+FONT_NORMAL+
              SubTitle('Modifies Flags')+
              Table(TAB+'CF')+BR+FONT_NORMAL+
              SubTitle('Remarks')+
              'The destination bit indexed by the source value is copied into the'+BR+
              'Carry Flag and then cleared in the destination.';
  FList.AddObject(toolTipItem.Token, toolTipItem);

  toolTipItem := TToolTipItem.Create('bts','');
  toolTipItem.Text := TitleMnemonic(toolTipItem.Token,'Bit Test and Set')+
              '386+ only'+BR2+
              SubTitle('Usage')+
              Table(TAB+'bts'+TAB+'dest,src')+BR+FONT_NORMAL+
              SubTitle('Modifies Flags')+
              Table(TAB+'CF')+BR+FONT_NORMAL+
              SubTitle('Remarks')+
              'The destination bit indexed by the source value is copied into the'+BR+
              'Carry Flag and then set in the destination.';
  FList.AddObject(toolTipItem.Token, toolTipItem);

  toolTipItem := TToolTipItem.Create('call','');
  toolTipItem.Text := TitleMnemonic(toolTipItem.Token,'Procedure Call')+
              'Original 8086/8088 instruction'+BR2+
              SubTitle('Usage')+
              Table(TAB+'call'+TAB+'destination')+BR+FONT_NORMAL+
              SubTitle('Modifies Flags')+
              Table(TAB+'None')+BR+FONT_NORMAL+
              SubTitle('Remarks')+
              'Pushes Instruction Pointer (and Code Segment for far calls) onto'+BR+
              'stack and loads Instruction Pointer with the address of proc-name.'+BR+
              'Code continues with execution at CS:IP.';
  FList.AddObject(toolTipItem.Token, toolTipItem);

  toolTipItem := TToolTipItem.Create('cbw','');
  toolTipItem.Text := TitleMnemonic(toolTipItem.Token,'Convert Byte to Word')+
              'Original 8086/8088 instruction'+BR2+
              SubTitle('Usage')+
              Table(TAB+'cbw'+TAB+'')+BR+FONT_NORMAL+
              SubTitle('Modifies Flags')+
              Table(TAB+'None')+BR+FONT_NORMAL+
              SubTitle('Remarks')+
              'Converts byte in AL to word Value in AX by extending sign of AL throughout register AH.';
  FList.AddObject(toolTipItem.Token, toolTipItem);

  toolTipItem := TToolTipItem.Create('cdq','');
  toolTipItem.Text := TitleMnemonic(toolTipItem.Token,'Convert Double to Quad')+
              '386+ only'+BR2+
              SubTitle('Usage')+
              Table(TAB+'cdq'+TAB+'')+BR+FONT_NORMAL+
              SubTitle('Modifies Flags')+
              Table(TAB+'None')+BR+FONT_NORMAL+
              SubTitle('Remarks')+
              'Converts signed DWORD in EAX to a signed quad word in EDX:EAX by'+BR+
              'extending the high order bit of EAX throughout EDX';
  FList.AddObject(toolTipItem.Token, toolTipItem);

  toolTipItem := TToolTipItem.Create('clc','');
  toolTipItem.Text := TitleMnemonic(toolTipItem.Token,'Clear Carry')+
              'Original 8086/8088 instruction'+BR2+
              SubTitle('Usage')+
              Table(TAB+'clc'+TAB+'')+BR+FONT_NORMAL+
              SubTitle('Modifies Flags')+
              Table(TAB+'CF')+BR+FONT_NORMAL+
              SubTitle('Remarks')+
              'Clears the Carry Flag.';
  FList.AddObject(toolTipItem.Token, toolTipItem);














  toolTipItem := TToolTipItem.Create('cmp','');
  toolTipItem.Text := TitleMnemonic(toolTipItem.Token,'Compare')+
              'Original 8086/8088 instruction'+BR2+
              SubTitle('Usage')+
              Table(TAB+'cmp'+TAB+'dest,src')+BR+FONT_NORMAL+
              SubTitle('Modifies Flags')+
              Table(TAB+'AF CF OF PF SF ZF')+BR+FONT_NORMAL+
              SubTitle('Remarks')+
              'Subtracts source from destination and updates the flags but does'+BR+
              'not save result. Flags can subsequently be checked for conditions.';
  FList.AddObject(toolTipItem.Token, toolTipItem);

  toolTipItem := TToolTipItem.Create('dec','');
  toolTipItem.Text := TitleMnemonic(toolTipItem.Token,'Decrement')+
              'Original 8086/8088 instruction'+BR2+
              SubTitle('Usage')+
              Table(TAB+'dec'+TAB+'dest')+BR+FONT_NORMAL+
              SubTitle('Modifies Flags')+
              Table(TAB+'AF OF PF SF ZF')+BR+FONT_NORMAL+
              SubTitle('Remarks')+
              'Unsigned binary subtraction of one from the destination.';
  FList.AddObject(toolTipItem.Token, toolTipItem);

  toolTipItem := TToolTipItem.Create('div','');
  toolTipItem.Text := TitleMnemonic(toolTipItem.Token,'Divide')+
              'Original 8086/8088 instruction'+BR2+
              SubTitle('Usage')+
              Table(TAB+'div'+TAB+'src')+BR+FONT_NORMAL+
              SubTitle('Modifies Flags')+
              Table(TAB+'(AF,CF,OF,PF,SF,ZF undefined)')+BR+FONT_NORMAL+
              SubTitle('Remarks')+
              'Unsigned binary division of accumulator by source. If the source'+BR+
              'divisor is a byte value then AX is divided by "src" and the quotient'+BR+
              'is placed in AL and the remainder in AH. If source operand is a word'+BR+
              'value, then DX:AX is divided by "src" and the quotient is stored in AX'+BR+
              'and the remainder in DX.';
  FList.AddObject(toolTipItem.Token, toolTipItem);

  toolTipItem := TToolTipItem.Create('inc','');
  toolTipItem.Text := TitleMnemonic(toolTipItem.Token,'Increment')+
              'Original 8086/8088 instruction'+BR2+
              SubTitle('Usage')+
              Table(TAB+'inc'+TAB+'dest')+BR+FONT_NORMAL+
              SubTitle('Modifies Flags')+
              Table(TAB+'AF OF PF SF ZF')+BR+FONT_NORMAL+
              SubTitle('Remarks')+
              'Adds one to destination unsigned binary operand.';
  FList.AddObject(toolTipItem.Token, toolTipItem);

  toolTipItem := TToolTipItem.Create('int','');
  toolTipItem.Text := TitleMnemonic(toolTipItem.Token,'Interrupt')+
              'Original 8086/8088 instruction'+BR2+
              SubTitle('Usage')+
              Table(TAB+'int'+TAB+'num')+BR+FONT_NORMAL+
              SubTitle('Modifies Flags')+
              Table(TAB+'TF IF')+BR+FONT_NORMAL+
              SubTitle('Remarks')+
              'Initiates a software interrupt by pushing the flags, clearing the'+BR+
              'Trap and Interrupt Flags, pushing CS followed by IP and loading'+BR+
              'CS:IP with the value found in the interrupt vector table. Execution'+BR+
              'then begins at the location addressed by the new CS:IP';

  FList.AddObject(toolTipItem.Token, toolTipItem);

  toolTipItem := TToolTipItem.Create('je','');
  toolTipItem.Text := TitleMnemonic(toolTipItem.Token,'Jump Equal')+
              'Original 8086/8088 instruction'+BR2+
              SubTitle('Usage')+
              Table(TAB+'je'+TAB+'label')+
              Table(TAB+'jz'+TAB+'label')+BR+FONT_NORMAL+
              SubTitle('Modifies Flags')+
              Table(TAB+'None')+BR+FONT_NORMAL+
              SubTitle('Remarks')+
              'Causes execution to branch to "label" if the Zero Flag is set. Uses unsigned comparison.'+BR+
              'JE/JZ are different mnemonics for the same instruction';
  FList.AddObject(toolTipItem.Token, toolTipItem);

  toolTipItem := TToolTipItem.Create('jz','');
  toolTipItem.Text := TitleMnemonic(toolTipItem.Token,'Jump Zero')+
              'Original 8086/8088 instruction'+BR2+
              SubTitle('Usage')+
              Table(TAB+'je'+TAB+'label')+
              Table(TAB+'jz'+TAB+'label')+BR+FONT_NORMAL+
              SubTitle('Modifies Flags')+
              Table(TAB+'None')+BR+FONT_NORMAL+
              SubTitle('Remarks')+
              'Causes execution to branch to "label" if the Zero Flag is set. Uses unsigned comparison.'+BR+
              'JE/JZ are different mnemonics for the same instruction';
  FList.AddObject(toolTipItem.Token, toolTipItem);

  toolTipItem := TToolTipItem.Create('jmp','');
  toolTipItem.Text := TitleMnemonic(toolTipItem.Token,'Unconditional Jump')+
              'Original 8086/8088 instruction'+BR2+
              SubTitle('Usage')+
              Table(TAB+'jmp'+TAB+'target')+BR+FONT_NORMAL+
              SubTitle('Modifies Flags')+
              Table(TAB+'None')+BR+FONT_NORMAL+
              SubTitle('Remarks')+
              'Unconditionally transfers control to "label". Jumps by default'+BR+
              'are within -32768 to 32767 bytes from the instruction following'+BR+
              'the jump. NEAR and SHORT jumps cause the IP to be updated while FAR'+BR+
              'jumps cause CS and IP to be updated.';
  FList.AddObject(toolTipItem.Token, toolTipItem);

  toolTipItem := TToolTipItem.Create('lea','');
  toolTipItem.Text := TitleMnemonic(toolTipItem.Token,'Load Effective Address')+
              'Original 8086/8088 instruction'+BR2+
              SubTitle('Usage')+
              Table(TAB+'lea'+TAB+'dest,src')+BR+FONT_NORMAL+
              SubTitle('Modifies Flags')+
              Table(TAB+'None')+BR+FONT_NORMAL+
              SubTitle('Remarks')+
              'Transfers offset address of "src" to the destination register.';
  FList.AddObject(toolTipItem.Token, toolTipItem);

  toolTipItem := TToolTipItem.Create('mov','');
  toolTipItem.Text := TitleMnemonic(toolTipItem.Token,'Move Byte or Word')+
              'Original 8086/8088 instruction'+BR2+
              SubTitle('Usage')+
              Table(TAB+'mov'+TAB+'dest,src')+BR+FONT_NORMAL+
              SubTitle('Modifies Flags')+
              Table(TAB+'None')+BR+FONT_NORMAL+
              SubTitle('Remarks')+
              'Copies byte or word from the source operand to the destination'+BR+
              'operand. If the destination is SS interrupts are disabled except'+BR+
              'on early buggy 808x CPUs. Some CPUs disable interrupts if the'+BR+
              'destination is any of the segment registers.';
  FList.AddObject(toolTipItem.Token, toolTipItem);

  toolTipItem := TToolTipItem.Create('or','');
  toolTipItem.Text := TitleMnemonic(toolTipItem.Token,'Inclusive Logical OR')+
              'Original 8086/8088 instruction'+BR2+
              SubTitle('Usage')+
              Table(TAB+'or'+TAB+'dest,src')+BR+FONT_NORMAL+
              SubTitle('Modifies Flags')+
              Table(TAB+'CF OF PF SF ZF (AF undefined)')+BR+FONT_NORMAL+
              SubTitle('Remarks')+
              'Logical inclusive OR of the two operands returning the result in the destination. Any bit set in either operand will be set in the destination.';
  FList.AddObject(toolTipItem.Token, toolTipItem);

  toolTipItem := TToolTipItem.Create('pop','');
  toolTipItem.Text := TitleMnemonic(toolTipItem.Token,'Pop Word off Stack')+
              'Original 8086/8088 instruction'+BR2+
              SubTitle('Usage')+
              Table(TAB+'popp'+TAB+'dest')+BR+FONT_NORMAL+
              SubTitle('Modifies Flags')+
              Table(TAB+'None')+BR+FONT_NORMAL+
              SubTitle('Remarks')+
              'Transfers word at the current stack top (SS:SP) to the destination'+BR+
              'then increments SP by two to point to the new stack top. CS is not'+BR+
              'a valid destination.';
  FList.AddObject(toolTipItem.Token, toolTipItem);

  toolTipItem := TToolTipItem.Create('push','');
  toolTipItem.Text := TitleMnemonic(toolTipItem.Token,'Push Word onto Stack')+
              'Original 8086/8088 instruction'+BR2+
              SubTitle('Usage')+
              Table(TAB+'push'+TAB+'src')+
              Table(TAB+'push'+TAB+'immed'+TAB+'(80188+ only)')+BR+FONT_NORMAL+
              SubTitle('Modifies Flags')+
              Table(TAB+'None')+BR+FONT_NORMAL+
              SubTitle('Remarks')+
              'Decrements SP by the size of the operand (two or four, byte values'+BR+
              'are sign extended) and transfers one word from source to the stack'+BR+
              'top (SS:SP).';
  FList.AddObject(toolTipItem.Token, toolTipItem);

  toolTipItem := TToolTipItem.Create('rep','');
  toolTipItem.Text := TitleMnemonic(toolTipItem.Token,'Repeat String Operation')+
              'Original 8086/8088 instruction'+BR2+
              SubTitle('Usage')+
              Table(TAB+'rep')+BR+FONT_NORMAL+
              SubTitle('Modifies Flags')+
              Table(TAB+'None')+BR+FONT_NORMAL+
              SubTitle('Remarks')+
              'Repeats execution of string instructions while CX != 0. After each string operation, CX is decremented and'+BR+
              'the Zero Flag is tested. The combination of a repeat prefix and a segment override on CPU''s before the '+BR+
              '386 may result in errors if an interrupt occurs before CX=0. The following code shows code that is '+BR+
              'susceptible to this and how to avoid it:'+BR+BR+
              Table(TAB+'again:'+TAB+'rep movs byte ptr ES:[DI],ES:[SI]'+TAB+'; vulnerable instr.')+
              Table(TAB+TAB+TAB+'jcxz next'+TAB+TAB+TAB+TAB+TAB+TAB+'; continue if REP successful')+
              Table(TAB+TAB+TAB+'loop again'+TAB+TAB+TAB+TAB+TAB+TAB+'; interrupt goofed count')+
              Table(TAB+'next:')+BR+FONT_NORMAL;
  FList.AddObject(toolTipItem.Token, toolTipItem);

  toolTipItem := TToolTipItem.Create('ret','');
  toolTipItem.Text := TitleMnemonic(toolTipItem.Token,'Return From Procedure')+
              'Original 8086/8088 instruction'+BR2+
              SubTitle('Usage')+
              Table(TAB+'ret '+TAB+'nBytes')+
              Table(TAB+'retf'+TAB+'nBytes')+
              Table(TAB+'retn'+TAB+'nBytes')+BR+FONT_NORMAL+
              SubTitle('Modifies Flags')+
              Table(TAB+'None')+BR+FONT_NORMAL+
              SubTitle('Remarks')+
              'Transfers control from a procedure back to the instruction address'+BR+
              'saved on the stack. "n bytes" is an optional number of bytes to'+BR+
              'release. Far returns pop the IP followed by the CS, while near'+BR+
              'returns pop only the IP register.';
  FList.AddObject(toolTipItem.Token, toolTipItem);

  toolTipItem := TToolTipItem.Create('retf','');
  toolTipItem.Text := TitleMnemonic(toolTipItem.Token,'Return From Procedure')+
              'Original 8086/8088 instruction'+BR2+
              SubTitle('Usage')+
              Table(TAB+'ret '+TAB+'nBytes')+
              Table(TAB+'retf'+TAB+'nBytes')+
              Table(TAB+'retn'+TAB+'nBytes')+BR+FONT_NORMAL+
              SubTitle('Modifies Flags')+
              Table(TAB+'None')+BR+FONT_NORMAL+
              SubTitle('Remarks')+
              'Transfers control from a procedure back to the instruction address'+BR+
              'saved on the stack. "n bytes" is an optional number of bytes to'+BR+
              'release. Far returns pop the IP followed by the CS, while near'+BR+
              'returns pop only the IP register.';
  FList.AddObject(toolTipItem.Token, toolTipItem);

  toolTipItem := TToolTipItem.Create('shr','');
  toolTipItem.Text := TitleMnemonic(toolTipItem.Token,'Shift Logical Right')+
              'Original 8086/8088 instruction'+BR2+
              SubTitle('Usage')+
              Table(TAB+'shr'+TAB+'dest,count')+BR+FONT_NORMAL+
              SubTitle('Modifies Flags')+
              Table(TAB+'CF OF PF SF ZF (AF undefined)')+BR+FONT_NORMAL+
              SubTitle('Remarks')+
              'Shifts the destination right by "count" bits with zeroes shifted'+BR+
              'in on the left. The Carry Flag contains the last bit shifted out.';
  FList.AddObject(toolTipItem.Token, toolTipItem);

  toolTipItem := TToolTipItem.Create('sub','');
  toolTipItem.Text := TitleMnemonic(toolTipItem.Token,'Subtract')+
              'Original 8086/8088 instruction'+BR2+
              SubTitle('Usage')+
              Table(TAB+'sub'+TAB+'dest,src')+BR+FONT_NORMAL+
              SubTitle('Modifies Flags')+
              Table(TAB+'AF CF OF PF SF ZF')+BR+FONT_NORMAL+
              SubTitle('Remarks')+
              'The source is subtracted from the destination and the result is'+BR+
              'stored in the destination.';
  FList.AddObject(toolTipItem.Token, toolTipItem);

end;

end.
