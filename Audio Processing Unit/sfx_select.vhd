library IEEE;
use IEEE.std_logic_1164.ALL;

entity sfx_select is
   port(clk   : in  std_logic;
        reset : in  std_logic;
        bump  : in  std_logic;
        splat : in  std_logic;
        jump  : in  std_logic;
        sfx   : out std_logic_vector(1 downto 0));
end sfx_select;
  
architecture behaviour of sfx_select is
    type sfx_state is(rst, jump_state, bump_state, splat_state);
    signal state, new_state: sfx_state;

    signal jump_old, bump_old, splat_old: std_logic;
begin
    --FSM reset and next-state handling
    process(reset, clk)
    begin
        if(rising_edge(clk)) then
            if(reset = '1') then
                state <= rst;
                jump_old <= '0';
                bump_old <= '0';
                splat_old <= '0';
            else
                state <= new_state;
                jump_old <= jump;
                bump_old <= bump;
                splat_old <= splat;
            end if;
        end if;
    end process;
	process(state, jump, bump, splat, jump_old, bump_old, splat_old) begin
        case state is
            when rst =>
                sfx <= "00";

                if(jump = '1' and jump_old = '0') then
                    new_state <= jump_state;
                elsif(bump = '1' and bump_old = '0') then
                    new_state <= bump_state;
                elsif(splat = '1' and splat_old = '0') then
                    new_state <= splat_state;
                else
                    new_state <= rst;
                end if;

            when jump_state =>
                sfx <= "01";

                if(bump = '1' and bump_old = '0') then
                    new_state <= bump_state;
                elsif(splat = '1' and splat_old = '0') then
                    new_state <= splat_state;
		elsif jump = '0' then
		    new_state <= rst;
                else
                    new_state <= jump_state;
                end if;

            when bump_state =>
                sfx <= "10";

                if(jump = '1' and jump_old = '0') then
                    new_state <= jump_state;
                elsif(splat = '1' and splat_old = '0') then
                    new_state <= splat_state;
		elsif bump = '0' then
		    new_state <= rst;
                else
                    new_state <= bump_state;
                end if;

            when splat_state =>
                sfx <= "11";
				if(jump = '1' and jump_old = '0') then
                    new_state <= jump_state;
                elsif(bump = '1' and bump_old = '0') then
                    new_state <= bump_state;
		elsif splat = '0' then
		    new_state <= rst;
                else
                    new_state <= splat_state;
                end if;

        end case;
    end process;

end architecture behaviour;
