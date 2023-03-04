## MULTI-STAGE DOCKERFILE

# STAGE 1
# maven to create the artifact
# 'build' is an alias to called from other stage
FROM maven as build
# if /app doesn't exist, it creates it
WORKDIR /app
# 1st . is our directory (CWD our PC)
# 2nd . is /app (CWD in the container)
COPY . .
RUN mvn install

# STAGE 2
FROM openjdk:11.0
WORKDIR /app
# 1st location .. the previous stage
# 2nd location .. our WORKDIR (it could also be '.')
COPY --from=build /app/target/Uber.jar /app/
EXPOSE 9090
CMD [ "java","-jar","Uber.jar" ]