const mysql = require("mysql2")

const conexao = mysql.createConnection({
    host: "localhost",
    user: "root",
    password: "",
    database: "labx_experience"
})

conexao.connect((erro) => {
    if (erro) {
        console.log("Erro ao conectar com o banco:", erro)
        return
    }

    console.log("Conectado ao banco de dados!")
})

module.exports = conexao