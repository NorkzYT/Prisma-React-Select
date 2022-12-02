# FrontEnd DockerFile

# We don't want to start from scratch.
# That is why we tell node here to use the current node image as base.
# Check https://github.com/nodejs/docker-node/tree/b4117f9333da4138b03a546ec926ef50a31506c3#nodealpine to understand why libc6-compat might be needed.
# --------------------------------------------------------------------------------------

FROM node:18-slim AS builder

ENV DEBIAN_FRONTEND noninteractive   
ENV DEBCONF_NOWARNINGS="yes"
# Check https://github.com/phusion/baseimage-docker/issues/319#issuecomment-1058835363 to understand why the above two `ENV` lines are needed.


# ---- Dependencies ----
# Use changes to package.json to force Docker not to use the cache
# when we change our application's nodejs dependencies:
RUN apt-get update
RUN apt-get install -y openssl

WORKDIR /app
COPY . .
RUN npm install --omit=dev

# Disable Nextjs telemetry
ENV NEXT_TELEMETRY_DISABLED=1

# Generate prisma clients
RUN npx prisma generate --schema ./prisma/first-schema.prisma

# Build the app
RUN npm run build

RUN mkdir -p /app/.next/cache/images

# ---- Production ----
# Copy all the files and run the following.

FROM node:18-slim AS runner

RUN apt-get update
RUN apt-get install -y openssl

WORKDIR /app

ENV NODE_ENV production
ENV NEXT_TELEMETRY_DISABLED 1

RUN addgroup --system --gid 1001 nodejs
RUN adduser --system --uid 1001 nextjs

COPY --chown=nextjs:nodejs --from=builder /app/ ./
USER nextjs

# Expose the App Port
EXPOSE 3507

# Expose the Prisma Studio Port
EXPOSE 5555

# Start the app
CMD [ "npm", "start", "--", "--port", "3507" ]

# --------------------------------------------------------------------------------------
# Best DockerFile Practice:
# http://bitjudo.com/blog/2014/03/13/building-efficient-dockerfiles-node-dot-js/
# https://docs.docker.com/develop/develop-images/dockerfile_best-practices/