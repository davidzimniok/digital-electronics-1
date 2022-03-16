library ieee;
use ieee.std_logic_1164.all;

------------------------------------------------------------
-- Entity declaration for testbench
------------------------------------------------------------
entity tb_top is
    -- Entity of testbench is always empty
end entity tb_top;

------------------------------------------------------------
-- Architecture body for testbench
------------------------------------------------------------
architecture testbench of tb_top is

    constant c_CLK_100MHZ_PERIOD : time := 10 ns;

    --Local signals
    signal s_clk_100MHz : std_logic;
    signal s_rst        : std_logic;
    signal s_input      : std_logic;
    signal s_leds       : std_logic_vector(3 downto 0);

begin
    -- Connecting testbench signals with top entity
    -- (Unit Under Test)
    uut_top : entity work.top
        port map(
            CLK100MHZ   => s_clk_100MHz,
            BTNC   => s_rst,
            SW     => s_input,
            LED     => s_leds
        );


    --------------------------------------------------------
    -- Clock generation process
    --------------------------------------------------------
    p_clk_gen : process
    begin
        while now < 200 ns loop -- 20 periods of 100MHz clock
            s_clk_100MHz <= '0';
            wait for c_CLK_100MHZ_PERIOD / 2;
            s_clk_100MHz <= '1';
            wait for c_CLK_100MHZ_PERIOD / 2;
        end loop;
        wait;                -- Process is suspended forever
    end process p_clk_gen;

    --------------------------------------------------------
    -- Reset generation process
    --------------------------------------------------------
    p_reset_gen : process
    begin
        s_rst <= '1';
        wait for 13 ns;
        s_rst <= '0';
        wait for 49 ns;
        s_rst <= '1';
        wait for 20 ns;
        s_rst <= '0';
        wait;
    end process p_reset_gen;

    --------------------------------------------------------
    -- Data generation process
    --------------------------------------------------------
    p_stimulus : process
    begin
        report "Stimulus process started" severity note;
        s_input <='0'; wait for 13 ns;
        s_input <='1'; wait for 13 ns;
        s_input <='0'; wait for 13 ns;
        s_input <='1'; wait for 26 ns;
        s_input <='0'; wait for 13 ns;
        s_input <='0'; wait for 13 ns;
        s_input <='1'; wait for 13 ns;
        s_input <='0'; wait for 13 ns;
        -- DEFINE YOUR INPUT DATA HERE

        report "Stimulus process finished" severity note;
        wait;
    end process p_stimulus;

end architecture testbench;