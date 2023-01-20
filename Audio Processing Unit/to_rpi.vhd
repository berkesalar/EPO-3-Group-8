library IEEE;
use IEEE.std_logic_1164.ALL;

entity to_rpi is
   port(clk     : in  std_logic;
        reset   : in  std_logic;
        start   : in  std_logic;
        win     : in  std_logic;
        death   : in  std_logic;
        jump    : in  std_logic;
        splat   : in  std_logic;
        bump    : in  std_logic;
        serial  : out std_logic;
		  note_reset: out std_logic);
end to_rpi;
  
architecture behaviour of to_rpi is
component signal_detect is
   port(clk			: in std_logic;
		reset  : in  std_logic;
        input  : in  std_logic;
        output : out std_logic);
end component;
component sfx_select is
   port(clk   : in  std_logic;
        reset : in  std_logic;
        bump  : in  std_logic;
        splat : in  std_logic;
        jump  : in  std_logic;
        sfx   : out std_logic_vector(1 downto 0));
end component;
component music_select is
   port(clk,reset     : in  std_logic;
        start     : in  std_logic;
		win		  : in  std_logic;
		death     : in	 std_logic;
        music_id  : out std_logic_vector(2 downto 0));
end component;
component pre_write_mod is
   port(clk          : in  std_logic;
        reset        : in  std_logic;
        music_id     : in  std_logic_vector(2 downto 0);
        sfx          : in  std_logic_vector(1 downto 0);
        enable       : in  std_logic;
        music_change : out std_logic;
        sfx_change   : out std_logic;
        music_out    : out std_logic_vector(2 downto 0);
        sfx_out      : out std_logic_vector(1 downto 0));
end component;
component uart_clk_gen_w is
   port(clk      : in  std_logic;
        reset    : in  std_logic;
        uart_clk_w : out std_logic);
end component;
component write_fsm_m is
   port(clk            : in  std_logic;
        reset          : in  std_logic;
        uart_clk       : in  std_logic;
        sfx            : in  std_logic_vector(1 downto 0);
        music_id       : in  std_logic_vector(2 downto 0);
        sfx_change     : in  std_logic;
        music_change   : in  std_logic;
        serial         : out std_logic;
        uart_clk_reset : out std_logic;
        write_done     : out std_logic);
end component;
signal windetect, deathdetect, startdetect, write_done, music_change, sfx_change, uart_clk, uart_reset : std_logic;
signal music_id, music_out : std_logic_vector(2 downto 0);
signal sfx_id, sfx_out : std_logic_vector(1 downto 0);
begin
lbl1: signal_detect port map(clk,reset,win,windetect);
lbl2: signal_detect port map(clk,reset,death,deathdetect);
lbl3: signal_detect port map(clk,reset,start,startdetect);
lbl4: sfx_select port map(clk, reset, bump, splat, jump, sfx_id);
lbl5: music_select port map(clk,reset, startdetect, windetect, deathdetect, music_id);
lbl6: pre_write_mod port map(clk, reset, music_id, sfx_id, write_done, music_change, sfx_change, music_out, sfx_out);
lbl7: uart_clk_gen_w port map(clk, uart_reset, uart_clk);
lbl8: write_fsm_m port map(clk, reset, uart_clk, sfx_out, music_out, sfx_change, music_change, serial, uart_reset, write_done);
note_reset <= music_change;
end behaviour;
