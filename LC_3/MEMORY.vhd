-- Beau Bakken
-- University of Florida

library ieee;
use ieee.std_logic_1164.all;
use work.LC_3_PACKAGE.all;

entity MEMORY is
  port (
    clk      : in std_logic;
    reset    : in std_logic;
    selMDR   : in std_logic;
    ldMAR    : in std_logic;
    ldMDR    : in std_logic;
    memWE    : in std_logic;
    Buss     : in std_logic_vector(WORD_SIZE-1 downto 0);
    mdrOut   : in std_logic_vector(WORD_SIZE-1 downto 0));
end MEMORY;

architecture BHV of MEMORY is

  signal MAR_OUT    : std_logic_vector(WORD_SIZE-1 downto 0);
  signal MDR_OUT    : std_logic_vector(WORD_SIZE-1 downto 0);
  signal MEMORY_OUT : std_logic_vector(WORD_SIZE-1 downto 0);
  signal MDRMUX_OUT : std_logic_vector(WORD_SIZE-1 downto 0);
  constant zeros    : std_logic_vector(WORD_SIZE-1 downto 0) := (others => '0');

begin

U_MAR : entity work.REG
  generic map (
    width => WORD_SIZE)
  port map(
    clk     => clk,
    rst     => reset,
    enable  => ldMAR,
    input   => Buss,
    output  => MAR_out);

U_RAM : entity work.RAM 


U_MDRMUX : entity work.MUX2x1
  generic map(
    width => WORD_SIZE)
  port map(
    in0    => Buss,
    in1    => MEMORY_OUT,
    sel    => selMDR,
    output => MDRMUX_OUT);

U_MDR : entity work.REG
  generic map (
    width => WORD_SIZE)
  port map(
    clk     => clk,
    rst     => reset,
    enable  => ldMDR,
    input   => MDRMUX_OUT,
    output  => MDR_out);

mdrOut <= MDR_OUT;

end BHV;