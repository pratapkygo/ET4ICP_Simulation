# SProcess through SWB
# Combined NMOS and PMOS - BICMOS5 EKL Process --> Device
# ET4ICP

## **************************************************************************
## ************************ MATH PARAMETERS *********************************

# This is to set the simulation coordinate sytem
# Same as visualisation coordinate system
math coord.ucs

# Parallelisation
math numThreads= 4

## **************************************************************************
## ************************ VARIABLES ***************************************

set devicetype @deviceType@

## **************************************************************************
## ************************ LOAD TDR FILE ***********************************

init tdr= n@node|sprocess_vtadj@

## **************************************************************************
## ************************ SAVING STRUCTURE - Device ***********************

set conList [contact list]
foreach ele ${conList} {
	puts ${ele}
}

# Going from left to right of the device

if {$devicetype == "NMOS"} {
	contact clear
	contact box Aluminum xlo=-1.1 ylo=9 xhi=0.7 yhi=15 name=substrate0
	contact box Aluminum xlo=-1.1 ylo=29 xhi=0.7 yhi=36 name=source
	contact box Aluminum xlo=-1.1 ylo=44 xhi=0.7 yhi=56 name=gate
	contact box Aluminum xlo=-1.1 ylo=63 xhi=0.7 yhi=71 name=drain
	contact box Aluminum xlo=-1.1 ylo=84 xhi=0.7 yhi=91 name=substrate1
	
	contact name=substrate merge= {substrate0 substrate1}
	
} elseif {$devicetype == "PMOS"} {
	contact clear
	contact box Aluminum xlo=-1.1 ylo=6 xhi=0.7 yhi=9 name=substrate0
	contact box Aluminum xlo=-1.1 ylo=18 xhi=0.7 yhi=21 name=psubstrate0
	contact box Aluminum xlo=-1.1 ylo=29 xhi=0.7 yhi=35 name=source
	contact box Aluminum xlo=-1.1 ylo=44 xhi=0.7 yhi=55 name=gate
	contact box Aluminum xlo=-1.1 ylo=65 xhi=0.7 yhi=70 name=drain
	contact box Aluminum xlo=-1.1 ylo=78 xhi=0.7 yhi=81 name=psubstrate1
	contact box Aluminum xlo=-1.1 ylo=90 xhi=0.7 yhi=95 name=substrate1
	
	contact name=substrate merge= {substrate0 substrate1}
	contact name=psubstrate merge= {psubstrate0 psubstrate1}
}


set conList [contact list]
foreach ele ${conList} {
	puts ${ele}
}

refinebox clear
refinebox clear.interface.mats
refinebox !keep.lines
line clear

grid set.Delaunay.type= boxmethod

struct tdr=n@node@_dev !Gas !interfaces
