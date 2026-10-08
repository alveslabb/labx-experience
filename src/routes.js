const express = require("express")
const participantes = require("./controllers/participantes")

const router = express.Router()

router.get("/participantes", participantes.listar)
router.post("/participantes", participantes.criar)
router.get("/participantes/:id", participantes.buscarPorId)
router.put("/participantes/:id", participantes.alterar)
router.delete("/participantes/:id", participantes.excluir)

module.exports = router
