const pool = require("../database/db");

const getAllPlaces = async (req, res) => {
   try {
      pool.query("SELECT * FROM Place", (err, results) => {
         if (err) {
            return res.status(400).send(err);
         }
         console.log(results.rows);
         return res.status(200).send(results.rows);
      });
   } catch (e) {
      console.log(e);
   }
};

const getAllUsersPlaces = async (req, res) => {
   const id_place = req.params.id_place;
   try {
      pool.query("SELECT * FROM is_in inner join Person as p on p.id_person = is_in.id_person where id_place = $1", [id_place], (err, results) => {
         if (err) {
            return res.status(400).send(err);
         }
         // console.log(results.rows)
         return res.status(200).send(results.rows);
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
   let id_person = req.params.id_person;
   console.log(id_person);
   try {
      pool.query(
         "DELETE FROM is_in WHERE id_person = $1",
         [id_person],
         (err, results) => {
            if (err) {
               return res.status(400).send({ success: 1, error: err });
            }
            try {
               pool.query(
                  "UPDATE Person SET is_placed = false WHERE id_person = $1",
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
   let id_person = req.params.id_person;
   let date = '2023-11-30 22:20:00' // Date.now();

   try {
      // await deleteInOnePlace(req, res);
      pool.query(
         "DELETE FROM is_in WHERE id_person = $1",
         [id_person],
         (err, results) => {
            if (err) {
               return res.status(400).send({ success: 1, error: err });
            }
            pool.query(
               "INSERT INTO is_in(id_place, id_person, date) VALUES ($1, $2, $3);",
               [id_place, id_person, date],
               (err, results) => {
                  
                  if (err) {
                     console.log(err)
                     return res.status(400).send({ success: 1, error: err });
                  }
                  try {
                     pool.query(
                        "UPDATE Person SET is_placed = true WHERE id_person = $1",
                        [id_person],
                        (error, result) => {
                           if (error) {
                              console.log(error)
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
         });
   } catch (e) {
      console.log(e);
   }
};

module.exports = {
   getAllPlaces,
   getAllUsersPlaces,
   getPlaceById,
   deleteInOnePlace,
   addInOnePlace,
};
