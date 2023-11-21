library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity program_memory is
	port(
			clk	: in std_logic;
			address	: in std_logic_vector(7 downto 0);
			-- Output:
			data_out	: out std_logic_vector(7 downto 0)
	);
end program_memory;

architecture arch of program_memory is

-- All instructions :

-- Save/Load instructions
constant LOAD_A_CONST       :std_logic_vector(7 downto 0) := x"86";
constant LOAD_A		        :std_logic_vector(7 downto 0) := x"87";
constant LOAD_B_CONST       :std_logic_vector(7 downto 0) := x"88";
constant LOAD_B		        :std_logic_vector(7 downto 0) := x"89";
constant SAVE_A		    	:std_logic_vector(7 downto 0) := x"96";	
constant SAVE_B		    	:std_logic_vector(7 downto 0) := x"97";

 -- ALU Instructions
constant SUM_AB     	:std_logic_vector(7 downto 0) := x"42";
constant SUB_AB     	:std_logic_vector(7 downto 0) := x"43";
constant AND_AB     	:std_logic_vector(7 downto 0) := x"44";
constant OR_AB	     	:std_logic_vector(7 downto 0) := x"45";
constant INCR_A     	:std_logic_vector(7 downto 0) := x"46";
constant INCR_B     	:std_logic_vector(7 downto 0) := x"47";
constant DECR_A     	:std_logic_vector(7 downto 0) := x"48";
constant DECR_B     	:std_logic_vector(7 downto 0) := x"49";


-- Jumping Instructions (Conditional/Unconditional)
constant JUMP					:std_logic_vector(7 downto 0) := x"20";
constant JUMP_NEGATIVE			:std_logic_vector(7 downto 0) := x"21";
constant JUMP_POZITIVE		 	:std_logic_vector(7 downto 0) := x"22";
constant JUMP_EQUAL_ZERO		:std_logic_vector(7 downto 0) := x"23";
constant JUMP_NOTEQUAL_ZERO	    :std_logic_vector(7 downto 0) := x"24";
constant JUMP_OVERFLOW_YES	    :std_logic_vector(7 downto 0) := x"25";
constant JUMP_OVERFLOW_NO	    :std_logic_vector(7 downto 0) := x"26";
constant JUMP_CARRY_YES			:std_logic_vector(7 downto 0) := x"27";
constant JUMP_CARRY_NOT			:std_logic_vector(7 downto 0) := x"28";

type rom_type is array (0 to 127) of std_logic_vector(7 downto 0);
	constant ROM : rom_type := (	
                                	0	=> LOAD_A,
									1	=> x"F0",	-- input port-00
									2	=> LOAD_B,
									3	=> x"F1",	-- input port-01		
									4 	=> SUM_AB,
									5   => JUMP_EQUAL_ZERO,
									6   => x"0B",		
									7   => SAVE_A,
									8   => X"80",	
									9	=> JUMP,
									10	=> x"20",
									11	=> LOAD_A,
									12	=> x"F2",	-- input port-02	
									13  => JUMP,
									14  => x"04",											
									others 	=> x"00"
								);
								
-- Signals:
-- Signals:
signal enable : std_logic;
begin

process(address)
begin
	if(address >= x"00" and address <= x"7F") then -- between 0 and 127 
		enable <= '1';
	else
		enable <= '0';
	end if;
end process;

----
process(clk)
begin
	if(rising_edge(clk)) then
		if(enable = '1') then
			data_out <= ROM(to_integer(unsigned(address)));
		end if;
	end if;
end process;

end architecture;