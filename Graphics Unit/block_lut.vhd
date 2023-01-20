library ieee;
use ieee.std_logic_1164.all;

entity block_lut is
    port (
        addr    : in std_logic_vector(7 downto 0); -- 16x16 
        pixel   : out std_logic_vector(1 downto 0) -- yellow (00), brown (01), black (10)
    );
end entity block_lut;

architecture lut of block_lut is

    begin
    
        with addr select pixel <=
            "01" when "00000000",
            "00" when "00000001",
            "00" when "00000010",
            "00" when "00000011",
            "00" when "00000100",
            "00" when "00000101",
            "00" when "00000110",
            "00" when "00000111",
            "00" when "00001000",
            "10" when "00001001",
            "01" when "00001010",
            "00" when "00001011",
            "00" when "00001100",
            "00" when "00001101",
            "00" when "00001110",
            "01" when "00001111",
            "00" when "00010000",
            "01" when "00010001",
            "01" when "00010010",
            "01" when "00010011",
            "01" when "00010100",
            "01" when "00010101",
            "01" when "00010110",
            "01" when "00010111",
            "01" when "00011000",
            "10" when "00011001",
            "00" when "00011010",
            "01" when "00011011",
            "01" when "00011100",
            "01" when "00011101",
            "01" when "00011110",
            "00" when "00011111",
            "00" when "00100000",
            "01" when "00100001",
            "01" when "00100010",
            "01" when "00100011",
            "01" when "00100100",
            "01" when "00100101",
            "01" when "00100110",
            "01" when "00100111",
            "01" when "00101000",
            "10" when "00101001",
            "00" when "00101010",
            "01" when "00101011",
            "01" when "00101100",
            "01" when "00101101",
            "01" when "00101110",
            "00" when "00101111",
            "00" when "00110000",
            "01" when "00110001",
            "01" when "00110010",
            "01" when "00110011",
            "01" when "00110100",
            "01" when "00110101",
            "01" when "00110110",
            "01" when "00110111",
            "01" when "00111000",
            "10" when "00111001",
            "00" when "00111010",
            "01" when "00111011",
            "01" when "00111100",
            "01" when "00111101",
            "01" when "00111110",
            "00" when "00111111",
            "00" when "01000000",
            "01" when "01000001",
            "01" when "01000010",
            "01" when "01000011",
            "01" when "01000100",
            "01" when "01000101",
            "01" when "01000110",
            "01" when "01000111",
            "01" when "01001000",
            "10" when "01001001",
            "00" when "01001010",
            "10" when "01001011",
            "01" when "01001100",
            "01" when "01001101",
            "01" when "01001110",
            "01" when "01001111",
            "00" when "01010000",
            "01" when "01010001",
            "01" when "01010010",
            "01" when "01010011",
            "01" when "01010100",
            "01" when "01010101",
            "01" when "01010110",
            "01" when "01010111",
            "01" when "01011000",
            "10" when "01011001",
            "01" when "01011010",
            "10" when "01011011",
            "01" when "01011100",
            "01" when "01011101",
            "01" when "01011110",
            "10" when "01011111",
            "00" when "01100000",
            "01" when "01100001",
            "01" when "01100010",
            "01" when "01100011",
            "01" when "01100100",
            "01" when "01100101",
            "01" when "01100110",
            "01" when "01100111",
            "01" when "01101000",
            "10" when "01101001",
            "00" when "01101010",
            "00" when "01101011",
            "10" when "01101100",
            "10" when "01101101",
            "10" when "01101110",
            "10" when "01101111",
            "00" when "01110000",
            "01" when "01110001",
            "01" when "01110010",
            "01" when "01110011",
            "01" when "01110100",
            "01" when "01110101",
            "01" when "01110110",
            "01" when "01110111",
            "01" when "01111000",
            "10" when "01111001",
            "00" when "01111010",
            "01" when "01111011",
            "00" when "01111100",
            "00" when "01111101",
            "00" when "01111110",
            "10" when "01111111",
            "00" when "10000000",
            "01" when "10000001",
            "01" when "10000010",
            "01" when "10000011",
            "01" when "10000100",
            "01" when "10000101",
            "01" when "10000110",
            "01" when "10000111",
            "01" when "10001000",
            "10" when "10001001",
            "00" when "10001010",
            "01" when "10001011",
            "01" when "10001100",
            "01" when "10001101",
            "01" when "10001110",
            "10" when "10001111",
            "00" when "10010000",
            "01" when "10010001",
            "01" when "10010010",
            "01" when "10010011",
            "01" when "10010100",
            "01" when "10010101",
            "01" when "10010110",
            "01" when "10010111",
            "01" when "10011000",
            "10" when "10011001",
            "00" when "10011010",
            "01" when "10011011",
            "01" when "10011100",
            "01" when "10011101",
            "01" when "10011110",
            "10" when "10011111",
            "10" when "10100000",
            "10" when "10100001",
            "01" when "10100010",
            "01" when "10100011",
            "01" when "10100100",
            "01" when "10100101",
            "01" when "10100110",
            "01" when "10100111",
            "10" when "10101000",
            "00" when "10101001",
            "01" when "10101010",
            "01" when "10101011",
            "01" when "10101100",
            "01" when "10101101",
            "01" when "10101110",
            "10" when "10101111",
            "00" when "10110000",
            "00" when "10110001",
            "10" when "10110010",
            "10" when "10110011",
            "01" when "10110100",
            "01" when "10110101",
            "01" when "10110110",
            "01" when "10110111",
            "10" when "10111000",
            "00" when "10111001",
            "01" when "10111010",
            "01" when "10111011",
            "01" when "10111100",
            "01" when "10111101",
            "01" when "10111110",
            "10" when "10111111",
            "00" when "11000000",
            "01" when "11000001",
            "00" when "11000010",
            "00" when "11000011",
            "10" when "11000100",
            "10" when "11000101",
            "10" when "11000110",
            "10" when "11000111",
            "00" when "11001000",
            "01" when "11001001",
            "01" when "11001010",
            "01" when "11001011",
            "01" when "11001100",
            "01" when "11001101",
            "01" when "11001110",
            "10" when "11001111",
            "00" when "11010000",
            "01" when "11010001",
            "01" when "11010010",
            "01" when "11010011",
            "00" when "11010100",
            "00" when "11010101",
            "00" when "11010110",
            "10" when "11010111",
            "00" when "11011000",
            "01" when "11011001",
            "01" when "11011010",
            "01" when "11011011",
            "01" when "11011100",
            "01" when "11011101",
            "01" when "11011110",
            "10" when "11011111",
            "00" when "11100000",
            "01" when "11100001",
            "01" when "11100010",
            "01" when "11100011",
            "01" when "11100100",
            "01" when "11100101",
            "01" when "11100110",
            "10" when "11100111",
            "00" when "11101000",
            "01" when "11101001",
            "01" when "11101010",
            "01" when "11101011",
            "01" when "11101100",
            "01" when "11101101",
            "01" when "11101110",
            "10" when "11101111",
            "01" when "11110000",
            "10" when "11110001",
            "10" when "11110010",
            "10" when "11110011",
            "10" when "11110100",
            "10" when "11110101",
            "10" when "11110110",
            "01" when "11110111",
            "10" when "11111000",
            "10" when "11111001",
            "10" when "11111010",
            "10" when "11111011",
            "10" when "11111100",
            "10" when "11111101",
            "10" when "11111110",
            "01" when "11111111",
	    "00" when others;
    
end lut;
    
