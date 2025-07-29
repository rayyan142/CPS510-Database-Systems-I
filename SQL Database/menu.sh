#!/bin/bash

while true; do
    echo "-----------------------------------"
    echo "|  Car Rental Database Interface  |"
    echo "-----------------------------------"
    echo "1) Drop Tables"
    echo "2) Create Tables"
    echo "3) Populate Tables"
    echo "4) Run Advanced Queries"
    echo "5) Exit"
    echo "-----------------------------------"
    read -p "Enter your choice: " choice

    case $choice in
        1)
            ./drop_tables.sh
            ;;
        2)
            ./create_tables.sh
            ;;
        3)
            ./populate_tables.sh
            ;;
        4)
            ./advanced_queries.sh
            ;;
        5)
            echo "Exiting the program."
            break
            ;;
        *)
            echo "Invalid choice. Please try again."
            ;;
    esac
done
