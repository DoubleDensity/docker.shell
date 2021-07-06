## docker.shell

##### wrap your $HOME in a dockerized alpine shell

---

### Install [docker](https://docs.docker.com/get-docker/)
### Install [make](https://www.gnu.org/software/make/)

---

## Linux

```shell
apt install docker.io docker-compose
```
## macOS
```shell
brew install make docker docker-compose
```

## git

```shell
git clone https://github.com/RandyMcMillan/docker.shell.git ~/docker.shell
cd docker.shell
make shell #host user
make shell user=root
```
