#!/bin/bash

# Define command version
VERSION="v0.1.0"

# Function to display manual page
show_manual() {
    echo "internsctl(1) - Custom Linux Command"
    echo
    echo "NAME"
    echo "    internsctl - Perform custom operations"
    echo
    echo "SYNOPSIS"
    echo "    internsctl [OPTION]"
    echo
    echo "DESCRIPTION"
    echo "    internsctl is a custom Linux command to perform specific operations."
    echo
    echo "OPTIONS"
    echo "    --help       Display this help message"
    echo "    --version    Display the command version"
    echo
    echo "EXAMPLES"
    echo "    internsctl --help"
    echo "    internsctl --version"
}

# Function to display help message
show_help() {
    echo "Usage: internsctl [OPTION]"
    echo "Perform custom operations with internsctl."
    echo
    echo "Options:"
    echo "  --help       Display this help message"
    echo "  --version    Display the command version"
    echo
    echo "Examples:"
    echo "  internsctl --help"
    echo "  internsctl --version"
}


# Function to get CPU information
get_cpu_info() {
    lscpu
}

# Function to get memory information
get_memory_info() {
    free -h
}

# Function to create a new user
create_user() {
    if [ -z "$1" ]; then
        echo "Error: Please provide a username."
        exit 1
    fi
    
    sudo useradd -m "$1"
}

# Function to list users
list_users() {
    if [ "$1" == "--sudo-only" ]; then
        getent passwd | grep -E 'sudo|admin' | cut -d: -f1
    else
        getent passwd | cut -d: -f1
    fi
}

# Function to get file information
get_file_info() {
    local file="$1"
    local size=""
    local permissions=""
    local owner=""
    local last_modified=""
    
    while [ "$#" -gt 1 ]; do
        case "$1" in
            --size|-s)
                size=$(stat -c %s "$file")
                ;;
            --permissions|-p)
                permissions=$(stat -c %A "$file")
                ;;
            --owner|-o)
                owner=$(stat -c %U "$file")
                ;;
            --last-modified|-m)
                last_modified=$(stat -c %y "$file")
                ;;
            *)
                echo "Invalid option: $1"
                exit 1
                ;;
        esac
        shift
    done
    
    echo "File: $file"
    [ -n "$permissions" ] && echo "Access: $permissions"
    [ -n "$size" ] && echo "Size(B): $size"
    [ -n "$owner" ] && echo "Owner: $owner"
    [ -n "$last_modified" ] && echo "Modify: $last_modified"
}

# Main script
case "$1" in
    --help)
        show_help
        ;;
    --version)
        echo "internsctl $VERSION"
        ;;
    cpu)
        case "$2" in
            getinfo)
                get_cpu_info
                ;;
            *)
                echo "Invalid option. Use 'internsctl cpu getinfo' for CPU information."
                exit 1
                ;;
        esac
        ;;
    memory)
        case "$2" in
            getinfo)
                get_memory_info
                ;;
            *)
                echo "Invalid option. Use 'internsctl memory getinfo' for memory information."
                exit 1
                ;;
        esac
        ;;
    user)
        case "$2" in
            create)
                create_user "$3"
                ;;
            list)
                list_users "$3"
                ;;
            *)
                echo "Invalid option. Use 'internsctl user create <username>' or 'internsctl user list'."
                exit 1
                ;;
        esac
        ;;
    file)
        case "$2" in
            getinfo)
                shift 2
                get_file_info "$@"
                ;;
            *)
                echo "Invalid option. Use 'internsctl file getinfo <file-name>' for file information."
                exit 1
                ;;
        esac
        ;;
    *)
        echo "Invalid option. Use 'internsctl --help' for usage information."
        exit 1
        ;;
esac