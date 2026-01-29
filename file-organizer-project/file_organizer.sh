#!/bin/bash

##############################################################################
# Personal File Organizer Script
# CMPS 260: Introduction to Linux - Final Project
# 
# Description: Automatically organizes files in a target directory by moving
#              them into categorized folders based on file extensions.
#
# Usage: ./file_organizer.sh [directory_path]
#        If no directory is provided, uses ~/Downloads by default
##############################################################################

# Color codes for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Configuration
DEFAULT_DIR="$HOME/Downloads"
LOG_DIR="$HOME/.file_organizer"
LOG_FILE="$LOG_DIR/organizer.log"

# Get target directory from argument or use default
TARGET_DIR="${1:-$DEFAULT_DIR}"

# Create log directory if it doesn't exist
mkdir -p "$LOG_DIR"

# Function to log messages
log_message() {
    local timestamp=$(date '+%Y-%m-%d %H:%M:%S')
    echo "[$timestamp] $1" >> "$LOG_FILE"
}

# Function to print colored messages
print_message() {
    local color=$1
    local message=$2
    echo -e "${color}${message}${NC}"
}

# Function to create category folders
create_folders() {
    local base_dir=$1
    
    # Define category folders
    local folders=(
        "Documents"
        "Images"
        "Videos"
        "Music"
        "Archives"
        "Programs"
        "Other"
    )
    
    for folder in "${folders[@]}"; do
        mkdir -p "$base_dir/$folder"
    done
    
    log_message "Created category folders in $base_dir"
}

# Function to determine file category based on extension
get_category() {
    local file=$1
    local extension="${file##*.}"
    extension=$(echo "$extension" | tr '[:upper:]' '[:lower:]')
    
    case "$extension" in
        # Documents
        pdf|doc|docx|txt|odt|rtf|tex|wpd|ods|xlsx|xls|csv|ppt|pptx)
            echo "Documents"
            ;;
        # Images
        jpg|jpeg|png|gif|bmp|svg|tif|tiff|ico|webp|heic)
            echo "Images"
            ;;
        # Videos
        mp4|avi|mkv|mov|wmv|flv|webm|m4v|mpg|mpeg)
            echo "Videos"
            ;;
        # Music
        mp3|wav|flac|aac|ogg|wma|m4a|opus)
            echo "Music"
            ;;
        # Archives
        zip|rar|tar|gz|7z|bz2|xz|iso|dmg)
            echo "Archives"
            ;;
        # Programs
        exe|dmg|deb|rpm|AppImage|sh|bin|run)
            echo "Programs"
            ;;
        # Other
        *)
            echo "Other"
            ;;
    esac
}

# Function to handle duplicate filenames
handle_duplicate() {
    local dest_file=$1
    local base_name="${dest_file%.*}"
    local extension="${dest_file##*.}"
    local counter=1
    
    # If file has no extension
    if [ "$base_name" = "$dest_file" ]; then
        while [ -e "${dest_file}_${counter}" ]; do
            ((counter++))
        done
        echo "${dest_file}_${counter}"
    else
        while [ -e "${base_name}_${counter}.${extension}" ]; do
            ((counter++))
        done
        echo "${base_name}_${counter}.${extension}"
    fi
}

# Function to organize a single file
organize_file() {
    local file=$1
    local base_dir=$2
    
    # Skip if it's a directory
    if [ -d "$file" ]; then
        return
    fi
    
    # Get filename without path
    local filename=$(basename "$file")
    
    # Skip hidden files (starting with .)
    if [[ "$filename" == .* ]]; then
        return
    fi
    
    # Determine category
    local category=$(get_category "$filename")
    
    # Determine destination
    local dest_dir="$base_dir/$category"
    local dest_file="$dest_dir/$filename"
    
    # Handle duplicates
    if [ -e "$dest_file" ]; then
        dest_file=$(handle_duplicate "$dest_file")
        local new_filename=$(basename "$dest_file")
        print_message "$YELLOW" "  • Duplicate found: Renaming to $new_filename"
        log_message "Duplicate: $filename -> $new_filename"
    fi
    
    # Move the file
    if mv "$file" "$dest_file" 2>/dev/null; then
        print_message "$GREEN" "  ✓ Moved: $filename -> $category/"
        log_message "SUCCESS: Moved $filename to $category/"
        return 0
    else
        print_message "$RED" "  ✗ Failed: $filename"
        log_message "ERROR: Failed to move $filename"
        return 1
    fi
}

# Main function
main() {
    local files_moved=0
    local files_failed=0
    
    # Check if target directory exists
    if [ ! -d "$TARGET_DIR" ]; then
        print_message "$RED" "Error: Directory '$TARGET_DIR' does not exist!"
        log_message "ERROR: Directory $TARGET_DIR not found"
        exit 1
    fi
    
    # Start log entry
    log_message "=== File Organization Started ==="
    log_message "Target Directory: $TARGET_DIR"
    
    # Print header
    print_message "$BLUE" "========================================"
    print_message "$BLUE" "  Personal File Organizer"
    print_message "$BLUE" "========================================"
    echo ""
    print_message "$BLUE" "Target Directory: $TARGET_DIR"
    echo ""
    
    # Create category folders
    create_folders "$TARGET_DIR"
    
    print_message "$BLUE" "Organizing files..."
    echo ""
    
    # Process all files in target directory (non-recursive)
    while IFS= read -r -d '' file; do
        if organize_file "$file" "$TARGET_DIR"; then
            ((files_moved++))
        else
            ((files_failed++))
        fi
    done < <(find "$TARGET_DIR" -maxdepth 1 -type f -print0)
    
    # Print summary
    echo ""
    print_message "$BLUE" "========================================"
    print_message "$GREEN" "  Files organized: $files_moved"
    if [ $files_failed -gt 0 ]; then
        print_message "$RED" "  Files failed: $files_failed"
    fi
    print_message "$BLUE" "========================================"
    echo ""
    print_message "$BLUE" "Log file: $LOG_FILE"
    
    # End log entry
    log_message "Files moved: $files_moved, Files failed: $files_failed"
    log_message "=== File Organization Completed ==="
    echo ""
}

# Run main function
main
