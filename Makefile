gen:
	docker run --rm -it \
		-v $(CURDIR):/ansible \
		-v ./secure:/ansible/secure \
		willhallonline/ansible:latest ansible-playbook ansible/gen.yml \
		-i ansible/gen \
		-vv

build:
	docker build -t tor:$(tag) .

publish:
	docker image tag tor:$(tag) hardandheavy/tor:$(tag)
	docker push hardandheavy/tor:$(tag)

run:
	docker run -it --rm \
		-v ./torrc:/etc/tor/torrc \
		-p 9150:9150 \
		hardandheavy/tor:10

test:
	curl https://ipinfo.tw/ip
	curl --socks5-hostname 127.0.0.1:9150 https://ipinfo.tw/ip
