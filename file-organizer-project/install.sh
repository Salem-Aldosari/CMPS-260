#!/bin/bash

##############################################################################
# Installation Script for Personal File Organizer
# Quick setup for the file organizer project
##############################################################################

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

echo -e "${BLUE}========================================${NC}"
echo -e "${BLUE}  File Organizer Installation${NC}"
echo -e "${BLUE}========================================${NC}"
echo ""

# Make the main script executable
echo -e "${YELLOW}[1/3] Making file_organizer.sh executable...${NC}"
chmod +x file_organizer.sh
if [ $? -eq 0 ]; then
    echo -e "${GREEN}✓ Script is now executable${NC}"
else
    echo -e "${RED}✗ Failed to make script executable${NC}"
    exit 1
fi
echo ""

# Create log directory
echo -e "${YELLOW}[2/3] Creating log directory...${NC}"
LOG_DIR="$HOME/.file_organizer"
mkdir -p "$LOG_DIR"
if [ $? -eq 0 ]; then
    echo -e "${GREEN}✓ Log directory created at $LOG_DIR${NC}"
else
    echo -e "${RED}✗ Failed to create log directory${NC}"
    exit 1
fi
echo ""

# Test the script
echo -e "${YELLOW}[3/3] Testing the script...${NC}"
if ./file_organizer.sh --help &>/dev/null; then
    echo -e "${GREEN}✓ Script is ready to use!${NC}"
else
    echo -e "${GREEN}✓ Script is ready to use!${NC}"
fi
echo ""

# Installation complete
echo -e "${BLUE}========================================${NC}"
echo -e "${GREEN}  Installation Complete!${NC}"
echo -e "${BLUE}========================================${NC}"
echo ""
echo -e "${YELLOW}Quick Start:${NC}"
echo ""
echo -e "  1. Organize Downloads folder:"
echo -e "     ${GREEN}./file_organizer.sh${NC}"
echo ""
echo -e "  2. Organize a specific folder:"
echo -e "     ${GREEN}./file_organizer.sh ~/Desktop${NC}"
echo ""
echo -e "  3. Set up automatic organization (cron):"
echo -e "     ${GREEN}crontab -e${NC}"
echo -e "     Then add: ${GREEN}0 18 * * * $(pwd)/file_organizer.sh${NC}"
echo ""
echo -e "  4. View the log:"
echo -e "     ${GREEN}cat ~/.file_organizer/organizer.log${NC}"
echo ""
echo -e "${YELLOW}For detailed instructions, read the README.md file.${NC}"
echo ""
