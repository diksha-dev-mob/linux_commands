# linux_commands
Custom Linux Command

Command name - internsctl
Command version - v0.1.0


Run the following commands:

To display the help message
./internsctl --help

To display the command version
./internsctl --version

To get CPU information:
./internsctl cpu getinfo

To get memory information:
./internsctl memory getinfo

To create a new user:
./internsctl user create <username>

To list users:
./internsctl user list

To list users with sudo permissions:
./internsctl user list --sudo-only

To get file information:
./internsctl file getinfo <file-name>

To get specific file information:
./internsctl file getinfo --size/--permissions/--owner/--last-modified <file-name>
