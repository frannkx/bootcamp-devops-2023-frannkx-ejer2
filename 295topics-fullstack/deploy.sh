
docker network create front-net
docker network create back-net

docker volume mongo-data 

# 295topics-frontend (Frontend en Node.js y Express:)

#Construye la imagen del frontend utilizando el Dockerfile.
docker build . -f frontend/dockerfile -t 295topics-frontend:1.0.0


#Publica la imagen en Docker Hub.
docker tag topics-frontend:v1 frannkx/295topics-frontend:1.0.0
docker push frannkx/295topics-frontend:1.0.0
#Se debe tomar en cuenta que consume el endpoint del backend a traves de la variable API_URI en donde se conectara con el backend
API_URI= http://topics-api:5000/api/topics

# 295topics-backend

DATABASE_URL=mongo:27017
DATABASE_NAME=Topics
HOST=localhost
PORT=5000

# 295topics-mongo

docker run --name mongo \
--network back-net \
-e MONGO_INITDB_ROOT_USERNAME:root \
-e MONGO_INITDB_ROOT_PASSWORD:example \
-v mongo-data:/data/db \
--mount type=bind,source=$PWD/db,target=/docker-entrypoint-initdb.d \
-d mongo:7.0.4

# 295topics-mongo-express

docker run --name me \
--network back-net \
-e ME_CONFIG_MONGODB_ADMINUSERNAME:root \
-e ME_CONFIG_MONGODB_ADMINPASSWORD:example \
-e ME_CONFIG_MONGODB_URL:mongodb://root:example@smongo:27017/ \
-p 8081:8081 \
-d mongo-express

