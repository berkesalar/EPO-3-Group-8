library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

architecture structural of timer_display is

    signal count            : std_logic_vector(23 downto 0);
    signal rst_counter      : std_logic;
    signal seconds          : std_logic_vector(8 downto 0);
    signal bcd_hun          : std_logic_vector(3 downto 0);
    signal bcd_ten          : std_logic_vector(3 downto 0);
    signal bcd_one          : std_logic_vector(3 downto 0);
    signal ripple_carry_h   : std_logic;
    signal ripple_carry_t   : std_logic;

    component mario_timer
        port(
                clk, rst                : in std_logic;
                count                   : in std_logic_vector(23 downto 0);
                rst_counter             : out std_logic;
                time_up                 : out std_logic;
                seconds                 : out std_logic_vector(8 downto 0);
                warning                 : out std_logic
        );
    end component;

    component bit_counter_25 is
        port(
                clk, reset              : in std_logic;
                count_out               : out std_logic_vector(23 downto 0)
        );
    end component bit_counter_25;
	
    component double_dabbler is
        port(       bin_in     : in std_logic_vector(8 downto 0);
                    bcd_hun    : out std_logic_vector(3 downto 0);
                    bcd_ten    : out std_logic_vector(3 downto 0);
                    bcd_one    : out std_logic_vector(3 downto 0)
                    );
    end component;
	
	component seg7_rc is
        port (      BCDin                   : in std_logic_vector (3 downto 0);
                    ripple                  : in std_logic;
                    ripple_carry            : out std_logic;
                    Seven_Segment           : out std_logic_vector (6 downto 0));
    end component;

    component seg7_nrc is
        port (      BCDin                   : in std_logic_vector (3 downto 0);
                    ripple                  : in std_logic;
                    Seven_Segment           : out std_logic_vector (6 downto 0));
    end component;

    begin

        timer       : mario_timer     port map (clk, rst, count, rst_counter, time_up, seconds, warning);
        counter     : bit_counter_25  port map (clk, rst_counter, count);
        bintobcd    : double_dabbler  port map (bin_in => seconds, bcd_hun => bcd_hun, bcd_ten => bcd_ten, bcd_one => bcd_one);
        seg7_h      : seg7_rc         port map (BCDin => bcd_hun, ripple => '1', ripple_carry => ripple_carry_h, Seven_Segment => Seven_Segment_h); --hundreds
        seg7_t      : seg7_rc         port map (BCDin => bcd_ten, ripple => ripple_carry_h, ripple_carry => ripple_carry_t, Seven_Segment => Seven_Segment_t); --tens
        seg7_o      : seg7_nrc        port map (BCDin => bcd_one, ripple => ripple_carry_t, Seven_Segment => Seven_Segment_o); --ones

end structural;

    