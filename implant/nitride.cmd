## **************************************************************************
## *********************  GRID DEFINITION ***********************************

line x loc=-1.0<um> spacing=1<nm>
line x loc=0<um> spacing=1<nm> tag=left	
line x loc=1.0<um> spacing=1<nm> tag=right

## **************************************************************************
## ********************** STARTING MATERIAL *********************************

region Silicon xlo=left xhi=right

init concentration=1e+14<cm-3> field=Boron

AdvancedCalibration

deposit nitride thickness=400<nm>

## *************************************************************************
## ********************** IMPLANTATION *************************************

implant Phosphorus dose=1e15 energy=160
       

## *************************************************************************
## ********************* PLOTTING ******************************************

select z=log10(Phosphorus)
plot.1d boundary
plot.1d !clear color=blue title="Implantation" label="Phosphorus" min = {-1 15} max = {1 20}


## ************************************************************************
## Export data to CSVs

print.data outfile=nitride-P.out name=Phosphorus