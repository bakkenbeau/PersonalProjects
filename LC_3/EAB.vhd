-- Beau Bakken
-- University of Florida

library ieee;
use ieee.std_logic_1164.all;
use work.LC_3_PACKAGE.all;

entity EAB is
  port (
    IR        : in  std_logic_vector(10 downto 0);
    Ra        : in  std_logic_vector(WORD_SIZE-1 downto 0);
    PC        : in  std_logic_vector(WORD_SIZE-1 downto 0);
    selEAB1   : in  std_logic;
    selEAB2   : in  std_logic_vector(1 downto 0);
    eabOut    : out std_logic_vector(WORD_SIZE-1 downto 0));
end EAB;

architecture BHV of EAB is

  signal SEXT_1_OUT   : std_logic_vector(WORD_SIZE-1 downto 0);
  signal SEXT_2_OUT   : std_logic_vector(WORD_SIZE-1 downto 0);
  signal SEXT_3_OUT   : std_logic_vector(WORD_SIZE-1 downto 0);
  signal ADDR1MUX_OUT : std_logic_vector(WORD_SIZE-1 downto 0);
  signal ADDR2MUX_OUT : std_logic_vector(WORD_SIZE-1 downto 0);
  constant zeros      : std_logic_vector(WORD_SIZE-1 downto 0) := (others => '0');

begin
  
U_SEXT_1 : entity work.SEXT
  generic map (
    inSize  => 6,
    outSize => WORD_SIZE)
  port map (
    input   => IR[5:0],
    output  => SEXT_1_OUT);

U_SEXT_2 : entity work.SEXT
  generic map (
    inSize  => 9,
    outSize => WORD_SIZE)
  port map (
    input   => IR[8:0],
    output  => SEXT_2_OUT);

U_SEXT_3 : entity work.SEXT
  generic map (
    inSize  => 11,
    outSize => WORD_SIZE)
  port map (
    input   => IR[10:0],
    output  => SEXT_3_OUT);

U_ADDR1MUX : entity work.MUX2x1
  generic map (
    width   => WORD_SIZE)
  port map (
    in0     => PC,
    in1     => Ra,
    sel     => selEAB1,
    output  => ADDR1MUX_OUT);

U_ADDR2MUX : entity work.MUX4x1
  generic map (
    width   => WORD_SIZE)
  port map (
    in0     => zeros,
    in1     => SEXT_1_OUT,
    in2     => SEXT_2_OUT,
    in3     => SEXT_3_OUT,
    sel     => selEAB2,
    output  => ADDR2MUX_OUT);

U_ADDER : entity work.ADDER
  generic map (
    width   => WORD_SIZE)
  port map (
    in0     => ADDR1MUX_OUT,
    in1     => ADDR2MUX_OUT,
    sum     => eabOut,
    c_out   => open);

end BHV;