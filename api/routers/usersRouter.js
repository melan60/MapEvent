const usersServices = require("../services/usersServices");
const express = require("express");
const router = express.Router();

router.get("/", usersServices.getAllUsers);

router.post("/", usersServices.addUser);

router.put("/", usersServices.updateUser);

module.exports = router;
