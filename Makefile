
USER_DATA = "https://raw.githubusercontent.com/amoncusir/muncruft/main/user_data.sh"

bash:
	docker run -it --rm ubuntu:20.04 bash

bash-test:
	./scripts/bash_test.sh ./infrastructure/data/user_data.sh

tf-plan:
	terraform -chdir="./infrastructure" plan -var-file="local.tfvars"

test:
	docker run -it --rm ubuntu:20.04 bash -c "`cat user_data.sh`"

git-test:
	docker run -it --rm ubuntu:20.04 bash -c "apt update && apt install -y curl && curl -s ${USER_DATA} | sh"

prune:
	docker rmi -f $(docker images -aq) && \
        docker volume prune -f && \
        docker image prune --all -f && \
        docker network prune -f
