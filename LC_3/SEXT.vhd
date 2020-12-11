-- Beau Bakken
-- University of Florida

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity SEXT is
	generic (
    	inSize  	: positive;
		outSize 	: positive);
	port (
		input 		: in std_logic_vector(inSize-1 downto 0);
		output 		: out std_logic_vector(outSize-1 downto 0));
end SEXT;

architecture STR of SEXT is

	signal out 		: std_logic_vector(outSize-1 downto 0);
	constant zeros 	: std_logic_vector((outSize-inSize)-1 downto 0) := (others => '0');
	constant ones  	: std_logic_vector((outSize-inSize)-1 downto 0) := (others => '1');

begin
process(input)
begin
	
	out <= zeros & input;

	if (input(inSize-1) = '1') then
		out <= ones & input;
	end if;

end process;

	output <= out;

end STR;