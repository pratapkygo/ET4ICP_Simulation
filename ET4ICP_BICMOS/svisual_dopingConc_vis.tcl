# SVisual through SWB
# Combined NMOS and PMOS - Structure & Doping Conc Viewer
# ET4ICP

# Dataset (TDR) Load
set myData2D [load_file "n@node|sprocess_vtadj@_fps.tdr"]

set deviceType "@deviceType@"
set vtAdj "@vtAdj@"

# ---------------------------------------

# Create 2D Plot - Net Active Region
set myPlot2D [create_plot -dataset $myData2D]

# Plot and Axis Properties
set_plot_prop -plot $myPlot2D -not_keep_aspect_ratio
set_axis_prop -plot $myPlot2D -axis x -range {-1.5 5}
set_axis_prop -plot $myPlot2D -axis y -range {0 100}

set plotTitle "NetActive"
set_plot_prop -plot $myPlot2D -title "${deviceType}_${vtAdj}_${plotTitle}"
set_axis_prop -plot $myPlot2D -axis x -title "X (um) (Into the device)"
set_axis_prop -plot $myPlot2D -axis y -title "Y (um) (Across the device)"

set fileName "deviceStructure.png"
export_view "${deviceType}_${vtAdj}_${fileName}" -format png -overwrite -plots $myPlot2D -resolution 1000x1000

# ---------------------------------------

# Doping across the Channel

set dopingChannelCutline [create_cutline  -plot $myPlot2D -type y -at 50.0]
set dopingChannelPlot [create_plot -dataset C1($myData2D) -1d]

set_axis_prop -plot $dopingChannelPlot -axis y -type log

create_curve -axisX X -axisY NetActive -dataset $dopingChannelCutline -plot $dopingChannelPlot

if {${deviceType} == "NMOS"} {
	set_axis_prop -plot $dopingChannelPlot -axis x -range {-1 5}
	set_axis_prop -plot $dopingChannelPlot -axis y -range {1e15 4e16}
} elseif {${deviceType} == "PMOS"} {
	set_axis_prop -plot $dopingChannelPlot -axis x -range {-1 5}
	set_axis_prop -plot $dopingChannelPlot -axis y -range {1e15 5e16}
}

set plotTitle "dopingAcrossChannel"
set_plot_prop -plot $dopingChannelPlot -title "${deviceType}_${vtAdj}_${plotTitle}"
set_plot_prop -plot $dopingChannelPlot -show_grid
set_plot_prop -plot $dopingChannelPlot -hide_legend
#set_plot_prop -plot $dopingChannelPlot -hide_title

set_curve_prop {Curve_1} -plot $dopingChannelPlot -line_width 2
set_axis_prop -plot $dopingChannelPlot -axis x -title "X (<greek>m</greek>m) (Into the device)"
set_axis_prop -plot $dopingChannelPlot -axis y -title "Doping Concentration (cm<sup>-3</sup>)"

set fileName "dopingAcrossChannel.png"
export_view "${deviceType}_${vtAdj}_${fileName}" -format png -overwrite -plots $dopingChannelPlot -resolution 1000x1000

# ---------------------------------------

# Doping across the Source

set dopingSourceCutline [create_cutline  -plot $myPlot2D -type y -at 37.5]
set dopingSourcePlot [create_plot -dataset C1($myData2D) -1d]

set_axis_prop -plot $dopingSourcePlot -axis y -type log

create_curve -axisX X -axisY NetActive -dataset $dopingSourceCutline -plot $dopingSourcePlot

if {${deviceType} == "NMOS"} {
	set_axis_prop -plot $dopingSourcePlot -axis x -range {-1 5}
	set_axis_prop -plot $dopingSourcePlot -axis y -range {1e15 1e21}
} elseif {${deviceType} == "PMOS"} {
	set_axis_prop -plot $dopingSourcePlot -axis x -range {-1 5}
	set_axis_prop -plot $dopingSourcePlot -axis y -range {5e14 1e19}
}

set plotTitle "dopingAcrossSource"
set_plot_prop -plot $dopingSourcePlot -title "${deviceType}_${vtAdj}_${plotTitle}"
set_plot_prop -plot $dopingSourcePlot -show_grid
set_plot_prop -plot $dopingSourcePlot -hide_legend
#set_plot_prop -plot $dopingSourcePlot -hide_title

set_curve_prop {Curve_1} -plot $dopingSourcePlot -line_width 2
set_axis_prop -plot $dopingSourcePlot -axis x -title "X (<greek>m</greek>m) (Into the device)"
set_axis_prop -plot $dopingSourcePlot -axis y -title "Doping Concentration (cm<sup>-3</sup>)"

set fileName "dopingAcrossSource.png"
export_view "${deviceType}_${vtAdj}_${fileName}" -format png -overwrite -plots $dopingSourcePlot -resolution 1000x1000

# ---------------------------------------

# Doping along the cross section of device

set dopingCrossSectionCutline [create_cutline  -plot $myPlot2D -type x -at 0.3]
set dopingCrossSectionPlot [create_plot -dataset C1($myData2D) -1d]

set_axis_prop -plot $dopingCrossSectionPlot -axis y -type log

create_curve -axisX Y -axisY NetActive -dataset $dopingCrossSectionCutline -plot $dopingCrossSectionPlot

if {${deviceType} == "NMOS"} {
	set_axis_prop -plot $dopingCrossSectionPlot -axis x -range {0 100}
	set_axis_prop -plot $dopingCrossSectionPlot -axis y -range {1e15 1e21}
} elseif {${deviceType} == "PMOS"} {
	set_axis_prop -plot $dopingCrossSectionPlot -axis x -range {0 100}
	set_axis_prop -plot $dopingCrossSectionPlot -axis y -range {5e13 5e20}
}

set plotTitle "dopingAcrossDevice"
set_plot_prop -plot $dopingCrossSectionPlot -title "${deviceType}_${vtAdj}_${plotTitle}"
set_plot_prop -plot $dopingCrossSectionPlot -show_grid
set_plot_prop -plot $dopingCrossSectionPlot -hide_legend
#set_plot_prop -plot $dopingCrossSectionPlot -hide_title

set_curve_prop {Curve_1} -plot $dopingCrossSectionPlot -line_width 2
set_axis_prop -plot $dopingCrossSectionPlot -axis x -title "Y (<greek>m</greek>m) (Across the device)"
set_axis_prop -plot $dopingCrossSectionPlot -axis y -title "Doping Concentration (cm<sup>-3</sup>)"

set fileName "dopingAlongDevice.png"
export_view "${deviceType}_${vtAdj}_${fileName}" -format png -overwrite -plots $dopingCrossSectionPlot -resolution 1000x1000

# ---------------------------------------

set plotTitle "NetActiveCutlines"
set_plot_prop -plot $myPlot2D -title "${deviceType}_${vtAdj}_${plotTitle}"

set fileName "deviceStructureCutLine.png"
export_view "${deviceType}_${vtAdj}_${fileName}" -format png -overwrite -plots $myPlot2D -resolution 1000x1000

# ---------------------------------------


