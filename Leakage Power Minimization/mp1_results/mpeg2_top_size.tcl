set design [get_attri [current_design] full_name]
set outFp [open ${design}_sizing.rpt w]

set initialWNS  [ PtWorstSlack clk ]
set initialLeak [ PtLeakPower ]
set capVio [ PtGetCapVio ]
set tranVio [ PtGetTranVio ]
puts "Initial slack:\t${initialWNS} ps"
puts "Initial leakage:\t${initialLeak} W"
puts "Initial $capVio"
puts "Initial $tranVio"
puts "======================================" 
puts $outFp "Initial slack:\t${initialWNS} ps"
puts $outFp "Initial leakage:\t${initialLeak} W"
puts $outFp "Initial $capVio"
puts $outFp "Initial $tranVio"
puts $outFp "======================================" 

set cellList [sort_collection [get_cells *] base_name]
set VtswapCnt 0
set SizeswapCnt 0

define_user_attribute CellSlack -classes {cell} -type float
define_user_attribute CellLeak -classes {cell} -type float

foreach_in_collection cell $cellList {
    set cellName [get_attri $cell base_name]
    # puts "checkpoint0"
    set libcell [get_lib_cells -of_objects $cellName]
    set libcellName [get_attri $libcell base_name]


    set_user_attribute $cell CellSlack [PtCellSlack $cellName]
    set_user_attribute $cell CellLeak [PtCellLeak $cellName]
    # set_user_attribute $cell OldCellLeak [get_attri $cell leakage_power]
}

set sortedCellList [sort_collection -descending $cellList {CellSlack CellLeak}]

# foreach_in_collection cell $newCellList {
#     set testCellSlack [get_attri $cell CellSlack]
#     puts "testCellSlack:\t${testCellSlack}"
# }

# Increasing Vt
foreach_in_collection cell $sortedCellList {
    set cellName [get_attri $cell base_name]
    # puts "checkpoint1"
    set libcell [get_lib_cells -of_objects $cellName]
    set libcellName [get_attri $libcell base_name]
    if {$libcellName == "ms00f80" || $libcellName == ""} {
        continue
    }
    
    # puts "checkpoint 1"
    # puts "cellName:\t${cellName}"
    # puts "libcell:\t${libcell}"
    # puts "libcellName:\t${libcellName}"  

    # set libcell [get_lib_cells -of_objects $cellName]
    # set libcellName [get_attri $libcell base_name]

    set flagVt 1
    while { $flagVt == 1} {
        set libcell [get_lib_cells -of_objects $cellName]
        set libcellName [get_attri $libcell base_name]
        set newlibcellName [ getNextVtUp $libcellName ]
        # puts "checkpoint2   "
        # puts "newlibcellName:\t${newlibcellName}"
        if { $newlibcellName == "skip"} {
            break;
        }
        size_cell $cellName $newlibcellName
        set newWNS [ PtWorstSlack clk ]
        if { $newWNS < 0.0 } {
            set flagVt 0
            size_cell $cellName $libcellName
        } else {
            incr VtswapCnt
            puts $outFp "- cell ${cellName} is swapped to $newlibcellName"
        }
    }
}

# puts "checkpoint 2"
# puts "cellName:\t${cellName}"
# puts "libcell:\t${libcell}"
# puts "libcellName:\t${libcellName}"

foreach_in_collection cell $sortedCellList {
    set cellName [get_attri $cell base_name]
    set libcell [get_lib_cells -of_objects $cellName]
    set libcellName [get_attri $libcell base_name]

    set_user_attribute $cell CellSlack [PtCellSlack $cellName]
    set_user_attribute $cell CellLeak [PtCellLeak $cellName]
    # set_user_attribute $cell OldCellLeak [get_attri $cell leakage_power]
}

set sortedCellList [sort_collection -descending $sortedCellList {CellSlack CellLeak}]


# # Downsizing
foreach_in_collection cell $sortedCellList {
    set cellName [get_attri $cell base_name]
    # puts "checkpoint2"
    set libcell [get_lib_cells -of_objects $cellName]
    set libcellName [get_attri $libcell base_name]
    if { $libcellName == "ms00f80" || $libcellName == "" } {
        continue
    }

    if { [regexp {[a-z][a-z][0-9][0-9][smf]0[0-9]} $libcellName] } {
        continue
    }
    
    set flagSize 1
    # while { $flagSize == 1 } {
    set libcell [get_lib_cells -of_objects $cellName]
    set libcellName [get_attri $libcell base_name]
    set newlibcellName [ getNextSizeDown $libcellName ]
    # puts "newlibcellName:\t${newlibcellName}"
    if { $newlibcellName == "skip"} {
        continue
    }
    size_cell $cellName $newlibcellName
    set newWNS [ PtWorstSlack clk ]
    if { $newWNS < 0.0 } {
        set flagSize 0
        size_cell $cellName $libcellName
    } else {
        incr SizeswapCnt
        puts $outFp "- cell ${cellName} is swapped to $newlibcellName"
    }
        
    # }
}

set finalWNS  [ PtWorstSlack clk ]
set finalLeak [ PtLeakPower ]
set capVio [ PtGetCapVio ]
set tranVio [ PtGetTranVio ]
set improvment  [format "%.3f" [expr ( $initialLeak - $finalLeak ) / $initialLeak * 100.0]]
puts  "======================================" 
puts  "Final slack:\t${finalWNS} ps"
puts  "Final leakage:\t${finalLeak} W"
puts  "Final $capVio"
puts  "Final $tranVio"
puts  "#Vt   cell swaps:\t${VtswapCnt}"
puts  "#Cell size swaps:\t${SizeswapCnt}"
puts  "Leakage improvment\t${improvment} %"
puts $outFp "======================================" 
puts $outFp "Final slack:\t${finalWNS} ps"
puts $outFp "Final leakage:\t${finalLeak} W"
puts $outFp "Final $capVio"
puts $outFp "Final $tranVio"
puts $outFp "#Vt cell swaps:\t${VtswapCnt}"
puts $outFp "#Cell size swaps:\t${SizeswapCnt}"
puts $outFp "Leakage improvment\t${improvment} %"

close $outFp    


