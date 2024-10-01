# ビルドステージ
FROM amazoncorretto:17 AS build
WORKDIR /home/app
COPY ./ /home/app
# Gradle wrapperに実行権限を付与
RUN chmod +x ./gradlew
RUN ./gradlew build

# 実行ステージ
FROM amazoncorretto:17-alpine
WORKDIR /app
COPY --from=build /home/app/build/libs/*.jar /app/todo-0.0.1-SNAPSHOT.jar
EXPOSE 8080
ENTRYPOINT ["java","-jar","-Dfile.encoding=UTF-8","/app/todo-0.0.1-SNAPSHOT.jar"]