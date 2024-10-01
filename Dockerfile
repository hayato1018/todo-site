# ベースイメージとしてOpenJDKを使用
FROM openjdk:17-jdk-slim

# 作業ディレクトリを作成
WORKDIR /app

# Gradleのビルドキャッシュを利用するためにGradleラッパーと設定ファイルをコピー
COPY gradlew gradlew
COPY gradle gradle
COPY build.gradle settings.gradle ./

# 依存関係をダウンロードしてキャッシュ
RUN ./gradlew build || return 0

# ソースコードをコピー
COPY src src

# プロジェクトをビルド
RUN ./gradlew build

# 実行するjarファイルをコピー
COPY build/libs/*.jar app.jar

# アプリケーションを起動
ENTRYPOINT ["java", "-jar", "app.jar"]