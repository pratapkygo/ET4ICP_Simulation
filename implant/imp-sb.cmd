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

implant Antimony 	dose=1e15	energy=200
       
## *************************************************************************
## ********************* PLOTTING ******************************************

select z=log10(Antimony)
plot.1d color=firebrick title="Diffusion" label="Sb - Implanted" min = {0 15} max = {1 20}


## *************************************************************************
## ************************** DIFFUSION ************************************

pdbSet Si Antimony ActiveModel Equilibrium

diffuse time=60<min> temperature=1000<C>

## *************************************************************************
## ********************* PLOTTING ******************************************

select z=log10(Antimony)
plot.1d !clear color=red label="Sb - Diffused"


## ************************************************************************
## Export data to CSVs, DO NOT FORGET TO CHANGE
print.data outfile=imp-sb1.out name=Antimony
