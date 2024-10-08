############################################################
# this script is to build PIO with Intel
# Created by Jonathan R. Buzan 08.07.2024
############################################################

############################################################
# this file is built around the following modules:
#Currently Loaded Modules:
#  1) craype-x86-rome      4) xpmem/2.8.2-1.0_3.9__g84a27a5.shasta   7) cray/23.12          10) craype/2.7.30      13) cray-libsci/23.12.5            16) cray-hdf5-parallel/1.12.2.9
#  2) libfabric/1.15.2.0   5) perftools-base/23.12.0                 8) cray-python/3.11.5  11) cray-dsmml/0.2.2   14) PrgEnv-intel/8.5.0             17) cray-netcdf-hdf5parallel/4.9.0.9
#  3) craype-network-ofi   6) cpe/23.12                              9) intel/2023.2.0      12) cray-mpich/8.1.28  15) cray-parallel-netcdf/1.12.3.9
############################################################


############################################################
# change to the directory where the module files
# are contained.
############################################################
cd /users/jbuzan/pio_jon/ParallelIO-main
############################################################

############################################################
# the configure file may not exist upon download. need
# to execute the autoreconf command to generate it.
############################################################
#autoreconf --install
############################################################


############################################################
# Flags must be set before the configure command can be
# executed
# according to https://user.cscs.ch/computing/compilation/
# there are specific flags for C,C++, and Fortran, 
# regardless of PngEnv-XXX loaded. These are: 
# C = cc
# CXX = CC
# FC = ftn
############################################################

export CC=cc
export CXX=CC
export FC=ftn
export F77=ftn

############################################################
# GNU Flags
############################################################
# there was an issue in compiling that required adding
# -fallow-argument-mismatch
############################################################

# GNU Compilers Flags and Libraries
#export FCFLAGS='-m64 -fallow-argument-mismatch'
#export FFLAGS='-m64 -fallow-argument-mismatch'
#export CFLAGS='-O2 -g -Wall'
#export CPPFLAGS='-I/opt/cray/pe/parallel-netcdf/1.12.3.9/gnu/12.3/include -I/opt/cray/pe/netcdf-hdf5parallel/4.9.0.9/gnu/12.3/include'
#export LDFLAGS='-L/opt/cray/pe/parallel-netcdf/1.12.3.9/gnu/12.3/lib -L/opt/cray/pe/netcdf-hdf5parallel/4.9.0.9/gnu/12.3/lib'

############################################################
# Intel Flags and Libraries.
# These flags are listed from the pnetcdf and netcdf-hdf5
# that should be loaded before starting this script.
# They are listed in the module calls. 
############################################################
export CPPFLAGS='-I/opt/cray/pe/parallel-netcdf/1.12.3.9/intel/2023.2/include -I/opt/cray/pe/netcdf-hdf5parallel/4.9.0.9/intel/2023.2/include'
export LDFLAGS='-L/opt/cray/pe/parallel-netcdf/1.12.3.9/intel/2023.2/lib -L/opt/cray/pe/netcdf-hdf5parallel/4.9.0.9/intel/2023.2/lib'
############################################################

#export CMAKE_INSTALL_PREFIX=/users/jbuzan/pio_jon/PIO

############################################################
# Make sure all previous attempts are removed.
############################################################
make clean
############################################################

############################################################
# configure the make file. the prefix flag allows for a 
# custom directory for the output.

# recommended that this should be in your $HOME directory. 
# Scratch gets scrubbed, and /project is inaccessible from 
# compute nodes. 
############################################################
./configure --enable-fortran --prefix /users/jbuzan/pio_jon/PIO_INTEL
############################################################


############################################################
# supposed to use cmake
############################################################
module load CMake
############################################################


############################################################
# this is the order of operations for building the PIO
############################################################
make
#make info
#make check
make install
#make clean
############################################################

