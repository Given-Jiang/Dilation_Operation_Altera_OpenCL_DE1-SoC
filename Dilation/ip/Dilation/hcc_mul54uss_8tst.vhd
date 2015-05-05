
LIBRARY ieee;
LIBRARY work;
LIBRARY lpm;
USE lpm.all;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_signed.all;
USE ieee.std_logic_arith.all; 

--***************************************************
--***                                             ***
--***   ALTERA FLOATING POINT DATAPATH COMPILER   ***
--***                                             ***
--***   HCC_MUL54USS_8TST.VHD                     ***
--***                                             ***
--***   Function: 6 pipeline stage unsigned 54    ***
--***             bit multiplier (synthesizable)  ***
--***                                             ***
--***  FOR FITTING TESTING ONLY - NOT TESTED      ***
--***                                             ***
--***                                             ***
--***                                             ***
--***************************************************

ENTITY hcc_mul54uss_8tst IS
PORT (
      sysclk : IN STD_LOGIC;
      reset : IN STD_LOGIC;
      enable : IN STD_LOGIC;
      mulaa, mulbb : IN STD_LOGIC_VECTOR (54 DOWNTO 1);      

      mulcc : OUT STD_LOGIC_VECTOR (64 DOWNTO 1)  
     );
END hcc_mul54uss_8tst;

ARCHITECTURE syn of hcc_mul54uss_8tst IS

  signal muloneout : STD_LOGIC_VECTOR (72 DOWNTO 1);
  signal multwoout, multhrout : STD_LOGIC_VECTOR (36 DOWNTO 1);
  signal mulforout, mulfivout : STD_LOGIC_VECTOR (36 DOWNTO 1);
  signal vecone, vectwo, vecthr : STD_LOGIC_VECTOR (36 DOWNTO 1);
  signal sumone, carone : STD_LOGIC_VECTOR (36 DOWNTO 1);
  signal vecfor, vecfiv, vecsix : STD_LOGIC_VECTOR (37 DOWNTO 1);
  signal sumtwo, cartwo : STD_LOGIC_VECTOR (37 DOWNTO 1);
  signal sumtwoff, cartwoff : STD_LOGIC_VECTOR (38 DOWNTO 1);
  signal vecsev, vecegt, vecnin : STD_LOGIC_VECTOR (72 DOWNTO 1);
  signal sumthr, carthr : STD_LOGIC_VECTOR (72 DOWNTO 1);
  signal sumthrff, carthrff : STD_LOGIC_VECTOR (72 DOWNTO 1);
  
  signal zerovec : STD_LOGIC_VECTOR (34 DOWNTO 1);

  component altmult_add
	GENERIC (
		addnsub_multiplier_aclr1		: STRING;
		addnsub_multiplier_pipeline_aclr1		: STRING;
		addnsub_multiplier_pipeline_register1		: STRING;
		addnsub_multiplier_register1		: STRING;
		dedicated_multiplier_circuitry		: STRING;
		input_aclr_a0		: STRING;
		input_aclr_b0		: STRING;
		input_register_a0		: STRING;
		input_register_b0		: STRING;
		input_source_a0		: STRING;
		input_source_b0		: STRING;
		intended_device_family		: STRING;
		lpm_type		: STRING;
		multiplier1_direction		: STRING;
		multiplier_aclr0		: STRING;
		multiplier_register0		: STRING;
		number_of_multipliers		: NATURAL;
		output_aclr		: STRING;
		output_register		: STRING;
		port_addnsub1		: STRING;
		port_signa		: STRING;
		port_signb		: STRING;
		representation_a		: STRING;
		representation_b		: STRING;
		signed_aclr_a		: STRING;
		signed_aclr_b		: STRING;
		signed_pipeline_aclr_a		: STRING;
		signed_pipeline_aclr_b		: STRING;
		signed_pipeline_register_a		: STRING;
		signed_pipeline_register_b		: STRING;
		signed_register_a		: STRING;
		signed_register_b		: STRING;
		width_a		: NATURAL;
		width_b		: NATURAL;
		width_result		: NATURAL
	);
	PORT (
			dataa	: IN STD_LOGIC_VECTOR (width_a-1 DOWNTO 0);
			datab	: IN STD_LOGIC_VECTOR (width_b-1 DOWNTO 0);
			clock0	: IN STD_LOGIC ;
			aclr3	: IN STD_LOGIC ;
			ena0	: IN STD_LOGIC ;
			result	: OUT STD_LOGIC_VECTOR (width_result-1 DOWNTO 0)
	);
	end component;
	
	-- identical component to that above, but fixed at 18x18, latency 2
	-- mul18usus generated by Quartus 
	component hcc_mul18usus
	PORT
	(
		aclr3		: IN STD_LOGIC  := '0';
		clock0		: IN STD_LOGIC  := '1';
		dataa_0		: IN STD_LOGIC_VECTOR (17 DOWNTO 0) :=  (OTHERS => '0');
		datab_0		: IN STD_LOGIC_VECTOR (17 DOWNTO 0) :=  (OTHERS => '0');
		ena0		: IN STD_LOGIC  := '1';
		result		: OUT STD_LOGIC_VECTOR (35 DOWNTO 0)
	);
	end component;

	COMPONENT lpm_add_sub
	GENERIC (
		lpm_direction		: STRING;
		lpm_hint		: STRING;
		lpm_pipeline		: NATURAL;
		lpm_type		: STRING;
		lpm_width		: NATURAL
	);
	PORT (
			dataa	: IN STD_LOGIC_VECTOR (63 DOWNTO 0);
			datab	: IN STD_LOGIC_VECTOR (63 DOWNTO 0);
			clken	: IN STD_LOGIC ;
			aclr	: IN STD_LOGIC ;
			clock	: IN STD_LOGIC ;
			result	: OUT STD_LOGIC_VECTOR (63 DOWNTO 0)
	);
	END COMPONENT;
		 
BEGIN

  gza: FOR k IN 1 TO 34 GENERATE
    zerovec(k) <= '0';
  END GENERATE;
  
  mulone : altmult_add
  GENERIC MAP (
		addnsub_multiplier_aclr1 => "ACLR3",
		addnsub_multiplier_pipeline_aclr1 => "ACLR3",
		addnsub_multiplier_pipeline_register1 => "CLOCK0",
		addnsub_multiplier_register1 => "CLOCK0",
		dedicated_multiplier_circuitry => "AUTO",
		input_aclr_a0 => "ACLR3",
		input_aclr_b0 => "ACLR3",
		input_register_a0 => "CLOCK0",
		input_register_b0 => "CLOCK0",
		input_source_a0 => "DATAA",
		input_source_b0 => "DATAB",
		intended_device_family => "Stratix II",
		lpm_type => "altmult_add",
		multiplier1_direction => "ADD",
		multiplier_aclr0 => "ACLR3",
		multiplier_register0 => "CLOCK0",
		number_of_multipliers => 1,
		output_aclr => "ACLR3",
		output_register => "CLOCK0",
		port_addnsub1 => "PORT_UNUSED",
		port_signa => "PORT_UNUSED",
		port_signb => "PORT_UNUSED",
		representation_a => "UNSIGNED",
		representation_b => "UNSIGNED",
		signed_aclr_a => "ACLR3",
		signed_aclr_b => "ACLR3",
		signed_pipeline_aclr_a => "ACLR3",
		signed_pipeline_aclr_b => "ACLR3",
		signed_pipeline_register_a => "CLOCK0",
		signed_pipeline_register_b => "CLOCK0",
		signed_register_a => "CLOCK0",
		signed_register_b => "CLOCK0",
		width_a => 36,
		width_b => 36,
		width_result => 72
	)
	PORT MAP (
		dataa => mulaa(54 DOWNTO 19),
		datab => mulbb(54 DOWNTO 19),
		clock0 => sysclk,
		aclr3 => reset,
		ena0 => enable,
		result => muloneout
	);
            
  --	Blo*C 18*18 = 36, latency = 2
	multwo: hcc_mul18usus
	PORT MAP (
		dataa_0 => mulaa(54 DOWNTO 37),
		datab_0 => mulbb(18 DOWNTO 1),
		clock0 => sysclk,
		aclr3 => reset,
		ena0 => enable,
		result => multwoout
	);
         	
  --	Bhi*C 18*18 = 36, latency = 2
  multhr: hcc_mul18usus
	PORT MAP (
		dataa_0 => mulaa(36 DOWNTO 19),
		datab_0 => mulbb(18 DOWNTO 1),
		clock0 => sysclk,
		aclr3 => reset,
		ena0 => enable,
		result => multhrout
	);
            
  --	Alo*D 18*18 = 36, latency = 2
  mulfor: hcc_mul18usus
	PORT MAP (
		dataa_0 => mulbb(54 DOWNTO 37),
		datab_0 => mulaa(18 DOWNTO 1),
		clock0 => sysclk,
		aclr3 => reset,
		ena0 => enable,
		result => mulforout
	);	

  --	Ahi*D 18*18 = 36, latency = 2
  mulfiv: hcc_mul18usus
	PORT MAP (
		dataa_0 => mulbb(36 DOWNTO 19),
		datab_0 => mulaa(18 DOWNTO 1),
		clock0 => sysclk,
		aclr3 => reset,
		ena0 => enable,
		result => mulfivout
	);

  vecone <= multwoout;
  vectwo <= zerovec(18 DOWNTO 1) & multhrout(36 DOWNTO 19);
  vecthr <= mulforout;
  
  gca: FOR k IN 1 TO 36 GENERATE
    sumone(k) <= vecone(k) XOR vectwo(k) XOR vecthr(k);
    carone(k) <= (vecone(k) AND vectwo(k)) OR 
                 (vecone(k) AND vecthr(k)) OR
                 (vectwo(k) AND vecthr(k));
  END GENERATE;
  
  vecfor <= '0' & sumone;
  vecfiv <= carone & '0';
  vecsix <= zerovec(19 DOWNTO 1) & mulfivout(36 DOWNTO 19);
  
  gcb: FOR k IN 1 TO 37 GENERATE
    sumtwo(k) <= vecfor(k) XOR vecfiv(k) XOR vecsix(k);
    cartwo(k) <= (vecfor(k) AND vecfiv(k)) OR 
                 (vecfor(k) AND vecsix(k)) OR
                 (vecfiv(k) AND vecsix(k));
  END GENERATE;
  
  pma: PROCESS (sysclk,reset)
  BEGIN
      
    IF (reset = '1') THEN

      FOR k IN 1 TO 38 LOOP
        sumtwoff(k) <= '0';
        cartwoff(k) <= '0';
      END LOOP;
      
    ELSIF (rising_edge(sysclk)) THEN
      
      IF (enable = '1') THEN
        sumtwoff <= '0' & sumtwo;
        cartwoff <= cartwo & '0';
      END IF;
    
    END IF;
      
  END PROCESS;
  
  vecsev <= zerovec(34 DOWNTO 1) & sumtwoff;
  vecegt <= zerovec(34 DOWNTO 1) & cartwoff;
  vecnin <= muloneout;
  
  gcc: FOR k IN 1 TO 72 GENERATE
    sumthr(k) <= vecsev(k) XOR vecegt(k) XOR vecnin(k);
    carthr(k) <= (vecsev(k) AND vecegt(k)) OR 
                 (vecsev(k) AND vecnin(k)) OR
                 (vecegt(k) AND vecnin(k));
  END GENERATE;
  
  pmb: PROCESS (sysclk,reset)
  BEGIN
      
    IF (reset = '1') THEN

      FOR k IN 1 TO 72 LOOP
        sumthrff(k) <= '0';
        carthrff(k) <= '0';
      END LOOP;
      
    ELSIF (rising_edge(sysclk)) THEN
      
      IF (enable = '1') THEN
        sumthrff <= sumthr;
        carthrff <= carthr(71 DOWNTO 1) & '0';
      END IF;
  
    END IF;
      
  END PROCESS;

  -- according to marcel, 2 pipes = 1 pipe in middle, on on output
	adder : lpm_add_sub
	GENERIC MAP (
		lpm_direction => "ADD",
		lpm_hint => "ONE_INPUT_IS_CONSTANT=NO,CIN_USED=NO",
		lpm_pipeline => 2,
		lpm_type => "LPM_ADD_SUB",
		lpm_width => 64
	)
	PORT MAP (
		dataa => sumthrff(72 DOWNTO 9),
		datab => carthrff(72 DOWNTO 9),
		clken => enable,
		aclr => reset,
		clock => sysclk,
		result => mulcc
	);
                                  
END syn;
