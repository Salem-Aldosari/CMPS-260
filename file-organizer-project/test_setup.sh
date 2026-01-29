#!/bin/bash

##############################################################################
# Test Script for File Organizer
# Creates sample files to test the file_organizer.sh script
##############################################################################

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo -e "${BLUE}========================================${NC}"
echo -e "${BLUE}  File Organizer Test Setup${NC}"
echo -e "${BLUE}========================================${NC}"
echo ""

# Create test directory
TEST_DIR="$HOME/test_organizer"

echo -e "${YELLOW}Creating test directory: $TEST_DIR${NC}"
mkdir -p "$TEST_DIR"

echo -e "${YELLOW}Creating sample files...${NC}"
echo ""

# Create sample files
touch "$TEST_DIR/report.pdf"
touch "$TEST_DIR/essay.docx"
touch "$TEST_DIR/notes.txt"
touch "$TEST_DIR/spreadsheet.xlsx"

touch "$TEST_DIR/vacation.jpg"
touch "$TEST_DIR/screenshot.png"
touch "$TEST_DIR/photo.jpeg"

touch "$TEST_DIR/movie.mp4"
touch "$TEST_DIR/tutorial.avi"

touch "$TEST_DIR/song.mp3"
touch "$TEST_DIR/podcast.wav"

touch "$TEST_DIR/backup.zip"
touch "$TEST_DIR/files.tar.gz"

touch "$TEST_DIR/installer.deb"
touch "$TEST_DIR/program.AppImage"

touch "$TEST_DIR/unknown.xyz"
touch "$TEST_DIR/random.abc"

echo -e "${GREEN}✓ Created 17 sample files in $TEST_DIR${NC}"
echo ""

echo -e "${BLUE}Sample files created:${NC}"
ls -1 "$TEST_DIR"
echo ""

echo -e "${BLUE}========================================${NC}"
echo -e "${BLUE}  Ready to Test!${NC}"
echo -e "${BLUE}========================================${NC}"
echo ""
echo -e "${YELLOW}To organize these test files, run:${NC}"
echo -e "${GREEN}./file_organizer.sh $TEST_DIR${NC}"
echo ""
echo -e "${YELLOW}After organizing, check the results:${NC}"
echo -e "${GREEN}ls -la $TEST_DIR${NC}"
echo ""
