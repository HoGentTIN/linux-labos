#! /bin/bash
#
# Provisioning script for srv001

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

# Location of provisioning scripts and files
readonly PROVISIONING_SCRIPTS="/vagrant/provisioning/"
# Location of files to be copied to this server
readonly PROVISIONING_FILES="${PROVISIONING_SCRIPTS}/files/${HOSTNAME}"

export PROVISIONING_SCRIPTS PROVISIONING_FILES

#------------------------------------------------------------------------------
# Functions
#------------------------------------------------------------------------------

#------------------------------------------------------------------------------
# Provision server
#------------------------------------------------------------------------------

# First perform common actions for all servers
source ${PROVISIONING_SCRIPTS}/common.sh

log "=== Starting server specific provisioning tasks on ${HOSTNAME} ==="

log "Installing MariaDB server"

apt-get install -y mariadb-server 

# In the code below, we use the `mysql` client to execute SQL statements on the
# server. A provisioning script is executed as root, so the `mysql` command will
# have root acces to the database server, without needing to specify a password.

log "Securing the database"

# These are the operations performed by the `mysql_secure_installation` script,
# but we execute them here in a non-interactive way, so that they can be part
# of the provisioning script.
mysql <<_EOF_
  DELETE FROM mysql.user WHERE User='';
  DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');
  DROP DATABASE IF EXISTS test;
  DELETE FROM mysql.db WHERE Db='test' OR Db='test\\_%';
  FLUSH PRIVILEGES;
_EOF_

log "Creating database and user"

# TODO: add the SQL code from the webserver_deb lab to create the database
# and the user, and grant the user permissions on the database.
# Replace hard-coded values with the variables defined above!

log "Creating database table and add some data"

# TODO: add the SQL code from the webserver_deb lab to create the table and
# insert some data. Use the credentials of the newly created database user
# here, which is an additional check that the user has correct permissions on
# the database.
# Again, replace hard-coded values with the variables defined above!
