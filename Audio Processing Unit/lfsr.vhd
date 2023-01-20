library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

--linear feedback shift register. component for generating pseudo-random signals.
entity lfsr is
    port (
        clk: in std_logic;
        reset: in std_logic;
        enable: in std_logic;
        noise: out std_logic
    );
end entity lfsr;

architecture behaviour of lfsr is
    signal reg: std_logic_vector(14 downto 0);
begin

    --a chain of registers with feedback
    process(clk,reset,enable)
    begin
        if(rising_edge(clk)) then
            if(reset = '1') then
                reg <= "111111111111111";
            elsif(enable = '1') then
                reg(0) <= reg(1);
                reg(1) <= reg(2);
                reg(2) <= reg(3);
                reg(3) <= reg(4);
                reg(4) <= reg(5);
                reg(5) <= reg(6);
                reg(6) <= reg(7);
                reg(7) <= reg(8);
                reg(8) <= reg(9);
                reg(9) <= reg(10);
                reg(10) <= reg(11);
                reg(11) <= reg(12);
                reg(12) <= reg(13);
                reg(13) <= reg(14);
                reg(14) <= reg(0) xor reg(1);
            else
                reg(0) <= reg(0);
                reg(1) <= reg(1);
                reg(2) <= reg(2);
                reg(3) <= reg(3);
                reg(4) <= reg(4);
                reg(5) <= reg(5);
                reg(6) <= reg(6);
                reg(7) <= reg(7);
                reg(8) <= reg(8);
                reg(9) <= reg(9);
                reg(10) <= reg(10);
                reg(11) <= reg(11);
                reg(12) <= reg(12);
                reg(13) <= reg(13);
                reg(14) <= reg(14);
            end if;
        end if;
    end process;

    noise <= reg(0);

end architecture;
