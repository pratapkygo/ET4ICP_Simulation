# SVisual through SWB
# Combined NMOS and PMOS - IdVg Curve Plotter
# ET4ICP

set deviceType "@deviceType@"
set vtAdj "@vtAdj@"

set fileList [glob -nocomplain n@node|sdevice@_@deviceType@_@vtAdj@_IdVg*.plt]
foreach myFile $fileList {
	puts $myFile
}

if {[llength [list_plots Plot_1D]]==0} {
	set myPlot1D [create_plot -1d -name Plot_1D]
	select_plots $myPlot1D
	
	set_plot_prop -plot $myPlot1D -title "${deviceType}; ${vtAdj} - IdVg"
	set_plot_prop -plot $myPlot1D -show_grid
	set_axis_prop -plot $myPlot1D -axis x -title "Gate Voltage Vg (V)" -type linear 
	set_axis_prop -plot $myPlot1D -axis y -title "Drain Current Id (A/<greek>m</greek>m)" -type linear
}

foreach myFile $fileList {
	set filePath [file normalize $myFile]
	set delimParts [split $myFile "_"]
	set Vsub [lindex $delimParts end-2]
	
	load_file $filePath -name IdVg_Vsub_${Vsub}
	create_curve -name IdVg_Vsub_${Vsub} -dataset IdVg_Vsub_${Vsub} -axisX "gate OuterVoltage" -axisY "drain TotalCurrent"
	set_curve_prop IdVg_Vsub_${Vsub} -line_width 2
}

if {$deviceType == "NMOS"} {
	set_legend_prop -plot $myPlot1D -label_font_size 10 -location top_left
} elseif {$deviceType == "PMOS"} {
	set_legend_prop -plot $myPlot1D -label_font_size 10 -location bottom_right
}

set fileName "IdVg.png"
export_view "${deviceType}_${vtAdj}_${fileName}" -format png -overwrite -plots $myPlot1D -resolution 1200x1000

