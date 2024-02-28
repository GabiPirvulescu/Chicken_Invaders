library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity Display_chicken is
    Port ( CLK : in STD_LOGIC;
           D0 : in STD_LOGIC_VECTOR (4 downto 0);
           D1 : in STD_LOGIC_VECTOR (4 downto 0);
           D2 : in STD_LOGIC_VECTOR (4 downto 0);
           D3 : in STD_LOGIC_VECTOR (4 downto 0);
           D4 : in STD_LOGIC_VECTOR (4 downto 0);
           D5 : in STD_LOGIC_VECTOR (4 downto 0);
           D6 : in STD_LOGIC_VECTOR (4 downto 0);
           D7 : in STD_LOGIC_VECTOR (4 downto 0);
           an : out STD_LOGIC_VECTOR (7 downto 0);
           cat : out STD_LOGIC_VECTOR (6 downto 0));
end Display_chicken;

architecture Behavioral of Display_chicken is
signal count: std_logic_VECTOR(15 downto 0);
signal input_decoder:std_logic_vector(4 downto 0);


begin

--- counter
    process(clk, count)
    begin
        ---if rising_edge(clk);
        if (clk='1' and clk'event) then count<=count+1;
        end if;
    end process;

--- anod
    process(count)
    begin
        case count(15 downto 13) is
            when "000" =>an <= "11111110";
            when "001" =>an <= "11111101";
            when "010" =>an <= "11111011";
            when "011" =>an <= "11110111";
            when "100" =>an <= "11101111";
            when "101" =>an <= "11011111";
            when "110" =>an <= "10111111";
            when others =>an <= "01111111";
        end case;
        
    end process;
    
--- digits
    process(count, d0,d1,d2,d3,d4,d5,d6,d7)
    begin
        case count(15 downto 13) is
            when "000" =>input_decoder<= D0;
            when "001" =>input_decoder <= D1;
            when "010" =>input_decoder <= D2;
            when "011" =>input_decoder <= D3;
            when "100" =>input_decoder <= D4;
            when "101" =>input_decoder <= D5;
            when "110" =>input_decoder <= D6;
            when others =>input_decoder <= D7;
        end case;
        
    end process;

    process(input_decoder)
    begin
         case input_decoder is
         
             when "00000" => cat<="1000000";
            when "00001" => cat<="1111001";
            when "00010" => cat<="0100100";
            when "00011" => cat<="0110000";
    
            when "00100" => cat<="0011001";
            when "00101" => cat<="0010010";
            when "00110" => cat<="0000010";
            when "00111" => cat<="1111000";
    
            when "01000" => cat<="0000000";
            when "01001" => cat<="0010000";
        
         
         ---FOR CHICKENS
           when "11111" => cat <= "0110110";
           when "11110" => cat <= "0111110";
           when "11100" => cat <= "1111110";
           
           when others =>cat <= "1111111";		
            end case;
    
    
    end process;

end Behavioral;