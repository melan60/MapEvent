const placesServices = require("../services/placesServices");
const express = require("express");
const router = express.Router();

router.get("/", placesServices.getAllPlaces);

router.get("/:id_place", placesServices.getPlaceById);

router.delete("/:id_place", placesServices.deleteInOnePlace);

router.post("/:id_place", placesServices.addInOnePlace);

module.exports = router;
