############################################################
# this script builds the ESMF libraries
# Created by Jonathan R. Buzan 28.06.2024
############################################################

############################################################
# This was tested with the following modules:
#Currently Loaded Modules:
#  1) craype-x86-rome      4) xpmem/2.8.2-1.0_3.9__g84a27a5.shasta   7) cray/23.12       10) cray-dsmml/0.2.2     13) PrgEnv-gnu/8.5.0               16) cray-netcdf-hdf5parallel/4.9.0.9
#  2) libfabric/1.15.2.0   5) perftools-base/23.12.0                 8) gcc-native/12.3  11) cray-mpich/8.1.28    14) cray-parallel-netcdf/1.12.3.9  17) cray-python/3.11.5
#  3) craype-network-ofi   6) cpe/23.12                              9) craype/2.7.30    12) cray-libsci/23.12.5  15) cray-hdf5-parallel/1.12.2.9
#
# Additionally, I previously installed NCAR PIO. Linking
# below. If PIO is not installed, the user must build PIO
# first.
############################################################



############################################################
# set the netcdf paths and libraries
export ESMF_NETCDF_INCLUDE=/opt/cray/pe/netcdf-hdf5parallel/4.9.0.9/gnu/12.3/include
export ESMF_NETCDF_LIBPATH=/opt/cray/pe/netcdf-hdf5parallel/4.9.0.9/gnu/12.3/lib
export ESMF_NETCDF=split
export ESMF_NETCDF_LIBS='-lnetcdff -lnetcdf -lhdf5_hl -lhdf5'
############################################################

############################################################
# set the pnetcdf paths and libraries
export ESMF_PNETCDF=standard
export ESMF_PNETCDF_INCLUDE=/opt/cray/pe/parallel-netcdf/1.12.3.9/gnu/12.3/include
export ESMF_PNETCDF_LIBPATH=/opt/cray/pe/parallel-netcdf/1.12.3.9/gnu/12.3/lib
############################################################

############################################################
# set the paths to NCAR PIO
export ESMF_PIO=external
export ESMF_PIO_INCLUDE=/users/jbuzan/pio_jon/PIO/include
export ESMF_PIO_LIBPATH=/users/jbuzan/pio_jon/PIO/lib
############################################################

############################################################
# it is theoretically possible to use NVIDIA GPUs
# leaving off for now. I do not see CSCS info on
# the NVML libraries.
# export ESMF_NVML=on
############################################################


############################################################
# compiler configurations for Eiger
export ESMF_F90=ftn
export ESMF_C=cc
export ESMF_CXX=CC

export ESMF_OS=Linux
export ESMF_DIR=/users/jbuzan/esmf_jon/esmf-8.6.1
export ESMF_BOPT=O
export ESMF_OPTLEVEL=2

export ESMF_COMM=mpich
export ESMF_COMPILER=gfortran
############################################################

############################################################
# path to output
# recommended that this should be in your $HOME directory. 
# Scratch gets scrubbed, and /project is inaccessible from 
# compute nodes. 
export ESMF_INSTALL_PREFIX=/users/jbuzan/esmf_jon/ESMF
############################################################

############################################################
# change  to the operating directory 
cd $ESMF_DIR
############################################################

############################################################
# clean up the mess you made
#make clean
############################################################

############################################################
#run make info first to check if everything is found.
#make info
############################################################

############################################################
#if successful make info
#then run make all. remember to clean... 
#make all
############################################################

############################################################
#if it fucks up, the user will need to make clean
#make clean
############################################################

############################################################
# if you made it this far, now make install
make install
############################################################

