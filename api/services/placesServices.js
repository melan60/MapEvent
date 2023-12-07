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

module.exports = {
   getAllPlaces,
};
