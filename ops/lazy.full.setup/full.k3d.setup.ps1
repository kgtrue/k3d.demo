# Purge your Docker env
docker rm -f $(docker ps -qa)
docker network prune -f
docker volume prune -
docker system prune -a -f


# run setup.prerequisites
invoke-expression -Command ..\step.by.step.setup\setup.prerequisites.ps1 | Out-Null

# run setup.k3d.cluster
invoke-expression -Command ..\step.by.step.setup\setup.k3d.cluster.ps1 | Out-Null

# run setup.cert-manager
invoke-expression -Command ..\step.by.step.setup\setup.cert-manager.ps1 | Out-Null

# run setup.rancher.ps1
invoke-expression -Command ..\step.by.step.setup\setup.rancher.ps1 | Out-Null

