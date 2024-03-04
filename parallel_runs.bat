@echo off
setlocal EnableDelayedExpansion

rem Prompt the user to enter the maximum number of processes
set /p max_processes="Enter the maximum number of processes: "

rem Define the list of options
set "options=-d 4 -f 0.5 -b 5 -c 2 -z 1.5 -s 3 -m 2"
set "output_dir=temp"

rem Define the list of values for each option
set "values_d=4 5 6"
set "values_f=0.5"&:: 0.6 0.7"
set "values_b=5"&:: 6 7"
set "values_c=2"&:: 3 4"
set "values_z=1.5"&:: 2.0 2.5"
set "values_s=3"&:: 4 5"
set "values_m=2"&:: 3 4"

rem Counter to keep track of running processes
set "process_count=0"

rem Iterate over each combination of options and values
for %%d in (%values_d%) do (
    for %%f in (%values_f%) do (
        for %%b in (%values_b%) do (
            for %%c in (%values_c%) do (
                for %%z in (%values_z%) do (
                    for %%s in (%values_s%) do (
                        for %%m in (%values_m%) do (
                            rem Construct the output filename based on options
                            set "output_file=!output_dir!\output_d%%d_f%%f_b%%b_c%%c_z%%z_s%%s_m%%m.stl"
                            
                            rem Construct the log filename based on options
                            set "log_file=!output_dir!\log_d%%d_f%%f_b%%b_c%%c_z%%z_s%%s_m%%m.txt"
                            
                            rem Run the command in parallel with different options
                            start "LidarTile" cmd /c "python -m lidartile.cli %options% -d %%d -f %%f -b %%b -c %%c -z %%z -s %%s -m %%m data\file.asc -o !output_file! > !log_file! 2>&1"
                            
                            rem Increment the process count
                            set /a process_count+=1
                            
                            rem Check if the maximum number of processes has been reached
                            if !process_count! geq %max_processes% (
                                rem Wait for a process to finish before starting the next one
                                timeout /t 1 /nobreak >nul
                                rem Reset the process count
                                set "process_count=0"
                            )
                        )
                    )
                )
            )
        )
    )
)

endlocal
