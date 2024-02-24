#!/bin/bash

# Function to convert time in h:mm format to minutes
time_to_minutes() {
    local time_in_minutes
    IFS=":" read -r hours minutes <<< "$1"
    time_in_minutes=$((hours * 60 + minutes))
    echo "$time_in_minutes"
}

# Function to calculate time expression in minutes
calculate_expression() {
    local expression="$1"
    local result
    result=$((expression))
    echo "$result"
}

# Function to prompt user for time input
prompt_for_time() {
    local prompt_message="$1"
    local time_input
    read -p "$prompt_message (h:mm format): " time_input
    echo "$time_input"
}

# Function to prompt user for break time in minutes or expression
prompt_for_break_time() {
    local break_time_input
    read -p "Enter break time (h:mm, minutes, or expression): " break_time_input

    # Check if input is an expression (contains +, -, *, /)
    if [[ $break_time_input =~ [+\-*\/] ]]; then
        break_time_in_minutes=$(calculate_expression "$break_time_input")
    elif [[ $break_time_input == *":"* ]]; then
        break_time_in_minutes=$(time_to_minutes "$break_time_input")
    else
        break_time_in_minutes=$break_time_input
    fi

    echo "$break_time_in_minutes"
}

# Prompt user for start time
start_time=$(prompt_for_time "Enter start time")

# Prompt user for end time
end_time=$(prompt_for_time "Enter end time")

# Prompt user for break time in hours:minutes, minutes, or expression
break_time=$(prompt_for_break_time)

# Convert start and end times to minutes
start_minutes=$(time_to_minutes "$start_time")
end_minutes=$(time_to_minutes "$end_time")

# Calculate work minutes
total_work_minutes=$((end_minutes - start_minutes - break_time))

echo "Total work minutes: $total_work_minutes"
