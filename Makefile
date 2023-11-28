IMAGE_NAME = first-bootstrap-app
BROWSER = /usr/bin/firefox
FIREFOX_PROFILE = .config/firefox

build:
	docker build -t $(IMAGE_NAME) .
	mkdir -vp $(FIREFOX_PROFILE) 

run: build
	docker run -p 8080:80 $(IMAGE_NAME) &
	$(BROWSER) --headless --profile $(FIREFOX_PROFILE) --new-instance http://localhost:8080

clean:
	rm -vrf $(FIREFOX_PROFILE) || true
	docker stop $(docker ps -q -f "ancestor=$(IMAGE_NAME)") || true
	docker rm $(docker ps -q -f "ancestor=$(IMAGE_NAME)") || true
	pkill -f $(BROWSER) || true