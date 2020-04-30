--------------------------------------------------------------------------------
-- (c) Copyright 2011 - 2013 Xilinx, Inc. All rights reserved.
--
-- This file contains confidential and proprietary information
-- of Xilinx, Inc. and is protected under U.S. and
-- international copyright and other intellectual property
-- laws.
--
-- DISCLAIMER
-- This disclaimer is not a license and does not grant any
-- rights to the materials distributed herewith. Except as
-- otherwise provided in a valid license issued to you by
-- Xilinx, and to the maximum extent permitted by applicable
-- law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
-- WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
-- AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
-- BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
-- INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
-- (2) Xilinx shall not be liable (whether in contract or tort,
-- including negligence, or under any other theory of
-- liability) for any loss or damage of any kind or nature
-- related to, arising under or in connection with these
-- materials, including for any direct, or any indirect,
-- special, incidental, or consequential loss or damage
-- (including loss of data, profits, goodwill, or any type of
-- loss or damage suffered as a result of any action brought
-- by a third party) even if such damage or loss was
-- reasonably foreseeable or Xilinx had been advised of the
-- possibility of the same.
--
-- CRITICAL APPLICATIONS
-- Xilinx products are not designed or intended to be fail-
-- safe, or for use in any application requiring fail-safe
-- performance, such as life-support or safety devices or
-- systems, Class III medical devices, nuclear facilities,
-- applications related to the deployment of airbags, or any
-- other applications that could lead to death, personal
-- injury, or severe property or environmental damage
-- (individually and collectively, "Critical
-- Applications"). Customer assumes the sole risk and
-- liability of any use of Xilinx products in Critical
-- Applications, subject only to applicable laws and
-- regulations governing limitations on product liability.
--
-- THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
-- PART OF THIS FILE AT ALL TIMES.
--------------------------------------------------------------------------------
-- Description:
-- This is an example testbench for the CORDIC IP core.
-- The testbench has been generated by Vivado to accompany the IP core
-- instance you have generated.
--
-- This testbench is for demonstration purposes only.  See note below for
-- instructions on how to use it with your core.
--
-- See the CORDIC product guide for further information
-- about this core.
--
--------------------------------------------------------------------------------
-- Using this testbench
--
-- This testbench instantiates your generated CORDIC core
-- instance named "cordic_3".
--
-- Use Vivado's Run Simulation flow to run this testbench.  See the Vivado
-- documentation for details.
--------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

entity tb_cordic_3 is
end tb_cordic_3;

architecture tb of tb_cordic_3 is

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
  constant IP_PHASE_SHIFT : integer := 0;  -- no bit shift, max amplitude
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

  -- Common function to calculate sine and cosine values
  function create_ip_entry(index, depth, width : integer) return T_IP_INT_ENTRY is
    variable result : T_IP_INT_ENTRY;
    variable theta : real;
    variable limited_width : integer := width - 2;
  begin
    if limited_width > 30 then
      limited_width := 30; --avoid integer overflow
    end if;
    theta := real(index) / real(depth) * 2.0 * MATH_PI;
    result.re := integer(round(cos(theta) * real(2**limited_width)));
    result.im := integer(round(sin(theta) * real(2**limited_width)));
    return result;
  end function create_ip_entry;

  -- Use separate functions to calculate channel S_AXIS_CARTESIAN and S_AXIS_PHASE sinusoids as they return different types
  function create_ip_cartesian_table return T_IP_CARTESIAN_TABLE is
    variable result : T_IP_CARTESIAN_TABLE;
    variable entry_int : T_IP_INT_ENTRY;
  begin
    for i in 0 to IP_CARTESIAN_DEPTH-1 loop
      entry_int := create_ip_entry(i, IP_CARTESIAN_DEPTH, IP_CARTESIAN_WIDTH - IP_CARTESIAN_SHIFT);
      result(i).re := std_logic_vector(to_signed(entry_int.re, IP_CARTESIAN_WIDTH));
      result(i).im := std_logic_vector(to_signed(entry_int.im, IP_CARTESIAN_WIDTH));
    end loop;
    return result;
  end function create_ip_cartesian_table;

  function create_ip_phase_table return T_IP_PHASE_TABLE is
    variable result : T_IP_PHASE_TABLE;
    variable entry_int : T_IP_INT_ENTRY;
  begin
    for i in 0 to IP_PHASE_DEPTH-1 loop
      entry_int := create_ip_entry(IP_PHASE_DEPTH-1-i, IP_PHASE_DEPTH, IP_PHASE_WIDTH - IP_PHASE_SHIFT);  -- note rotation direction
      result(i).re := std_logic_vector(to_signed(entry_int.re, IP_PHASE_WIDTH));
    end loop;
    return result;
  end function create_ip_phase_table;

  -- Call the functions to create the data
  constant IP_CARTESIAN_DATA : T_IP_CARTESIAN_TABLE := create_ip_cartesian_table;
  constant IP_PHASE_DATA     : T_IP_PHASE_TABLE     := create_ip_phase_table;


begin

  -----------------------------------------------------------------------
  -- Instantiate the DUT
  -----------------------------------------------------------------------

  dut : entity work.cordic_3
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
      if cycles >= TEST_CYCLES then
        report "Not a real failure. Simulation finished successfully. Test completed successfully" severity failure;
        wait;
      end if;
    end loop;
  end process clock_gen;

  -----------------------------------------------------------------------
  -- Generate inputs
  -----------------------------------------------------------------------

  stimuli : process
    variable ip_cartesian_index   : integer   := 0;
    variable ip_phase_index       : integer   := 0;
    variable cartesian_tvalid_nxt : std_logic := '0';
    variable phase_tvalid_nxt     : std_logic := '0';
    variable phase2_cycles        : integer := 1;
    variable phase2_count         : integer := 0;
    constant PHASE2_LIMIT         : integer := 30;
  begin

    -- Test is stopped in clock_gen process, use endless loop here
    loop

      -- Drive inputs T_HOLD time after rising edge of clock
      wait until rising_edge(aclk);
      wait for T_HOLD;

      -- Drive AXI TVALID signals to demonstrate different types of operation
      case cycles is  -- do different types of operation at different phases of the test
        when 0 to PHASE_CYCLES * 1 - 1 =>
          -- Phase 1: inputs always valid, no missing input data
          cartesian_tvalid_nxt    := '1';
          phase_tvalid_nxt    := '1';
        when PHASE_CYCLES * 1 to PHASE_CYCLES * 2 - 1 =>
          -- Phase 2: deprive channel S_AXIS_CARTESIAN of valid transactions at an increasing rate
          phase_tvalid_nxt    := '1';
          if phase2_count < phase2_cycles then
            cartesian_tvalid_nxt := '0';
          else
            cartesian_tvalid_nxt := '1';
          end if;
          phase2_count := phase2_count + 1;
          if phase2_count >= PHASE2_LIMIT then
            phase2_count  := 0;
            phase2_cycles := phase2_cycles + 1;
          end if;
        when PHASE_CYCLES * 2 to PHASE_CYCLES * 3 - 1 =>
          -- Phase 3: deprive channel S_AXIS_CARTESIAN of 1 out of 2 transactions, and channel S_AXIS_PHASE of 1 out of 3 transactions
          if cycles mod 2 = 0 then
            cartesian_tvalid_nxt := '0';
          else
            cartesian_tvalid_nxt := '1';
          end if;
          if cycles mod 3 = 0 then
            phase_tvalid_nxt := '0';
          else
            phase_tvalid_nxt := '1';
          end if;
        when others =>
          -- Test will stop imminently - do nothing
          null;
      end case;

      -- Drive handshake signals with local variable values
      s_axis_cartesian_tvalid <= cartesian_tvalid_nxt;
      s_axis_phase_tvalid     <= phase_tvalid_nxt;

      -- Drive AXI slave channel CARTESIAN payload
      -- Drive 'X's on payload signals when not valid
      if cartesian_tvalid_nxt /= '1' then
        s_axis_cartesian_tdata <= (others => 'X');
      else
        -- TDATA: Real and imaginary components are each 16 bits wide and byte-aligned at their LSBs
        s_axis_cartesian_tdata(15 downto 0) <= IP_CARTESIAN_DATA(ip_cartesian_index).re;
        s_axis_cartesian_tdata(31 downto 16) <= IP_CARTESIAN_DATA(ip_cartesian_index).im;

      end if;

      -- Drive AXI slave channel PHASE payload
      -- Drive 'X's on payload signals when not valid
      if phase_tvalid_nxt /= '1' then
        s_axis_phase_tdata <= (others => 'X');
      else
        -- TDATA: Real component is 16 bits wide and byte-aligned at its LSBs
        s_axis_phase_tdata(15 downto 0) <= IP_PHASE_DATA(ip_phase_index).re;
      end if;

      -- Increment input data indices
      if cartesian_tvalid_nxt = '1' then
        ip_cartesian_index := ip_cartesian_index + 1;
        if ip_cartesian_index = IP_CARTESIAN_DEPTH then
          ip_cartesian_index := 0;
        end if;
      end if;
      if phase_tvalid_nxt = '1' then
        ip_phase_index := ip_phase_index + 1;
        if ip_phase_index = IP_PHASE_DEPTH then
          ip_phase_index := 0;
        end if;
      end if;

    end loop;

  end process stimuli;

  -----------------------------------------------------------------------
  -- Check outputs
  -----------------------------------------------------------------------

  check_outputs : process
    variable check_ok : boolean := true;
  begin

    -- Check outputs T_STROBE time after rising edge of clock
    wait until rising_edge(aclk);
    wait for T_STROBE;

    -- Do not check the output payload values, as this requires the behavioral model
    -- which would make this demonstration testbench unwieldy.
    -- Instead, check the protocol of the DOUT channel:
    -- check that the payload is valid (not X) when TVALID is high

    if m_axis_dout_tvalid = '1' then
      if is_x(m_axis_dout_tdata) then
        report "ERROR: m_axis_dout_tdata is invalid when m_axis_dout_tvalid is high" severity error;
        check_ok := false;
      end if;

    end if;

    assert check_ok
      report "ERROR: terminating test with failures." severity failure;

  end process check_outputs;

  -----------------------------------------------------------------------
  -- Assign TDATA fields to aliases, for easy simulator waveform viewing
  -----------------------------------------------------------------------

  s_axis_cartesian_tdata_real  <= s_axis_cartesian_tdata(15 downto 0);
  s_axis_cartesian_tdata_imag  <= s_axis_cartesian_tdata(31 downto 16);

  m_axis_dout_tdata_real       <= m_axis_dout_tdata(15 downto 0);
  m_axis_dout_tdata_phase      <= m_axis_dout_tdata(31 downto 16);

end tb;

