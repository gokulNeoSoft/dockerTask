#! /bin/bash



function start(){
    echo "##docker compose for mongo and mongo express"
    docker-compose up -d

    echo "##docker build for node application"
    docker build -t docktest .

    echo "##docker run for node application"
    docker run -d -e DATABASE_URL=mongodb://admin:password@mongodb --net=rest-api-express-mongodb_default --name node_app -p3000:3000 docktest
}


function stop(){
    echo "##docker compose down for mongo and mongo express"
    docker-compose down 
    echo "##docker stop for node application"
    docker stop node_app
}

function remove(){
    echo "##removing all containers and images of node application"
    docker rm node_app
    echo "## image"
    docker image rm docktest
}


echo "1.start"
echo "2.stop"
echo "3.remove all containers and images of node"
read -p "Select:1 or 2 or 3" OPTION

if [ "$OPTION" == "1" ]
then
  echo "Your OPTION is start"
  start
elif [ "$OPTION" == "2" ]
then  
  echo "Your OPTION is stop"
  stop
elif [ "$OPTION" == "3" ]
then  
  echo "Your OPTION is remove"
  remove
else 
  echo "pls select 1 or 2"
fi
