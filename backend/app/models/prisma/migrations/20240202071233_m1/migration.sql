-- CreateTable
CREATE TABLE "authors" (
    "author_id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "surname" TEXT NOT NULL,
    "birthday" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "authors_pkey" PRIMARY KEY ("author_id")
);

-- CreateTable
CREATE TABLE "books" (
    "book_id" SERIAL NOT NULL,
    "title" TEXT NOT NULL,
    "publish_year" TIMESTAMP(3) NOT NULL,
    "page_count" INTEGER NOT NULL,
    "price" DOUBLE PRECISION NOT NULL,

    CONSTRAINT "books_pkey" PRIMARY KEY ("book_id")
);

-- CreateTable
CREATE TABLE "genres" (
    "genre_id" SERIAL NOT NULL,
    "genre_name" TEXT NOT NULL,

    CONSTRAINT "genres_pkey" PRIMARY KEY ("genre_id")
);

-- CreateTable
CREATE TABLE "author_book" (
    "author_id" INTEGER NOT NULL,
    "book_id" INTEGER NOT NULL,

    CONSTRAINT "author_book_pkey" PRIMARY KEY ("author_id","book_id")
);

-- CreateTable
CREATE TABLE "book_genre" (
    "book_id" INTEGER NOT NULL,
    "genre_id" INTEGER NOT NULL,

    CONSTRAINT "book_genre_pkey" PRIMARY KEY ("book_id","genre_id")
);

-- CreateTable
CREATE TABLE "_author_book" (
    "A" INTEGER NOT NULL,
    "B" INTEGER NOT NULL
);

-- CreateTable
CREATE TABLE "_book_genre" (
    "A" INTEGER NOT NULL,
    "B" INTEGER NOT NULL
);

-- CreateIndex
CREATE UNIQUE INDEX "authors_author_id_key" ON "authors"("author_id");

-- CreateIndex
CREATE UNIQUE INDEX "books_book_id_key" ON "books"("book_id");

-- CreateIndex
CREATE UNIQUE INDEX "genres_genre_id_key" ON "genres"("genre_id");

-- CreateIndex
CREATE UNIQUE INDEX "_author_book_AB_unique" ON "_author_book"("A", "B");

-- CreateIndex
CREATE INDEX "_author_book_B_index" ON "_author_book"("B");

-- CreateIndex
CREATE UNIQUE INDEX "_book_genre_AB_unique" ON "_book_genre"("A", "B");

-- CreateIndex
CREATE INDEX "_book_genre_B_index" ON "_book_genre"("B");

-- AddForeignKey
ALTER TABLE "author_book" ADD CONSTRAINT "author_book_author_id_fkey" FOREIGN KEY ("author_id") REFERENCES "authors"("author_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "author_book" ADD CONSTRAINT "author_book_book_id_fkey" FOREIGN KEY ("book_id") REFERENCES "books"("book_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "book_genre" ADD CONSTRAINT "book_genre_book_id_fkey" FOREIGN KEY ("book_id") REFERENCES "books"("book_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "book_genre" ADD CONSTRAINT "book_genre_genre_id_fkey" FOREIGN KEY ("genre_id") REFERENCES "genres"("genre_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_author_book" ADD CONSTRAINT "_author_book_A_fkey" FOREIGN KEY ("A") REFERENCES "authors"("author_id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_author_book" ADD CONSTRAINT "_author_book_B_fkey" FOREIGN KEY ("B") REFERENCES "books"("book_id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_book_genre" ADD CONSTRAINT "_book_genre_A_fkey" FOREIGN KEY ("A") REFERENCES "books"("book_id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_book_genre" ADD CONSTRAINT "_book_genre_B_fkey" FOREIGN KEY ("B") REFERENCES "genres"("genre_id") ON DELETE CASCADE ON UPDATE CASCADE;
