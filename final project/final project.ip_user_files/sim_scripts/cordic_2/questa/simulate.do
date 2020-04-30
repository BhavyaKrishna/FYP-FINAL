onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib cordic_2_opt

do {wave.do}

view wave
view structure
view signals

do {cordic_2.udo}

run -all

quit -force
