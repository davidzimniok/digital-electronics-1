----------------------------------------------------------------------------------
-- Company: VUTBR FEKT UREL
-- Engineer: David Zimniok
-- 
-- Create Date: 03/02/2022 02:00:59 PM
-- Design Name: 
-- Module Name: mux_3bit_4to1 - Behavioral
-- Project Name: Multiplexer 3 bit 4 to 1
-- Target Devices: Nexys A7
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_mux_3bit_4to1 is
--  Port ( );
end tb_mux_3bit_4to1;

architecture testbench of tb_mux_3bit_4to1 is
    signal s_a           : std_logic_vector(2 downto 0);
    signal s_b           : std_logic_vector(2 downto 0);
    signal s_c           : std_logic_vector(2 downto 0);
    signal s_d           : std_logic_vector(2 downto 0);
    signal s_sel         : std_logic_vector(1 downto 0);
    signal s_fo          : std_logic_vector(2 downto 0);
    
begin
    uut_mux_3bit_4to1 : entity work.mux_3bit_4to1
        port map(
            a_i           => s_a,
            b_i           => s_b,
            c_i           => s_c,
            d_i           => s_d,
            sel_i         => s_sel,
            f_o           => s_fo
        );

        p_stimulus : process
        begin
            report "Stimulus process started" severity note;
            -- set inputs for mux
            s_a <= "111"; 
            s_b <= "110"; 
            s_c <= "101"; 
            s_d <= "011"; 
            --choose first input
            s_sel <= "00";
            assert (s_fo = "111")
            report "Bad output on A selected" severity error;
            wait for 100 ns;
            s_sel <= "01";
            assert (s_fo = "110")
            report "Bad output on B selected" severity error;
            wait for 100 ns;
            s_sel <= "10";
            assert (s_fo = "101")
            report "Bad output on C selected" severity error;
            wait for 100 ns;
            s_sel <= "11";
            assert (s_fo = "011")
            report "Bad output on D selected" severity error;
            s_sel <= "00";
            assert (s_fo = "111")
            report "Bad output on A selected" severity error;
            wait for 100 ns;    
            -- Report a note at the end of stimulus process
            report "Stimulus process finished" severity note;
            wait; -- Data generation process is suspended forever
        end process p_stimulus;
    
end architecture testbench;