library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Mem_Ram is
    Port ( R_W : in  STD_LOGIC;
           CS : in  STD_LOGIC;
           I : in  STD_LOGIC_VECTOR (3 downto 0);
           A : in  STD_LOGIC_VECTOR (3 downto 0);
           O : out  STD_LOGIC_VECTOR (3 downto 0));
end Mem_Ram;

architecture Behavioral of Mem_Ram is
type ram is array(15 downto 0) of std_logic_vector(3 downto 0);
signal dato: ram;
signal clk_w, clk_r: std_logic;
signal qaux: std_logic_vector(3 downto 0);

begin
clk_w <= (CS and R_W);
clk_r <= (CS and not(R_W));

escritura: process(clk_w)
begin
if(clk_w'event and clk_w='1')
then dato(conv_integer(A)) <= I;
end if;
end process;

lectura: process(clk_r)
begin
if (clk_r'event and clk_r='1')
then qaux <= dato(conv_integer(A));
end if;
end process;

process(CS, qaux)
begin 
if(CS='1')
then O <= qaux;
else O <= "ZZZZ";
end if;
end process;
end Behavioral;
