-- CreateTable
CREATE TABLE "notification_followers" (
    "chatId" SERIAL NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "notification_followers_pkey" PRIMARY KEY ("chatId")
);

-- CreateIndex
CREATE UNIQUE INDEX "notification_followers_chatId_key" ON "notification_followers"("chatId");
