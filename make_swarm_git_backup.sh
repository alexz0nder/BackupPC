#!/bin/bash

function usage() {
 cat << EOF
 Usage: $0 hostname
EOF
}

function main() {
    if [ $# -eq 0 ]; then
        usage
    else
        host=$1
        export gitlab_hostname=$(/usr/bin/ssh -q -p 2222 -l backuppc $host sudo /bin/docker service ps gitlab | grep Running | /usr/bin/awk '{print $4}') && \
        export gitlab_container=$(/usr/bin/ssh -q -p 2222 -l backuppc $gitlab_hostname "sudo /bin/docker ps | grep gitlab") && \
        export gitlab_container_id=$(echo $gitlab_container | /usr/bin/awk '{print $1}') && \
        /usr/bin/ssh -q -p 2222 -l backuppc $gitlab_hostname sudo /bin/docker exec -i $gitlab_container_id gitlab-rake gitlab:backup:create && \
        /usr/bin/ssh -q -p 2222 -l backuppc $gitlab_hostname sudo /bin/docker exec -i $gitlab_container_id chmod -R 777 /var/opt/gitlab/git-backups && \
        /usr/bin/ssh -q -p 2222 -l backuppc $gitlab_hostname sudo /bin/docker exec -i $gitlab_container_id chmod -R -x+X /var/opt/gitlab/git-backups
    fi
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main $@
fi
