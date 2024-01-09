const placesServices = require("../services/placesServices");
const express = require("express");
const router = express.Router();

router.get("/", placesServices.getAllPlaces);

router.get("/isin/:id_place", placesServices.getAllUsersPlaces);

router.get("/:id_place", placesServices.getPlaceById);

router.delete("/:id_person", placesServices.deleteInOnePlace);

router.post("/:id_place/:id_person", placesServices.addInOnePlace);

module.exports = router;
