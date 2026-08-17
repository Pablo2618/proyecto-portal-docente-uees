// URL base de la API simulada (json-server corriendo en la terminal, puerto 3000)
const API_URL = "http://localhost:3000";

// Trae la lista de grupos desde la API y los manda a pintar en la tabla
async function cargarGrupos() {
  // Petición GET a /grupos, esperando (await) a que responda
  const respuesta = await fetch(`${API_URL}/grupos`);

  // Convierte el cuerpo de la respuesta (texto) a un array de JavaScript
  const grupos = await respuesta.json();

  // Le pasa los datos ya convertidos a la función que dibuja la tabla
  pintarGrupos(grupos);
}

// Recibe un array de grupos y genera las filas <tr> dentro de la tabla
function pintarGrupos(grupos) {
  // Busca el <tbody id="tabla-grupos"> donde van a ir las filas
  const contenedor = document.getElementById("tabla-grupos");

  // Limpia el contenido anterior, para evitar filas duplicadas
  contenedor.innerHTML = "";

  // Recorre cada grupo del array y arma su fila correspondiente
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

// Envía una nueva calificación a la API mediante una petición POST
async function guardarCalificacion(idMatricula, nota) {
  // Arma el objeto con la forma exacta que espera la API
  const nuevaCalificacion = { id_matricula: idMatricula, nota: nota };

  // Petición POST a /calificaciones, enviando el objeto como JSON
  const respuesta = await fetch(`${API_URL}/calificaciones`, {
    method: "POST",
    headers: { "Content-Type": "application/json" }, // le avisa al servidor que el body es JSON
    body: JSON.stringify(nuevaCalificacion) // convierte el objeto a texto JSON
  });

  // Convierte la respuesta del servidor de vuelta a un objeto de JavaScript
  const resultado = await respuesta.json();

  // Muestra en la consola del navegador el resultado, solo para verificar
  console.log("Guardado:", resultado);
}

// Llama a cargarGrupos() apenas se carga el script, para mostrar los grupos automáticamente
cargarGrupos();


// Busca el botón "Listar Estudiantes" por su id
const botonListarEstudiantes = document.getElementById("btn-ListarEstudiantes");

// Le agrega un evento: cuando el usuario hace clic, pide los estudiantes y los pinta
botonListarEstudiantes.addEventListener("click", async () => {
  // Petición GET a /estudiantes
  const respuesta = await fetch(`${API_URL}/estudiantes`);

  // Convierte la respuesta a un array de JavaScript
  const estudiantes = await respuesta.json();

  // Dibuja los estudiantes en su tabla correspondiente
  pintarEstudiantes(estudiantes);
});
