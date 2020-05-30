library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;
use ieee.numeric_std;

entity Rect_to_polar is
port  (
      x_real :in std_logic_vector(15 downto 0) ;
      y_real :in std_logic_vector(15 downto 0);
      mag    :out std_logic_vector(15 downto 0);
      phase  :out std_logic_vector(15 downto 0);
      input_rdy:in  std_logic;
      output_rdy:out std_logic); 

end Rect_to_polar;

architecture tb of Rect_to_polar is

  -----------------------------------------------------------------------
  -- Timing constants
  -----------------------------------------------------------------------
  constant CLOCK_PERIOD : time := 100 ns;
  constant T_HOLD       : time := 10 ns;
  constant T_STROBE     : time := CLOCK_PERIOD - (1 ns);
  constant TEST_CYCLES  : integer := 3000;
  constant PHASE_CYCLES : integer := 1000;

  -----------------------------------------------------------------------
  -- DUT input signals
  -----------------------------------------------------------------------

  -- General inputs
  signal aclk               : std_logic := '0';  -- the master clock

  -- Slave channel CARTESIAN inputs
  signal s_axis_cartesian_tvalid    : std_logic := '0';  -- TVALID for channel S_AXIS_CARTESIAN
  signal s_axis_cartesian_tdata     : std_logic_vector(31 downto 0) := (others => 'X');  -- TDATA for channel S_AXIS_CARTESIAN

  -- Slave channel PHASE inputs
  signal s_axis_phase_tvalid    : std_logic := '0';  -- TVALID for channel S_AXIS_PHASE
  signal s_axis_phase_tdata     : std_logic_vector(15 downto 0) := (others => 'X');  -- TDATA for channel S_AXIS_PHASE

  -----------------------------------------------------------------------
  -- DUT output signals
  -----------------------------------------------------------------------

  -- Master channel DOUT outputs
  signal m_axis_dout_tvalid : std_logic := '0';  -- TVALID for channel M_AXIS_DOUT
  signal m_axis_dout_tdata  : std_logic_vector(31 downto 0) := (others => '0');  -- TDATA for channel M_AXIS_DOUT

  -----------------------------------------------------------------------
  -- Aliases for AXI channel TDATA fields
  -- These are a convenience for viewing data in a simulator waveform viewer.
  -- If using ModelSim or Questa, add "-voptargs=+acc=n" to the vsim command
  -- to prevent the simulator optimizing away these signals.
  -----------------------------------------------------------------------
  signal s_axis_cartesian_tdata_real     : std_logic_vector(15 downto 0) := (others => '0');
  signal s_axis_cartesian_tdata_imag     : std_logic_vector(15 downto 0) := (others => '0');
  signal s_axis_phase_tdata_real         : std_logic_vector(15 downto 0) := (others => '0');

  signal m_axis_dout_tdata_real  : std_logic_vector(15 downto 0) := (others => '0');
  signal m_axis_dout_tdata_imag  : std_logic_vector(15 downto 0) := (others => '0');
  signal m_axis_dout_tdata_phase : std_logic_vector(15 downto 0) := (others => '0');
  -----------------------------------------------------------------------
  -- Testbench signals
  -----------------------------------------------------------------------

  signal cycles       : integer   := 0;    -- Clock cycle counter

  -----------------------------------------------------------------------
  -- Constants, types and functions to create input data
  -- The CORDIC is fed two sinusoids exp(+/-jwt) of different frequencies and amplitudes:
  --   channel CARTESIAN: exp(+jwt), frequency = clock / 30,
  --   channel PHASE: exp(-jwt), frequency = clock / 32,
  -----------------------------------------------------------------------

  constant IP_CARTESIAN_DEPTH : integer := 30;
  constant IP_CARTESIAN_WIDTH : integer := 16;
  constant IP_CARTESIAN_SHIFT : integer := 3;  -- bit shift for amplitude
  constant IP_PHASE_DEPTH : integer := 32;
  constant IP_PHASE_WIDTH : integer := 16;
  constant IP_PHASE_SHIFT : integer := 0; 
  signal x_real1 : std_logic_vector(15 downto 0):="1100000000000000"; 
  signal y_real1 : std_logic_vector(15 downto 0):="1100000000000000"; -- no bit shift, max amplitude

  type T_IP_INT_ENTRY is record
    re : integer;
    im : integer;
  end record;
  type T_IP_CARTESIAN_ENTRY is record
    re : std_logic_vector(IP_CARTESIAN_WIDTH-1 downto 0);
    im : std_logic_vector(IP_CARTESIAN_WIDTH-1 downto 0);
  end record;
  type T_IP_PHASE_ENTRY is record
    re : std_logic_vector(IP_PHASE_WIDTH-1 downto 0);
  end record;
  type T_IP_CARTESIAN_TABLE is array (0 to IP_CARTESIAN_DEPTH-1) of T_IP_CARTESIAN_ENTRY;
  type T_IP_PHASE_TABLE is array (0 to IP_PHASE_DEPTH-1) of T_IP_PHASE_ENTRY;



begin

  -----------------------------------------------------------------------
  -- Instantiate the DUT
  -----------------------------------------------------------------------

  dut : entity work.cordic_1
    port map (
      aclk                => aclk,
      s_axis_cartesian_tvalid     => s_axis_cartesian_tvalid,
      s_axis_cartesian_tdata      => s_axis_cartesian_tdata,
      m_axis_dout_tvalid  => m_axis_dout_tvalid,
      m_axis_dout_tdata   => m_axis_dout_tdata
      );

  -----------------------------------------------------------------------
  -- Generate clock
  -----------------------------------------------------------------------
 
 clock_gen : process
  begin
    aclk <= '0';
    wait for CLOCK_PERIOD;
    loop
      cycles <= cycles + 1;
      aclk <= '0';
      wait for CLOCK_PERIOD/2;
      aclk <= '1';
      wait for CLOCK_PERIOD/2;
    end loop;
  end process clock_gen;

  -----------------------------------------------------------------------
  -- Generate inputs
  -----------------------------------------------------------------------

  stimuli : process(input_rdy)
    variable ip_cartesian_index   : integer   := 0;
    variable ip_phase_index       : integer   := 0;
    variable cartesian_tvalid_nxt : std_logic := '0';
    variable phase_tvalid_nxt     : std_logic := '0';
    variable phase2_cycles        : integer := 1;
    variable phase2_count         : integer := 0;
    constant PHASE2_LIMIT         : integer := 30;
  begin
      if input_rdy='1' then
      cartesian_tvalid_nxt    := '1';
      phase_tvalid_nxt    := '1';
      end if;
      -- Drive handshake signals with local variable values
      if input_rdy='0' then
      cartesian_tvalid_nxt    := '0';
      phase_tvalid_nxt    := '0';
      end if;
      
      s_axis_cartesian_tvalid <= cartesian_tvalid_nxt;
      s_axis_phase_tvalid     <= phase_tvalid_nxt;
      
      s_axis_cartesian_tdata(15 downto 0) <= x_real;
      s_axis_cartesian_tdata(31 downto 16) <= y_real;
     
 
end process stimuli;


  -----------------------------------------------------------------------
  -- Assign TDATA fields to aliases, for easy simulator waveform viewing
  -----------------------------------------------------------------------

  s_axis_cartesian_tdata_real  <= s_axis_cartesian_tdata(15 downto 0);
  s_axis_cartesian_tdata_imag  <= s_axis_cartesian_tdata(31 downto 16);

  m_axis_dout_tdata_real       <= m_axis_dout_tdata(15 downto 0);
  m_axis_dout_tdata_phase      <= m_axis_dout_tdata(31 downto 16);
  mag <= m_axis_dout_tdata(15 downto 0);
  phase<=m_axis_dout_tdata(31 downto 16);
  output_rdy<=m_axis_dout_tvalid;
end tb;
