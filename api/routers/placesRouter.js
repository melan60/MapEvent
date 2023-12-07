const placesServices = require("../services/placesServices");
const express = require("express");
const router = express.Router();

router.get("/", placesServices.getAllPlaces);

// TODO
// Modifier la présence dans is_in

module.exports = router;
