const express = require("express")
const participantes = require("./controllers/participantes")
const laboratorios = require("./controllers/laboratorios")

const router = express.Router()

router.get("/participantes", participantes.listar)
router.post("/participantes", participantes.criar)
router.get("/participantes/:id", participantes.buscarPorId)
router.put("/participantes/:id", participantes.alterar)
router.delete("/participantes/:id", participantes.excluir)

router.get("/laboratorios", laboratorios.listar)
router.post("/laboratorios", laboratorios.criar)
router.put("/laboratorios/:id", laboratorios.alterar)
router.delete("/laboratorios/:id", laboratorios.excluir)

module.exports = router
