-- Beau Bakken
-- University of Florida

library ieee;
use ieee.std_logic_1164.all;
use work.LC_3_PACKAGE.all;

entity MARMux is
  port (
    IR        : in  std_logic_vector(7 downto 0);
    eabOut    : in  std_logic_vector(WORD_SIZE-1 downto 0);
    selMAR    : in  std_logic;
    MARMuxOut : out std_logic_vector(WORD_SIZE-1 downto 0));
end MARMux;

architecture BHV of MARMux is

	signal ZEXT		: std_logic_vector(7 downto 0);
	constant zeros 	: std_logic_vector(7 downto 0) := (others => '0');

begin
  
ZEXT <= zeros & IR;

U_MARMUX : entity work.MUX2x1
  generic map (
    width 	=> WORD_SIZE)
  port map (
    in0 	=> eabOut,
    in1 	=> ZEXT,
    sel 	=> selMAR,
    output 	=> MARMuxOut);

end BHV;