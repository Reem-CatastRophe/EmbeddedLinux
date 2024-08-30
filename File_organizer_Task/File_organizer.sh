#!/usr/bin/env bash

##################################### 1. Script Info ############################################
# Author: Reem Mahmoud
# Date: 2024-07-27
# Version: 1.2
# Description: This script organizes files in a specified directory based on their file types
# into separate sub-directories. Files with unknown or no file extensions, or with extensions
# other than jpg, pdf, or txt are placed in a "misc" sub-directory.
# Input: Path of the directory to be organized
# Output: Organized files 
#################################################################################################

##################################### 2. Source Files & Global Variables ########################

# Function to create a directory if it doesn't exist
create_dir_if_not_exists() {
    declare dir="$1"
    if [ ! -d "$dir" ]; then
        mkdir -p "$dir"
        if [ $? -ne 0 ]; then
            echo "Error: Failed to create directory $dir"
            exit 1
        fi
    fi
}

# Function to move a file to its corresponding sub-directory
move_file() {
    local file="$1"
    local dest_dir="$2"
    
    mv "$file" "$dest_dir"
    if [ $? -ne 0 ]; then
        echo "Error: Failed to move $file to $dest_dir"
        exit 1
    fi
}

# Function to organize files in the given directory
organize_files() {
    declare directory="$1"

    # Loop through all files in the directory
    for file in "$directory"/*; do
        # Skip directories
        if [ -d "$file" ]; then
            continue
        fi

        # Get the base name of the file
        base_name=$(basename "$file")
        # Check if the filename is valid (not empty and doesn't start with a dot)
        if [[ -z "$base_name" || "$base_name" == .* ]]; then
            echo "Warning: Invalid filename '$base_name'. Skipping."
            continue
        fi
        # Extract the extension considering files with multiple leading dots
        declare extension="${base_name##*.}"

        # If the extension is the entire filename, treat it as having no extension
        if [ "$base_name" = "$extension" ]; then
            extension="none"
        fi

        # Determine the destination directory based on the file extension
        case "$extension" in
            jpg|pdf|txt)
                declare dest_dir="$directory/$extension"
                ;;
            *)
                declare dest_dir="$directory/misc"
                ;;
        esac

        # Create the destination directory if it doesn't exist
        create_dir_if_not_exists "$dest_dir"

        # Move the file to the destination directory
        move_file "$file" "$dest_dir"
    done

    echo "Files organized successfully."
}

# Function to check if the provided path is a valid directory
check_directory() {
    local dir="$1"
    if [ ! -d "$dir" ]; then
        echo "Error: $dir is not a directory."
        exit 1
    fi
}

##################################### 3. Main Function & Script Logic ##########################

main() {
    # Get the directory path from the argument
    declare DIRECTORY

    read -r DIRECTORY 

    # Check if the provided path is a directory
    check_directory "$DIRECTORY"

    # Organize files in the directory
    organize_files "$DIRECTORY"
}

##################################### 4. Calling Main Function ##################################
# Call the main function with arguments
main "$@"
