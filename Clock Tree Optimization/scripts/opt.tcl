
set ffList [get_cells * -filter "is_sequential==true"]
foreach_in_collection ff $ffList {
    set in_pin [filter_collection [get_pins -of $ff -filter "direction==in"] is_clock_pin==false]
    set in_clock_pin [filter_collection [get_pins -of $ff -filter "direction==in"] is_clock_pin==true]
    set out_pin [get_pins -of $ff -filter "direction==out"]
    set in_slack [get_attri [get_timing_paths -to $in_pin] slack]
    set out_slack [get_attri [get_timing_paths -from $out_pin] slack]

    if {$in_slack < 0 && $out_slack > 0} {
	puts "[get_object_name $ff] [get_object_name $in_clock_pin]"
        PtInsertCell [get_object_name $in_clock_pin] bf01f01  
    }
}


