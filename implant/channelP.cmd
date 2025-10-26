## **************************************************************************
## *********************  GRID DEFINITION ***********************************

line x loc=0<um> spacing=1<nm> tag=left	
line x loc=1.0<um> spacing=1<nm> tag=right

## **************************************************************************
## ********************** STARTING MATERIAL *********************************

region Silicon xlo=left xhi=right
init concentration=1e+14<cm-3> field=Boron

AdvancedCalibration

## *************************************************************************
## ********************** IMPLANTATION *************************************

implant Phosphorus dose=1e15 energy=40 tilt=7 rotation=270
       
## *************************************************************************
## ********************* PLOTTING ******************************************

select z=log10(Phosphorus)
plot.1d color=blue title="Implantation" label="Phosphorus" min = {0 14} max = {1 20}

## ************************************************************************
## Export data to CSV, take care to change the number after T for different tilt angles
print.data outfile=channelPT7.out name=Phosphorus


