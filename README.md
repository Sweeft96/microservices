# microservices
## HW 14(docker-1)

В данной работе мы:

установили docker, docker-compose, docker-machine;
рассмотрели жизненные цикл контейнера на примере hello-world и nginx;
рассмотрели отличия image и container.

### Полезные команды:
```
docker info - информация о dockerd (включая количество containers, images и т.п.).
$ docker version
$ docker images - список всех images.
$ docker ps - список запущенных на текущий момент контейнеров.
$ docker ps -a - список всех контейнеров, в т.ч. остановленных.
$ docker system df - информация о дисковом пространстве (контейнеры, образы и т.д.).
$ docker inspect <id> - подробная информация об объекте docker.
```

## HW 15(docker-2)

В данной работе мы:
создали docker host;
описали Dockerfile;
опубликовали Dockerfile на Docker Hub;
подготовили прототип автоматизации деплоя приложения в связке Terraform + Ansible

