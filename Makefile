
USER_DATA = "https://raw.githubusercontent.com/amoncusir/muncruft/main/user_data.sh"

bash:
	docker run -it --rm ubuntu:20.04 bash

bash-test:
	./scripts/bash_test.sh

test:
	docker run -it --rm ubuntu:20.04 bash -c "`cat user_data.sh`"

git-test:
	docker run -it --rm ubuntu:20.04 bash -c "apt update && apt install -y curl && curl -s ${USER_DATA} | sh"
