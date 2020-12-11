-- Beau Bakken
-- University of Florida

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.LC_3_PACKAGE.all;

entity ALU_COMP is
	generic (
		width : positive);
	port (
		input0 : in std_logic_vector(WIDTH-1 downto 0);
		input1 : in std_logic_vector(WIDTH-1 downto 0);
		aluControl : in std_logic_vector(1 downto 0);
		aluOut : out std_logic_vector(WIDTH-1 downto 0));
end ALU_COMP;

architecture BHV of ALU_COMP is

begin

end BHV;