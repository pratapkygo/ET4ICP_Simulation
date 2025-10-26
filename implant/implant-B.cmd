## **************************************************************************
## *********************  GRID DEFINITION ***********************************

line x loc=0<um> spacing=1<nm> tag=left	
line x loc=1.0<um> spacing=1<nm> tag=right

## **************************************************************************
## ********************** STARTING MATERIAL *********************************

region Silicon xlo=left xhi=right
init concentration=1e+14<cm-3> field=Arsenic

AdvancedCalibration

## *************************************************************************
## ********************** IMPLANTATION *************************************

##implant Arsenic 	dose=1e15  	energy=148 
##implant Antimony 	dose=1e15	energy=200 
implant Boron 		dose=1e15 	energy=24

## implant Phosphorus dose=1e15 energy??
       

## *************************************************************************
## ********************* PLOTTING ******************************************

select z=log10(Boron)
plot.1d color=green title="Implantation" label="Boron" min = {0 14} max = {1 20}

##select z=log10(Antimony)
##plot.1d !clear color=red label="Antimony"

##select z=log10(Boron)
##plot.1d !clear color=green label="Boron"

##select z=log10(Phosphorus)
##plot.1d !clear color=blue label="Phosporus"

## ************************************************************************
## Export data to CSVs
##print.data outfile=implantAs.out name=Arsenic
##print.data outfile=implantSb.out name=Antimony
print.data outfile=implantB.out name=Boron
##print.data outfile=implantP.out name=Phosphorus
