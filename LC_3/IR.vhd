-- Beau Bakken
-- University of Florida

library ieee;
use ieee.std_logic_1164.all;
use work.PC_3_PACKAGE.all;

entity IR is
  port (
    clk     : in  std_logic;
    reset   : in  std_logic;
    ldIR    : in  std_logic;
    Buss    : in std_logic_vector(WORD_SIZE-1 downto 0);
    IR   : out std_logic_vector(WORD_SIZE-1 downto 0));
end IR;

architecture BHV of IR is
begin
  
U_PC : entity work.REG
  generic map (
    width => WORD_SIZE)
  port map (
    clk => clk,
    rst => reset,
    enable => ldIR,
    input => Buss,
    output => IR);

end BHV;