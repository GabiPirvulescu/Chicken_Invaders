library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity Count_down is
    Port ( CLK : in STD_LOGIC;
           START : in STD_LOGIC;
           RESET : in STD_LOGIC;
           DIGIT1,DIGIT2: out STD_LOGIC_VECTOR(4 downto 0)
           );
end Count_down;

architecture Behavioral of Count_down is
   signal DIVCLOCK: STD_LOGIC;
   signal count:integer:=1;
   signal count_d1: STD_LOGIC_VECTOR( 4 downto 0):="00000";
   signal count_d2: STD_LOGIC_VECTOR(4 downto 0):="00100";

begin
    process(CLK, RESET, START)
        begin
            if(RESET = '1')then
                count <= 1;
            elsif (CLK'event and CLK = '1' and START = '1' ) then
                count<= count+1;
                if (count = 9999999) then 
                       DIVCLOCK <= NOT DIVCLOCK;
                       count <= 1;
                 end if;
            end if;    
    end process;

COUNT_DOWN : process(DIVCLOCK, RESET, START)
        begin
            if(RESET = '1') then 
                count_d1<="00000";
                count_d2<="00100";
                
            elsif( DIVCLOCK'event and DIVCLOCK = '1' and START ='1') then 
                if(count_d1 = "00000")then 
                        count_d2 <= count_d2 - 1;
                        count_d1<= "01001";
                else
                    count_d1<= count_d1-1;
                end if;
                
            end if;
        end process COUNT_DOWN;
    DIGIT1<=count_d1;
    DIGIT2<=count_d2;
end Behavioral;