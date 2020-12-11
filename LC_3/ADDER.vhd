-- Beau Bakken
-- University of Florida

library ieee;
use ieee.std_logic_1164.all;

entity ADDER is
	generic(
		width : positive);
 	port (
    	in0   : in  std_logic_vector(width-1 downto 0);
    	in1   : in  std_logic_vector(width-1 downto 0);
    	sum   : out std_logic_vector(width-1 downto 0);
    	c_out : out std_logic);
end ADDER;

architecture BHV of ADDER is

	signal result : std_logic_vector(width downto 0);

begin 
 	
	result 	<= ('0' & in0) + ('0' & in1);
    sum		<= result(width-1 downto 0);
    c_out 	<= result(width);

end BHV;