	library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity programa is
    Port ( A : in  STD_LOGIC_VECTOR (15 downto 0);
           Q : out  STD_LOGIC_VECTOR (24 downto 0));
end programa;

architecture memoria of programa is

CONSTANT OPCODE_TIPOR 	: STD_LOGIC_VECTOR(4 DOWNTO 0) := "00000";
	CONSTANT OPCODE_LI 		: STD_LOGIC_VECTOR(4 DOWNTO 0) := "00001";
	CONSTANT OPCODE_LWI 		: STD_LOGIC_VECTOR(4 DOWNTO 0) := "00010";
	CONSTANT OPCODE_LW 		: STD_LOGIC_VECTOR(4 DOWNTO 0) := "10111";
	CONSTANT OPCODE_SWI 		: STD_LOGIC_VECTOR(4 DOWNTO 0) := "00011";
	CONSTANT OPCODE_SW 		: STD_LOGIC_VECTOR(4 DOWNTO 0) := "00100";
	CONSTANT OPCODE_ADDI		: STD_LOGIC_VECTOR(4 DOWNTO 0) := "00101";
	CONSTANT OPCODE_SUBI		: STD_LOGIC_VECTOR(4 DOWNTO 0) := "00110";
	CONSTANT OPCODE_ANDI		: STD_LOGIC_VECTOR(4 DOWNTO 0) := "00111";
	CONSTANT OPCODE_ORI 		: STD_LOGIC_VECTOR(4 DOWNTO 0) := "01000";
	CONSTANT OPCODE_XORI		: STD_LOGIC_VECTOR(4 DOWNTO 0) := "01001";
	CONSTANT OPCODE_NANDI	: STD_LOGIC_VECTOR(4 DOWNTO 0) := "01010";
	CONSTANT OPCODE_NORI		: STD_LOGIC_VECTOR(4 DOWNTO 0) := "01011";
	CONSTANT OPCODE_XNORI	: STD_LOGIC_VECTOR(4 DOWNTO 0) := "01100";
	CONSTANT OPCODE_BEQI		: STD_LOGIC_VECTOR(4 DOWNTO 0) := "01101";
	CONSTANT OPCODE_BNEI		: STD_LOGIC_VECTOR(4 DOWNTO 0) := "01110";
	CONSTANT OPCODE_BLTI		: STD_LOGIC_VECTOR(4 DOWNTO 0) := "01111";
	CONSTANT OPCODE_BLETI	: STD_LOGIC_VECTOR(4 DOWNTO 0) := "10000";
	CONSTANT OPCODE_BGTI		: STD_LOGIC_VECTOR(4 DOWNTO 0) := "10001";
	CONSTANT OPCODE_BGETI	: STD_LOGIC_VECTOR(4 DOWNTO 0) := "10010";
	CONSTANT OPCODE_B 		: STD_LOGIC_VECTOR(4 DOWNTO 0) := "10011";
	CONSTANT OPCODE_CALL		: STD_LOGIC_VECTOR(4 DOWNTO 0) := "10100";
	CONSTANT OPCODE_RET 		: STD_LOGIC_VECTOR(4 DOWNTO 0) := "10101";
	CONSTANT OPCODE_NOP 		: STD_LOGIC_VECTOR(4 DOWNTO 0) := "10110";
--	FUNCONDE	
	CONSTANT FUNCODE_ADD		: STD_LOGIC_VECTOR(3 DOWNTO 0) := "0000";
	CONSTANT FUNCODE_SUB		: STD_LOGIC_VECTOR(3 DOWNTO 0) := "0001";
	CONSTANT FUNCODE_AND		: STD_LOGIC_VECTOR(3 DOWNTO 0) := "0010";
	CONSTANT FUNCODE_OR		: STD_LOGIC_VECTOR(3 DOWNTO 0) := "0011";
	CONSTANT FUNCODE_XOR		: STD_LOGIC_VECTOR(3 DOWNTO 0) := "0100";
	CONSTANT FUNCODE_NAND	: STD_LOGIC_VECTOR(3 DOWNTO 0) := "0101";
	CONSTANT FUNCODE_NOR		: STD_LOGIC_VECTOR(3 DOWNTO 0) := "0110";
	CONSTANT FUNCODE_XNOR	: STD_LOGIC_VECTOR(3 DOWNTO 0) := "0111";
	CONSTANT FUNCODE_NOT		: STD_LOGIC_VECTOR(3 DOWNTO 0) := "1000";
	CONSTANT FUNCODE_SLL		: STD_LOGIC_VECTOR(3 DOWNTO 0) := "1001";
	CONSTANT FUNCODE_SRL		: STD_LOGIC_VECTOR(3 DOWNTO 0) := "1010";
-- REGISTROS	
	CONSTANT R0					: STD_LOGIC_VECTOR(3 DOWNTO 0) := "0000";
	CONSTANT R1					: STD_LOGIC_VECTOR(3 DOWNTO 0) := "0001";
	CONSTANT R2					: STD_LOGIC_VECTOR(3 DOWNTO 0) := "0010";
	CONSTANT R3					: STD_LOGIC_VECTOR(3 DOWNTO 0) := "0011";
	CONSTANT R4					: STD_LOGIC_VECTOR(3 DOWNTO 0) := "0100";
	CONSTANT R5					: STD_LOGIC_VECTOR(3 DOWNTO 0) := "0101";
	CONSTANT R6					: STD_LOGIC_VECTOR(3 DOWNTO 0) := "0110";
	CONSTANT R7					: STD_LOGIC_VECTOR(3 DOWNTO 0) := "0111";
	CONSTANT R8					: STD_LOGIC_VECTOR(3 DOWNTO 0) := "1000";
	CONSTANT R9					: STD_LOGIC_VECTOR(3 DOWNTO 0) := "1001";
	CONSTANT R10				: STD_LOGIC_VECTOR(3 DOWNTO 0) := "1010";
	CONSTANT R11				: STD_LOGIC_VECTOR(3 DOWNTO 0) := "1011";
	CONSTANT R12				: STD_LOGIC_VECTOR(3 DOWNTO 0) := "1100";
	CONSTANT R13				: STD_LOGIC_VECTOR(3 DOWNTO 0) := "1101";
	CONSTANT R14				: STD_LOGIC_VECTOR(3 DOWNTO 0) := "1110";
	CONSTANT R15				: STD_LOGIC_VECTOR(3 DOWNTO 0) := "1111";
-- SIN USO	
	CONSTANT SU					: STD_LOGIC_VECTOR(3 DOWNTO 0) := "0000";
---------MEMORIA------------
type memoria is array (0 to 2**16-1) of std_logic_vector(24 downto 0);

constant mem_prog: memoria :=(

OPCODE_LI&R0&X"0000",					--LI R0, #0			0
OPCODE_LI&R1&X"0001",					--LI R1, #1			1
OPCODE_LI&R2&X"0000",					--LI R2, #0			2
OPCODE_LI&R3&X"1010",					--LI R3, #10		3

OPCODE_TIPOR&R4&R0&R1&SU&FUNCODE_ADD,	--ADD R4, R0, R1	4

OPCODE_SWI&R4&X"0048",					--SWI R4, 72		5
OPCODE_ADDI&R0&R1&X"000",				--ADDI R0, R1, #0	6
OPCODE_ADDI&R1&R4&X"000",				--ADDI R1, R4, #0	7
OPCODE_ADDI&R2&R2&X"001",				--ADDI R2, R2, #1	8

OPCODE_BNEI&R2&R3&X"FFB",				--BNEI R2, R3,X"FFB"	9

OPCODE_NOP&SU&SU&SU&SU&SU,				--NOP				10
OPCODE_B&SU&X"000A",					--B CICLO
																		--B CICLO
			OTHERS=>(OTHERS=>'0')	--others para llenar de ceros las localidades y su tama�o.
);
begin
		Q <= mem_prog(CONV_INTEGER(A)); -- La salida de 25 bits
end memoria;

