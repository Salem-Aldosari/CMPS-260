# Personal File Organizer Script

An automated bash script that organizes files into categorized folders based on file extensions.

## 📋 Project Files

- **Project_Proposal_Solo.docx** - Initial project proposal
- **Progress_Status_Report.docx** - Mid-project progress report  
- **Final_Project_Report.docx** - Complete final report
- **file_organizer.sh** - Main file organization script
- **test_setup.sh** - Creates test files for demonstration
- **install.sh** - Installation and setup helper

## 🚀 Quick Start

```bash
# Make scripts executable
chmod +x *.sh

# Run installation
./install.sh

# Create test files
./test_setup.sh

# Organize test directory
./file_organizer.sh ~/test_organizer
```

## ✨ Features

- Categorizes files into 7 folders: Documents, Images, Videos, Music, Archives, Programs, Other
- Safe duplicate file handling (renames instead of overwriting)
- Comprehensive logging with timestamps
- Color-coded terminal output
- Cron automation support
- Works on any directory

## 📁 File Categories

- **Documents:** pdf, doc, docx, txt, xlsx, ppt, etc.
- **Images:** jpg, png, gif, svg, webp, etc.
- **Videos:** mp4, avi, mkv, mov, etc.
- **Music:** mp3, wav, flac, aac, etc.
- **Archives:** zip, tar, gz, 7z, etc.
- **Programs:** exe, deb, rpm, sh, etc.
- **Other:** All unrecognized file types

## 📝 Usage

### Basic Usage
```bash
# Organize Downloads folder (default)
./file_organizer.sh

# Organize specific directory
./file_organizer.sh /path/to/directory
```

### Automated Scheduling
Add to crontab for daily organization at 6 PM:
```bash
0 18 * * * /path/to/file_organizer.sh
```

## 📊 Reports

**IMPORTANT:** Before submitting the .docx files, replace "[Your Name Here]" with your actual name!

- **Proposal:** Due Jan 1, 2026
- **Progress Report:** Due Jan 21, 2026  
- **Final Report:** Due Jan 28, 2026

## 🎯 Project Goals

Demonstrate practical Linux skills including:
- Bash scripting fundamentals
- File system operations
- Process automation with cron
- Error handling and logging
- User-friendly command-line tools

## 📖 Documentation

View the log file:
```bash
tail -20 ~/.file_organizer/organizer.log
```

Logs show:
- Timestamp of operation
- Files moved and their destinations
- Any errors encountered

---

**Course:** CMPS 260 - Introduction to Linux  
**Semester:** January 2026
