-- Beau Bakken
-- University of Florida

library ieee;
use ieee.std_logic_1164.all;
use work.LC_3_PACKAGE.all;

entity ALU is
  port (
    IR        	: in  std_logic_vector(5 downto 0);
    Ra        	: in  std_logic_vector(WORD_SIZE-1 downto 0);
    Rb        	: in  std_logic_vector(WORD_SIZE-1 downto 0);
    PC        	: in  std_logic_vector(WORD_SIZE-1 downto 0);
    aluControl  : in  std_logic_vector(1 downto 0);
    aluOut    	: out std_logic_vector(WORD_SIZE-1 downto 0));
end ALU;

architecture BHV of ALU is

  signal SEXT_1_OUT   : std_logic_vector(WORD_SIZE-1 downto 0);
  constant zeros      : std_logic_vector(WORD_SIZE-1 downto 0) := (others => '0');

begin
  
U_SEXT : entity work.SEXT
  generic map (
    inSize  => 5,
    outSize => WORD_SIZE)
  port map (
    input   => IR[4:0],
    output  => SEXT_1_OUT);

 U_SR2MUX : entity work.MUX2x1
  generic map (
    width   => WORD_SIZE)
  port map (
    in0     => Rb,
    in1     => SEXT_1_OUT,
    sel     => IR[5],
    output  => SR2MUX_OUT);

U_ALU_COMP : entity work.ALU_COMP 
	generic map (
		width => WORD_SIZE)
	port map (
		input0 		=> Ra,
		input1 		=> SR2MUX_OUT,
		aluControl 	=> aluControl,
		aluOut 		=> aluOut);

end BHV;