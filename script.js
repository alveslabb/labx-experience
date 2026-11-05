
const form = document.querySelector("#formCadastro")
const lista = document.querySelector("#listaParticipantes")

// LISTAR PARTICIPANTES

async function listarParticipantes() {

    try {

        const resposta = await fetch("http://localhost:3000/participantes")

        if (!resposta.ok) {
            throw new Error("Erro ao buscar participantes")
        }

        const participantes = await resposta.json()

        lista.innerHTML = ""

        if (participantes.length == 0) {

            lista.innerHTML = `
                <tr>
                    <td colspan="5">Nenhum participante cadastrado.</td>
                </tr>
            `

            return
        }

        participantes.forEach(participante => {

            const linha = document.createElement("tr")

            const nome = document.createElement("td")
            nome.textContent = participante.nome

            const email = document.createElement("td")
            email.textContent = participante.email

            const telefone = document.createElement("td")
            telefone.textContent = participante.telefone

            const turma = document.createElement("td")
            turma.textContent = participante.turma

            const acoes = document.createElement("td")
            acoes.classList.add("acoes")

            const botaoEditar = document.createElement("button")
            botaoEditar.textContent = "Editar"
            botaoEditar.classList.add("btn-editar")

            botaoEditar.addEventListener("click", function() {
                editarParticipante(participante)
            })

            const botaoExcluir = document.createElement("button")
            botaoExcluir.textContent = "Excluir"
            botaoExcluir.classList.add("btn-excluir")

            botaoExcluir.addEventListener("click", function() {
                excluirParticipante(participante.id)
            })

            acoes.appendChild(botaoEditar)
            acoes.appendChild(botaoExcluir)

            linha.appendChild(nome)
            linha.appendChild(email)
            linha.appendChild(telefone)
            linha.appendChild(turma)
            linha.appendChild(acoes)

            lista.appendChild(linha)

        })

    } catch (erro) {

        lista.innerHTML = `
            <tr>
                <td colspan="5">Não foi possível carregar os participantes.</td>
            </tr>
        `

        console.log(erro)

    }
}

// CADASTRAR PARTICIPANTE

form.addEventListener("submit", async function(event) {

    event.preventDefault()

    const dados = {
        nome: document.querySelector("#nome").value,
        email: document.querySelector("#email").value,
        telefone: document.querySelector("#telefone").value,
        turma: document.querySelector("#turma").value
    }

    try {

        const resposta = await fetch("http://localhost:3000/participantes", {
            method: "POST",
            headers: {
                "Content-Type": "application/json"
            },
            body: JSON.stringify(dados)
        })

        if (!resposta.ok) {
            throw new Error("Erro ao cadastrar participante")
        }

        await resposta.json()

        alert("Participante cadastrado com sucesso!")

        form.reset()

        listarParticipantes()

    } catch (erro) {

        alert("Erro ao cadastrar participante.")

        console.log(erro)

    }

})

// EDITAR PARTICIPANTE

async function editarParticipante(participante) {

    const nome = prompt("Digite o novo nome:", participante.nome)

    if (nome === null) return

    const email = prompt("Digite o novo e-mail:", participante.email)

    if (email === null) return

    const telefone = prompt("Digite o novo telefone:", participante.telefone)

    if (telefone === null) return

    const turma = prompt("Digite a nova turma:", participante.turma)

    if (turma === null) return

    if (!nome.trim() || !email.trim() || !telefone.trim() || !turma.trim()) {
        alert("Preencha todos os campos.")
        return
    }

    const dados = {
        nome: nome,
        email: email,
        telefone: telefone,
        turma: turma
    }

    try {

        const resposta = await fetch(`http://localhost:3000/participantes/${participante.id}`, {
            method: "PUT",
            headers: {
                "Content-Type": "application/json"
            },
            body: JSON.stringify(dados)
        })

        if (!resposta.ok) {
            throw new Error("Erro ao editar participante")
        }

        alert("Participante atualizado com sucesso!")

        listarParticipantes()

    } catch (erro) {

        alert("Não foi possível editar o participante.")

        console.log(erro)

    }

}

// EXCLUIR PARTICIPANTE

async function excluirParticipante(id) {

    const confirmar = confirm("Tem certeza que deseja excluir este participante?")

    if (!confirmar) return

    try {

        const resposta = await fetch(`http://localhost:3000/participantes/${id}`, {
            method: "DELETE"
        })

        if (!resposta.ok) {
            throw new Error("Erro ao excluir participante")
        }

        alert("Participante excluído com sucesso!")

        listarParticipantes()

    } catch (erro) {

        alert("Não foi possível excluir o participante.")

        console.log(erro)

    }

}

// CARREGAR PARTICIPANTES

listarParticipantes()

// LABORATÓRIOS

const formLaboratorio = document.querySelector("#formLaboratorio");
const listaLaboratorios = document.querySelector("#listaLaboratorios");

// Listar laboratórios
async function listarLaboratorios() {

    try {
        const resposta = await fetch("http://localhost:3000/laboratorios");

        if (!resposta.ok) {
            throw new Error("Erro ao buscar laboratórios");
        }

        const laboratorios = await resposta.json();

        listaLaboratorios.innerHTML = "";

        if (laboratorios.length === 0) {
            listaLaboratorios.innerHTML = `
                <tr>
                    <td colspan="4">Nenhum laboratório cadastrado.</td>
                </tr>
            `;
            return;
        }

        laboratorios.forEach(laboratorio => {

            listaLaboratorios.innerHTML += `
                <tr>
                    <td>${laboratorio.nome}</td>
                    <td>${laboratorio.area}</td>
                    <td>${laboratorio.capacidade}</td>
                    <td>${laboratorio.descricao || "Sem descrição"}</td>
                </tr>
            `;

        });

    } catch (erro) {
        console.log("Erro:", erro);
        listaLaboratorios.innerHTML = `
            <tr>
                <td colspan="4">Não foi possível carregar os laboratórios.</td>
            </tr>
        `;
    }
}

// Cadastrar laboratório
formLaboratorio.addEventListener("submit", async (evento) => {

    evento.preventDefault();

    const laboratorio = {
        nome: document.querySelector("#nomeLaboratorio").value,
        area: document.querySelector("#areaLaboratorio").value,
        capacidade: Number(document.querySelector("#capacidadeLaboratorio").value),
        descricao: document.querySelector("#descricaoLaboratorio").value
    };

    try {

        const resposta = await fetch("http://localhost:3000/laboratorios", {
            method: "POST",
            headers: {
                "Content-Type": "application/json"
            },
            body: JSON.stringify(laboratorio)
        });

        if (!resposta.ok) {
            throw new Error("Erro ao cadastrar laboratório");
        }

        alert("Laboratório cadastrado com sucesso!");

        formLaboratorio.reset();

        listarLaboratorios();

    } catch (erro) {
        console.log("Erro:", erro);
        alert("Não foi possível cadastrar. Verifique se o backend está funcionando.");
    }

});

// Carregar laboratórios ao abrir a página
listarLaboratorios();
