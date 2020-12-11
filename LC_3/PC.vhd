-- Beau Bakken
-- University of Florida

library ieee;
use ieee.std_logic_1164.all;
use work.PC_3_PACKAGE.all;

entity PC is
  port (
    clk     : in  std_logic;
    reset   : in  std_logic;
    ldPC    : in  std_logic;
    selPC   : in std_logic_vector(1 downto 0);
    eabOut  : in std_logic_vector(WORD_SIZE-1 downto 0);
    Buss    : in std_logic_vector(WORD_SIZE-1 downto 0);
    PCOut   : out std_logic_vector(WORD_SIZE-1 downto 0));
end PC;

architecture BHV of PC is

  signal PCMUX_out : std_logic_vector(WORD_SIZE-1 downto 0);
  signal PC_inc    : std_logic_vector(WORD_SIZE-1 downto 0);

begin

PC_inc <= std_logic_vector(unsigned(PCOut + 1));

U_PCMUX : entity work.MUX4x1
  generic map (
    width   => WORD_SIZE)
  port map (
    in0     => PC_inc,
    in1     => eabOut,
    in2     => Buss,
    in3     => (others => '0'),
    sel     => selPC,
    output  => PCMUX_out);
  
U_PC : entity work.REG
  generic map (
    width => WORD_SIZE)
  port map (
    clk => clk,
    rst => reset,
    enable => ldPC,
    input => PCMUX_out,
    output => PCOut);

end BHV;