LIBRARY       IEEE; 
USE           IEEE.STD_LOGIC_1164.ALL;
use           ieee.std_logic_unsigned.all;
use           IEEE.NUMERIC_STD.all;


ENTITY  generateurPWM IS
generic(N : integer := 8
);
PORT(
clk                         :             in     std_logic;
--reset                     :             in     std_logic;
DUTY_INCREASE_BUTTON        :             in     std_logic; 
DUTY_DECREASE_BUTTON        :             in      std_logic; 
PWMOut                      :             out     std_logic;
DUTY_CYCLE_SWs              :             in     std_logic_vector(3 downto 0)
);
END generateurPWM;

ARCHITECTURE behv of generateurPWM IS

signal counter_PWM: std_logic_vector(N-1 downto 0):=(others => '0');
signal DUTY_CYCLE: std_logic_vector(N-1 downto 0):=x"00";

BEGIN

DUTY_CYCLE <=   x"00" when DUTY_CYCLE_SWs = "0000"  else
                x"0A" when DUTY_CYCLE_SWs = "0001"  else
                x"14" when DUTY_CYCLE_SWs = "0010"  else
                x"1E" when DUTY_CYCLE_SWs = "0011"  else
                x"28" when DUTY_CYCLE_SWs = "0100"  else
                x"32" when DUTY_CYCLE_SWs = "0101"  else
                x"3C" when DUTY_CYCLE_SWs = "0110"  else
                x"46" when DUTY_CYCLE_SWs = "0111"  else
                x"50" when DUTY_CYCLE_SWs = "1000"  else
                x"5A" when DUTY_CYCLE_SWs = "1001"  else
                x"64" when DUTY_CYCLE_SWs = "1010"  else
                x"00";

compteur : PROCESS(clk)
begin
if rising_edge(clk) then
   counter_PWM <= counter_PWM + x"1";
   if counter_PWM > x"64" then
      counter_PWM <= x"00";
    end if;
end if;
end PROCESS;
PWMOut <= '1' when counter_PWM < DUTY_CYCLE else '0';
                
                
END ARCHITECTURE behv;