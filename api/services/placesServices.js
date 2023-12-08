const pool = require("../database/db");

const getAllPlaces = async (req, res) => {
   try {
      pool.query("SELECT * FROM Place", (err, results) => {
         if (err) {
            return res.status(400).send({ success: 1, error: err });
         }
         return res.status(200).send({ success: 0, data: results.rows });
      });
   } catch (e) {
      console.log(e);
   }
};

const getPlaceById = async (req, res) => {
   let id_place = req.params.id_place;
   try {
      pool.query("SELECT * FROM Place WHERE id_place = $1", [id_place], (err, results) => {
         if (err) {
            return res.status(400).send({ success: 1, error: err });
         }
         return res.status(200).send({ success: 0, data: results.rows });
      });
   } catch (e) {
      console.log(e);
   }
};

const deleteInOnePlace = async (req, res) => {
   let id_place = req.params.id_place;
   let id_person = req.query.id_person;
   try {
      pool.query(
         "DELETE FROM is_in WHERE id_place = $1 AND id_person = $2",
         [id_place, id_person],
         (err, results) => {
            if (err) {
               return res.status(400).send({ success: 1, error: err });
            }
            try {
               pool.query(
                  "UPDATE Person SET isPlaced = false WHERE id_person = $1",
                  [id_person],
                  (error, result) => {
                     if (error) {
                        return res.status(400).send({ success: 1, error: error });
                     }
                     return res.status(200).send({ success: 0, data: result.rows[0] });
                  }
               );
            } catch (e) {
               console.log(e);
            }
         }
      );
   } catch (e) {
      console.log(e);
   }
};

const addInOnePlace = async (req, res) => {
   let id_place = req.params.id_place;
   let id_person = req.body.id_person;
   let date = req.body.date;
   try {
      pool.query(
         "INSERT INTO is_in(id_place, id_person, date) VALUES ($1, $2, $3) RETURNING *",
         [id_place, id_person, date],
         (err, results) => {
            if (err) {
               return res.status(400).send({ success: 1, error: err });
            }
            try {
               pool.query(
                  "UPDATE Person SET isPlaced = true WHERE id_person = $1",
                  [id_person],
                  (error, result) => {
                     if (error) {
                        return res.status(400).send({ success: 1, error: error });
                     }
                     return res.status(200).send({ success: 0, data: result.rows[0] });
                  }
               );
            } catch (e) {
               console.log(e);
            }
         }
      );
   } catch (e) {
      console.log(e);
   }
};

module.exports = {
   getAllPlaces,
   getPlaceById,
   deleteInOnePlace,
   addInOnePlace,
};
