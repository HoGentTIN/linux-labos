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
readonly PROVISIONING_FILES="${PROVISIONING_SCRIPTS}/${HOSTNAME}"

export PROVISIONING_SCRIPTS PROVISIONING_FILES

# Database name
readonly db_name=trialsite

# Database table
readonly db_table=trialsite_tbl

# Database user
readonly db_user=www_user

# Database password
readonly db_password='Kof3Cup.ByRu'

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

dnf install -y mariadb-server 

log "Enabling MariaDB service"

systemctl enable --now mariadb.service

log "Setting firewall rules"

firewall-cmd --add-service=mysql --permanent
firewall-cmd --reload

log "Securing the database"

mysql <<_EOF_
  DELETE FROM mysql.user WHERE User='';
  DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');
  DROP DATABASE IF EXISTS test;
  DELETE FROM mysql.db WHERE Db='test' OR Db='test\\_%';
  FLUSH PRIVILEGES;
_EOF_

log "Creating database and user"

mysql << _EOF_
CREATE DATABASE IF NOT EXISTS ${db_name};
GRANT ALL ON ${db_name}.* TO '${db_user}'@'%' IDENTIFIED BY '${db_password}';
FLUSH PRIVILEGES;
_EOF_

log "Creating database table and add some data"

mysql --user="${db_user}" --password="${db_password}" "${db_name}" <<_EOF_
CREATE TABLE IF NOT EXISTS ${db_table} (
  id int(5) NOT NULL AUTO_INCREMENT,
  name varchar(50) DEFAULT NULL,
  PRIMARY KEY(id)
);
REPLACE INTO ${db_table} (id,name) VALUES (1,"Tuxedo T. Penguin");
REPLACE INTO ${db_table} (id,name) VALUES (2,"Bobby Tables");
_EOF_
