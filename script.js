const form = document.querySelector("#formCadastro")

form.addEventListener("submit", async function(event) {
    event.preventDefault()

    const dados = {
        nome: document.querySelector("#nome").value,
        email: document.querySelector("#email").value,
        telefone: document.querySelector("#telefone").value,
        turma: document.querySelector("#turma").value
    }

    const resposta = await fetch("http://localhost:3000/participantes", {
        method: "POST",
        headers: {
            "Content-Type": "application/json"
        },
        body: JSON.stringify(dados)
    })

    const participante = await resposta.json()

    alert("Participante cadastrado com sucesso!")

    form.reset()
})