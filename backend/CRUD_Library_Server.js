const express = require('express');
const fileUpload = require('express-fileupload');
const { PrismaClient } = require('@prisma/client');
const prisma = new PrismaClient();
const loggerMiddleware = require('./app/middleware/loggerMiddleware');
const app = express();
app.use(express.json());
app.use(fileUpload());
const loggerMiddleware = require('./app/middleware/loggerMiddleware');
const PORT = 3000;

const swaggerUi = require('swagger-ui-express'),
swaggerDocument = require('./swagger.json');

const authorRoutes = require('./app/routers/authorsRouter');
const bookRoutes = require('./app/routers/booksRouter');
const genreRoutes = require('./app/routers/genresRouter');
const fileRoutes = require('./app/routers/fileRouter');

// Route to get books by author ID using LEFT JOIN
app.get('/author/:id/books', async (req, res) => {
    const { id } = req.params;
    const authorBooks = await prisma.authors
      .findUnique({
          where: { author_id: parseInt(id) },
          include: {
              books: true, // LEFT JOIN to fetch books associated with the author
          },
      });

    res.json(authorBooks?.books || []);
});

// Route to get books by genre ID using LEFT JOIN
app.get('/genre/:id/books', async (req, res) => {
    const { id } = req.params;
    const genreBooks = await prisma.genres
      .findUnique({
          where: { genre_id: parseInt(id) },
          include: {
              books: true, // LEFT JOIN to fetch books associated with the genre
          },
      });

    res.json(genreBooks?.books || []);
});


app.use('/books', bookRoutes);
app.use('/authors', authorRoutes);
app.use('/genres', genreRoutes);
app.use('/file', fileRoutes);

app.use(
  '/api-docs',
  swaggerUi.serve,
  swaggerUi.setup(swaggerDocument)
);

app.listen(PORT, () => {
    console.log(`The server is running on http://localhost:${PORT}`)
})