# SProcess through SWB
# Combined NMOS and PMOS - BICMOS5 EKL Process
# ET4ICP

## **************************************************************************
## ************************ MATH PARAMETERS *********************************

# This is to set the simulation coordinate sytem
# Same as visualisation coordinate system
math coord.ucs

# Parallelisation
math numThreads= 4

## **************************************************************************
## ************************ PARAMETER ***************************************

puts " *** Checking Parameter Values *** "
set siliconDiffModel [pdbGet Silicon Dopant DiffModel]
puts "Silicon Diffusion Model : ${siliconDiffModel}"
set computeNoStressRelax [pdbGet Compute NoStressRelax]
puts "Compute NoStressRelax : ${computeNoStressRelax}"
set mechanicsSaveElasticStrain [pdbGet Mechanics saveElasticStrain]
puts "Mechanics SaveElasticStrain : ${mechanicsSaveElasticStrain}"
set mechanicsDecomposeStress [pdbGet Mechanics decomposeStress]
puts "Mechanics DecomposeStress : ${mechanicsDecomposeStress}"
set implantResistSkip [pdbGet Implant ResistSkip]
puts "Implant ResistSkip : ${implantResistSkip}"

pdbSet InfoDefault 0

pdbSet Silicon Dopant DiffModel Fermi
#pdbSet Compute NoStressRelax 1
#pdbSet Mechanics saveElasticStrain 0
#pdbSet Mechanics decomposeStress 0
pdbSet Implant ResistSkip 1

# NOT SUGGESTED
#SetFastMode no.mechanics

puts " *** Post Setting Parameter Values *** "
set siliconDiffModel [pdbGet Silicon Dopant DiffModel]
puts "Silicon Diffusion Model : ${siliconDiffModel}"
set computeNoStressRelax [pdbGet Compute NoStressRelax]
puts "Compute NoStressRelax : ${computeNoStressRelax}"
set mechanicsSaveElasticStrain [pdbGet Mechanics saveElasticStrain]
puts "Mechanics SaveElasticStrain : ${mechanicsSaveElasticStrain}"
set mechanicsDecomposeStress [pdbGet Mechanics decomposeStress]
puts "Mechanics DecomposeStress : ${mechanicsDecomposeStress}"
set implantResistSkip [pdbGet Implant ResistSkip]
puts "Implant ResistSkip : ${implantResistSkip}"

## **************************************************************************
## ************************ VARIABLES ***************************************

set devicetype @deviceType@

set sndose @snDose@
set snenergy @snEnergy@
set spdose @spDose@
set spenergy @spEnergy@
set nwdose @nwDose@
set nwenergy @nwEnergy@

if {$devicetype == "NMOS"} {
	set xMin 0.0
	set xMax 5.0
	set yMin 0.0
	set yMax 50.0
} elseif {$devicetype == "PMOS"} {
	set xMin 0.0
	set xMax 5.0
	set yMin 0.0
	set yMax 50.0
}

## **************************************************************************
## ************************ MASK DEFINITION *********************************

if {$devicetype == "NMOS"} {
	mask name= sn segments= {${yMin} 25.0 46.25 ${yMax}} negative
	mask name= sp segments= {${yMin} 10.0 15.0 ${yMax}} negative
	mask name= co segments= {${yMin} 11.0 14.0 30.0 35.0 ${yMax}}
	mask name= al segments= {10.0 15.0 29.0 36.0 44.5 ${yMax}}
} elseif {$devicetype == "PMOS"} {
	mask name= nw segments= {${yMin} 15.0} negative
	mask name= sn segments= {${yMin} 17.0 22.0 ${yMax}} negative
	mask name= sp segments= {${yMin} 5.0 10.0 25.0 45.0 ${yMax}} negative
	mask name= co segments= {${yMin} 6.0 9.0 19.0 21.0 30.0 35.0 ${yMax}}
	mask name= al segments= {6.0 9.0 19.0 21.0 30.0 35.0 44.5 ${yMax}}
}

## **************************************************************************
## ************************ GRID DEFINITION *********************************

if {$devicetype == "NMOS"} {

	line clear
	line x location=${xMin}<um> spacing=0.02 tag=top
	line x location=${xMax}<um> spacing=1 tag=bottom

	line y location=${yMin}<um> spacing=2 tag=left
	line y location=${yMax}<um> spacing=2 tag=right
	
} elseif {$devicetype == "PMOS"} {

	line clear
	line x location=${xMin}<um> spacing=0.02 tag=top
	line x location=${xMax}<um> spacing=1 tag=bottom

	line y location=${yMin}<um> spacing=2 tag=left
	line y location=${yMax}<um> spacing=2 tag=right
	
}

## **************************************************************************
## ************************ STARTING MATERIAL *******************************

set siliconClusterModel [pdbGet Silicon Int ClusterModel]
puts "Silicon Cluster Model : ${siliconClusterModel}"
pdbSet Silicon Int ClusterModel Full
puts "Silicon Cluster Model : ${siliconClusterModel}"

region Silicon xlo=top xhi=bottom ylo=left yhi=right
init concentration=1e16<cm-3> field=Boron

AdvancedCalibration

## **************************************************************************
## ************************ OXIDE DIRT BARRIER ******************************

temp_ramp clear
temp_ramp name=dibar time=5 flows= {N2= 8.0<l/min>} temperature= 800

#temp_ramp name=dibar time=10 flows= {N2= 3.0<l/min> O2=0.3<l/min>} temperature= 800
#temp_ramp name=dibar time=15 flows= {N2= 3.0<l/min> O2=0.3<l/min>} temperature= 800 ramprate=10<K/min>
#temp_ramp name=dibar time=10 flows= {N2= 3.0<l/min> O2=0.3<l/min>} temperature= 950
temp_ramp name=dibar time=10 flows= {N2= 3.0<l/min>} temperature= 800
temp_ramp name=dibar time=15 flows= {N2= 3.0<l/min>} temperature= 800 ramprate=10<K/min>
temp_ramp name=dibar time=10 flows= {N2= 3.0<l/min>} temperature= 950

temp_ramp name=dibar time=35 flows= {O2=3.0<l/min>} temperature= 950
temp_ramp name=dibar flows= {N2= 3.0<l/min>} temperature= 950 ramprate=-5<K/min> t.final= 800
temp_ramp name=dibar time=5 flows= {N2= 3.0<l/min>} temperature= 800

diffuse temp.ramp= dibar

## **************************************************************************
## ************************ OXIDE DIRT THICKNESS MEASURE ********************

select z=1
layers

## **************************************************************************
## ************************ GRID STATS **************************************

grid get.mesh.stats
grid FullD

struct tdr=interGrid

## **************************************************************************
## ************************ REFINE BOX **************************************

set L0_refinement 0.05
set L1_refinement 0.15
set L2_refinement 0.25
set L3_refinement 0.5
set L4_refinement 1
set L5_refinement 2

if {$devicetype == "NMOS"} {
	set rbox1_min {${xMin} ${yMin}}
	set rbox1_max {1.0 ${yMax}}
	set rbox2_min {1.0 ${yMin}}
	set rbox2_max {${xMax} ${yMax}}
} elseif {$devicetype == "PMOS"} {
	set rbox0_min {${xMin} 10.0}
	set rbox0_max {2.5 ${yMax}}
	set rbox1_min {${xMin} ${yMin}}
	set rbox1_max {1.0 ${yMax}}
	set rbox2_min {1.0 ${yMin}}
	set rbox2_max {${xMax} ${yMax}}
}

## **************************************************************************

if {$devicetype == "PMOS"} {
	## ************************ NWELL IMPLANTATION  ****************************

	# Using 2um photoresist! Per the document
	photo thickness= 2<um> mask= nw
	implant Phosphorus dose= ${nwdose} energy= ${nwenergy} tilt=7 rotation=22
	strip resist
	
} elseif {$devicetype == "NMOS"} {
	## ************************ SN MASK + IMPLANT ******************************

	photo thickness= 1<um> mask= sn
	implant Arsenic dose= ${sndose} energy= ${snenergy} tilt=7 rotation=22
	strip resist
}

## **************************************************************************

if {$devicetype == "PMOS"} {
	## ************************ INTER_REMESH ***********************************
	
	line clear
	refinebox clear

	refinebox min= ${rbox0_min} max= ${rbox0_max} name= refineBox0 xrefine= ${L2_refinement} yrefine= ${L3_refinement} Silicon
	
	grid remesh
	grid get.mesh.stats
	
	struct tdr=interGrid_PMOS

	## ************************ NWELL DRIVE IN *********************************

	temp_ramp clear
	temp_ramp name=nwdrivein time=5 flows= {N2= 3.0<l/min>} temperature= 600
	temp_ramp name=nwdrivein time=10 flows= {N2= 3.0<l/min>} temperature= 600
	temp_ramp name=nwdrivein time=55 flows= {N2= 3.0<l/min> O2=0.3<l/min>} ramprate=10<K/min>
	temp_ramp name=nwdrivein time=10 flows= {N2= 3.0<l/min> O2=0.3<l/min>} temperature= 1150
	temp_ramp name=nwdrivein time=240 flows= {N2= 3.0<l/min> O2=0.3<l/min>} temperature= 1150
	temp_ramp name=nwdrivein time=90 flows= {N2= 3.0<l/min>}  temperature= 1150 ramprate=-5<K/min>
	temp_ramp name=nwdrivein time=5 flows= {N2= 3.0<l/min>} temperature= 700

	diffuse temp.ramp= nwdrivein

	etch oxide etchstop= Silicon

	## ************************ OXIDE DIRT BARRIER *****************************

	temp_ramp clear
	temp_ramp name=dibar time=5 flows= {N2= 8.0<l/min>} temperature= 800
	
	#temp_ramp name=dibar time=10 flows= {N2= 3.0<l/min> O2=0.3<l/min>} temperature= 800
	#temp_ramp name=dibar time=15 flows= {N2= 3.0<l/min> O2=0.3<l/min>} temperature= 800 ramprate=10<K/min>
	#temp_ramp name=dibar time=10 flows= {N2= 3.0<l/min> O2=0.3<l/min>} temperature= 950
	temp_ramp name=dibar time=10 flows= {N2= 3.0<l/min>} temperature= 800
	temp_ramp name=dibar time=15 flows= {N2= 3.0<l/min>} temperature= 800 ramprate=10<K/min>
	temp_ramp name=dibar time=10 flows= {N2= 3.0<l/min>} temperature= 950
	
	temp_ramp name=dibar time=35 flows= {O2=3.0<l/min>} temperature= 950
	temp_ramp name=dibar flows= {N2= 3.0<l/min>} temperature= 950 ramprate=-5<K/min> t.final= 800
	temp_ramp name=dibar time=5 flows= {N2= 3.0<l/min>} temperature= 800

	diffuse temp.ramp= dibar
	
	## ************************ SN MASK + IMPLANT ******************************

	# Using 1um photoresist
	photo thickness= 1<um> mask= sn
	implant Arsenic dose= ${sndose} energy= ${snenergy} tilt=7 rotation=22
	strip resist
}

## **************************************************************************
## ************************ SP MASK + IMPLANT *******************************

# Using 1um photoresist
photo thickness= 1<um> mask= sp
implant Boron dose= ${spdose} energy= ${spenergy} tilt=7 rotation=22
strip resist

## **************************************************************************
## ************************ REMESH ******************************************

line clear
refinebox clear

refinebox min= ${rbox1_min} max= ${rbox1_max} name= refineBox1 xrefine= ${L1_refinement} yrefine= ${L1_refinement} Silicon
refinebox min= ${rbox2_min} max= ${rbox2_max} name= refineBox2 xrefine= ${L3_refinement} yrefine= ${L4_refinement} Silicon

grid remesh
grid get.mesh.stats

## **************************************************************************
## ************************ SAVING STRUCTURE - Process **********************

struct tdr=n@node@
