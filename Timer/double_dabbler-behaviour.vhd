library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

architecture structural of double_dabbler is

    signal T         : std_logic_vector(3 downto 0);
    signal U         : std_logic_vector(3 downto 0);
    signal V         : std_logic_vector(3 downto 0);
    signal W         : std_logic_vector(3 downto 0);
    signal X         : std_logic_vector(3 downto 0);
    signal Y         : std_logic_vector(3 downto 0);
    signal Z         : std_logic_vector(3 downto 0);
    signal Q         : std_logic_vector(3 downto 0);
    signal R         : std_logic_vector(3 downto 0);

    component dabble is
        port (      A_in    : in std_logic_vector (3 downto 0);
                    A_out   : out std_logic_vector (3 downto 0));
    end component;

   begin
        --three left shifts at the start without issue  
        --|0000|0000|0 B8 B7 B6 | B5 B4 B3 B2 B1 B0 000|
        dabble_t    : dabble    port map (A_in(3) => '0', A_in(2 downto 0) => bin_in(8 downto 6), A_out => T);
        --checking after shift 4                        
        --|0000|000 T3 |T2 T1 T0 B5 | B4 B3 B2 B1 B0 0000|
        dabble_u    : dabble    port map (A_in(3 downto 1) => T(2 downto 0), A_in(0) => bin_in(5), A_out => U);
        --checking after shift 5                        
        --|0000|00 T3 U3 |U2 U1 U0 B4 | B3 B2 B1 B0 00000|
        dabble_v    : dabble    port map (A_in(3 downto 1) => U(2 downto 0), A_in(0) => bin_in(4), A_out => V);
        --checking after shift 6 (both tens and ones may have values larger than 4)
        --|0000|0 T3 U3 V3 |V2 V1 V0 B3 | B2 B1 B0 000000|
            --checking tens
        dabble_w    : dabble    port map (A_in(3) => '0', A_in(2) => T(3), A_in(1) => U(3), A_in(0) => V(3), A_out => W);
            --checking ones
        dabble_x    : dabble    port map (A_in(3 downto 1) => V(2 downto 0), A_in(0) => bin_in(3), A_out => X);
        --checking after shift 7 (both tens and ones may have values larger than 4)
        --|000 W3 | W2 W1 W0 X3 |X2 X1 X0 B2 | B1 B0 0000000|
            --checking tens
        dabble_y    : dabble    port map (A_in(3 downto 1) => W(2 downto 0), A_in(0) => X(3), A_out => Y);
            --checking ones
        dabble_z    : dabble    port map (A_in(3 downto 1) => X(2 downto 0), A_in(0) => bin_in(2), A_out => Z);
        --checking after shift 8 (both tens and ones may have values larger than 4)
        --|00 W3 Y3 | Y2 Y1 Y0 Z3 |Z2 Z1 Z0 B1 | B0 00000000|
            --checking tens
        dabble_q    : dabble    port map (A_in(3 downto 1) => Y(2 downto 0), A_in(0) => Z(3), A_out => Q);
            --checking ones
        dabble_r    : dabble    port map (A_in(3 downto 1) => Z(2 downto 0), A_in(0) => bin_in(1), A_out => R);
         --|0 W3 Y3 Q3| Q2 Q1 Q0 R3 |R2 R1 R0 B0 |000000000|

        bcd_hun <= '0' & W(3) & Y(3) & Q(3);
        bcd_ten <= Q(2 downto 0) & R(3);
        bcd_one <= R(2 downto 0) & bin_in(0);

end structural;
    