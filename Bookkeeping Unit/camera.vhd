library IEEE;
use IEEE.std_logic_1164.ALL;
use IEEE.numeric_std.all;

entity camera is
    port (
        clk   : in std_logic;
        reset : in std_logic;
        x_abs : in std_logic_vector(11 downto 0);
        ready : in std_logic;
	disable_camera: in std_logic;
        x_rel : out std_logic_vector(8 downto 0);
        x_cam : out std_logic_vector(11 downto 0));
end entity camera;
