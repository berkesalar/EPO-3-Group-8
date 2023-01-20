library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

--component that connects all other components in the wave generator sub-module
entity wave_gen is
    port(
        clk, reset: in std_logic;
        duty_p1, duty_p2: in std_logic_vector(1 downto 0);
        volume1, volume2, volume3: in std_logic_vector(3 downto 0);
        period_p1, period_p2, period_t, period_n: in std_logic_vector(7 downto 0);
        audio: out std_logic
    );
end entity;

architecture structural of wave_gen is

    component pulse is
        port(
            clk:        in std_logic;
            reset:      in std_logic;
            duty:       in std_logic_vector(1 downto 0);
            period:     in std_logic_vector(7 downto 0);
            count:      in std_logic_vector(7 downto 0);
            count_reset:out std_logic;
            active:     out std_logic);
    end component;

    component counter_8 is
        port(
            clk:        in std_logic;
            reset:      in std_logic;
            count_reset:in std_logic;
            increment:  in std_logic;
            count:      out std_logic_vector(7 downto 0));
    end component;

    component counter_6 is
        port(
            clk: in std_logic;
            reset: in std_logic;
            count: out std_logic_vector(5 downto 0));
    end component;

    component counter_5 is
        port(
            clk: in std_logic;
            reset: in std_logic;
            increment: in std_logic;
            clk_divided: in std_logic;
            count: out std_logic_vector(4 downto 0));
    end component;

    component clk_divider is
        port(
            clk: in std_logic;
            reset: in std_logic;
            clk_divided: out std_logic);
    end component; 

    component triangle is
        port(
            clk:        in std_logic;
            reset:      in std_logic;
            period:     in std_logic_vector(7 downto 0);
            count:      in std_logic_vector(7 downto 0);
            phase:      in std_logic_vector(4 downto 0);
            clk_divided:      in std_logic;
            count_reset:out std_logic;
            amplitude:  out std_logic_vector(3 downto 0));
    end component;

    component noise is
        port(
            clk: in std_logic;
            reset: in std_logic;
            period: in std_logic_vector(7 downto 0);
            count: in std_logic_vector(7 downto 0);
            count_reset: out std_logic;
            noisy: out std_logic);
    end component;

    component mixer is
        port(
            amp1: in std_logic_vector(3 downto 0);
            amp2: in std_logic_vector(3 downto 0);
            amp3: in std_logic_vector(3 downto 0);
            amp4: in std_logic_vector(3 downto 0);
            amp_out: out std_logic_vector(5 downto 0));
    end component;

    component volume is
        port(
            active: in std_logic;
            volume: in std_logic_vector(3 downto 0);
            amplitude: out std_logic_vector(3 downto 0));
    end component;
    
    component pwm is
        port (
            clk: in std_logic;
            reset: in std_logic;
            amplitude: in std_logic_vector(5 downto 0);
            count: in std_logic_vector(5 downto 0);
            pwm: out std_logic);
    end component pwm;
    
    signal count_reset1, count_reset2, count_reset3, count_reset4, active1, active2, noisy, clk_divided: std_logic;
    signal count0: std_logic_vector(5 downto 0);
    signal count1, count2, count3, count4: std_logic_vector(7 downto 0);
    signal amp1, amp2, amp3, amp4: std_logic_vector(3 downto 0);
    signal amplitude: std_logic_vector(5 downto 0);
    signal phase: std_logic_vector(4 downto 0);
    
    begin

    CD:         clk_divider port map(clk, reset, clk_divided);
    CNTP1:      counter_8 port map(clk, reset, count_reset1, clk_divided, count1);
    CNTP2:      counter_8 port map(clk, reset, count_reset2, clk_divided, count2);
    CNTT7:      counter_8 port map(clk, reset, count_reset3, clk_divided, count3);
    CNTT5:      counter_5 port map(clk, reset, count_reset3, clk_divided, phase);
    CNTN:       counter_8 port map(clk, reset, count_reset4, clk_divided, count4);
    CNTPWM:     counter_6 port map(clk, reset, count0);

    P1:     pulse port map(clk, reset, duty_p1, period_p1, count1, count_reset1, active1);
    P2:     pulse port map(clk, reset, duty_p2, period_p2, count2, count_reset2, active2);
    T:      triangle port map(clk, reset, period_t, count3, phase, clk_divided, count_reset3, amp3);
    N:      noise port map(clk, reset, period_n, count4, count_reset4, noisy); 
    
    V1:     volume port map(active1, volume1, amp1);
    V2:     volume port map(active2, volume2, amp2);
    V3:     volume port map(noisy, volume3, amp4);
    M:      mixer port map(amp1, amp2, amp3, amp4, amplitude);
    P3:     pwm port map(clk, reset, amplitude, count0, audio);

end architecture structural;
