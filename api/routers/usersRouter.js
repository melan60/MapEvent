const usersServices = require("../services/usersServices");
const express = require("express");
const router = express.Router();

router.get("/", usersServices.getAllUsers);

router.post("/", usersServices.addUser);

router.put("/:id_person", usersServices.updateUser);

module.exports = router;
