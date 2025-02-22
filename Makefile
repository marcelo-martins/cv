.PHONY: stop_conteiners remove_conteiners remove_images start restart stop

stop_conteiners:
	docker ps -q | xargs -r docker stop

remove_conteiners:
	docker ps -a -q | xargs -r docker rm

remove_images:
	docker images -q | xargs docker rmi

clean: stop_conteiners remove_conteiners remove_images

start:
	astro dev start

restart:
	astro dev restart

stop:
	astro dev stop