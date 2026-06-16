#! /bin/bash
#
# Provisioning script common for all servers

#------------------------------------------------------------------------------
# Bash settings
#------------------------------------------------------------------------------

# Enable "Bash strict mode"
set -o errexit   # abort on nonzero exitstatus
set -o nounset   # abort on unbound variable
set -o pipefail  # do not mask errors in piped commands

#------------------------------------------------------------------------------
# Variables
#------------------------------------------------------------------------------
# TODO: put all variable definitions here. Tip: make them readonly if possible.

# Set to 'yes' if debug messages should be printed.
readonly debug_output='yes'

# Information for creating the database. Since these values are needed in both
# the `db` and `web` provisioning scripts, we define them here in the common
# script, so that they can be reused in both scripts.

# Database name
readonly db_name=www_db

# Database table
readonly db_table=todo_list

# Database user
readonly db_user=www_user

# Database password
readonly db_password='Kof3Cup.ByRu'

#------------------------------------------------------------------------------
# Helper functions
#------------------------------------------------------------------------------
# Three levels of logging are provided: log (for messages you always want to
# see), debug (for debug output that you only want to see if specified), and
# error (obviously, for error messages).

# Usage: log [ARG]...
#
# Prints all arguments on the standard error stream
log() {
  printf '\e[0;33m[LOG]  %s\e[0m\n' "${*}"
}

# Usage: debug [ARG]...
#
# Prints all arguments on the standard error stream
debug() {
  if [ "${debug_output}" = 'yes' ]; then
    printf '\e[0;36m[DBG] %s\e[0m\n' "${*}"
  fi
}

# Usage: error [ARG]...
#
# Prints all arguments on the standard error stream
error() {
  printf '\e[0;31m[ERR] %s\e[0m\n' "${*}" 1>&2
}

#------------------------------------------------------------------------------
# Provisioning tasks
#------------------------------------------------------------------------------

log '=== Starting common provisioning tasks ==='

# TODO: insert common provisioning code here, e.g. installing packages that you
# need on all VMs.

# Update the package index on all servers.
# Note: we don't upgrade, because that may cause problems with VirtualBox guest
# additions (when the kernel is updated)
apt-get update