const API_URL = "http://localhost:3000";

async function cargarGrupos() {
  const respuesta = await fetch(`${API_URL}/grupos`);
  const grupos = await respuesta.json();
  pintarGrupos(grupos);
}

function pintarGrupos(grupos) {
  const contenedor = document.getElementById("tabla-grupos");
  contenedor.innerHTML = "";
  grupos.forEach(grupo => {
    contenedor.innerHTML += `
      <tr>
        <td>${grupo.codigo_materia}</td>
        <td>${grupo.nombre_materia}</td>
        <td>${grupo.horario}</td>
      </tr>
    `;
  });
}

async function guardarCalificacion(idMatricula, nota) {
  const nuevaCalificacion = { id_matricula: idMatricula, nota: nota };

  const respuesta = await fetch(`${API_URL}/calificaciones`, {
    method: "POST",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify(nuevaCalificacion)
  });

  const resultado = await respuesta.json();
  console.log("Guardado:", resultado);
}

cargarGrupos(); 


const botonListarEstudiantes = document.getElementById("btn-listar-estudiantes");
botonListarEstudiantes.addEventListener("click", async () => {
  const respuesta = await fetch(`${API_URL}/estudiantes`);
  const estudiantes = await respuesta.json();
  pintarEstudiantes(estudiantes);
});


const btnAjustes = document.querySelector("#btn-Ajustes");
const salirAjustes = document.querySelector("#btn-SalirAjustes");
const modal = document.querySelector("#modal-ajustes");

btnAjustes.addEventListener("click", () => {
  modal.showModal();
});

salirAjustes.addEventListener("click", () => {
  modal.close();
});



