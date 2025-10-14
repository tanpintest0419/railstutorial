FROM ruby:3.2

# Node.js & Yarn (Berry)
RUN apt-get update -qq \
    && apt-get install -y curl gnupg apt-transport-https lsb-release ca-certificates \
    && curl -fsSL https://deb.nodesource.com/setup_18.x | bash - \
    && apt-get install -y nodejs \
    && corepack enable \
    && apt-get install -y imagemagick

  # corepack enable :Yarn Berry を有効化
  # apt-get install -y imagemagick : ないとMiniMagick::Error ("convert" not found) のようなエラーになります。

WORKDIR /app
#COPY ./src /app
#COPY ./src/chapter3 /app

# Gemfile だけコピー（bundle install キャッシュ用）
COPY ./src/chapter3/Gemfile /app/Gemfile
COPY ./src/chapter3/Gemfile.lock /app/Gemfile.lock

RUN bundle config --local set path 'vendor/bundle' \
    && bundle install

# 末尾に追加 server.pid を削除
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]

CMD ["bundle", "exec", "rails", "s", "-b", "0.0.0.0"]
