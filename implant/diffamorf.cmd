## **************************************************************************
## *********************  GRID DEFINITION ***********************************

line x loc=0<um> spacing=1<nm> tag=left	
line x loc=1.0<um> spacing=1<nm> tag=right

## **************************************************************************
## ********************** STARTING MATERIAL *********************************

region Silicon xlo=left xhi=right
init concentration=1e+14<cm-3> field=Boron

## Make material amorphous
pdbSet Silicon Amorphous 1
pdbSet Silicon Mechanics Anisotropic 1

AdvancedCalibration

## *************************************************************************
## ********************** IMPLANTATION *************************************

implant Arsenic 	dose=1e15  	energy=148 sentaurus.mc particles=20000 info=1
implant Antimony 	dose=1e15	  energy=200 sentaurus.mc particles=20000 info=1
implant Boron 		dose=1e15 	energy=24 sentaurus.mc particles=20000 info=1
implant Phosphorus	dose=1e15 	energy=68 sentaurus.mc particles=20000 info=1

## *************************************************************************
## ********************* PLOTTING ******************************************

select z=log10(Arsenic)
plot.1d color=orange title="Diffusion" label="As - Implanted" min = {0 15} max = {1 20}

## *************************************************************************
## ************************** DIFFUSION ************************************

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
print.data outfile=diffamorfAs.out name=Arsenic
print.data outfile=diffamorfSb.out name=Antimony
print.data outfile=diffamorfB.out name=Boron
print.data outfile=diffamorfP.out name=Phosphorus
