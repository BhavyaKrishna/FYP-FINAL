@echo off
REM ****************************************************************************
REM Vivado (TM) v2018.2 (64-bit)
REM
REM Filename    : elaborate.bat
REM Simulator   : Xilinx Vivado Simulator
REM Description : Script for elaborating the compiled design
REM
REM Generated by Vivado on Wed Apr 29 11:57:26 +0530 2020
REM SW Build 2258646 on Thu Jun 14 20:03:12 MDT 2018
REM
REM Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
REM
REM usage: elaborate.bat
REM
REM ****************************************************************************
call xelab  -wto 1a5e0d0325ac4d40b473a3f339e17514 --incr --debug typical --relax --mt 2 -L xbip_utils_v3_0_9 -L c_reg_fd_v12_0_5 -L xbip_dsp48_wrapper_v3_0_4 -L xbip_pipe_v3_0_5 -L xbip_dsp48_addsub_v3_0_5 -L xbip_addsub_v3_0_5 -L c_addsub_v12_0_12 -L xbip_bram18k_v3_0_5 -L mult_gen_v12_0_14 -L axi_utils_v2_0_5 -L cordic_v6_0_14 -L xil_defaultlib -L unisims_ver -L unimacro_ver -L secureip -L xpm --snapshot Integrator_behav xil_defaultlib.Integrator xil_defaultlib.glbl -log elaborate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
