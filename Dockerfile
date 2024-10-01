# ビルドステージ
FROM amazoncorretto:17 AS build
# Gradle wrapperに実行権限を付与
RUN chmod +x ./gradlew
RUN ./gradlew build

# 実行ステージ
FROM amazoncorretto:17-alpine
COPY --from=build /home/app/build/libs/todo-0.0.1-SNAPSHOT.jar /build/libs/todo-0.0.1-SNAPSHOT.jar
EXPOSE 8080
ENTRYPOINT ["java","-jar","-Dfile.encoding=UTF-8","/build/libs/todo-0.0.1-SNAPSHOT.jar"]
