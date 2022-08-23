
$title    = 'Purge docker setup'
$question = 'This wil purge docker of images, containers and volumes. Do you want to continue?'
$choices  = '&Yes', '&No'

$decision = $Host.UI.PromptForChoice($title, $question, $choices, 1)
if ($decision -eq 0) {
   # Purge your Docker env
   docker rm -f $(docker ps -qa)
   docker network prune -f
   docker network prune -f
   docker volume prune -
   docker system prune -a -f
}

