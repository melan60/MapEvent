const pool = require("../database/db");

const getAllUsers = async (req, res) => {
   try {
      pool.query("SELECT * FROM Person WHERE id_person = 1", (err, results) => {
         if (err) {
            return res.status(400).send({ success: 1, error: err });
         }
         console.log(results);
         return res.status(200).send(results.rows);
      });
   } catch (e) {
      console.log(e);
   }
};

const addUser = async (req, res) => {
   let { firstname, lastname, email, company, activity } = req.body;
   try {
      pool.query(
         "INSERT INTO Person(firstname, lastname, email, company, activity) VALUES($1, $2, $3, $4, $5) RETURNING *",
         [firstname, lastname, email, company, activity],
         (err, results) => {
            if (err) {
               return res.status(400).send({ success: 1, error: err });
            }
            return res.status(200).send({ success: 0, data: results.rows[0] });
         }
      );
   } catch (e) {
      console.log(e);
   }
};

const updateUser = async (req, res) => {
   let id_person = req.params.id_person;
   let { firstname, lastname, email, company, activity } = req.body;
   try {
      pool.query(
         "UPDATE Person SET firstname=$1, lastname=$2, email=$3, company=$4, activity=$5 WHERE id_person = $6 RETURNING *",
         [firstname, lastname, email, company, activity, id_person],
         (err, results) => {
            if (err) {
               return res.status(400).send({ success: 1, error: err });
            }
            return res.status(200).send({ success: 0, data: results.rows[0] });
         }
      );
   } catch (e) {
      console.log(e);
   }
};

module.exports = {
   getAllUsers,
   addUser,
   updateUser,
};

// const getUsers = (request, response) => {
//     pool.query('SELECT * FROM users ORDER BY id ASC', (error, results) => {
//       if (error) {
//         throw error
//       }
//       response.status(200).json(results.rows)
//     })
//   }

// const addEntreprise = (req, res) => {
//     const {name} = req.query
//     pool.query(queries.getOneEntreprise, [name], (err, results) => {
//         if(results.rowCount > 0)
//             res.send("Entreprise already exists")
//         pool.query(queries.addEntreprise, [name], (error, result) => {
//             if (error) throw error
//             res.status(200).send("Successfully created")
//         })
//     })
// }

// const getOrganisateur = async (callback) => {
//     try {
//         pool.query(auth_queries.getOrganisateur, (error, results) => {
//             if (error) {
//                 console.log("F1: error service", error);
//                 return callback("Error retrieving orga.");
//             }
//             return callback(null, results.rows)
//         });
//     } catch (e) {
//         console.log(e);
//         return callback([]);
//     }
// }
