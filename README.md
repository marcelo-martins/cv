## Useful Commands

tail -f /dev/null at the end of the CMD to keep the conteiner running

docker build -t name_of_conteiner . -> builds the conteiner

to enter the conteiner
 - "docker run name_of_conteiner" if the conteiner does not stop (by default, it stops after the CMD command if a /dev/null or similar is not present)
 - if the conteiner does not stop:
    - "docker run -d name_of_conteiner" to run in the backgroun
    - "docker exec -it conteiner_hash bash" to access bash inside the conteiner