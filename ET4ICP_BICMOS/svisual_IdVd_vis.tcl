# SVisual through SWB
# Combined NMOS and PMOS - IdVd Curve Plotter
# ET4ICP

set deviceType "@deviceType@"
set vtAdj "@vtAdj@"

set fileList [glob -nocomplain n@node|sdevice_IdVd@_@deviceType@_@vtAdj@_IdVd_*.plt]
foreach myFile $fileList {
	puts $myFile
}

if {[llength [list_plots Plot_1D]]==0} {
	set myPlot1D [create_plot -1d -name Plot_1D]
	select_plots $myPlot1D
	
	set_plot_prop -plot $myPlot1D -title "${deviceType}; ${vtAdj}  - IdVd"
	set_plot_prop -plot $myPlot1D -show_grid
	set_axis_prop -plot $myPlot1D -axis x -title "Drain Voltage Vd (V)" -type linear 
	set_axis_prop -plot $myPlot1D -axis y -title "Drain Current Id (A/<greek>m</greek>m)" -type linear
	if {$deviceType == "NMOS"} {
		set_legend_prop -plot $myPlot1D -label_font_size 10 -location top_left
		set_axis_prop -axis y -range {-0.05e-4 1.3e-4}
	} elseif {$deviceType == "PMOS"} {
		set_legend_prop -plot $myPlot1D -label_font_size 10 -location bottom_right
		set_axis_prop -axis y -range {0.1e-6 -6.2e-6}
	}
}

foreach myFile $fileList {
	set filePath [file normalize $myFile]
	set delimParts [split $myFile "_"]
	set Vsub [lindex $delimParts end-2]
	
	load_file $filePath -name IdVg_Vgate_${Vsub}
	create_curve -name IdVg_Vgate_${Vsub} -dataset IdVg_Vgate_${Vsub} -axisX "drain OuterVoltage" -axisY "drain TotalCurrent"
	set_curve_prop IdVg_Vgate_${Vsub} -line_width 2
}

set fileName "IdVd.png"
export_view "${deviceType}_${vtAdj}_${fileName}" -format png -overwrite -plots $myPlot1D -resolution 1200x1000

