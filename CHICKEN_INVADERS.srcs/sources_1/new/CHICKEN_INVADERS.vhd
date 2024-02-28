

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity CHICKEN_INVADERS is
    Port ( START : in STD_LOGIC;
           RESET : in STD_LOGIC;
           BT_ARM : in STD_LOGIC;
           AN : out STD_LOGIC_VECTOR (7 downto 0);
           CAT : out STD_LOGIC_VECTOR (6 downto 0);
           ARM : out STD_LOGIC_VECTOR(8 downto 0);
           LED1, LED2 : out STD_LOGIC;
           CLK : in STD_LOGIC
           );
end CHICKEN_INVADERS;

architecture Behavioral of CHICKEN_INVADERS is
signal CHICKEN1,CHICKEN2,CHICKEN3,CHICKEN4: STD_LOGIC_VECTOR (4 downto 0);
signal CD1,CD2: STD_LOGIC_VECTOR(4 downto 0);
signal ENABLE_START: STD_LOGIC:='0';
signal ENABLE_RESET: STD_LOGIC;
signal en_count:STD_LOGIC;
signal COUNTER: std_logic_VECTOR(1 DOWNTO 0) :="00";
signal end_game: std_logic:='1';
signal LED_W: std_logic:='0';
signal LED_L : std_logic:='0';

begin
    
    start_counting: entity WORK.debouncer port map (CLK=>CLK, BTN=>START, ENABLE=>EN_COUNT);
    --process_reset: entity WORK.debouncer port map(CLK=>CLK, BTN=>RESET, ENABLE=>ENABLE_RESET);
   -- process_start: entity WORK.counter port map (CLK=>CLK, en=>en_count, RESET=>ENABLE_RESET, output=>ENABLE_START);
   
   process(clk,COUNTER)
    begin
        if(RESET ='1') then 
            COUNTER<="00";
        elsif (clk='1' and clk'event) then 
            if(EN_COUNT ='1')then 
                COUNTER<= COUNTER +1;
            end if;
        end if;
    end process;
    
    process(RESET, CHICKEN1,CHICKEN2,CHICKEN3,CHICKEN4,CD1,CD2)
        begin
            if(RESET ='1')then
                end_game<='1'; 
                LED_W<='0';
                LED_L<='0';
           elsif(ENABLE_START = '1') then
                if ( CHICKEN1 = "11000" and CHICKEN2= "11000" and CHICKEN3= "11000" and CHICKEN4= "11000")then
                    end_game<='0';
                    LED_W<='1';
                elsif (CD1="000000" and CD2 = "000000")then 
                       end_game <= '0';
                       LED_L<='1';
                end if;
           end if;
    end process;
    LED1<=LED_W;
    LED2<=LED_L;
    ENABLE_START<= end_game AND COUNTER(0);
    PLAY: entity WORK.CHICKENS_AND_ARMS port map(RESET=>RESET, START=>ENABLE_START, CLK=>CLK, BUTON=>BT_ARM,ARM=>ARM, AN=>AN, CAT=>CAT, CHICKEN1=>CHICKEN1,CHICKEN2=>CHICKEN2,CHICKEN3=>CHICKEN3,CHICKEN4=>CHICKEN4, CD1_OUT=>CD1, CD2_OUT=>CD2);
end Behavioral;