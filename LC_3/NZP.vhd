-- Beau Bakken
-- University of Florida

library ieee;
use ieee.std_logic_1164.all;
use work.PC_3_PACKAGE.all;

entity NZP is
  port (
    clk     : in  std_logic;
    reset   : in  std_logic;
    flagWE    : in  std_logic;
    Buss    : in std_logic_vector(WORD_SIZE-1 downto 0);
    N   : out std_logic;
    Z   : out std_logic;
    P   : out std_logic);
end NZP;

architecture BHV of NZP is

  signal N_OUT, Z_OUT, P_OUT : std_logic;

begin

U_NZP_LOGIC : entity work.NZP_LOGIC
  generic map (
    width => WORD_SIZE)
  port map (
    Buss => Buss,
    N => N_OUT,
    Z => Z_OUT,
    P => P_OUT);
  
U_N : entity work.REG
  generic map (
    width => 1)
  port map (
    clk => clk,
    rst => reset,
    enable => flagWE,
    input => N_OUT,
    output => N);

U_Z : entity work.REG
  generic map (
    width => 1)
  port map (
    clk => clk,
    rst => reset,
    enable => flagWE,
    input => Z_OUT,
    output => Z);

U_P : entity work.REG
  generic map (
    width => 1)
  port map (
    clk => clk,
    rst => reset,
    enable => flagWE,
    input => P_OUT,
    output => P);


end BHV;