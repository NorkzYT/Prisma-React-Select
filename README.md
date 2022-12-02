# Prisma App

Ready for development, and production. This is a starter template I made for the Prisma App.


------------------
#### Docker issue [resolved] - 2022-12-02 (aarch64 architecture issue)

This issue has been resolved by updating the `Dockerfile`.

This is a test repository to reproduce a docker issue.

##### Steps to reproduce

1. Clone this repository
2. Run `make docker-build-prismastudio`
3. Run `docker-compose-build`
4. Run `npx prisma studio --schema=./prisma/first-schema.prisma`
5. After using `Prisma Migrate` like so `npx prisma migrate dev --name init`.
6. Open `http://localhost:5559` in your browser, and add, change, and delete information to the Database through Prisma Studio, and also spam the refresh button, do this for at least 1 minute and you will see the following error appear.
```
Prisma Client Error
----
Unable to run script
> Show Details
----
Error Documentation | Dismiss
```
Sometimes the refresh button will take a while to refresh the database data, and eventually the error will show.