-- Beau Bakken
-- University of Florida

library ieee;
use ieee.std_logic_1164.all;
use work.PC_3_PACKAGE.all;

entity NZP_LOGIC is
  generic (
     width  : positive);
  port (
    Buss    : in std_logic_vector(WORD_SIZE-1 downto 0);
    N   : out std_logic;
    Z   : out std_logic;
    P   : out std_logic);
end NZP_LOGIC;

architecture BHV of NZP_LOGIC is

  constant zeros : std_logic_vector(width-1 downto 0) := (others => '0');

begin

process(Buss)
begin
  
  N <= '0';
  Z <= '0';
  P <= '0';
  
  if(Buss = zeros) then
    Z <= '1';
  elsif (Buss(width-1) = '1') then
    N <= '1';
  else 
    P <= '1';
  end if;

end process;

end BHV;