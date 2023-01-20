library IEEE;
use IEEE.std_logic_1164.ALL;

entity mario_struct is
   port(clk     : in  std_logic;
        reset   : in  std_logic;
        L       : in  std_logic;
        R       : in  std_logic;
        A       : in  std_logic;
        B       : in  std_logic;
	rx	: in std_logic;

	disable_camera: in std_logic;
	always_win: in std_logic;
	collide_south: in std_logic;
	never_lose: in std_logic;

 	hsync   : out std_logic;
        vsync   : out std_logic;
        red     : out std_logic_vector(3 downto 0);
        green   : out std_logic_vector(3 downto 0);
        blue    : out std_logic_vector(3 downto 0);
	pwm	: out std_logic;
	tx	: out std_logic);
end mario_struct;

architecture structural of mario_struct is

component graphx_struct is
   port(clk   : in  std_logic;
        reset : in  std_logic;
	x     : in std_logic_vector(8 downto 0);
	y     : in std_logic_vector(7 downto 0);
	--enemies
	x1     : in std_logic_vector(11 downto 0);
	y1    : in std_logic_vector(7 downto 0);
	x2     : in std_logic_vector(11 downto 0);
	y2     : in std_logic_vector(7 downto 0);
	killed1 : in std_logic;
	killed2 : in std_logic;
	always_win : in std_logic;
	--timer
	x_cam		: in std_logic_vector(11 downto 0);
	lut_to_rgb : in std_logic_vector (3 downto 0);
        hsync : out std_logic;
        vsync : out std_logic;
	lut_address : out std_logic_vector(11 downto 0);
	
        red   : out std_logic_vector(3 downto 0);
        green : out std_logic_vector(3 downto 0);
        blue  : out std_logic_vector(3 downto 0);
	forw  : in std_logic;
	back  : in std_logic;
	Ani   : in std_logic;
	lose	: in std_logic;
	win	: in std_logic;
	enable: in std_logic;
	dgd1  : out std_logic;
	dgd2  : out std_logic;
	start : out std_logic);
end component;



component map_lut_struct is
   port(map_address : in  std_logic_vector(11 downto 0);
        vga_address : in  std_logic_vector(11 downto 0);
        vsync_sel   : in  std_logic;
        lut_output  : out std_logic_vector(3 downto 0));
end component;

component physics_module is
   port(clk       : in  std_logic;
        reset     : in  std_logic;
        L         : in  std_logic;
        R         : in  std_logic;
	B	  : in  std_logic;
	A	  : in  std_logic;
        Collision : in  std_logic_vector(3 downto 0);
	clk_from_map : in std_logic;
	kill	  : in std_logic;
	jump  : out std_logic;
	enable_goomba : out std_logic;
	enable_ani: out std_logic;
        X  : out std_logic_vector(11 downto 0);
	Y : out std_logic_vector(7 downto 0);
	Ani : out std_logic);
end component;

component collide_check is
    port (
        clk         : in std_logic;
        reset       : in std_logic;
        x_m     	: in std_logic_vector(11 downto 0); -- 0 <= x_m <= 319 < 2^9
        y_m	        : in std_logic_vector(7 downto 0); -- 0 <= y_m <= 239 < 2^8
        blk_data	: in std_logic_vector(3 downto 0);
        ready       : in std_logic;
	collide_south: in std_logic;
	x_cam	 : in std_logic_vector(11 downto 0);
        addr    	: out std_logic_vector(11 downto 0);
        NESW    	: out std_logic_vector(3 downto 0);
        victory 	: out std_logic;
        lose    	: out std_logic;
        goomba_x_1  : in std_logic_vector(11 downto 0);
        goomba_y_1  : in std_logic_vector(7 downto 0);
        goomba_x_2  : in std_logic_vector(11 downto 0);
        goomba_y_2  : in std_logic_vector(7 downto 0);
	ESW_G1	: out std_logic_vector(2 downto 0);
	ESW_G2	: out std_logic_vector(2 downto 0)
    );
end component;

component goomba_physics is
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
end component;

component lose_or_gate is
   port(lose1      : in  std_logic;
        lose2      : in  std_logic;
	never_lose : in std_logic;
        final_lose : out std_logic);
end component;

component timer_display is
    port(
        clk, rst                  : in std_logic;
        time_up                   : out std_logic;
        Seven_Segment_h           : out std_logic_vector (6 downto 0);
        Seven_Segment_t           : out std_logic_vector (6 downto 0);
        Seven_Segment_o           : out std_logic_vector (6 downto 0);
        warning                   : out std_logic
    );
end component;

component camera is
    port (
        clk   : in std_logic;
        reset : in std_logic;
        x_abs : in std_logic_vector(11 downto 0);
        ready : in std_logic;
	disable_camera: in std_logic;
        x_rel : out std_logic_vector(8 downto 0);
        x_cam : out std_logic_vector(11 downto 0));
end component;


component apu is
   port(clk     : in  std_logic;
        reset   : in  std_logic;
        start   : in  std_logic; --'right' signal
        death   : in  std_logic; -- gameover
        win     : in  std_logic; 
        jump    : in  std_logic; -- jump signal
        splat   : in  std_logic; -- kill signal from enemies module
        bump    : in  std_logic; -- collision north
        rx      : in  std_logic;
        tx      : out std_logic;
        pwm     : out std_logic);
end component;

component inputbuffer is
    port (  clk             : in    std_logic;
            reset           : in    std_logic;
            left            : in    std_logic;
            right           : in    std_logic;
            a               : in    std_logic;
            b               : in    std_logic;
	    disable_camera: in std_logic;
	    always_win: in std_logic;
	    collide_south: in std_logic;
	    never_lose: in std_logic;
            data_out        : out   std_logic_vector(7 downto 0));
            
end component;

component reset_toggle is
    port(
        reset           : in std_logic;
        forward           : in std_logic;
        clk             : in std_logic;
        reset_local     : out std_logic
    );
end component;



signal ready_temp, vsync_temp, victory_temp, lose_temp, lose_temp_2, final_lose, jump_temp, kill_temp, start_temp, reset_local_temp, enable_goomba_temp, enable_ani_temp, dead_goomba_done_temp, L_signal, R_signal, A_signal,  B_signal, disable_camera_signal, always_win_signal, collide_south_signal, never_lose_signal: std_logic;
signal x_temp, XG1, XG2, col_address_temp, vga_address_temp, x_shift: std_logic_vector(11 downto 0);
signal y_temp, YG1, YG2: std_logic_vector(7 downto 0);
signal x_cam_graphx: std_logic_vector(8 downto 0);
signal nesw_temp: std_logic_vector(3 downto 0);
signal blk_data_temp: std_logic_vector(3 downto 0);
signal ani_temp: std_logic;
signal ESW_G1_temp, ESW_G2_temp: std_logic_vector(2 downto 0);
signal seven_segment_h_temp, seven_segment_o_temp, seven_segment_t_temp: std_logic_vector(6 downto 0);
signal time_up_temp, warning_temp : std_logic;
signal killG1_temp, killG2_temp, dgd1_temp, dgd2_temp: std_logic;


begin

physics: physics_module port map ( clk => clk, reset => reset_local_temp, L => L_signal, R => R_signal, B => B_signal, A => A_signal, Collision => nesw_temp, clk_from_map => vsync_temp, kill => kill_temp, jump => jump_temp, enable_goomba => enable_goomba_temp, enable_ani => enable_ani_temp, X => x_temp, Y => y_temp, Ani => ani_temp);

collide_checker: collide_check port map(x_cam => x_shift, clk => clk, reset => reset_local_temp, x_m => x_temp, y_m => y_temp, blk_data => blk_data_temp, ready => ready_temp, collide_south => collide_south_signal, addr => col_address_temp, NESW => nesw_temp, victory => victory_temp, lose => lose_temp, goomba_x_1 => XG1, goomba_x_2 => XG2, goomba_y_1 => YG1, goomba_y_2 => YG2, ESW_G1 => ESW_G1_temp, ESW_G2 => ESW_G2_temp);

goomba: goomba_physics port map(clk => clk, reset => reset_local_temp, enable => enable_goomba_temp, collisionG1 => ESW_G1_temp, collisionG2 => ESW_G2_temp, mario_x => x_temp, mario_y => y_temp, X_G1 => XG1, Y_G1 => YG1, X_G2 => XG2, Y_G2 => YG2, ready_signal => ready_temp, lose => lose_temp_2, kill => kill_temp, kill_G1 => killG1_temp, kill_G2 => killG2_temp, dead_goomba1_done => dgd1_temp, dead_goomba2_done => dgd2_temp, x_cam =>x_shift);

mux_lut: map_lut_struct port map( map_address => col_address_temp, vga_address => vga_address_temp, vsync_sel => vsync_temp, lut_output => blk_data_temp);

graphx: graphx_struct port map(x_cam => x_shift, clk => clk, reset => reset, x => x_cam_graphx, y => y_temp, x1 => XG1, y1 => YG1, x2 => XG2, y2 => YG2, killed1 => killG1_temp, killed2 => killG2_temp, always_win => always_win_signal,  lut_to_rgb => blk_data_temp, hsync => hsync, vsync => vsync_temp, lut_address => vga_address_temp, red => red, green => green, blue => blue, forw => R_signal, back => L_signal, Ani => ani_temp, lose => final_lose, win => victory_temp, enable=> enable_ani_temp, dgd1 => dgd1_temp, dgd2 => dgd2_temp);

lose_or: lose_or_gate port map(lose1 => lose_temp, lose2 => lose_temp_2, never_lose => never_lose_signal, final_lose => final_lose);

--timer: timer_display port map(clk, rst => reset_local_temp, time_up => time_up_temp, seven_segment_h => seven_segment_h_temp, seven_segment_t => seven_segment_t_temp, seven_segment_o => seven_segment_o_temp, warning => warning_temp);

camera_module: camera port map(clk => clk, reset => reset, x_abs => x_temp, ready => ready_temp, disable_camera => disable_camera_signal, x_rel => x_cam_graphx, x_cam => x_shift);



sound_module: apu port map(clk => clk, reset => reset_local_temp, start => R_signal, death => final_lose, win => victory_temp, jump => jump_temp, splat => kill_temp, bump => nesw_temp(3), rx => rx, tx => tx, pwm => pwm);

input: inputbuffer
    port map(  clk => clk,
            reset => reset,
            left => L,
            right => R,
            a => A,
            b => B,
	    disable_camera => disable_camera,
	    always_win => always_win,
	    collide_south => collide_south,
	    never_lose => never_lose,
            data_out(0) => L_signal,
            data_out(1) => R_signal,
            data_out(2) => A_signal,
            data_out(3) => B_signal,
	    data_out(4) => disable_camera_signal,
            data_out(5) => always_win_signal,
            data_out(6) => collide_south_signal,
            data_out(7) => never_lose_signal);


reset_module: reset_toggle port map(clk => clk, reset => reset, forward => R_signal, reset_local => reset_local_temp);

vsync <= vsync_temp;


end structural;


