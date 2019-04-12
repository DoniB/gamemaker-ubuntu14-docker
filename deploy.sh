export REV=$(cat revision)

docker build -t donibtk/gamemaker-ubuntu14:latest -t donibtk/gamemaker-ubuntu14:$REV ./

docker push donibtk/gamemaker-ubuntu14:latest

docker push donibtk/gamemaker-ubuntu14:$REV
