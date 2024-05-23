FROM ruby:3.0.1
RUN apt update -y
RUN apt-get install -y libpq-dev
RUN apt-get install -y libsqlite3-dev
RUN apt-get install -y nodejs
RUN apt-get install -y npm
RUN npm install --global yarn
RUN echo "gem: --no-document" > ~/.gemrc
RUN gem install bundler
RUN gem env home
RUN gem install rails -v 6.1.4.4
RUN git clone https://github.com/ansal-sajan/budget-app.git /app
WORKDIR /app
RUN gem install bundler && \
    bundle install
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash && \
  . ~/.nvm/nvm.sh && \
  nvm install 16 && \
  nvm use 16 && \
  yarn install
RUN rails webpacker:compile
EXPOSE 3000
CMD ["bash", "-c", "rails db:create && rails db:migrate && rails server -b 0.0.0.0"]

