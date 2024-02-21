const express = require ('express');
const User = require ('../model/user');
const authRouter = express.Router ();
const bcryptjs = require ('bcryptjs');
const jwt = require ('jsonwebtoken');
//SIGNUP
authRouter.post ('/api/signup', async (req, res) => {
  //get data from client
  try {
    const {name, email, password} = req.body;

    const existingUser = await User.findOne ({email});
    if (existingUser) {
      return res
        .status (400)
        .json ({msg: 'User with same email already exists!'});
    }
    var hashedpassword = await bcryptjs.hash (password, 8);
    let user = new User ({
      email,
      password: hashedpassword,
      name,
    });
    user = await user.save ();
    res.json (user);
  } catch (e) {
    res.status (500).json ({error: e.message});
  }
  // _V
  //id
  //post data to DB
  //send data to user
});

//SignIn Route
authRouter.post ('/api/signin', async (req, res) => {
  try {
    const {email, password} = req.body;
    const user = await User.findOne ({email});
    if (!user) {
      return res
        .status (400)
        .json ({msg: 'User with this email does not exist'});
    }

    const isMatch = await bcryptjs.compare (password, user.password);
    if (!isMatch) {
      return res.status (400).json ({msg: 'Incorrect Password!'});
    }
    const token = jwt.sign ({id: user._id}, 'Passwordkey');
    res.json ({token, ...user._doc});
  } catch (e) {
    res.status (500).json ({error: e.message});
  }
});
module.exports = authRouter;
