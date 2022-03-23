----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/23/2022 01:34:47 PM
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
    Port ( CLK100MHZ : in STD_LOGIC;                -- main clock
           SW : in STD_LOGIC;                       -- counter direction
           LED : out STD_LOGIC_VECTOR (15 downto 0); -- couner value LED
           CA : out STD_LOGIC;                      -- 7seg led diode
           CB : out STD_LOGIC;                      -- 7seg led diode
           CC : out STD_LOGIC;                      -- 7seg led diode
           CD : out STD_LOGIC;                      -- 7seg led diode
           CE : out STD_LOGIC;                      -- 7seg led diode
           CF : out STD_LOGIC;                      -- 7seg led diode
           CG : out STD_LOGIC;                      -- 7seg led diode
           AN : out STD_LOGIC_VECTOR (7 downto 0);  -- common anodes for 7seg display
           BTNC : in STD_LOGIC);                    -- reset buttnos
end top;

------------------------------------------------------------------------
-- Architecture body for top level
------------------------------------------------------------------------
architecture Behavioral of top is

  -- Internal clock enable
  signal s_en  : std_logic;
  signal s_en10  : std_logic;
  -- Internal counter
  signal s_cnt : std_logic_vector(4 - 1 downto 0);
  signal s_cnt10 : std_logic_vector(16 - 1 downto 0);

begin

  --------------------------------------------------------------------
  -- Instance (copy) of clock_enable entity
  clk_en0 : entity work.clock_enable
      generic map(
          g_MAX => 25000000
      )
      port map(
          clk   => CLK100MHZ,
          reset => BTNC,
          ce_o  => s_en
      );
      
  --------------------------------------------------------------------
  -- Instance (copy) of clock_enable entity
  clk_en1 : entity work.clock_enable
      generic map(
          g_MAX => 1000000
      )
      port map(
          clk   => CLK100MHZ,
          reset => BTNC,
          ce_o  => s_en10
      );

  --------------------------------------------------------------------
  -- Instance (copy) of cnt_up_down entity
  bin_cnt0 : entity work.cnt_up_down
     generic map(
          g_CNT_WIDTH => 4
      )
      port map(
          clk       =>  CLK100MHZ,
          reset     =>  BTNC,
          en_i      =>  s_en,
          cnt_up_i  =>  SW,
          cnt_o     =>  s_cnt
      );

  --------------------------------------------------------------------
  -- Instance (copy) of cnt_up_down entity
  bin_cnt1 : entity work.cnt_up_down
     generic map(
          g_CNT_WIDTH => 16
      )
      port map(
          clk       =>  CLK100MHZ,
          reset     =>  BTNC,
          en_i      =>  s_en10,
          cnt_up_i  =>  SW,
          cnt_o     =>  s_cnt10
      );
      
  --------------------------------------------------------------------
  -- Instance (copy) of hex_7seg entity
  hex2seg : entity work.hex_7seg
      port map(
          hex_i    => s_cnt,
          seg_o(6) => CA,
          seg_o(5) => CB,
          seg_o(4) => CC,
          seg_o(3) => CD,
          seg_o(2) => CE,
          seg_o(1) => CF,
          seg_o(0) => CG
      );

  -- Connect one common anode to 3.3V
  AN <= b"1111_1110";

  -- Display counter values on LEDs
  LED(15 downto 0) <= s_cnt10;

end architecture Behavioral;
