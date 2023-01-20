library IEEE;
use IEEE.std_logic_1164.ALL;

entity anim_struct is
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
end anim_struct;

architecture behaviour of anim_struct is
component mario_still is
    port (
        addr    : in std_logic_vector(7 downto 0); -- 12x16 = 192 < 2^8 = 256
        pixel   : out std_logic_vector(1 downto 0)
    );
end component;

component mario_wforw is
    port (
        addr    : in std_logic_vector(7 downto 0); -- 12x16 = 192 < 2^8 = 256
        pixel   : out std_logic_vector(1 downto 0)
    );
end component;

component mario_wnorm is
    port (
        addr    : in std_logic_vector(7 downto 0); -- 12x16 = 192 < 2^8 = 256
        pixel   : out std_logic_vector(1 downto 0)
    );
end component;

component anim_controller is
    port (
	clk	     : in std_logic;
        reset        : in std_logic;
        forw         : in std_logic;
        back         : in std_logic;
        enable    : in std_logic;
        sel_anim     : out std_logic;
        sel_move     : out std_logic
    );
end component;

component anim_multiplex is
   port(sel_anim    : in  std_logic;
        stand_still : in  std_logic_vector(1 downto 0);
        anim_frame  : in  std_logic_vector(1 downto 0);
        mario_frame : out std_logic_vector(1 downto 0));
end component;

component move_multiplex is
   port(sel_move   : in  std_logic;
        walk_forw  : in  std_logic_vector(1 downto 0);
        stand_norm : in  std_logic_vector(1 downto 0);
        anim_frame : out std_logic_vector(1 downto 0));
end component;

component direction_mux is
   port(sel_direction    : in  std_logic;
        ref_address : in  std_logic_vector(7 downto 0);
        norm_address  : in  std_logic_vector(7 downto 0);
        lut_address : out std_logic_vector(7 downto 0));
end component;

component inverse_m_address_gen is
   port(h             : in  std_logic_vector(9 downto 0);
        v             : in  std_logic_vector(9 downto 0);
        x             : in  std_logic_vector(8 downto 0);
        y             : in  std_logic_vector(7 downto 0);
        mario_address : out std_logic_vector(7 downto 0));
end component;

component m_address_gen is
   port(h             : in  std_logic_vector(9 downto 0);
        v             : in  std_logic_vector(9 downto 0);
        x             : in  std_logic_vector(8 downto 0);
        y             : in  std_logic_vector(7 downto 0);
        mario_address : out std_logic_vector(7 downto 0));
end component;

signal p1, p2, p3, p_int : std_logic_vector(1 downto 0);
signal s1, s2 : std_logic;
signal inverse_address_mux, normal_address_mux, address: std_logic_vector(7 downto 0);

begin


inverse_gen: component inverse_m_address_gen port map(h => h, v => v, x => x, y => y, mario_address => inverse_address_mux);

normal_gen: component m_address_gen port map(h => h, v => v, x => x, y => y, mario_address => normal_address_mux);

direction_multiplexer: component direction_mux port map(sel_direction => Ani, ref_address => inverse_address_mux, norm_address => normal_address_mux, lut_address => address);


stand: component mario_still port map (address, p1);
norm: component mario_wnorm port map (address, p2);
forward: component mario_wforw port map (address, p3);
move_mux: component move_multiplex port map(s1, p3, p2, p_int);
anim_mux: component anim_multiplex port map (s2, p1, p_int, pixel);
cont: component anim_controller port map (clk, reset, forw, back, enable, s2, s1);

end behaviour;
