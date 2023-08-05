#!/bin/bash

export_dir="/tmp/output"  
container1="nginx"      
container2="jovial_nobel"      
count_limit=12    #
timestamp=$(date +%Y-%m-%d_%H%M%S)


while true; do

# Export container1
 docker export "$container1" > "$export_dir/$container1-$timestamp.tar"
 # Export container2
 docker export "$container2" > "$export_dir/$container2-$timestamp.tar"


# Count the number of exported files
count=$(ls -l "$export_dir"/*.tar | wc -l )

# If count exceeds the limit, delete the oldest file(s)
    if (( count > count_limit )); then
        num_files_to_delete=$(( count - count_limit ))

        oldest_files=$(ls -1t "$export_dir"/*.tar | tail -n "$num_files_to_delete")
        rm $oldest_files
    fi


    sleep 1h  # Sleep for one hour before exporting again




done



