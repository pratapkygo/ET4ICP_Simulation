#!/bin/sh

# ET4ICP - Initial Setup Script
# Sets up user environment and copies relevant files and directories into ${USER} home space

echo ""
echo '	### ET4ICP - Initial Setup Script ###'
echo "		Now running in bash: $BASH_VERSION"
echo ""

export PATH="/usr/local/bin:/usr/bin:/usr/local/sbin:/usr/sbin"
#echo -n "		PATH = "
#echo ${PATH}
#echo ""

# Flexible Licence Manager and Synopsys Sentaurus Tool source files
source /eda/scripts/flexlm.sh
#echo -n "		CDS_LIC_FILE = "
#echo ${CDS_LIC_FILE}
#echo -n "		LM_LICENSE_FILE = "
#echo ${LM_LICENSE_FILE}
#echo ""

source /eda/synopsys/2024-25/scripts/SENTAURUS_2024.09-SP1_RHELx86.sh
echo -n "		STROOT = "
echo ${STROOT}
echo -n "		swb executable = "
which swb
echo -n "		sprocess executable = "
which sprocess
echo -n "		sdevice executable = "
which sdevice
echo -n "		svisual executable = "
which svisual
echo ""

export PATH=${PATH}:/eda/synopsys/licenses/bin/SCL_2020.06/linux64/bin/
#echo -n "		PATH = "
#echo ${PATH}
#echo ""

echo -n "		USER = "
echo ${USER}
echo -n "		HOME = "
echo ${HOME}
echo ""

export STDB=$HOME/STDB
echo -n "		STDB = "
echo ${STDB}
echo ""

export PATH=${PATH}:${HOME}/.local/bin/
echo -n "		PATH = "
echo ${PATH}
echo ""

echo "		Installing Required Python Packages: matplotlib, pandas"
echo ""
pip3 install pandas
pip3 install --upgrade matplotlib
echo ""

source ${PWD}/copyFiles.sh

echo ""
echo '	### ET4ICP - Initial Setup Done ###'
echo ""
