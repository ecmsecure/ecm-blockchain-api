ARG PLATFORM=linux/arm64
FROM --platform=$PLATFORM ruby:3.2.5-slim

RUN apt-get update -qq && apt-get install -y build-essential git

WORKDIR '/gem'
COPY . /gem


RUN gem install bundler -v '2.5.18'
RUN gem update --system

RUN bundle install 

# COPY .docker/entrypoint.sh /usr/bin/
# RUN chmod +x /usr/bin/entrypoint.sh
# ENTRYPOINT ["entrypoint.sh"]
CMD ["./bin/console"] 
