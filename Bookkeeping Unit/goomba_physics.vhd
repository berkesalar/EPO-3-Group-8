library IEEE;
use IEEE.std_logic_1164.ALL;

entity goomba_physics is
   port(clk   : in  std_logic;
        reset : in  std_logic;
	enable: in  std_logic;
	collisionG1 : in std_logic_vector(2 downto 0);
	collisionG2 : in std_logic_vector(2 downto 0);
	mario_x	: in std_logic_vector(11 downto 0);
	mario_y : in std_logic_vector(7 downto 0);
	x_cam	: in std_logic_vector(11 downto 0);
        X_G1    : out std_logic_vector(11 downto 0);
        Y_G1    : out std_logic_vector(7 downto 0);
        X_G2    : out std_logic_vector(11 downto 0);
        Y_G2    : out std_logic_vector(7 downto 0);
	ready_signal: out std_logic;
	lose: out std_logic;
	kill: out std_logic;
	kill_G1: out std_logic;
	kill_G2: out std_logic;
	dead_goomba1_done: in std_logic;
	dead_goomba2_done: in std_logic);
end goomba_physics;
