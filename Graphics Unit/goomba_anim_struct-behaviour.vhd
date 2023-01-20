library IEEE;
use IEEE.std_logic_1164.ALL;



architecture behaviour of goomba_anim_struct is

component en_address_gen is
   port(h             : in  std_logic_vector(9 downto 0);
        v             : in  std_logic_vector(9 downto 0);
        x1             : in  std_logic_vector(8 downto 0);
        y1             : in  std_logic_vector(7 downto 0);
		x2             : in  std_logic_vector(8 downto 0);
        y2             : in  std_logic_vector(7 downto 0);
        enemies_address : out std_logic_vector(7 downto 0);
	s		: out std_logic);
end component;

component goomba_1 is
    port (
        addr    : in std_logic_vector(7 downto 0); -- 12x16 = 192 < 2^8 = 256
        pixel   : out std_logic_vector(1 downto 0)
    );
end component;

component goomba_2_lut is
    port (
        addr    : in std_logic_vector(7 downto 0); -- 12x16 = 192 < 2^8 = 256
        pixel   : out std_logic_vector(1 downto 0)
    );
end component;

component goomba_anim is
    port (
			clk: in std_logic;
        reset        	 : in std_logic;
	killed		 	 : in std_logic;
        enable    	 : in std_logic;
	dead_goomba_done : out std_logic;
        sel_goomba   	 : out std_logic_vector(1 downto 0)
    );
end component;

component goomba_dead is
    port (
        addr    : in std_logic_vector(7 downto 0); -- 12x16 = 192 < 2^8 = 256
        pixel   : out std_logic_vector(1 downto 0)
    );
end component;

component goomba_mux is
   port(sel_goomba        : in  std_logic_vector(1 downto 0);
        goomba_1        : in  std_logic_vector(1 downto 0);
        goomba_2        : in  std_logic_vector(1 downto 0);
        goomba_dead     : in std_logic_vector(1 downto 0);
	r		: in std_logic;
        goomba_out      : out std_logic_vector(1 downto 0));
end component;

component enemies_fsm is
   port(clk            : in  std_logic;
        reset          : in  std_logic;
        enemies_lut_data : in  std_logic_vector( 1 downto 0);
        red            : out std_logic_vector(3 downto 0);
        green          : out std_logic_vector(3 downto 0);
        blue           : out std_logic_vector(3 downto 0);
        enemies_sel_bit  : out std_logic);
end component;

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

component g_abs_rel is
    port(
        x_abs   : in std_logic_vector(11 downto 0);
        x_cam   : in std_logic_vector(11 downto 0);
        renderable : out std_logic;
        x_rel   : out std_logic_vector(8 downto 0)
    );
end component; 

component megamux is
   port(g_lut_data_1 : in  std_logic_vector(1 downto 0);
        g_lut_data_2 : in  std_logic_vector(1 downto 0);
	s	     : in  std_logic;
        g_lut_data   : out std_logic_vector(1 downto 0));
end component;

signal	en_address : std_logic_vector(7 downto 0);
signal	g1_lut_data		: std_logic_vector(1 downto 0);
signal	g2_lut_data		: std_logic_vector(1 downto 0);
signal	gd_lut_data, g_lut_data		: std_logic_vector(1 downto 0);
signal	gs1, gs2		: std_logic_vector(1 downto 0);
signal	g_lut_data_1, g_lut_data_2		: std_logic_vector(1 downto 0);
signal	en_select		: std_logic;
signal	en_red		: std_logic_vector(3 downto 0);
signal	en_green		: std_logic_vector(3 downto 0);
signal	en_blue		: std_logic_vector(3 downto 0);
signal  x_rel_g1, x_rel_g2			: std_logic_vector(8 downto 0);
signal r1,r2, select_bit		: std_logic;


begin

	addressgen 	: component en_address_gen 	port map(h, v, x_rel_g1, y1, x_rel_g2, y2, enemies_address => en_address, s => select_bit);
	goomba1	    : component	goomba_1 			port map(addr => en_address, pixel => g1_lut_data);
	goomba2	    : component	goomba_2_lut 			port map(addr => en_address, pixel => g2_lut_data);
	goombadead  : component	goomba_dead     port map(addr => en_address, pixel => gd_lut_data);
	goombabsrel_g1 : component g_abs_rel port map (x_abs => x1, x_cam => x_cam, renderable => r1, x_rel => x_rel_g1);
	goombabsrel_g2 : component g_abs_rel port map (x_abs => x2, x_cam => x_cam, renderable => r2, x_rel => x_rel_g2);
	goombamux   : component	goomba_mux 				port map(sel_goomba => gs1, goomba_1 => g1_lut_data, goomba_2 => g2_lut_data, goomba_dead => gd_lut_data, goomba_out => g_lut_data_1, r => r1);
	goombamux2  : component	goomba_mux 				port map(sel_goomba => gs2, goomba_1 => g1_lut_data, goomba_2 => g2_lut_data, goomba_dead => gd_lut_data, goomba_out => g_lut_data_2, r => r2);
	mega_mux     :	component megamux				port map(g_lut_data_1 => g_lut_data_1, g_lut_data_2 => g_lut_data_2, s => select_bit, g_lut_data => g_lut_data);
	enemiesfsm  : component	enemies_fsm				port map(clk => clk, reset => reset, enemies_lut_data => g_lut_data, red => en_red, green => en_green, blue => en_blue, enemies_sel_bit => en_select);
	goombaanim 	: component goomba_anim				port map(clk => clk, reset => reset, killed => killed1, enable => enable, dead_goomba_done => dgd1, sel_goomba => gs1);
	goombaanim2 : component goomba_anim				port map(clk => clk, reset => reset, killed => killed2, enable => enable, dead_goomba_done => dgd2, sel_goomba => gs2);
	rgbmux	    : component	rgb_multiplex			port map(mario_sel_bit => en_select, mario_red => en_red, mario_green => en_green, mario_blue => en_blue, map_red => red_total, map_green => green_total, map_blue => blue_total, red => red_out, green => green_out, blue => blue_out);

end behaviour;

