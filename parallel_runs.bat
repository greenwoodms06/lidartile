@echo off
setlocal EnableDelayedExpansion

rem Define the list of options
set "options=-d 4 -f 0.5 -b 5 -c 2 -z 1.5 -s 3 -m 2"
set "output_dir=temp"

rem Define the list of values for each option
set "values_d=4 5 6"
set "values_f=0.5"&:: 0.6 0.7"
set "values_b=5" &:: 6 7"
set "values_c=2"&:: 3 4"
set "values_z=1.5"&:: 2.0 2.5"
set "values_s=3"&:: 4 5"
set "values_m=2"&:: 3 4"

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
                            
                            rem Run the command in parallel with different options
                            start "LidarTile" python -m lidartile.cli %options% -d %%d -f %%f -b %%b -c %%c -z %%z -s %%s -m %%m data\file.asc -o !output_file!
                        )
                    )
                )
            )
        )
    )
)

endlocal
