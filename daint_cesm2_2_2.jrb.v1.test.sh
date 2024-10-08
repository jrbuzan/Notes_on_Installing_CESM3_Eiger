#!/bin/bash
#
# Script to start a CESM 3 benchmark test
#
# start_benchmark_test compiler ncpus ndays profiler
#


# date
startdate=`date +'%Y-%m-%d %H:%M:%S'`
date=`date +'%Y%m%d%H%M%S'`

# run setup
#nnodes=60
#nnodes=40
#nthrds=1
#time="3:00:00"
time="6:00:00"
#time="20:00:00"
#stop_opt="nmonths"
#stop_opt="nyears"
stop_opt="ndays"
#stop_n="12"
stop_n="5"
#stop_n="1"

#   case definitions
#COMPILER=gnu
COMPILER=intel
#PE_ENV=INTEL
#PE_ENV=INTEL
#COMPSET=BSSP126
#COMPSET=BHIST
#COMPSET=B1850
COMPSET=BLT1850_v0c
#RES=f09_g17
RES=ne30pg3_t232
MODEL=cesm3_0_beta01
#MODEL=cesm2_2_2
export PROJECT=s1207
#export PROJECT=s996
#export PROJECT=s911

#if [ $RES -eq "f09_g17" ]
#then
reso="x1"
#fi

##### Mutable Values #####
##########################

#CSMROOT=/users/jbuzan/CESM2_2_2/CESM/cime/scripts
CSMROOT=/users/jbuzan/cesm3_0_beta01/cesm3_0_beta01/cime/scripts
#CASEDIRPATH=/capstor/scratch/cscs/jbuzan/cesm2_2_2/cases/
CASEDIRPATH=/capstor/scratch/cscs/jbuzan/cesm3_0_beta01/cases/
CASE=${COMPILER}_${MODEL}_${COMPSET}_O4608_02

echo ${CASE}

CHARGE_ACCOUNT=jbuzan



#sed -i.bak 's/<arg name="craypat".*/<\!--arg name="craypat">pat_run <\/arg-->/' /users/${CHARGE_ACCOUNT}/.cime/config_machines.xml
#if [ $# -gt 3 ]
#then 
# #   CASE=BHIST_BPRP_f09g17_daint_${COMPILER}_${nnodes}_${stop_n}_$4
#    sed -i.bak 's/<\!--arg name="craypat".*/<arg name="craypat">pat_run <\/arg>/' /users/${CHARGE_ACCOUNT}/.cime/config_machines.xml
#fi

export outfile="/users/jbuzan/cesm222_logs_${CHARGE_ACCOUNT}/${CASE}_$date.log"
export jobfile="/users/jbuzan/cesm222_logs_${CHARGE_ACCOUNT}/jobs.csv"

echo "OUTFILE: $outfile"
echo "CASE: $CASE"
echo "JOBFILE: $jobfile"

# function for log output (use "tee" to send output to both screen and $outfile)
print_out() {
    output="$1"
    echo "${output}" | tee -a $outfile
}

cd $CSMROOT

# Create new case
print_out "##############################################################################################"
print_out "Create new case \"$CASE\""
print_out "    - Compset:    $COMPSET"
print_out "    - Res:        $RES"
print_out "    - Compiler:   $COMPILER"
print_out "    - run for:    $stop_n"
print_out "    - run type:   $stop_opt"
print_out "    - time:       $time"


print_out "##############################################################################################"
print_out "Started at: $startdate"
print_out ""

module list | tee -a $outfile

print_out "Create case"

pwd
print_out "Create new case \"${CASEDIRPATH}${CASE}\""

#PYTHONUNBUFFERED=1 ./create_newcase --case ${CASEDIRPATH}${CASE} --compiler ${COMPILER} --compset ${COMPSET} --mpilib mpich --res ${RES} --mach eiger --run-unsupported | tee -a $outfile
#PYTHONUNBUFFERED=1 ./create_newcase --case ${CASEDIRPATH}${CASE} --compiler ${COMPILER} --compset ${COMPSET} --res ${RES} --mach eiger --run-unsupported | tee -a $outfile
PYTHONUNBUFFERED=1 ./create_newcase --case ${CASEDIRPATH}${CASE} --compiler ${COMPILER} --compset ${COMPSET} --res ${RES} --mach eiger --driver nuopc --mpilib mpich --run-unsupported | tee -a $outfile 


# Setup case
print_out ""

cd $CASEDIRPATH 
cd $CASE

print_out "##############################################################################################"
print_out "Adapt PE setup"
print_out "##############################################################################################"


#		n_tasks_atm=1728
#		n_thrds_atm=1
#		rootpe_atm=0

#                n_tasks_atm=1408
#                n_tasks_atm=768
#                n_tasks_atm=384
#                n_tasks_atm=1920
                n_tasks_atm=3840
#                n_tasks_atm=256
#		n_tasks_atm=128
		n_thrds_atm=1
		rootpe_atm=0


echo $n_tasks_atm
echo $n_thrds_atm
echo $rootpe_atm
		
#		n_tasks_lnd=1404
#		n_thrds_lnd=1
#		rootpe_lnd=0

#                n_tasks_lnd=512
#                n_tasks_lnd=128
#                n_tasks_lnd=640
#               n_tasks_lnd=128
#                n_tasks_lnd=256
		n_tasks_lnd=1280
		n_thrds_lnd=1
		rootpe_lnd=0


echo $n_tasks_lnd
echo $n_thrds_lnd
echo $rootpe_lnd
		
#		n_tasks_ice=216
#		n_thrds_ice=1
#		rootpe_ice=1404

#                n_tasks_ice=256
#                n_tasks_ice=128
                n_tasks_ice=2304
#                n_tasks_ice=1152
#		n_tasks_ice=256
#               n_tasks_ice=384
#               n_tasks_ice=768
		n_thrds_ice=1
                rootpe_ice=1280
#		rootpe_ice=512
#                rootpe_ice=256
#                rootpe_ice=704
#                rootpe_ice=128


echo $n_tasks_ice
echo $n_thrds_ice
echo $rootpe_ice 
		
#		n_tasks_ocn=432
#		n_thrds_ocn=1
#		rootpe_ocn=1728

                n_tasks_ocn=768
#                n_tasks_ocn=256
#                n_tasks_ocn=128
#		n_tasks_ocn=384
#                n_tasks_ocn=128
#                n_tasks_ocn=128
		n_thrds_ocn=1
#                rootpe_ocn=256
#                rootpe_ocn=1408
#		rootpe_ocn=768
                rootpe_ocn=3840


echo $n_tasks_ocn
echo $n_thrds_ocn
echo $rootpe_ocn
		
#		n_tasks_cpl=1728
#		n_thrds_cpl=1
#		rootpe_cpl=0

                n_tasks_cpl=3840
#                n_tasks_cpl=4608
#                n_tasks_cpl=1408
#                n_tasks_cpl=768
#                n_tasks_cpl=384
#                n_tasks_cpl=1920
#                n_tasks_cpl=256
#		n_tasks_cpl=128
		n_thrds_cpl=1
		rootpe_cpl=0



echo $n_tasks_cpl
echo $n_thrds_cpl
echo $rootpe_cpl
		
#		n_tasks_rof=1404
#		n_thrds_rof=1
#		rootpe_rof=0

#                n_tasks_rof=128
#                n_tasks_rof=512
#                n_tasks_rof=256
#                n_tasks_rof=512
		n_tasks_rof=1024
		n_thrds_rof=1
                rootpe_rof=0
#		rootpe_rof=2688


echo $n_tasks_rof
echo $n_thrds_rof
echo $rootpe_rof
		
#		n_tasks_glc=1728   
#		n_thrds_glc=1
#		rootpe_glc=0

                n_tasks_glc=64
#                n_tasks_glc=256
#		n_tasks_glc=128   
		n_thrds_glc=1
                rootpe_glc=3712
#                rootpe_glc=640
#                rootpe_glc=256
#                rootpe_glc=1856
#		rootpe_glc=0



echo $n_tasks_glc
echo $n_thrds_glc
echo $rootpe_glc
		
#		n_tasks_wav=108
#		n_thrds_wav=1
#		rootpe_wav=1620

                n_tasks_wav=64
#                n_tasks_wav=256
#		n_tasks_wav=128
		n_thrds_wav=1
#                rootpe_wav=0
#                rootpe_wav=1792
#                rootpe_wav=1280
#                rootpe_wav=704
		rootpe_wav=3776



echo $n_tasks_wav
echo $n_thrds_wav
echo $rootpe_wav
		
#		ncpus_tot=2160

                ncpus_tot=4608
#                ncpus_tot=1536
#                ncpus_tot=896
#                ncpus_tot=512
#                ncpus_tot=2304
#                ncpus_tot=384
#                ncpus_tot=256
#		ncpus_tot=128


echo $ncpus_tot
		
		
 ./xmlchange NTASKS_ATM=$n_tasks_atm
 ./xmlchange NTHRDS_ATM=$n_thrds_atm
 ./xmlchange ROOTPE_ATM=$rootpe_atm
 
 ./xmlchange NTASKS_LND=$n_tasks_lnd
 ./xmlchange NTHRDS_LND=$n_thrds_lnd
 ./xmlchange ROOTPE_LND=$rootpe_lnd
 
 ./xmlchange NTASKS_ICE=$n_tasks_ice
 ./xmlchange NTHRDS_ICE=$n_thrds_ice
 ./xmlchange ROOTPE_ICE=$rootpe_ice
 
 ./xmlchange NTASKS_OCN=$n_tasks_ocn
 ./xmlchange NTHRDS_OCN=$n_thrds_ocn
 ./xmlchange ROOTPE_OCN=$rootpe_ocn
 
 ./xmlchange NTASKS_CPL=$n_tasks_cpl
 ./xmlchange NTHRDS_CPL=$n_thrds_cpl
 ./xmlchange ROOTPE_CPL=$rootpe_cpl
 
 ./xmlchange NTASKS_GLC=$n_tasks_glc
 ./xmlchange NTHRDS_GLC=$n_thrds_glc
 ./xmlchange ROOTPE_GLC=$rootpe_glc

 ./xmlchange NTASKS_ROF=$n_tasks_rof
 ./xmlchange NTHRDS_ROF=$n_thrds_rof
 ./xmlchange ROOTPE_ROF=$rootpe_rof

 ./xmlchange NTASKS_WAV=$n_tasks_wav
 ./xmlchange NTHRDS_WAV=$n_thrds_wav
 ./xmlchange ROOTPE_WAV=$rootpe_wav


print_out ""
print_out "##############################################################################################"
print_out "Turn on NUOPC\""
print_out "Turn off NUOPC\""
print_out "##############################################################################################"

./xmlchange CPL_SEQ_OPTION='NUOPC'
./xmlchange COMP_INTERFACE='nuopc'

 
print_out ""
print_out "##############################################################################################"
#print_out "Change type of run, hybrid, startup, branch run\""
#print_out "CAM namelist options changed to ''\""
#print_out "CLM and OCN CO2_TYPE = Prognostic ''\""
print_out "##############################################################################################"

#./xmlchange CAM_NAMELIST_OPTS=''
#./xmlchange CLM_CO2_TYPE='prognostic'
#./xmlchange OCN_CO2_TYPE='prognostic'

print_out ""
print_out "##############################################################################################"
print_out "Change type of run, hybrid, startup, branch run\""
print_out ""startup""
print_out "##############################################################################################"

#./xmlchange RUN_TYPE='hybrid'
#./xmlchange RUN_TYPE='startup'
#./xmlchange RUN_REFDIR='ccsm4_init'
#./xmlchange GET_REFCASE='FALSE'


print_out "##############################################################################################"
#print_out "starting after 2025\""
#print_out ""yes""
print_out "##############################################################################################"
#./xmlchange RUN_REFCASE='PR_SSP126_GCBNDC_Emis_02_x1_60_1'
#./xmlchange RUN_REFDATE='2026-01-01'
#./xmlchange RUN_STARTDATE='2026-01-01'
#./xmlchange RESUBMIT=0
#./xmlchange RUN_REFTOD='00000'

print_out "##############################################################################################"
print_out "Set ESMF LIB TRUE\""
#print_out ""yes""
print_out "##############################################################################################"
#./xmlchange USE_ESMF_LIB='TRUE'

print_out ""
print_out "##############################################################################################"
print_out "Fixing init interp bug\""
print_out "(https://bb.cgd.ucar.edu/cesm/threads/issues-setting-up-hybrid-run.5074/)"
print_out "##############################################################################################"
#./xmlchange CLM_NAMELIST_OPTS="use_init_interp=.true.  init_interp_method='general'"


print_out ""
print_out "##############################################################################################"
#print_out " CO2 From PR_SSP126_AERA_02_Type_${TEMP_TARGET_TYPE}_Targ_${TEMP_TARGET_RELVALUE}_YEAR_${YEARPREVIOUS}_x1_60_5\""
print_out "##############################################################################################"

print_out ""
print_out "##############################################################################################"
print_out " output frequency\""
print_out " cp /project/s996/jbuzan/freq_files/* ${CASEDIRPATH}${CASE}/SourceMods/src.pop/ \""
print_out "##############################################################################################"
#cp /project/s996/jbuzan/freq_files/* ${CASEDIRPATH}${CASE}/SourceMods/src.pop/
#cp /project/s996/jbuzan/freq_files/26012023_Changes/* ${CASEDIRPATH}${CASE}/SourceMods/src.pop/

print_out ""
print_out "##############################################################################################"
print_out " cp updated HumanIndexMod \""
print_out " cp updated VQ MT \""
print_out "##############################################################################################"

#cp /project/s996/jbuzan/humanindexmod_files/Modified_CLM5_files_v11/* ${CASEDIRPATH}${CASE}/SourceMods/src.clm/
#cp /project/s996/jbuzan/humanindexmod_files/* ${CASEDIRPATH}${CASE}/SourceMods/src.clm/
#cp /project/s996/jbuzan/cesm2_modified_f90files/cam_diagnostics.F90 ${CASEDIRPATH}${CASE}/SourceMods/src.cam/

print_out "##############################################################################################"
print_out " user nl files, cam co2 values\""
print_out " Changing the values in the user_nl_cam\""
print_out " to match the new input files\""
print_out " via using the sed command \""
print_out "##############################################################################################"
#print_out "" cp /project/s996/jbuzan/user_nl_files/AERA_user_nl/${YEAR_X}/Type_${TEMP_TARGET_TYPE}_Targ_${TEMP_TARGET_REL}/* ${CASEDIRPATH}${CASE}/ ""
#print_out "" cp /project/s996/jbuzan/user_nl_files/AERA_user_nl/master_user_nl_dir/v04_WBGT/* ${CASEDIRPATH}${CASE}/ ""

#cp /project/s996/jbuzan/user_nl_files/AERA_user_nl/master_user_nl_dir/v04_WBGT/* ${CASEDIRPATH}${CASE}/
#cp /project/s996/jbuzan/user_nl_files/AERA_user_nl/master_user_nl_dir/* ${CASEDIRPATH}${CASE}/
#cp /project/s996/jbuzan/user_nl_files/AERA_user_nl/${YEAR_X}/Type_${TEMP_TARGET_TYPE}_Targ_${TEMP_TARGET_REL}/* ${CASEDIRPATH}${CASE}/

#cat ${CASEDIRPATH}${CASE}/user_nl_cam

#sed -i "s/Type_1/Type_${TEMP_TARGET_TYPE}/g" ${CASEDIRPATH}${CASE}/user_nl_cam
#sed -i "s/Targ_1\.5_/Targ_${TEMP_TARGET_REL}_/g" ${CASEDIRPATH}${CASE}/user_nl_cam
#sed -i "s/YEAR_2030/YEAR_${YEAR_X}/g" ${CASEDIRPATH}${CASE}/user_nl_cam
#sed -i "s/Targ_1_5_/Targ_${TEMP_TARGET_RELVALUE}_/g" ${CASEDIRPATH}${CASE}/user_nl_cam
#sed -i "s/cam\.i\.2031/cam.i.${YEARFOLLOW}/g" ${CASEDIRPATH}${CASE}/user_nl_cam
#sed -i "s/YEAR_2025/YEAR_${YEARPREVIOUS}/g" ${CASEDIRPATH}${CASE}/user_nl_cam

#cp /project/s996/jbuzan/SSP126_user_nl_files_test/SSP125_user_nl_GCB_NDC/* ${CASEDIRPATH}${CASE}/
#cp /project/s996/jbuzan/SSP126_user_nl_files_test/* ${CASEDIRPATH}${CASE}/
#cp /project/s996/jbuzan/user_nl_files/* ${CASEDIRPATH}${CASE}/


print_out ""
print_out "##############################################################################################"
print_out "Toggle On and Off the files extension beyond 2100 \""
print_out "##############################################################################################"
#Toggle On and Off the files extension beyond 2100


print_out ""
print_out "##############################################################################################" 
print_out "Run \"case.setup\""
print_out "Run \"case.setup Debug\""
print_out "##############################################################################################"
./case.setup | tee -a $outfile
#./case.setup --debug | tee -a $outfile

#cp /project/s996/jbuzan/ocn_freq_file/gx1v7_tavg_contents ${CASEDIRPATH}${CASE}/Buildconf/popconf/


print_out ""
print_out "##############################################################################################" 
print_out "Usernamelist add\""
print_out "##############################################################################################"
cp /capstor/scratch/cscs/jbuzan/cesm3_0_beta01/cases/user_nl_cice ${CASEDIRPATH}${CASE}/
#cp /capstor/scratch/cscs/jbuzan/cesm3_0_beta01/cases/user_nl_cam ${CASEDIRPATH}${CASE}/

#exit 0

print_out ""
print_out "##############################################################################################"
print_out "preview the namelist \""
print_out "##############################################################################################"
./preview_namelists
#./preview_namelists --debug



print_out ""
print_out "##############################################################################################"
print_out "Initialization files\""
#print_out "" cp /scratch/snx3000/jbuzan/cesm2.1.3/archive/${PREVIOUSCASE}/rest/${YEARFOLLOW}-01-01-00000/* /scratch/snx3000/jbuzan/cesm2.1.3/${CASE}/run/ ""
#print_out "" cp /project/s911/jbuzan/archive/PR_SSP126_GCBNDC_Emis_02_x1_60_1/rest/2026-01-01-00000/* /scratch/snx3000/jbuzan/cesm2.1.3/${CASE}/run/ ""
print_out "##############################################################################################"

#cp /scratch/snx3000/jbuzan/cesm2.1.3/archive/${PREVIOUSCASE}/rest/${YEARFOLLOW}-01-01-00000/* /scratch/snx3000/jbuzan/cesm2.1.3/${CASE}/run/
#cp /project/s911/jbuzan/archive/PR_SSP126_GCBNDC_Emis_02_x1_60_1/rest/2026-01-01-00000/* /scratch/snx3000/jbuzan/cesm2.1.3/${CASE}/run/

#print_out "" cp /project/s996/jbuzan/rest/2015-01-01-00000/* /scratch/snx3000/jbuzan/cesm2.1.3/${CASE}/run/ ""
#print_out "" cp /project/s911/jbuzan/archive/PR_SSP126_GCBNDC_Emis_x1_60_1/rest/2026-01-01-00000/* /scratch/snx3000/jbuzan/cesm2.1.3/${CASE}/run/ ""

#cp /project/s911/jbuzan/archive/PR_SSP126_GCBNDC_Emis_x1_60_1/rest/2026-01-01-00000/* /scratch/snx3000/jbuzan/cesm2.1.3/${CASE}/run/

#cp /project/s996/jbuzan/rest/2015-01-01-00000/* /scratch/snx3000/jbuzan/cesm2.1.3/${CASE}/run/
#cp /project/s996/jbuzan/rest/0211-01-01-00000/* /scratch/snx3000/jbuzan/cesm2.1.3/${CASE}/run/
#cp /project/s996/jbuzan/rest/0211-01-01-00000/rest_modification/* /scratch/snx3000/jbuzan/cesm2.1.3/${CASE}/run/
# Clean and build model
print_out ""
print_out "##############################################################################################" 
print_out "Clean and build executable"
print_out "##############################################################################################"
./case.build --clean-all | tee -a $outfile
print_out "##############################################################################################"
./case.build | tee -a $outfile
print_out "##############################################################################################"
print_out ""
print_out "##############################################################################################"
print_out "Adapt stop options"
./xmlchange STOP_OPTION=$stop_opt

print_out ""
print_out "##############################################################################################"
print_out "Submit job"
print_out "##############################################################################################"

print_out "Run for $stop_n days"
print_out "  - adapt run-script"
    
./xmlchange STOP_N=$stop_n
./xmlchange JOB_WALLCLOCK_TIME=$time --subgroup case.run

jobname="${CASE}"
#exit 0

print_out "     --job-name=$jobname"
print_out "     --nnodes=$nnodes"
print_out "     --time=$time"

#sed -i "s/<directive> --ntasks=.*/<directive>--ntasks=$ncpus_tot<\/directive>/" env_batch.xml 

print_out "  - make preview for run"
./preview_run | tee -a $outfile
print_out "  - submit run"

./case.submit | tee -a $outfile

print_out "##############################################################################################"

#squeue | grep jbuzan | tee -a $outfile
print_out "##############################################################################################"
enddate=`date +'%Y-%m-%d %H:%M:%S'`
duration=$SECONDS
print_out "Finished at: $enddate"
print_out "Duration: $(($duration / 60)) min $(($duration % 60)) sec"
exit
