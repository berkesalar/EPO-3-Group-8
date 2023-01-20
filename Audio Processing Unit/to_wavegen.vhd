library IEEE;
use IEEE.std_logic_1164.ALL;

entity to_wavegen is
   port(serial_in : in  std_logic;
        clk       : in  std_logic;
        reset     : in  std_logic;
		  note_reset : in std_logic;
	dutycycle1: out std_logic_vector(1 downto 0);
	volume1		 : out std_logic_vector(3 downto 0);
        note1     : out std_logic_vector(7 downto 0);
        note2     : out  std_logic_vector(7 downto 0);
        note3     : out std_logic_vector(7 downto 0);
        note4     : out std_logic_vector(7 downto 0));
end to_wavegen;

architecture behaviour of to_wavegen is
component buffer_rx is
   port(clk    : in  std_logic;
        input  : in  std_logic;
        output : out std_logic);
end component;

component uart_read_fsm is
   port(reset          : in  std_logic;
        clk            : in  std_logic;
        serial         : in  std_logic;
		uart_clk			   : in  std_logic;
        sample_clk     : in  std_logic;
		  note_reset : in std_logic;
        parallel       : out std_logic_vector(7 downto 0);
        uart_clk_reset : out std_logic;
        data_ready     : out std_logic);
end component;

component uart_clk_gen_r is
   port(clk        : in  std_logic;
        reset      : in  std_logic;
        uart_clk   : out std_logic;
        sample_clk : out std_logic);
end component;

component midi_fsm_m is
   port(clk          : in  std_logic;
        reset        : in  std_logic;
        read_done    : in  std_logic;
        midi_signal  : in  std_logic_vector(7 downto 0);
		  note_reset : in std_logic;
        wavechannel  : out std_logic_vector(1 downto 0);
        dutycycle    : out std_logic_vector(1 downto 0);
	volume			 : out std_logic_vector(3 downto 0);
        note       : out std_logic_vector(6 downto 0));
end component;

component lut_notes is
   port(note   : in  std_logic_vector(6 downto 0);
        period : out std_logic_vector(7 downto 0));
end component;

component channel_select is
   port(clk		  : in  std_logic;
	reset		  : in  std_logic;
	channel   : in  std_logic_vector(1 downto 0);
	note_in   : in  std_logic_vector(7 downto 0);
	note_reset: in std_logic;
        note_out1 : out std_logic_vector(7 downto 0);
        note_out2 : out std_logic_vector(7 downto 0);
        note_out3 : out std_logic_vector(7 downto 0);
        note_out4 : out std_logic_vector(7 downto 0));
end component;

signal buff_serial, uart_clk, sample_clk, uart_reset, data_ready: std_logic;
signal channel : std_logic_vector(1 downto 0);
signal midi_signal : std_logic_vector(7 downto 0);
signal midi_note : std_logic_vector(6 downto 0);
signal note_period : std_logic_vector(7 downto 0);

begin

lbl1: buffer_rx port map (clk,serial_in, buff_serial);
lbl2: uart_read_fsm port map (reset, clk, buff_serial, uart_clk, sample_clk, note_reset, midi_signal, uart_reset, data_ready);
lbl3: uart_clk_gen_r port map(clk, uart_reset, uart_clk, sample_clk); 
lbl4: midi_fsm_m port map(clk, reset, data_ready, midi_signal, note_reset, channel, dutycycle1,volume1, midi_note);
lbl5: lut_notes port map(midi_note, note_period);
lbl6: channel_select port map(clk,reset,channel,note_period, note_reset, note1, note2, note3, note4);


end behaviour;
