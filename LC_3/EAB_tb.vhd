library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity EAB_tb is
end EAB_tb;

architecture TB of EAB_tb is
    
    signal clk50MHz : std_logic := '0';
    signal rst      : std_logic;
    signal button_n : std_logic;
    signal clk_out  : std_logic;
    signal done     : std_logic := '0';

    constant MS_PERIOD : integer := 2;
    constant MAX_TIME  : time    := (MS_PERIOD+1)*1 ms;  -- allow for time if
                                                         -- button was pressed
                                                         -- between clocks
    constant MIN_TIME  : time    := (MS_PERIOD)*1 ms;    -- the generated clock
                                                         -- should never occur
                                                         -- before MIN_TIME after
                                                         -- the button is pressed

begin 

    U_CLK_GEN : entity work.clk_gen
        generic map (
            ms_period => MS_PERIOD)
        port map (
            clk50MHz => clk50MHz,
            rst      => rst,
            button_n => button_n,
            clk_out  => clk_out);

    clk50MHz <= not clk50MHz and not done after 10 ns;

    process
        variable before_time, after_time : time;

    begin

        rst      <= '1';
        button_n <= '1';
        wait for 100 ns;

   

        report "DONE!";
        done <= '1';
        wait;

    end process;

end TB;