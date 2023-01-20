library IEEE;
use IEEE.std_logic_1164.ALL;
use ieee.numeric_std.all;

architecture structural of inputbuffer is
    
        signal temp             :   std_logic_vector(7 downto 0);
        signal input_signals    :   std_logic_vector(7 downto 0);
    
        component reg_6_bit is
                port    (clk, reset     : in    std_logic;
                        d               : in    std_logic_vector(7 downto 0);
                        q               : out   std_logic_vector(7 downto 0));
        end component reg_6_bit;
    
    begin
    
        input_signals(0)        <= left;
        input_signals(1)        <= right;
        input_signals(2)        <= a;
        input_signals(3)        <= b;
	input_signals(4)        <= disable_camera;
        input_signals(5)        <= always_win;
        input_signals(6)        <= collide_south;
        input_signals(7)        <= never_lose;
    
        reg1: reg_6_bit port map (clk => clk, reset => reset, d => input_signals, q => temp);
        reg2: reg_6_bit port map (clk => clk, reset => reset, d => temp, q => data_out);
end structural;
