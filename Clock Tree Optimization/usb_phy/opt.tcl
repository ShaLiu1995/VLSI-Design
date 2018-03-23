set ffList [get_cells * -filter "is_sequential==true"]

define_user_attribute ffInSlack -classes {cell} -type float
define_user_attribute ffOutSlack -classes {cell} -type float
define_user_attribute ffDeltaSlack -classes {cell} -type float
foreach_in_collection cell $ffList {
    set in_pin [filter_collection [get_pins -of $cell -filter "direction==in"] is_clock_pin==false]
    set in_clock_pin [filter_collection [get_pins -of $cell -filter "direction==in"] is_clock_pin==true]
    set out_pin [get_pins -of $cell -filter "direction==out"]
    set in_slack [get_attri [get_timing_paths -to $in_pin] slack]
    set out_slack [get_attri [get_timing_paths -from $out_pin] slack]

    set_user_attribute $cell ffInSlack $in_slack
    set_user_attribute $cell ffOutSlack $out_slack
    set_user_attribute $cell ffDeltaSlack [expr $out_slack - $in_slack]
}
# set ffList [sort_collection -descending $ffList {ffInSlack}]
set ffList [sort_collection $ffList {ffOutSlack}]

foreach_in_collection ff $ffList {
    set in_pin [filter_collection [get_pins -of $ff -filter "direction==in"] is_clock_pin==false]
    set in_clock_pin [filter_collection [get_pins -of $ff -filter "direction==in"] is_clock_pin==true]
    set out_pin [get_pins -of $ff -filter "direction==out"]
    set in_slack [get_attri [get_timing_paths -to $in_pin] slack]
    set out_slack [get_attri [get_timing_paths -from $out_pin] slack]

    # if {$in_slack < 0 && $out_slack > 0} {
	#     puts "[get_object_name $ff] [get_object_name $in_clock_pin]"
    #     PtInsertCell [get_object_name $in_clock_pin] bf01f02  
    # }

    if {$in_slack < 0 && $out_slack > 0} {
        puts "Out_slack:\t${out_slack} ps"
        puts "In_slack:\t${in_slack} ps"
	    puts "[get_object_name $ff] [get_object_name $in_clock_pin]"
        PtInsertCell [get_object_name $in_clock_pin] bf01f02  
    }
}


