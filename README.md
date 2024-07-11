# Automatic Protocol for Generating Electrostatic Spectral Tuning Maps (ESTM)

## Overview

This project provides an automated protocol for generating Electrostatic Spectral Tuning Maps (ESTM) using Python. By following this protocol, users can efficiently compute the Van der Waals (vdW) surface points of a molecule from its XYZ coordinates, prepare Gaussian input files, submit computational jobs, and collect the resulting data. The ultimate goal is to generate detailed ESTM maps, which are crucial for understanding the electrostatic properties and tuning the spectral features of molecules.

The process involves multiple steps, including setting up a virtual environment, installing necessary dependencies, running the main script to compute vdW surface points, generating Gaussian input files, submitting jobs to a computational cluster, and collecting the results. These steps are designed to streamline the workflow and provide a comprehensive solution for ESTM map generation.

## Authors

Mohammad Pabel Kabir, Samer Gozem

## Requirements

> Python 2.7

> NumPy

> Matplotlib

> Cython

> pyvdwsurface module

## Installation of Requirements

### Step 1: Create a Virtual Environment

Install virtualenv if you don't have it: python2.7 -m pip install virtualenv

Create a virtual environment: python2.7 -m virtualenv vdw_surface

Activate the virtual environment: source vdw_surface/bin/activate

### Step 2: Download and Install pyvdwsurface

Install Cython: python -m pip install cython

Clone the pyvdwsurface repository (optional: you can clone it in any folder): git clone https://github.com/rmcgibbo/pyvdwsurface.git

cd vdw_surface

cd pyvdwsurface

Install pyvdwsurface: python -m pip install .

### Step 3: Install Dependencies

Install NumPy: python -m pip install numpy

Install Matplotlib: python -m pip install matplotlib

## Workflow Description

### Step 1: Van der Waals (vdW) surface points generation

Place your XYZ coordinate file (Project.xyz) in the same directory as the script. The file should be formatted as follows:

python
Copy code
Number of atoms
Comment line
Atom1 x1 y1 z1
Atom2 x2 y2 z2
...
Ensure you have the following files in your working directory:

vdw_surface.py (the main script)
Your XYZ file (e.g., PHE.xyz)
Run the script:

sh
Copy code
python vdw_surface.py
If you encounter the error "Python is not installed as a framework," open the Matplotlib configuration file and add the following line:

sh
Copy code
vim ~/.matplotlib/matplotlibrc
# Add this line:
backend: TkAgg
The script will generate the points of the surface in two formats:

pointsXx.txt: Contains the points with atomic label Xx.
points.txt: Contains the raw coordinate points on the vdW surface.

The first step involves the retrieval of molecule coordinates based on CAS numbers provided in `file.csv`. The `cirpy` Python library is utilized to generate SMILES codes from these CAS numbers. Following this, the `rdkit` Python library is employed to extract coordinates from the SMILES codes.

It's important to note that some molecules may lack a CAS number, and in some cases, `rdkit` may fail to determine the coordinates despite the presence of a CAS number. In such scenarios, manual addition of coordinates is required.

The script creates a directory named `xyzs` and organizes the contents in an indexed sequence, mirroring the order present in `file.csv`. This organization facilitates the mapping of each coordinate to its corresponding molecule, ensuring seamless coordination between the two datasets.

### Step 2: Iodine Check (`check_iodine.py`)

This script is used to identify molecules containing iodine. Since the 6-311++G(d,p) basis set (used for all other molecules) does not support iodine, a mixed basis set approach is employed. The `gen` keyword within the route section indicates the use of a combination of 6-311++G(d,p) basis sets for elements like H, C, O, N, and the def2TZVP basis set exclusively for iodine.

### Step 3: Optimization and Calculation

The remaining workflow scripts are located under Table 2 and within `opt-2` directory of that Table. The same scripts have been applied on other Tables with modifying the range of ID numbers. Each script is accompanied by a detailed README file that provides a thorough description of the script's functionality and purpose. The README is present in Table2 as the scripts are repetitive for all other Tables we have.

## Getting Started

To begin using this workflow, clone the repository and navigate to the root directory. Ensure that all required Python libraries (`cirpy`, `rdkit`, `periodictable`, etc.) are installed. Follow the steps outlined in the README files within each directory to execute the workflow successfully.

## Contributions

Contributions to this workflow are welcome. If you have suggestions for improvement or encounter any issues, please feel free to open an issue or submit a pull request.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE.md) file for more details.
