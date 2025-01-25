.PHONY: build generate_pdf

build:
	docker build -t latex_compiler .

generate_pdf:
	docker run --rm -v $(pwd)/output:/output latex_compiler