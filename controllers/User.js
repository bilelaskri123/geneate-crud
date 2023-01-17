const User = require("../models/User");

/* Add User */
const Add = async (req, res) => {
  try {
    await User.create(req.body);
    res.status(201).json({ success: true });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};

/* GelAll */
const GetAll = async (req, res) => {
  try {
    const data = await User.findAll();
    res.status(200).json(data);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};

/* GetOne User */
const GetOne = async (req, res) => {
  try {
    const data = await User.findOne({ where: { id: req.params.id } });
    res.status(200).json(data);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};

/* UpdateOne User  */
const UpdateOne = async (req, res) => {
  try {
    await User.update(req.body, { where: { id: req.params.id } });
    res.status(200).json({ success: true });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};

/* DeleteOne User  */
const DeleteOne = async (req, res) => {
  try {
    await User.destroy({ where: { id: req.params.id } });
    res.status(200).json({ success: true });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};

module.exports = {
  Add,
  GetAll,
  GetOne,
  UpdateOne,
  DeleteOne,
};
