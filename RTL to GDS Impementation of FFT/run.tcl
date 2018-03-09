#!/usr/bin/tclsh

set arg [lindex $argv 0]
set ::env(LD_LIBRARY_PATH) "/software/nonrdist/synopsys-verdi-J2014.12/share/PLI/IUS/LINUX/boot:$::env(LD_LIBRARY_PATH)"

if {$argv=="SIM"} {
    #exec matlab -nosplash -nodesktop -r fft_sim
        #exec sed -e "s/__szBit__/$szBit/g" fft_variable_bit_template.v > fft_variable_bit.v
        source float2hex.tcl
        exec ncverilog -sv +ncaccess+r -loadpli1 debpli:novas_pli_boot -f filelist 
        source hex2float.tcl
        source calc_avg_error.tcl
        #exec cp fft_error.csv fft_error_${szBit}.csv
        #break
} elseif {$argv=="WAVE"} {
    exec verdi -sv -f filelist -ssf ./vcd/tb_top.fsdb &
} elseif {$argv=="SYN"} {
    exec dc_shell-xg-t -f run_dc.tcl -out dc.log &
} elseif {$argv=="REPORT"} {
    if {![file exists REPORT]} {
        exec mkdir REPORT
    }
    exec cp -rb fft_error.csv vlog.fft_output.csv.float fft_output.csv design.sdc fft_variable_bit.v log/ gate/ result_dc.rpt dc.log REPORT/
}


