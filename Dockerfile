# ビルドステージ
FROM amazoncorretto:17 AS build
WORKDIR /home/app
COPY ./ /home/app
# Gradle wrapperに実行権限を付与
RUN chmod +x ./gradlew
RUN ./gradlew build

# 実行ステージ
FROM amazoncorretto:17-alpine
COPY --from=build /home/app/build/libs/spring-render-deploy-0.0.1-SNAPSHOT.jar /usr/local/lib/spring-render-deploy.jar
EXPOSE 8080
ENTRYPOINT ["java","-jar","-Dfile.encoding=UTF-8","/usr/local/lib/spring-render-deploy.jar"]
