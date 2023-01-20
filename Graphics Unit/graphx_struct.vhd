library IEEE;
use IEEE.std_logic_1164.ALL;

entity graphx_struct is
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
end graphx_struct;

architecture structural of graphx_struct is

--Counters for h,v and sync pulses-------------------------------------------------------------

component vga_counters is
   port(clk   : in  std_logic;
        reset : in  std_logic;
        h     : out std_logic_vector(9 downto 0);
        v  	  : out std_logic_vector (9 downto 0));
end component;

component hsync_vsync is
   port(h     : in  std_logic_vector(9 downto 0);
        hsync : out std_logic;
	v     : in  std_logic_vector(9 downto 0);
        vsync : out std_logic);
end component;

--Modules for the colours------------------------------------------------------------------------------

component rgb_fsm is
	port(
	clk          : in  std_logic;
    reset        : in  std_logic;
	lut_data	: in std_logic_vector(2 downto 0);			
	h_reg		: in std_logic_vector(9 downto 0);
	v_reg		: in std_logic_vector(9 downto 0);
	red          : out std_logic_vector(3 downto 0);
    green        : out std_logic_vector(3 downto 0);
    blue         : out std_logic_vector(3 downto 0));
end component;

------ LUT ARITHMETIC-----------------------------------------------------------------------------------------

component lut_move_addr is
   port(h       : in  std_logic_vector(9 downto 0);
        v       : in  std_logic_vector(9 downto 0);
	x_shift : in std_logic_vector(11 downto 0);
        address : out std_logic_vector(11 downto 0));
end component;


--BUFFER--------------------------------------------------------------------------------------------------------
component hv_buffer is
   port(clk   : in  std_logic;
        reset : in  std_logic;
        h_in  : in  std_logic_vector(9 downto 0);
        v_in  : in  std_logic_vector(9 downto 0);
        h_out : out std_logic_vector(9 downto 0);
        v_out : out std_logic_vector(9 downto 0));
end component;

component sync_buff is
   port(clk       : in  std_logic;
        reset     : in  std_logic;
        hsync_in  : in  std_logic;
        vsync_in  : in  std_logic;
        hsync_out : out std_logic;
        vsync_out : out std_logic);
end component;


---MARIO FSM------------------------------------------

component mario_fsm is
	port(
	clk          : in  std_logic;
    reset        : in  std_logic;
	mario_lut_data	: in std_logic_vector(1 downto 0);			
	red          : out std_logic_vector(3 downto 0);
    green        : out std_logic_vector(3 downto 0);
    blue         : out std_logic_vector(3 downto 0);
	mario_select_bit	 : out std_logic);
end component;

---MARIO LUT----------------------------------------
component mario_lut is
   port(addr  : in  std_logic_vector(7 downto 0);
        pixel : out std_logic_vector (1 downto 0));
end component;


----MULTIPLEXER---------------------
component rgb_multiplex is
   port(mario_sel_bit : in  std_logic;
        mario_red     : in  std_logic_vector(3 downto 0);
        mario_green   : in  std_logic_vector(3 downto 0);
        mario_blue    : in  std_logic_vector(3 downto 0);
        map_red       : in  std_logic_vector(3 downto 0);
        map_green     : in  std_logic_vector(3 downto 0);
        map_blue      : in  std_logic_vector(3 downto 0);
        red           : out std_logic_vector(3 downto 0);
        green         : out std_logic_vector(3 downto 0);
        blue          : out std_logic_vector(3 downto 0));
end component;


----MARIO ADDRESS GENERATOR--------
component m_address_gen is
   port(h             : in  std_logic_vector(9 downto 0);
        v             : in  std_logic_vector(9 downto 0);
        x             : in  std_logic_vector(8 downto 0);
        y             : in  std_logic_vector(7 downto 0);
        mario_address : out std_logic_vector(7 downto 0));
end component;

-----RGB BUFFER-----

component rgb_buffer is
   port(clk   : in  std_logic;
        reset : in  std_logic;
        red_in  : in  std_logic_vector(3 downto 0);
        green_in  : in  std_logic_vector(3 downto 0);
	blue_in  : in  std_logic_vector(3 downto 0);
        red_out : out std_logic_vector(3 downto 0);
        green_out : out std_logic_vector(3 downto 0);
	blue_out  : out  std_logic_vector(3 downto 0));
end component;


------MARIO ANIMATION-----
component anim_struct is
   port(clk		: in std_logic;
        reset   : in  std_logic;
        forw    : in  std_logic;
        back    : in  std_logic;
        enable		: in  std_logic;
	h	: in std_logic_vector(9 downto 0);
	v	: in std_logic_vector(9 downto 0);
	x	: in std_logic_vector(8 downto 0);
	y	: in std_logic_vector(7 downto 0);
	Ani	: in std_logic;
	pixel	: out std_logic_vector(1 downto 0));
end component;

---- Background Block design-----

component background_struct is
   port(clk		   : in std_logic;
	reset	   : in std_logic;
	h_val      : in  std_logic_vector(9 downto 0);
        v_val      : in  std_logic_vector(9 downto 0);
        lut_to_rgb : in  std_logic_vector(3 downto 0);
        map_red    : out std_logic_vector(3 downto 0);
        map_green  : out std_logic_vector(3 downto 0);
        map_blue   : out std_logic_vector(3 downto 0);
	x_shift	   : in std_logic_vector(11 downto 0));
end component;

component screens_struct is
   port(clk   : in  std_logic;
        reset : in  std_logic;
        h     : in  std_logic_vector(9 downto 0);
        v     : in  std_logic_vector(9 downto 0);
        lose  : in  std_logic;
        win   : in  std_logic;
	start : out std_logic;
        red_screen   : out std_logic_vector(3 downto 0);
        green_screen : out std_logic_vector(3 downto 0);
        blue_screen  : out std_logic_vector(3 downto 0));
end component;

component game_screenfsm is
   port(clk		: in std_logic;
	reset	: in std_logic;
	forw     : in  std_logic;
        lose     : in  std_logic;
        win      : in  std_logic;
        game_sel : out std_logic);
end component;


component vga_colors_mux is
   port(game_select_bit : in  std_logic;
   
        red_screen : in  std_logic_vector(3 downto 0);
        green_screen : in  std_logic_vector(3 downto 0);
        blue_screen : in  std_logic_vector(3 downto 0);
		
        red_game : in  std_logic_vector(3 downto 0);
        green_game : in  std_logic_vector(3 downto 0);
        blue_game : in  std_logic_vector(3 downto 0);
		
        red : out  std_logic_vector(3 downto 0);
        green : out  std_logic_vector(3 downto 0);
        blue : out  std_logic_vector(3 downto 0));
end component ;

component goomba_anim_struct is
	port (  clk             : in    std_logic;
            		reset           : in    std_logic;
            		h		: in 	std_logic_vector(9 downto 0);
		v		: in 	std_logic_vector(9 downto 0);
		enable		: in std_logic;
		x1             	: in  std_logic_vector(11 downto 0);
        		y1             	: in  std_logic_vector(7 downto 0);
		x2             	: in  std_logic_vector(11 downto 0);
       		y2             	: in  std_logic_vector(7 downto 0);
		killed1		: in std_logic;
		killed2		: in std_logic;
		red_total		: in std_logic_vector(3 downto 0);
		green_total		: in std_logic_vector(3 downto 0);
		blue_total		: in std_logic_vector(3 downto 0);
		x_cam		: in std_logic_vector(11 downto 0);
		red_out		: out std_logic_vector(3 downto 0);
		green_out		: out std_logic_vector(3 downto 0);
		blue_out		: out std_logic_vector(3 downto 0);
		dgd1		: out std_logic;
		dgd2		: out std_logic);
end component;


component timer_graphics_h is
   port(clk      : in  std_logic;
        reset    : in  std_logic;
		h             : in  std_logic_vector(9 downto 0);
        v             : in  std_logic_vector(9 downto 0);
		timer_data_h : in std_logic_vector ( 6 downto 0);
		timer_data_t : in std_logic_vector ( 6 downto 0);
		timer_data_o : in std_logic_vector ( 6 downto 0);
		timer_select    : out std_logic);
end component;



component timer_mux is
   port(timer_select_bit : in  std_logic;
   
        total_red : in  std_logic_vector(3 downto 0);
        total_green : in  std_logic_vector(3 downto 0);
        total_blue : in  std_logic_vector(3 downto 0);
		
        red : out  std_logic_vector(3 downto 0);
        green : out  std_logic_vector(3 downto 0);
        blue : out  std_logic_vector(3 downto 0));
end component;

signal h_val,v_val, v_buff_out, h_buff_out:std_logic_vector (9 downto 0);
signal mario_lut_address: std_logic_vector(7 downto 0);
signal hsync_1in,vsync_1in, hsync_2in, vsync_2in,mario_select_bit: std_logic;
signal mario_pixel: std_logic_vector(1 downto 0);
signal hsync_mid, vsync_mid, vsync_final: std_logic;

signal mario_red, mario_green, mario_blue, map_green, map_red, map_blue: std_logic_vector(3 downto 0);
signal red_buff, green_buff, blue_buff: std_logic_vector (3 downto 0);
signal red_screen, green_screen, blue_screen: std_logic_vector (3 downto 0);
signal red_game, green_game, blue_game: std_logic_vector (3 downto 0);
signal red_game2, green_game2, blue_game2: std_logic_vector (3 downto 0);
signal red_game3, green_game3, blue_game3: std_logic_vector (3 downto 0);
signal timerselect : std_logic;


signal graphx_sel: std_logic;
-- goomba_anim

begin

--Counters for h,v and sync pulses-------------------------------------------------------------
	counter: component vga_counters port map(clk => clk, reset => reset, h => h_val, v => v_val);

	hsync_blk: component hsync_vsync port map(h => h_val, hsync => hsync_1in,v => v_val, vsync => vsync_1in);


------- LUT ARITHMETIC -----


	lut_arithmetic_blk: component lut_move_addr port map(h => h_val, v => v_val, x_shift => x_cam, address => lut_address);

	
--Background generator------------------------------------------------------------------------------
	level_backgroound: component background_struct port map(clk => clk, reset => reset, h_val => h_val, v_val => v_val, lut_to_rgb => lut_to_rgb, x_shift => x_cam, map_red => map_red, map_green => map_green, map_blue => map_blue);

--BUFFER------------------------------------------------------------------------------------------------

	buffer_sync_blk1: component sync_buff port map (clk => clk, reset => reset, hsync_in => hsync_1in, vsync_in => vsync_1in, hsync_out => hsync_mid, vsync_out => vsync_mid);

	buffer_sync_blk2: component sync_buff port map (clk => clk, reset => reset, hsync_in => hsync_mid, vsync_in => vsync_mid, hsync_out => hsync, vsync_out => vsync_final);


	rgb_buffer_blk: component rgb_buffer port map(clk => clk, reset => reset, red_in => red_buff, green_in => green_buff, blue_in => blue_buff, red_out => red, green_out => green, blue_out => blue);



---Mario LUT
	
	mario_animations: component anim_struct port map(clk => clk, reset => reset, forw => forw, back => back, enable => enable, h => h_val, v => v_val, x => x, y => y, Ani => Ani, pixel => mario_pixel);


----Mario FSM

	mario_fsm_blk: component mario_fsm port map(clk => clk, reset => reset, mario_lut_data => mario_pixel, red => mario_red, green => mario_green, blue => mario_blue, mario_select_bit => mario_select_bit);

---- Multiplexer of the mario and the level----
	graphics_multiplexer: component rgb_multiplex port map(mario_sel_bit => mario_select_bit, mario_red => mario_red, mario_green => mario_green, mario_blue => mario_blue, map_red => map_red, map_green => map_green, map_blue => map_blue, red => red_game, green => green_game, blue => blue_game);	

----structural of the lose/win/start screen---


screens: component screens_struct port map (clk => clk, reset => reset, h=> h_val, v => v_val, lose => lose, win => (win or always_win), start => start, red_screen => red_screen, green_screen => green_screen, blue_screen => blue_screen);

----fsm for final graphx mux---

color_game_fsm: component game_screenfsm port map(clk => clk, reset => reset, forw => forw, lose => lose, win => (win or always_win), game_sel => graphx_sel);

----mux for timer graphx-----

graphx_mux: component vga_colors_mux port map(game_select_bit => graphx_sel, red_screen => red_screen, green_screen => green_screen, blue_screen=> blue_screen, red_game => red_game2, green_game => green_game2, blue_game => blue_game2, red => red_buff, green => green_buff, blue => blue_buff);

--goomba animation

goombaanim:	component goomba_anim_struct port map(clk, reset, x_cam => x_cam, h=>h_val, v=>v_val, enable => enable, x1=>x1 , y1=>y1 , x2=>x2, y2=>y2, killed1=>killed1, killed2=>killed2, red_total => red_game, green_total => green_game, blue_total => blue_game, red_out => red_game2 , green_out => green_game2, blue_out => blue_game2, dgd1=>dgd1, dgd2=>dgd2 );

---Timer Graphics
--timergraphicsh: component timer_graphics_h port map (clk, reset, h => h_val, v => v_val, timer_data_h => seven_segment_h, timer_data_t => seven_segment_t, timer_data_o => seven_segment_o, timer_select => timerselect);


---Timer Mux
--timermux: component timer_mux port map (timer_select_bit => timerselect, total_red => red_game2, total_green => green_game2, total_blue => blue_game2, red => red_game3, green => green_game3, blue => blue_game3);


vsync <= vsync_final;

end structural;
