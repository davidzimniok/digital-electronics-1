----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/16/2022 02:16:36 PM
-- Design Name: 
-- Module Name: fdivider - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity fdivider is
    Port ( CLKM : in STD_LOGIC;
           CLKH : out STD_LOGIC);
end fdivider;

architecture Behavioral of fdivider is

signal clkl : std_logic; 

begin
    fdivider_pr : process(CLKM)
    variable count : integer := 0;
    begin
        if rising_edge(CLKM) then  -- Synchronous process
                count := count+1;
                if count = 10000000 then
                    clkl    <= not clkl;
                    count := 0; 
                end if;
        end if;
        CLKH <= clkl;
    end process fdivider_pr;
end Behavioral;
