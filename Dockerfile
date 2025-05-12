# Dockerfile

FROM ruby:3.2.2

# Instala dependências do sistema
RUN apt-get update -qq && apt-get install -y \
  build-essential \
  libpq-dev \
  nodejs \
  yarn \
  redis-server \
  ffmpeg \
  libvips \
  && rm -rf /var/lib/apt/lists/*

# Define diretório de trabalho
WORKDIR /app

# Copia arquivos de dependência
COPY Gemfile Gemfile.lock ./

# Instala gems
RUN bundle install

# Copia o restante do código
COPY . .

# Prepara o servidor
CMD ["bash", "-c", "rm -f tmp/pids/server.pid && bundle exec rails s -b '0.0.0.0'"]
