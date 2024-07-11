# Automated Workflow for Electrostatic Spectral Tuning Maps (ESTMs)

## Overview

This repository contains an automated workflow designed for generation of ESTMs for any small molecules. The workflow encompasses all the steps involved in the calculation process, starting from molecule retrieval to the final computation of redox potentials.

## Authors

Mohammad Pabel Kabir, Samer Gozem

## Workflow Description

### Step 1: Molecule Retrieval (`1-retrieve-molecules.py`)

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
