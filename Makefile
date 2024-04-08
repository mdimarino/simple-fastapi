APPLICATION=simple-fastapi
VERSION=0.1.0

## help: exibe esta mensagem de ajuda
help:
	@echo "Uso:"
	@sed -n 's/^##//p' ${MAKEFILE_LIST} | column -t -s ':' |  sed -e 's/^/ /'

## env: cria o virtual environment
env: 
	@echo "Cria virtual environment"
	test -d .env || python3 -m venv .env

## deps: instala dependências
deps: env
	@echo "Instala dependências"
	bash -c "source .env/bin/activate && pip install -r requirements.txt"

## image: cria localmente a imagem docker
image:
	@echo "Cria imagem Docker"
	docker build --build-arg arg_version=${VERSION} -t ${APPLICATION}:${VERSION} .

## kaniko
kaniko:
	@echo "Cria imagem com Kaniko"
	docker run --rm -v .:/workspace gcr.io/kaniko-project/executor:latest --dockerfile=Dockerfile --context=. --no-push --verbosity=debug

## clean: remove a imagem docker local
clean:
	@echo "Remove a imagem"
	docker image rm ${APPLICATION}:${VERSION}
	docker image rm ${APPLICATION}:latest
