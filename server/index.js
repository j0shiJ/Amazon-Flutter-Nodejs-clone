const express = require ('express');

const mongoose = require ('mongoose');

//import from files
const authRouter = require ('./routes/auth');

//initializations
const app = express ();
const port = 3000;
const DB =
  'mongodb+srv://jayesh:eiMRWAzKDPp1ZufC@cluster0.1dvnzne.mongodb.net/?retryWrites=true&w=majority';
//middleware
app.use (express.json ());
app.use (authRouter);

//connections
mongoose
  .connect (DB)
  .then (() => {
    console.log ('connection successful');
  })
  .catch (e => {
    console.log (e);
  });
app.listen (port, () => {});
