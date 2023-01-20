library IEEE;
use IEEE.std_logic_1164.ALL;

entity screens_struct is
   port(clk   : in  std_logic;
        reset : in  std_logic;
        h     : in  std_logic_vector(9 downto 0);
        v     : in  std_logic_vector(9 downto 0);
        lose  : in  std_logic;
        win   : in  std_logic;
	start   : out std_logic;
        red_screen   : out std_logic_vector(3 downto 0);
        green_screen : out std_logic_vector(3 downto 0);
        blue_screen  : out std_logic_vector(3 downto 0));
end screens_struct;

architecture structural of screens_struct is

component win_lut is
    port (
        addr    : in std_logic_vector(7 downto 0);
        blk_data: out std_logic
    );
end component;

component start_lut is
    port (
        addr    : in std_logic_vector(7 downto 0);
        blk_data: out std_logic
    );
end component;

component game_over_lut is
    port (
        addr    : in std_logic_vector(7 downto 0);
        blk_data: out std_logic
    );
end component;

component screen_address_gen is
   port(h             : in  std_logic_vector(9 downto 0);
        v             : in  std_logic_vector(9 downto 0);
        lose             : in  std_logic;
        win             : in  std_logic;
	restart		: in std_logic;
        mario_address : out std_logic_vector(7 downto 0));
end component;

component screen_mux is
   port(lose_lut   : in  std_logic;
        win_lut    : in  std_logic;
        start_lut  : in  std_logic;
	lose_sel   : in std_logic;
	win_sel   : in std_logic;
	start_sel   : in std_logic;
        screen : out std_logic);
end component;


component screen_color is
   port(lut_val : in  std_logic;
        red     : out std_logic_vector(3 downto 0);
        green   : out std_logic_vector(3 downto 0);
        blue    : out std_logic_vector(3 downto 0));
end component;

component screen_sel_fsm is
   port(clk		: in std_logic;
	dead    : in  std_logic;
        victory : in  std_logic;
        reset   : in  std_logic;
        lose    : out std_logic;
        win     : out std_logic;
        restart : out std_logic);
end component;

signal lose_lut_address, win_lut_address, start_lut_address: std_logic;
signal lut_address: std_logic_vector(7 downto 0);
signal lose_lut_val, win_lut_val, start_lut_val: std_logic;
signal screen_colors: std_logic;
begin

selecting_lut: component screen_sel_fsm port map(clk => clk, dead => lose, victory => win, reset => reset, lose => lose_lut_address, win => win_lut_address, restart => start_lut_address);

address_generator: component screen_address_gen port map(h => h, v => v, lose => lose_lut_address, win => win_lut_address, restart => start_lut_address, mario_address => lut_address);

winlut: component win_lut port map(addr => lut_address, blk_data => win_lut_val);
loselut: component game_over_lut port map(addr => lut_address, blk_data => lose_lut_val);
startlut: component start_lut port map(addr => lut_address, blk_data => start_lut_val);

screenmux: component screen_mux port map(lose_lut => lose_lut_val, win_lut => win_lut_val, start_lut => start_lut_val, lose_sel => lose_lut_address, win_sel => win_lut_address, start_sel => start_lut_address, screen => screen_colors);

producing_colors: component screen_color port map(lut_val => screen_colors, red => red_screen, green => green_screen, blue => blue_screen);

start <= start_lut_address;

end structural;

