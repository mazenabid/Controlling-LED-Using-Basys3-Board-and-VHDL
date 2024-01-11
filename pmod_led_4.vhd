----------------------------------  Input Counter -----------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity button_up_down is  -- we name it button up down
Port ( present_state : out STD_LOGIC_VECTOR (3 downto 0); --This part iss listing all the buttons, 
--switches and lights... Each item in this list
-- is a way it can interact with the other entities.
       previous_state : in STD_LOGIC_VECTOR (3 downto 0); -- it shows 4 lights (in state)
           next_state : in STD_LOGIC_VECTOR (3 downto 0); -- it tells the fpga what the next step should be
           clk : in STD_LOGIC; -- clock to make it go to a lower state
           down_enable : in STD_LOGIC; -- it can go down
           up_enable : in STD_LOGIC); -- it can go up
end button_up_down; 

architecture Behavioral of button_up_down is 

begin  -- now we start
flop : process(next_state, clk, up_enable, down_enable, previous_state) -- we start special set of instructions
begin
if (rising_edge(clk)) then -- if it moves up switch is on and the next state isn't the lowest, then do something!! (increase led intensity)
    if (up_enable = '1' and not(next_state="0000")) then 
        present_state <= next_state; -- update to the next state
        
    elsif (down_enable = '1' and not(previous_state= "1111")) then -- if we move down, then go to the previous state
        present_state <= previous_state;
    end if;
end if;
end process flop; end Behavioral;

-------------------------------------counter clock div ----------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_arith.ALL;

entity counter_clkDiv is
    --here we list the connections to our fpga.
    Port (  
        clk : in std_logic; -- this is the main heartbeat..., like a fast ticking clock.
        sclk : out std_logic -- This is a slower ticking clock to pause a lil between levels (show on demo).
    );
end counter_clkDiv; 

-- now we start describing how counter_clkDiv behaves.
architecture my_clk_div of counter_clkDiv is
    -- This is like a big number the fpga cpu counts up to before it does something important.
    constant max_count : integer := (10000000);  
    -- this is a temporary clock inside the fpga, starting at '0'.
    signal tmp_clk : std_logic := '0'; 

begin
    --starting a special set of instructions named 'my_div'. It pays attention to the fast clock and the temporary clock.
    my_div: process (clk,tmp_clk)              
        -- this is a counter; think of it as the robot's way of counting steps.
        variable div_cnt : integer := 0;   
    begin
        -- if the main heartbeat ticks...
        if (rising_edge(clk)) then   
            -- If the robot has counted enough steps (reached max_count)... 15...
            if (div_cnt >= MAX_COUNT) then 
                tmp_clk <= not tmp_clk; --change the temporary clock to its opposite.
                div_cnt := 0; -- reset the step counter to 0.
            else
                div_cnt := div_cnt + 1; -- otherwise, just take another step in counting.
            end if; 
        end if; 
        sclk <= tmp_clk; --the slow ticking clock follows the temporary clock.
    end process my_div; --done with the 'my_div' process instructions.
end my_clk_div; --finally, we're done describing the robot's behavior.

---------------------------------LED clock divider---------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_arith.ALL;

entity led_clkDiv is
    -- Here we list the connections to our robot.
    Port ( 
        present_state : in STD_LOGIC_VECTOR (3 downto 0); 
        clk : in STD_LOGIC; 
        led_clk : out STD_LOGIC 
    );
end led_clkDiv; 

-- Now we start describing how led_clkDiv worksss.
architecture Behavioral of led_clkDiv is
    -- this is a temporary clock inside the fpga, starting at '0'.
    signal tmp_clk : std_logic := '0'; 
    -- this is a shared number the uses to decide when to change the LED.
    shared variable max_count : integer;

begin
    
    count_stuff : process (present_state)
    begin
        -- Depending on the current state, the fpga picks a different number.
        case present_state is
            when "0000" => max_count := 0; -- It continues like this, picking a number for each possible state.
            when "0001" => max_count := 2;
            when "0010" => max_count := 4;
            when "0011" => max_count := 6;
           when "0100" => max_count := 8;
            when "0101" => max_count := 10;
            when "0110" => max_count := 12;
            when "0111" => max_count := 14;
            when "1000" => max_count := 16;
            when "1001" => max_count := 25;
            when "1010" => max_count := 50;
            when "1011" => max_count := 100;
            when "1100" => max_count := 150;
            when "1101" => max_count := 200;
            when "1110" => max_count := 250;
            when "1111" => max_count := 300;
            
        end case;  
    end process count_stuff;

    -- another set of instructions named 'my_div'. It watches the fast clock and the temporary clock.
    my_div: process (clk, tmp_clk, present_state)  
        --this is a counter for the robot, like counting steps.
        variable div_cnt : integer := 0;   
    begin
        -- If the robot's main heartbeat ticks...
        if (rising_edge(clk)) then   
            -- If the robot has counted enough steps (reached 15)...
            if (div_cnt >= max_count) then 
                tmp_clk <= not tmp_clk; --change the temporary clock to its opposite.
                div_cnt := 0; -- Reset the step counter to 0.
            else
                div_cnt := div_cnt + 1; --otherwise, just take another step in counting.
            end if; 
        end if; 
        led_clk <= tmp_clk; --the special light follows the temporary clock.
    end process my_div; --done with the 'my_div' process instructions.

end Behavioral; 


---------------------------------LED controller-------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_arith.ALL;


entity counter is
    Port ( clk : in STD_LOGIC;
           up_enable : in STD_LOGIC;
           down_enable : in STD_LOGIC;
           SEGMENTS : out STD_LOGIC_VECTOR (7 downto 0);
           DISP_EN : out STD_LOGIC_VECTOR (3 downto 0);
           led_clk : out STD_LOGIC);
           
end counter;

architecture Behavioral of counter is

component button_up_down is
Port ( present_state : out STD_LOGIC_VECTOR (3 downto 0);
       previous_state : in STD_LOGIC_VECTOR (3 downto 0);
           next_state : in STD_LOGIC_VECTOR (3 downto 0);
           clk : in STD_LOGIC;
           down_enable :in STD_LOGIC;
           up_enable : in STD_LOGIC);
end component button_up_down;

component counter_clkDiv is
    Port (  clk : in std_logic;
           sclk : out std_logic);
end component counter_clkDiv;

-- Tshows numbers on a display.
component sseg_dec is
    Port ( 
        ALU_VAL : in std_logic_vector(7 downto 0); --this is the number to be displayed.
        SIGN : in std_logic; --this tells if the number is positive or negative.
        VALID : in std_logic; --this says if the number is a good one to show.
        CLK : in std_logic; --this is the clock, like the heartbeat.
        DISP_EN : out std_logic_vector(3 downto 0); -- these are switches to control which part of the display is on.
        SEGMENTS : out std_logic_vector(7 downto 0) --these control the individual parts of each number on the display.
    );
end component sseg_dec;

--this is another part of our robot that controls a special clock based on the robot's state.
component led_clkDiv is
    Port ( 
        present_state : in STD_LOGIC_VECTOR (3 downto 0); --this shows the robot's current state.
        clk : in STD_LOGIC; --this is another clock signal.
        led_clk : out STD_LOGIC -- this is the special clock controlled by the robot's state.
    );
end component led_clkDiv;

--these are like dials and clocks inside the robot.
signal present_state : STD_LOGIC_VECTOR (3 downto 0) := "0000";
signal next_state : STD_LOGIC_VECTOR (3 downto 0) := "0000";
signal previous_state : STD_LOGIC_VECTOR (3 downto 0) := "0000";
signal Alu_Val : STD_LOGIC_VECTOR (7 downto 0);
signal sclk : STD_LOGIC;

begin
    --here we set the first half of Alu_Val to zero and the second half to the present state.
    Alu_Val(7 downto 4) <= "0000";
    Alu_Val(3 downto 0) <= present_state;

    --these lines calculate what the next state should be based on the current state.
    next_state(0) <= not(present_state(0));
    next_state(1) <= present_state(0) xor present_state(1);
    next_state(2) <= (present_state(0) and present_state(1)) xor present_state(2);
    next_state(3) <= (present_state(0) and present_state(1) and present_state(2)) xor present_state(3);

    -- These lines calculate the previous state in a similar way.
    previous_state(0) <= not(present_state(0));
    previous_state(1) <= present_state(0) xnor present_state(1);
    previous_state(2) <= (present_state(0) nor present_state(1)) xor present_state(2);
    previous_state(3) <= ((present_state(0) or present_state(1) or present_state(2))) xnor present_state(3);

    --here we connect the parts of our robot.
    count : button_up_down port map(
    clk => sclk,
    next_state => next_state,
    previous_state => previous_state,
    up_enable => up_enable,
    down_enable => down_enable,
    present_state => present_state);     
        

    display : sseg_dec port map(
    ALU_VAL => Alu_Val,
    SIGN => '0',
    VALID => '1',
    CLK => clk,
    DISP_EN => DISP_EN,
    SEGMENTS => SEGMENTS);
    
led_div : led_clkDiv port map(
    clk => clk,
    present_state => present_state,
    led_clk => led_clk);    
    
clk_div : counter_clkDiv port map(
    clk => clk,
    sclk => sclk);
        
end Behavioral;
