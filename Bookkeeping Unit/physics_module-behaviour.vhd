library IEEE;
use IEEE.std_logic_1164.ALL;

architecture behaviour of physics_module is

component clock_module is
   port(clk     : in  std_logic;
	reset   : in  std_logic;
	clk_from_map : in std_logic;
        enable_acc : out std_logic;
        enable_vel : out std_logic;
        enable_xy  : out std_logic;
		  enable_ani : out std_logic;
	enable_goomba: out std_logic);
end component;


component acceleration_module
	port( clk: in std_logic;
	      enable_acc : in std_logic;
	      reset : in std_logic; 
	      L : in std_logic;
              R : in std_logic;
	      B : in std_logic;
	      airborne : in std_logic;
	      Collision_L: in std_logic;
	      Collision_R: in std_logic;
	      Velocity: in std_logic_vector(10 downto 0);
	      Acceleration: out std_logic_vector(5 downto 0));
end component;

component vel_calc_x
    port(
        clk             : in    std_logic;
	enable_vel		: in	std_logic;
        rst             : in    std_logic;
        b               : in    std_logic;
        collision       : in    std_logic_vector(3 downto 0);
        a_x             : in    std_logic_vector(5 downto 0);
        v_x_out         : out   std_logic_vector(10 downto 0)
    );
end component;

component acceleration_y
	port(clk        : in  std_logic;
	enable_acc		: in	std_logic;
        reset          : in  std_logic;
        A              : in  std_logic;
	Collision_Down   : in  std_logic;
	kill		: in std_logic;
        jump           : out std_logic;
	airborne		: out std_logic;
        Acceleration_y : out std_logic_vector(10 downto 0));
end component;

component vel_calc_y is
	port(
        clk             : in    std_logic;
	enable_vel		: in	std_logic;
        rst             : in    std_logic;
	a_y		: in	std_logic_vector(10 downto 0);
	collision       : in    std_logic_vector(3 downto 0);
	v_y_out		: out	std_logic_vector(11 downto 0)
    );
end component;

component xy_calc is
    port(
        clk             : in std_logic;
	enable_xy		: in	std_logic;
        rst             : in std_logic;
        v_x             : in std_logic_vector(10 downto 0);
        v_y             : in std_logic_vector(11 downto 0);
        x_out           : out std_logic_vector(11 downto 0);
        y_out           : out std_logic_vector(7 downto 0);
	Ani		: out std_logic
        );
end component;



signal enable_acc_signal, enable_vel_signal, enable_xy_signal, A2, B2, R2, L2: std_logic;
signal Velocity_signal, Acceleration_y_signal: std_logic_vector(10 downto 0);
signal Velocity_y_signal: std_logic_vector(11 downto 0);
signal Acceleration_signal: std_logic_vector(5 downto 0);
signal airborne_temp: std_logic;


begin

circ1: clock_module
	port map(
	clk => clk,
	reset => reset,
	clk_from_map => clk_from_map,
       	enable_acc => enable_acc_signal,
        enable_vel => enable_vel_signal,
        enable_xy => enable_xy_signal,
	enable_ani => enable_ani,
	enable_goomba => enable_goomba 
);

circ2: acceleration_module
	port map( 
	      clk => clk,
	      enable_acc => enable_acc_signal,
	      reset => reset,
	      L => L2,
              R  => R2,
	      B => B2,
	      airborne => airborne_temp,
	      Collision_L => Collision(0),
	      Collision_R => Collision(2),
	      Velocity => Velocity_signal,
	      Acceleration => Acceleration_signal
);

circ3: vel_calc_x
    port map(
        clk => clk,
	enable_vel => enable_vel_signal,
        rst => reset,
        b => B2,
        collision => Collision,
        a_x => Acceleration_signal,
        v_x_out => Velocity_signal
    );

circ4: acceleration_y
   port map(clk => clk,
	enable_acc => enable_acc_signal,
        reset => reset,
        A => A2,
	Collision_Down => Collision(1), --converted to 3 from 1
	kill => kill,
        airborne => airborne_temp,
	jump => jump,
        Acceleration_y => Acceleration_y_signal
	);

circ5: vel_calc_y
	port map(
        clk =>clk,
	enable_vel=> enable_vel_signal,
        rst => reset,
	a_y => Acceleration_y_signal,
	collision => Collision,
	v_y_out => velocity_y_signal
    );

circ6: xy_calc
    port map(
        clk => clk,
	enable_xy=> enable_xy_signal,
        rst => reset,
        v_x => Velocity_signal,
        v_y => velocity_y_signal,
	X_out => X,
	Y_out => Y,
	Ani => Ani
        );

A2 <= not(A);
B2 <= not(B);
L2 <= not(L);
R2 <= not(R);
				
end behaviour;

