# Docker issue

This is a test repository to reproduce a docker issue.

## Steps to reproduce

1. Clone this repository
2. Run `make docker-build-prismastudio`
3. Then run `docker-compose-build`
4. Lastly run `npx prisma studio --schema ./prisma/first-schema.prisma`