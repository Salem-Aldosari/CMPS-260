#!/bin/bash

# Problem 2 Script: Processes and Filters
# Demonstrates background jobs, PIDs, wait, and exit status

echo "Starting two background jobs..."

# Start first background job
sleep 5 &
PID1=$!
echo "Job 1 PID: $PID1"

# Start second background job
sleep 3 &
PID2=$!
echo "Job 2 PID: $PID2"

echo "Waiting for background jobs to complete..."
wait

echo "Exit status: $?"
echo "All jobs completed!"
