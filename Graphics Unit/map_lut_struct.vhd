library IEEE;
use IEEE.std_logic_1164.ALL;

entity map_lut_struct is
   port(map_address : in  std_logic_vector(11 downto 0);
        vga_address : in  std_logic_vector(11 downto 0);
        vsync_sel   : in  std_logic;
        lut_output  : out std_logic_vector(3 downto 0));
end map_lut_struct;

architecture structural of map_lut_struct is

signal rom_lut_address: std_logic_vector(11 downto 0);


component rom_multiplex is
   port(rom_sel    : in  std_logic;
        map_output : in  std_logic_vector(11 downto 0);
        vga_output : in  std_logic_vector(11 downto 0);
        rom_input  : out std_logic_vector(11 downto 0));
end component;

component level_lut is
   port(addr  : in  std_logic_vector(11 downto 0);
        blk_data : out std_logic_vector(3 downto 0));
end component;


begin

mux: component rom_multiplex port map (rom_sel => vsync_sel, map_output => map_address, vga_output => vga_address, rom_input => rom_lut_address);

map_lut: component level_lut port map(addr => rom_lut_address, blk_data => lut_output);


end structural;
