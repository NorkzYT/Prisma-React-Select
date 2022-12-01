# Docker issue

This is a test repository to reproduce a docker issue.

## Steps to reproduce

1. Clone this repository.
2. Run `make docker-build-prismastudio`.
3. Run `docker-compose-build`.
4. Then run `npx prisma studio --schema ./prisma/first-schema.prisma`.
5. When the Prisma App docker container is running, run `docker exec -d app-test npx prisma studio --schema ./prisma/first-schema.prisma`.