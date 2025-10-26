# ET4ICP TCAD Simulation Workflow

This repository contains the Synopsys Sentaurus TCAD (SProcess, SDevice, SVisual) command files for the IC Technology Practical Course (ET4ICP) at TU Delft. The workflow simulates the complete fabrication and electrical characterization of NMOS and PMOS transistors based on the Else Kooi Laboratory's BICMOS5 process. This also includes the code for simulating basic individual process steps (implant, oxide & nitride growth and photoresist deposition & etch).

## Technology

* **Simulator:** Synopsys Sentaurus (SProcess, SDevice, SVisual)
* **Scripting Language:** TCL (Tool Command Language), Python

## How to Run

The workflow is designed to be run from the **Sentaurus Workbench (`swb`)**. The project files are parameterized using `@variable@` syntax, allowing the Sentaurus Workbench to manage and sweep variables like `@deviceType@` (NMOS/PMOS) and `@vtAdj@` (the $V_T$-adjust implant dose).

### 1. Basic Process Simulations

1.  Run the main setup script to initialize the environment:
    ```bash
    source /path/to/initialSetup.sh
    ```
2.  Navigate to the implant directory:
    ```bash
    cd implant
    ```
3.  Run the SProcess simulations individually (e.g., `implant-As.cmd`):
    ```bash
    sprocess implant-As.cmd
    ```
4.  Run the Python script to plot the results:
    ```bash
    python3 implant.py
    ```

### 2. Main BICMOS5 Workflow

1.  Ensure your environment is set up (if not already done in the session):
    ```bash
    source /path/to/initialSetup.sh
    ```
2.  Navigate to the main project directory (or the directory where `swb` is launched):
    ```bash
    cd ET4ICP_BICMOS
    ```
3.  Launch Sentaurus Workbench (the `&` runs it in the background):
    ```bash
    swb &
    ```
4.  In the Workbench GUI, open the `ET4ICP_BICMOS5` project. The `.dat` files in this directory will be loaded to build the project tree.
5.  Run the simulation nodes by right-clicking and selecting **Run**.
