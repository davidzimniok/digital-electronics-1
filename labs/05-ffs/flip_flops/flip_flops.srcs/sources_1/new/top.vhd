----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/16/2022 01:50:17 PM
-- Design Name: 
-- Module Name: top - Behavioral
-- Project Name: 
-- Target Devices: 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity top is
    Port ( CLK100MHZ : in STD_LOGIC;
           BTNC : in STD_LOGIC;                         -- synchronous reset
           SW : in STD_LOGIC;                           -- serial input of data
           LED : out std_logic_vector (3 downto 0));    -- output of SIPO
end top;

architecture Behavioral of top is

-- signals beteen each flip-flop 
signal s_ff : std_logic_vector (3 downto 0);
signal clkdiv : STD_LOGIC;

begin

    fdiv : entity work.fdivider
    port map(
      CLKM   => CLK100MHZ,
      CLKH   => clkdiv
    );

    d_ff_0 : entity work.d_ff_rst
    port map(
      clk   => clkdiv,
      rst   => BTNC,
      d     => SW,   
      q     => s_ff(0)
    );
    
    d_ff_1 : entity work.d_ff_rst
    port map(
      clk   => clkdiv,
      rst   => BTNC,
      d     => s_ff(0),   
      q     => s_ff(1)
    );
    
    d_ff_2 : entity work.d_ff_rst
    port map(
      clk   => clkdiv,
      rst   => BTNC,
      d     => s_ff(1),   
      q     => s_ff(2)
    );
    
    d_ff_3 : entity work.d_ff_rst
    port map(
      clk   => clkdiv,
      rst   => BTNC,
      d     => s_ff(2),   
      q     => s_ff(3)
    );
    
    LED <= s_ff;
        
end Behavioral;
