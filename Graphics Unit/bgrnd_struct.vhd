library IEEE;
use IEEE.std_logic_1164.ALL;

entity background_struct is
   port(clk		   : in std_logic;
	reset	   : in std_logic;
	h_val      : in  std_logic_vector(9 downto 0);
        v_val      : in  std_logic_vector(9 downto 0);
        lut_to_rgb : in  std_logic_vector(3 downto 0);
        map_red    : out std_logic_vector(3 downto 0);
        map_green  : out std_logic_vector(3 downto 0);
        map_blue   : out std_logic_vector(3 downto 0);
	x_shift	   : in std_logic_vector(11 downto 0));
end background_struct;

architecture structural of background_struct is

component brick_lut is
    port (
        addr    : in std_logic_vector(7 downto 0); -- 16x16 
        pixel   : out std_logic_vector(1 downto 0) -- yellow (00), brown (01), black (10)
    );
end component;


component block_lut is
    port (
        addr    : in std_logic_vector(7 downto 0); -- 16x16 
        pixel   : out std_logic_vector(1 downto 0) -- yellow (00), brown (01), black (10)
    );
end component;


component block_rgb is
port(   clk		 :  in std_logic;
	block_lut_data : in  std_logic_vector(1 downto 0);
        red      : out std_logic_vector(3 downto 0);
        green    : out std_logic_vector(3 downto 0);
        blue     : out std_logic_vector(3 downto 0));
end component;



component blk_address_gen is
   port(clk			: in std_logic;
	reset				: in std_logic;
	h             : in  std_logic_vector(9 downto 0);
	v	     : in std_logic_vector(9 downto 0);
	x_shift		: in std_logic_vector(11 downto 0); 
        blk_address : out std_logic_vector(7 downto 0));
	
end component;


component background_mux is
   port(background_select_bit : in  std_logic_vector(1 downto 0);
   
        block1 : in  std_logic_vector(1 downto 0);
  
        block2 : in  std_logic_vector(1 downto 0);

        lut_data_mux : out  std_logic_vector(1 downto 0));
end component;

component background_control is
   port(clk      : in  std_logic;
        reset    : in  std_logic;
        h_reg    : in  std_logic_vector(9 downto 0);
        v_reg    : in  std_logic_vector(9 downto 0);
        lut_data : in  std_logic_vector(3 downto 0);
        background_muxselect : out std_logic_vector(1 downto 0));
end component;

signal blk_lut_address: std_logic_vector(7 downto 0);
signal block_lut_data, brick_lut_data, background_select, lut_data_mux_out: std_logic_vector (1 downto 0);
signal red_block, green_block, blue_block, red_brick, green_brick, blue_brick: std_logic_vector(3 downto 0);




begin

address_generator: component blk_address_gen port map(clk =>clk, reset => reset, h => h_val, v => v_val, x_shift => x_shift, blk_address => blk_lut_address);
block_outline: component block_lut port map(addr => blk_lut_address, pixel => block_lut_data);
brick_outline: component brick_lut port map(addr => blk_lut_address, pixel => brick_lut_data);

--rgb_for_block: component block_rgb port map(clk => clk, block_lut_data => block_lut_data, red => red_block, green => green_block, blue => blue_block);
--rgb_for_brick: component block_rgb port map(clk => clk, block_lut_data => brick_lut_data, red => red_brick, green => green_brick, blue => blue_brick);


background_controller: component background_control port map(clk => clk, reset => reset, h_reg => h_val, v_reg => v_val, lut_data => lut_to_rgb, background_muxselect => background_select);


block_type_mux: component background_mux port map(background_select_bit => background_select, block1 => block_lut_data, block2 => brick_lut_data, lut_data_mux => lut_data_mux_out);

rgb_for_everything: component block_rgb port map(clk => clk, block_lut_data => lut_data_mux_out, red => map_red, green => map_green, blue => map_blue);



--background_multiplexer: component background_mux port map(background_select_bit => background_select, block1_red => red_block, block1_green => green_block, block1_blue => blue_block, block2_red => red_brick, block2_green => green_brick, block2_blue => blue_brick, red => map_red, green => map_green, blue => map_blue);



end structural;
