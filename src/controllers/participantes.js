const fs = require("fs")
const path = require("path")

const arquivo = path.join(__dirname, "../../dados/participantes.json")

function lerParticipantes() {
    const dados = fs.readFileSync(arquivo, "utf8")
    return JSON.parse(dados)
}

function salvarParticipantes(participantes) {
    fs.writeFileSync(arquivo, JSON.stringify(participantes, null, 2))
}

function listar(req, res) {
    const participantes = lerParticipantes()

    res.json(participantes)
}

function criar(req, res) {
    const participantes = lerParticipantes()

    const novoParticipante = {
        id: participantes.length + 1,
        nome: req.body.nome,
        email: req.body.email,
        telefone: req.body.telefone,
        turma: req.body.turma
    }

    participantes.push(novoParticipante)

    salvarParticipantes(participantes)

    res.status(201).json(novoParticipante)
}

function buscarPorId(req, res) {
    const participantes = lerParticipantes()

    const participante = participantes.find(p => p.id == req.params.id)

    if (!participante) {
        return res.status(404).json({
            mensagem: "Participante não encontrado"
        })
    }

    res.json(participante)
}

function alterar(req, res) {
    const participantes = lerParticipantes()

    const participante = participantes.find(p => p.id == req.params.id)

    if (!participante) {
        return res.status(404).json({
            mensagem: "Participante não encontrado"
        })
    }

    participante.nome = req.body.nome
    participante.email = req.body.email
    participante.telefone = req.body.telefone
    participante.turma = req.body.turma

    salvarParticipantes(participantes)

    res.json(participante)
}

function excluir(req, res) {
    const participantes = lerParticipantes()

    const novosParticipantes = participantes.filter(p => p.id != req.params.id)

    if (participantes.length == novosParticipantes.length) {
        return res.status(404).json({
            mensagem: "Participante não encontrado"
        })
    }

    salvarParticipantes(novosParticipantes)

    res.json({
        mensagem: "Participante excluído com sucesso"
    })
}

module.exports = {
    listar,
    criar,
    buscarPorId,
    alterar,
    excluir
}