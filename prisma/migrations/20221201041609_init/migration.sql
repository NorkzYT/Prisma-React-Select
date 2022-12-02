-- CreateTable
CREATE TABLE "info" (
    "sub" TEXT NOT NULL,
    "info" TEXT NOT NULL,
    "key" TEXT NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- CreateIndex
CREATE UNIQUE INDEX "info_sub_key" ON "info"("sub");

-- CreateIndex
CREATE UNIQUE INDEX "info_info_key" ON "info"("info");

-- CreateIndex
CREATE UNIQUE INDEX "info_key_key" ON "info"("key");
