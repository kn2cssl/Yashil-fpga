library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity micro_com2 is
port (
--   CLK : in std_logic;
--	RPM_IN : in std_logic_vector(7 downto 0);
--	CLK_PAR : in std_logic;
--	PARITY_IN : in std_logic;
--	MOTOR_NUM : in std_logic_vector(1 downto 0);
--	RPM1 : out std_logic_vector(15 downto 0);
--	RPM2 : out std_logic_vector(15 downto 0);
--	RPM3 : out std_logic_vector(15 downto 0);
--	RPM4 : out std_logic_vector(15 downto 0);
--	STARTBIT_FLG : in std_logic;
--	FREE_WHEELS : out std_logic 
	CLK : in std_logic;
	DATA_IN : in std_logic_vector(6 downto 0);
	DATA_OUT: OUT std_logic_vector(6 downto 0)
   --LED  : out std_logic_vector(3 downto 0)
	);
end micro_com2;

architecture Behavioral of micro_com2 is
   type memory8 is array (0 to 3) of std_logic_vector(7 downto 0);
	type state_machine is (s0,s1,s2,s3,s4,s5,s6);
	signal motor_rpm_high : memory8 :=("00000000","00000000","00000000","00000000");
	signal motor_rpm_low  : memory8 :=("00000000","00000000","00000000","00000000");
	signal motor_rpm_tmp  : std_logic_vector(7 downto 0); 
	signal startbyte_low	 : std_logic_vector(7 downto 0);
	signal state : state_machine :=s0;
	
--	signal motor_rpm_low0_s  :  std_logic_vector(7 downto 0):="00000010"; 
--	signal motor_rpm_high0_S :  std_logic_vector(7 downto 0):="00000001";
--	signal motor_rpm_low1_S  :  std_logic_vector(7 downto 0):="00000100";
--	signal motor_rpm_high1_S :  std_logic_vector(7 downto 0):="00000011";
	
	signal cnt : std_logic:='0';
	begin
	
--  	process(CLK_par)
--		 begin
--		 if rising_edge(clk_par) then
--		 cnt <= '1';
--		 if cnt = '1' then
--		 cnt <= '0';
--		 end if;
--		 end if;
--	end process;
	
	process(CLK) 
	    begin
       if (rising_edge(clk)) then
		 if(clk_par='0') then     
		 case state is 
		 when s0 =>
				  motor_rpm_tmp <= RPM_IN(7 downto 0);
				  state <= s1;				  
		 when s1 =>
			  if (motor_rpm_tmp = RPM_IN(7 downto 0)) then
					motor_rpm_tmp <= RPM_IN(7 downto 0);
					state <= s2;
			  else
					state <= s0;
			  end if;
		 when s2 =>
			  if (motor_rpm_tmp = RPM_IN(7 downto 0)) then
					motor_rpm_tmp <= RPM_IN(7 downto 0);
					state <= s3;
			  else
					state <= s0;
			  end if;
		 when s3 =>
			  if (motor_rpm_tmp = RPM_IN(7 downto 0)) then
					motor_rpm_tmp <= RPM_IN(7 downto 0);
					state <= s4;
			  else
					state <= s0;
			  end if;
		 when s4 =>
			  if (motor_rpm_tmp = RPM_IN(7 downto 0)) then
					motor_rpm_tmp <= RPM_IN(7 downto 0);
					state <= s5;
			  else
					state <= s0;
			  end if;
		 when s5 =>
			  if (motor_rpm_tmp = RPM_IN(7 downto 0)) then
					motor_rpm_tmp <= RPM_IN(7 downto 0);
					state <= s6;
			  else
					state <= s0;
			  end if;
		 when s6 =>
			  if (STARTBIT_FLG = '1') then
					startbyte_low  <= RPM_IN(7 downto 0);
			elsif ((STARTBIT_FLG = '0')and (startbyte_low = "10101010")) then
			  if (PARITY_IN = '0') then
					motor_rpm_low (conv_integer(motor_num)) <= RPM_IN(7 downto 0);
			  elsif (PARITY_IN = '1') then
					motor_rpm_high (conv_integer(motor_num)) <= RPM_IN(7 downto 0);
			  end if;
			end if;
					state <= s0;
		  when others =>
					state <= s0;		      
		end case;

		 
	 rpm1 <= motor_rpm_high(0)& motor_rpm_low(0);
	 rpm2 <= motor_rpm_high(1)& motor_rpm_low(1);
	 rpm3 <= motor_rpm_high(2)& motor_rpm_low(2);
	 rpm4 <= motor_rpm_high(3)& motor_rpm_low(3);
	

--	 end if;
--	 end process;
	   end if;
		end if;
		
		if (falling_edge(clk))then
		end if;
	   end process;
	 end Behavioral; 
