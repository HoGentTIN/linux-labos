#! /bin/bash
#
# install-docker.sh -- Install Docker on the Linux Mint VM.

# ---------- Variables --------------------------------------------------------

readonly debug='on'  # Set to 'on' to enable debug output
readonly user=hogent # This user will be added to the docker group so they can
                     # use Docker without sudo

# ---------- Helper functions -------------------------------------------------

# Usage: log [ARG]...
#
# Prints all arguments on the standard output stream
log() {
  printf '\e[0;94mℹ️  %s\e[0m\n' "${*}"
}

# Usage: debug [ARG]...
#
# Prints all arguments on the standard output stream,
# if debug output is enabled
debug() {
  [ "${debug}" != 'on' ] || printf '\e[0;93m🪳  %s\e[0m\n' "${*}"
}

# Usage: error [ARG]...
#
# Prints all arguments on the standard error stream
error() {
  printf '\e[0;91m‼️  %s\e[0m\n' "${*}" 1>&2
}

# ---------- Script proper -----------------------------------------------------

# Check if we are running as root.
if [ "${EUID}" -ne '0' ]; then
   error "This script must be run as root. Execute 'sudo ${0}' instead." 
   exit 1
fi

# Check if we're on a systemd-based system
if [ ! -d /run/systemd ]; then
    error "This script is only supported on systemd-based systems."
    exit 1
fi

# Installl Docker if necessary
if [ ! -x /usr/bin/docker ]; then
    log "Installing Docker..."
    apt-get update
    apt-get install -y docker.io docker-compose
else
    log "Docker already installed"
fi

# Enable and start Docker
log "Enabling and starting Docker..."
systemctl enable --now docker.service

# Add that user to the docker group
if groups "${user}" | grep -q docker; then
    log "User ${user} already in docker group"
else
    log "Adding user ${user} to docker group. You may need to log out and log back in for this to take effect."
    usermod -aG docker "${user}"
fi

# Create a persistent volume for Portainer, if necessary
if docker volume ls | grep -q portainer_data; then
    log "Portainer data volume already exists"
else
    log "Creating Portainer data volume"
    docker volume create portainer_data
fi

# Start Portainer if necessary
if docker ps | grep -q portainer; then
    log "Portainer already running"
else
    log "Starting Portainer"
    docker run --detach \
        --publish 8000:8000 --publish 9000:9000 \
        --name=portainer --restart=always \
        --volume /var/run/docker.sock:/var/run/docker.sock \
        --volume portainer_data:/data \
        portainer/portainer-ce
fi

