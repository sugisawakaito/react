# 1. Node.jsのベースイメージを使用
FROM node:alpine as build-stage

# 2. 作業ディレクトリを設定
WORKDIR /app

# 3. アプリケーションの依存関係をインストール
COPY package*.json ./
RUN npm install

# 4. アプリケーションのソースコードをコピー
COPY . .

# 5. Reactアプリケーションをビルド
RUN npm run build

# 6. Nginxを使用してサーバーを設定
FROM nginx:alpine
COPY --from=build-stage /app/build /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
