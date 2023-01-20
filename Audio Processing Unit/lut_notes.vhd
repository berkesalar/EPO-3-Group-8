library IEEE;
use IEEE.std_logic_1164.ALL;
use IEEE.numeric_std.ALL;

entity lut_notes is                                       --this look up table selects the right period needed for the wave generator that fits the note given by the midi signal
  port(note   : in  std_logic_vector(6 downto 0);
       period : out std_logic_vector(7 downto 0));
end lut_notes;
  
architecture behaviour of lut_notes is
begin
  process(note)
  begin                                                   --every 7 bit note has a 7 bit period (that is modified later). Only the notes that are used are in the LUT

    case note is
      when std_logic_vector(to_unsigned(41,7)) => period <= std_logic_vector(to_unsigned(18,8));
      when std_logic_vector(to_unsigned(42,7)) => period <= std_logic_vector(to_unsigned(1,8));
      when std_logic_vector(to_unsigned(43,7)) => period <= std_logic_vector(to_unsigned(255,8));
      when std_logic_vector(to_unsigned(44,7)) => period <= std_logic_vector(to_unsigned(243,8));
      when std_logic_vector(to_unsigned(45,7)) => period <= std_logic_vector(to_unsigned(229,8));
      when std_logic_vector(to_unsigned(46,7)) => period <= std_logic_vector(to_unsigned(216,8));
      when std_logic_vector(to_unsigned(47,7)) => period <= std_logic_vector(to_unsigned(204,8));
      when std_logic_vector(to_unsigned(48,7)) => period <= std_logic_vector(to_unsigned(193,8));
      when std_logic_vector(to_unsigned(49,7)) => period <= std_logic_vector(to_unsigned(182,8));
      when std_logic_vector(to_unsigned(50,7)) => period <= std_logic_vector(to_unsigned(172,8));
      when std_logic_vector(to_unsigned(51,7)) => period <= std_logic_vector(to_unsigned(162,8));
      when std_logic_vector(to_unsigned(52,7)) => period <= std_logic_vector(to_unsigned(153,8));
      when std_logic_vector(to_unsigned(53,7)) => period <= std_logic_vector(to_unsigned(145,8));
      when std_logic_vector(to_unsigned(54,7)) => period <= std_logic_vector(to_unsigned(136,8));
      when std_logic_vector(to_unsigned(55,7)) => period <= std_logic_vector(to_unsigned(129,8));
      when std_logic_vector(to_unsigned(56,7)) => period <= std_logic_vector(to_unsigned(122,8));
      when std_logic_vector(to_unsigned(57,7)) => period <= std_logic_vector(to_unsigned(115,8));
      when std_logic_vector(to_unsigned(58,7)) => period <= std_logic_vector(to_unsigned(108,8));
      when std_logic_vector(to_unsigned(59,7)) => period <= std_logic_vector(to_unsigned(102,8));
      when std_logic_vector(to_unsigned(60,7)) => period <= std_logic_vector(to_unsigned(97,8));
      when std_logic_vector(to_unsigned(61,7)) => period <= std_logic_vector(to_unsigned(91,8));
      when std_logic_vector(to_unsigned(62,7)) => period <= std_logic_vector(to_unsigned(86,8));
      when std_logic_vector(to_unsigned(63,7)) => period <= std_logic_vector(to_unsigned(81,8));
      when std_logic_vector(to_unsigned(64,7)) => period <= std_logic_vector(to_unsigned(77,8));
      when std_logic_vector(to_unsigned(65,7)) => period <= std_logic_vector(to_unsigned(73,8));
      when std_logic_vector(to_unsigned(66,7)) => period <= std_logic_vector(to_unsigned(68,8));
      when std_logic_vector(to_unsigned(67,7)) => period <= std_logic_vector(to_unsigned(65,8));
      when std_logic_vector(to_unsigned(68,7)) => period <= std_logic_vector(to_unsigned(61,8));
      when std_logic_vector(to_unsigned(69,7)) => period <= std_logic_vector(to_unsigned(58,8));
      when std_logic_vector(to_unsigned(70,7)) => period <= std_logic_vector(to_unsigned(54,8));
      when std_logic_vector(to_unsigned(71,7)) => period <= std_logic_vector(to_unsigned(51,8));
      when std_logic_vector(to_unsigned(72,7)) => period <= std_logic_vector(to_unsigned(49,8));
      when std_logic_vector(to_unsigned(73,7)) => period <= std_logic_vector(to_unsigned(46,8));
      when std_logic_vector(to_unsigned(74,7)) => period <= std_logic_vector(to_unsigned(43,8));
      when std_logic_vector(to_unsigned(75,7)) => period <= std_logic_vector(to_unsigned(41,8));
      when std_logic_vector(to_unsigned(76,7)) => period <= std_logic_vector(to_unsigned(39,8));
      when std_logic_vector(to_unsigned(77,7)) => period <= std_logic_vector(to_unsigned(37,8));
      when std_logic_vector(to_unsigned(78,7)) => period <= std_logic_vector(to_unsigned(34,8));
      when std_logic_vector(to_unsigned(79,7)) => period <= std_logic_vector(to_unsigned(33,8));
      when std_logic_vector(to_unsigned(80,7)) => period <= std_logic_vector(to_unsigned(31,8));
      when std_logic_vector(to_unsigned(81,7)) => period <= std_logic_vector(to_unsigned(29,8));
      when std_logic_vector(to_unsigned(82,7)) => period <= std_logic_vector(to_unsigned(27,8));
      when std_logic_vector(to_unsigned(83,7)) => period <= std_logic_vector(to_unsigned(26,8));
      when std_logic_vector(to_unsigned(84,7)) => period <= std_logic_vector(to_unsigned(25,8));
      when std_logic_vector(to_unsigned(85,7)) => period <= std_logic_vector(to_unsigned(23,8));
      when others => period <= std_logic_vector(to_unsigned(0,8));
    end case;
  end process;
end behaviour;
