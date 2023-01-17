const express = require("express");
const router = express.Router();
const Controllers = require("../Controllers/User");

router.post("/User", Controllers.Add);
router.get("/User", Controllers.GetAll);
router.get("/User/:id", Controllers.GetOne);
router.put("/User/:id", Controllers.UpdateOne);
router.delete("/User/:id", Controllers.DeleteOne);

module.exports = router;
