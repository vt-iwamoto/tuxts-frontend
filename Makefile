build:
	docker build -t tuxts-frontend .

run:
	docker run --rm -it -v $(CURDIR)/tuxts-frontend:/tuxts-frontend -p 3000:3000 --name tuxts-frontend tuxts-frontend

sh:
	docker run --rm -it -v $(CURDIR)/tuxts-frontend:/tuxts-frontend -p 3000:3000 --name tuxts-frontend tuxts-frontend sh

exec:
	docker exec -it tuxts-frontend sh
