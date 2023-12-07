const express = require("express");
const app = express();
const usersRouter = require("./routers/usersRouter");
const placesRouter = require("./routers/placesRouter");

app.use(express.json());

app.use("/users", usersRouter);
app.use("/places", placesRouter);

const port = 3000;
app.listen(port, () => console.log(`Server is listening on port ${port}`));
