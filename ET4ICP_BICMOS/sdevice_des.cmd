* SProcess through SWB
* Combined NMOS and PMOS - BICMOS5 EKL Device IdVg
* ET4ICP

** #########################################################################
** #################### Variables based on deviceType ######################

!( 

if {"@deviceType@"=="NMOS" } {
	puts "##### Device is NMOS #####"
	set SIGN 1.0
	if { "@vtAdj@"=="9e11" } {
		set ListOfVb { 0.0 1.0 2.0 }
	} else {
		set ListOfVb { 0.0 }
	}	
} else {
	puts "##### Device is PMOS #####"
	set SIGN -1.0
	set ListOfVb { 0.0 }
}

set reuseSavedState 0

set EQN  "Poisson Electron Hole"
set Vd [expr $SIGN * 0.1]

)!

** #########################################################################
** ############################# File Section ##############################

File {
	* Input Files
	Grid= "n@node|sprocess_dev@_dev_fps.tdr"
}

** #########################################################################
** ########################## Electrode Section ############################

#if "@deviceType@" == "NMOS"
	Electrode {
		{ Name="source"    Voltage= 0.0 }
		{ Name="drain"     Voltage= 0.0 }
		{ Name="gate"      Voltage= 0.0 }
		{ Name="substrate" Voltage= 0.0 }
	} 
#elif "@deviceType@" == "PMOS"
	Electrode {
		{ Name="source"    	Voltage= 0.0 }
		{ Name="drain"     	Voltage= 0.0 }
		{ Name="gate"      	Voltage= 0.0 }
		{ Name="substrate" 	Voltage= 0.0 }
		{ Name="psubstrate" Voltage= 0.0 }
	}
#endif

** #########################################################################
** ############################# Math Section ##############################

Math {
	Extrapolate
	ExitOnFailure
	Iterations= 45
}

** #########################################################################
** ############################# Plot Section ##############################

Plot{
   TotalCurrent
}

** #########################################################################
** ########################### Physics Section #############################

* ##### Physics - Trapped Interface Charge #####
Physics ( MaterialInterface= "Oxide/Silicon" ) {
	Traps (
		( FixedCharge Conc= @fixedCharge@ )
	)
}

* ##### Physics - Initial Solve #####
#if "@deviceType@" == "NMOS"
	Physics {
		Recombination ( SRH ( DopingDependence ) Auger )
		EffectiveIntrinsicDensity( OldSlotboom )
		Mobility ( HighFieldSaturation ( Eparallel ) DopingDependence )
	}
#elif "@deviceType@" == "PMOS"
	Physics {
		Recombination ( SRH ( DopingDependence ) Auger )
		EffectiveIntrinsicDensity( BandGapNarrowing ( OldSlotboom ) )
	}
#endif

** #########################################################################
** ############################ Solve Section ##############################

* ##### Initial Solve - Gummel #####
Solve {
	Plugin (Iterations = 100) { Poisson }
}

** #########################################################################
** ########################### Physics Section #############################

* ##### Physics - Subsequent solve #####
#if "@deviceType@" == "NMOS"
	Physics {
		Recombination ( SRH ( DopingDependence ) Auger )
		EffectiveIntrinsicDensity( OldSlotboom )
		Mobility ( Enormal ( UniBo ) )
	}
#elif "@deviceType@" == "PMOS"
	Physics {
		Recombination ( SRH ( DopingDependence ) Auger )
		EffectiveIntrinsicDensity( OldSlotboom )
		Mobility ( Enormal ( UniBo ) )
	}
#endif

** #########################################################################
** ############################ Solve Section ##############################

* ##### Subsequent solve #####
Solve {
	Coupled { Poisson Electron Hole }
	
!(

	puts "\n######## Drain ramp  ########\n"
	puts "\n# --- Vd ramp = 0V to ${Vd} --- #\n"
	puts "Quasistationary ("
	puts "InitialStep = 1e-4" 
	puts "Minstep     = 1e-5" 
	puts "MaxStep     = 0.1"
	puts "Goal { name = drain  Voltage = $Vd }"
	puts [format ") { Coupled { %s  } }" $EQN ]

	if { $reuseSavedState == 0 } {
		puts "\n######## Substrate ramp  ########\n"

		foreach Vb $ListOfVb {
			set Vsub [expr -$Vb * $SIGN]
			set VsubInt [expr int($Vsub)]
			puts "\n# --- Vsub ramp = 0V to $Vsub --- #\n"
			puts "Quasistationary ("
			puts "InitialStep = 1e-4" 
			puts "Minstep     = 1e-5" 
			puts "MaxStep     = 0.1"
			puts "Goal { name = substrate  Voltage = $Vsub }"
			puts [format ") { Coupled { %s  } }" $EQN ]
			puts "save(FilePrefix=\"n@node@_@deviceType@_@vtAdj@_subBias_${VsubInt}\")"
		}
	}

	puts "\n######## IdVg Ramp ########\n"

	set Vg [expr $SIGN * 5.0]
	foreach Vb $ListOfVb {
		set Vsub [expr -$Vb * $SIGN]
		set VsubInt [expr int($Vsub)]
		puts "\n# --- Vg ramp = 0 to $Vg --- #\n"
		puts "Load(FilePreFix=\"n@node@_@deviceType@_@vtAdj@_subBias_${VsubInt}\")"
		puts "NewCurrentPrefix=\"n@node@_@deviceType@_@vtAdj@_IdVg_subBias_${VsubInt}_\""
		puts "Quasistationary ("
		puts "InitialStep = 1e-2" 
		puts "Minstep     = 1e-5" 
		puts "MaxStep     = 0.05"
		puts "Goal { name = gate Voltage = $Vg}"
		puts [format ") { Coupled { %s } }" $EQN]
	}

)!

}

** ################################# EOF ###################################
** #########################################################################
