# FrontEnd DockerFile

# We don't want to start from scratch.
# That is why we tell node here to use the current node image as base.
# Check https://github.com/nodejs/docker-node/tree/b4117f9333da4138b03a546ec926ef50a31506c3#nodealpine to understand why libc6-compat might be needed.
# --------------------------------------------------------------------------------------

FROM node:16-slim

# ---- Dependencies ----
# Use changes to package.json to force Docker not to use the cache
# when we change our application's nodejs dependencies:
RUN apt-get update
RUN apt-get install -y openssl
ADD package.json /tmp/package.json
RUN npm install -g pnpm
RUN cd /tmp && pnpm install
ENV NEXT_TELEMETRY_DISABLED 1\_\node
RUN mkdir -p /opt/app && cp -a /tmp/node_modules /opt/app/


# From here we load our application's code in, therefore the previous docker
# "layer" thats been cached will be used if possible.
WORKDIR /opt/app
ADD . /opt/app

# Generate prisma clients
RUN npx prisma generate --schema ./prisma/first-schema.prisma

# # Build the app
RUN npm run build

# Expose the Port
EXPOSE 3507

# Expose the Prisma Studio Ports
EXPOSE 5555

# Start the app
CMD [ "npm", "start", "--", "--port", "3507" ]

# --------------------------------------------------------------------------------------
# Best DockerFile Practice:
# http://bitjudo.com/blog/2014/03/13/building-efficient-dockerfiles-node-dot-js/
# https://docs.docker.com/develop/develop-images/dockerfile_best-practices/
