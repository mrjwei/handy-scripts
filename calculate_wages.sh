#!/bin/bash

# Function to convert h:m format to decimal hours
convert_to_decimal_hours() {
    IFS=":" read -r hours minutes <<< "$1"
    decimal_hours=$(echo "scale=2; $hours + $minutes / 60" | bc)
    echo $decimal_hours
}

# Function to convert h:m format to minutes
convert_to_minutes() {
    IFS=":" read -r hours minutes <<< "$1"
    echo $((hours * 60 + minutes))
}

# Function to calculate wages
calculate_wages() {
    local hours_worked=$1
    local hourly_wage=$2

    # Convert work hours to decimal hours
    decimal_hours=$(convert_to_decimal_hours "$hours_worked")

    # Calculate total minutes worked
    total_minutes=$(convert_to_minutes "$hours_worked")

    # Calculate wages
    total_wages=$(echo "scale=2; $total_minutes * $hourly_wage / 60" | bc)

    echo "Total wages for $hours_worked at $hourly_wage per hour: \$ $total_wages"
    echo "Equivalent decimal hours worked: $decimal_hours hours"
}

# Get user input for hours worked and hourly wage
read -p "Enter work hours in h:m format (e.g., 8:30): " work_hours
read -p "Enter hourly wage: " hourly_wage

# Call the function to calculate wages
calculate_wages "$work_hours" "$hourly_wage"
