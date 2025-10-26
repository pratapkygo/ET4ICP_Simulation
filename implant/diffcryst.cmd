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

implant Arsenic 	dose=1e15  	energy=148
implant Antimony 	dose=1e15	energy=200
implant Boron 		dose=1e15 	energy=28
implant Phosphorus dose=1e15 energy=68
       
## *************************************************************************
## ********************* PLOTTING ******************************************

select z=log10(Arsenic)
plot.1d color=grey title="Diffusion" label="As - Implanted" min = {0 15} max = {1 20}

select z=log10(Antimony)
plot.1d !clear color=firebrick label="Sb - Implanted"

select z=log10(Boron)
plot.1d !clear color=forestgreen label="B - Implanted"

select z=log10(Phosphorus)
plot.1d !clear color=blue3 label="P - Implanted"

## *************************************************************************
## ************************** DIFFUSION ************************************

##pdbSet Silicon Mechanics Amorphous

diffuse time=300<min> temperature=1000<C>

## *************************************************************************
## ********************* PLOTTING ******************************************

select z=log10(Arsenic)
plot.1d !clear color=black label="As - Diffused"

select z=log10(Antimony)
plot.1d !clear color=red label="Sb - Diffused"

select z=log10(Boron)
plot.1d !clear color=green label="B - Diffused"

select z=log10(Phosphorus)
plot.1d !clear color=blue label="P - Diffused"

## ************************************************************************
## Export data to CSVs
print.data outfile=diffcrystAs.out name=Arsenic
print.data outfile=diffcrystSb.out name=Antimony
print.data outfile=diffcrystfB.out name=Boron
print.data outfile=diffcrystP.out name=Phosphorus