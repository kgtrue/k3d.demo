# Purge your Docker env
docker rm -f $(docker ps -qa)
docker network prune -f
docker volume prune -
docker system prune -a -f


# run setup.prerequisites
..\step.by.step.setup\setup.prerequisites.ps1

# run setup.k3d.cluster
..\step.by.step.setup\setup.k3d.cluster.ps1

# run setup.cert-manager
..\step.by.step.setup\setup.cert-manager.ps1

# run setup.rancher.ps1
..\step.by.step.setup\setup.rancher.ps1

