library IEEE;
use IEEE.std_logic_1164.ALL;

entity apu is
   port(clk     : in  std_logic;
        reset   : in  std_logic;
        start   : in  std_logic; --'right' signal
        death   : in  std_logic; -- gameover
        win     : in  std_logic; 
        jump    : in  std_logic; -- jump signal
        splat   : in  std_logic; -- kill signal from enemies module
        bump    : in  std_logic; -- collision north
        rx      : in  std_logic;
        tx      : out std_logic;
        pwm     : out std_logic);
end apu;

architecture behaviour of apu is
component to_rpi is
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
end component;
component to_wavegen is
   port(serial_in : in  std_logic;
        clk       : in  std_logic;
        reset     : in  std_logic;
		  note_reset: in std_logic;
		dutycycle1: out std_logic_vector(1 downto 0);
		volume1		 : out std_logic_vector(3 downto 0);
        note1     : out std_logic_vector(7 downto 0);
        note2     : out  std_logic_vector(7 downto 0);
        note3     : out std_logic_vector(7 downto 0);
        note4     : out std_logic_vector(7 downto 0));
end component;
component wave_gen is
    port(
        clk, reset: in std_logic;
        duty_p1, duty_p2: in std_logic_vector(1 downto 0);
        volume1, volume2, volume3: in std_logic_vector(3 downto 0);
        period_p1, period_p2, period_t, period_n: in std_logic_vector(7 downto 0);
        audio: out std_logic
    );
end component;
signal dutycycle1: std_logic_vector(1 downto 0);
signal volume1 : std_logic_vector(3 downto 0);
signal note1, note2, note3, note4 : std_logic_vector(7 downto 0);
signal note_reset : std_logic;
begin
lbl1: to_rpi port map(clk, reset, start, win, death, jump, splat, bump, tx, note_reset);
lbl2: to_wavegen port map(rx, clk, reset, note_reset, dutycycle1, volume1, note1, note2, note3, note4);
lbl3: wave_gen port map(clk, reset, dutycycle1, "11", volume1, "1000", "0011", note1, note2, note3, note4, pwm);
end behaviour; 
