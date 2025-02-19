// Función global para registrar eventos en la bitácora (modo local)
function registrarEvento(usuario, accion, descripcion = '') {
    const evento = {
        fecha: new Date().toISOString(),
        usuario: usuario,
        accion: accion,
        descripcion: descripcion
    };

    // Simulación sin servidor
    console.log('Evento registrado localmente:', evento);
    mostrarEventoEnPantalla(evento);
}

// Mostrar eventos en tiempo real en la interfaz
function mostrarEventoEnPantalla(evento) {
    const logContainer = document.getElementById('logEventos');
    if (!logContainer) {
        console.warn('No se encontró el contenedor de eventos en el DOM');
        return;
    }
    const logEntry = document.createElement('div');
    logEntry.className = 'log-entry';
    logEntry.innerHTML = `<strong>${evento.fecha}</strong> - ${evento.usuario}: ${evento.accion} - ${evento.descripcion}`;
    logContainer.prepend(logEntry);
}

// Integración con la estructura existente
const usuarioActual = sessionStorage.getItem('usuario') || 'Desconocido';

// Agregar las funciones dentro de la tabla bitácora
const bitacoraTable = document.getElementById('bitacoraTable');
bitacoraTable?.addEventListener('click', (event) => {
    const fila = event.target.closest('tr');
    if (fila && event.target.classList.contains('btn-agregar')) {
        const usuario = fila.cells[1].innerText;
        const accion = 'Agregado';
        const descripcion = `Se agregó un evento para el usuario ${usuario}`;
        registrarEvento(usuarioActual, accion, descripcion);
    } else if (event.target.classList.contains('btn-bloquear')) {
        const usuario = fila.cells[1].innerText;
        registrarBloqueo(usuario);
    } else if (event.target.classList.contains('btn-modificar')) {
        const usuario = fila.cells[1].innerText;
        registrarModificacion(`Se modificó el registro de ${usuario}`);
    } else if (event.target.classList.contains('btn-cambiar-pass')) {
        registrarCambioContrasena();
    }
});

// Registrar eventos al cambiar contraseña, bloquear o modificar
function registrarCambioContrasena() {
    registrarEvento(usuarioActual, 'Cambio de contraseña', 'El usuario cambió su contraseña.');
}

function registrarBloqueo(usuarioBloqueado) {
    registrarEvento(usuarioActual, 'Bloqueo', `El usuario ${usuarioBloqueado} fue bloqueado.`);
}

function registrarModificacion(descripcion) {
    registrarEvento(usuarioActual, 'Modificación', descripcion);
}

// Llamadas de ejemplo
registrarCambioContrasena();
registrarBloqueo('Juan Pérez');
registrarModificacion('Se modificó el perfil de Ana García.');

// Agregar botones al HTML dentro de la tabla
const filas = document.querySelectorAll('#bitacoraTable tbody tr');
filas.forEach(fila => {
    const celdaAcciones = fila.querySelector('td:last-child');
    celdaAcciones.innerHTML = `
        <button class="btn-agregar">Agregar</button>
        <button class="btn-bloquear">Bloquear</button>
        <button class="btn-modificar">Modificar</button>
        <button class="btn-cambiar-pass">Cambiar Contraseña</button>
    `;
});

// Agregar el contenedor para ver eventos en tiempo real
document.body.insertAdjacentHTML('beforeend', '<div id="logEventos" class="event-log"></div>');

// Estilos para el log de eventos
document.head.insertAdjacentHTML('beforeend', `
<style>
    .event-log {
        max-height: 300px;
        overflow-y: auto;
        border: 1px solid #ccc;
        padding: 10px;
        margin-top: 20px;
        background-color: #f0f0f0;
    }
    .log-entry {
        border-bottom: 1px solid #ddd;
        padding: 5px 0;
    }
    .btn-agregar, .btn-bloquear, .btn-modificar, .btn-cambiar-pass {
        margin: 3px;
        padding: 5px;
        border: none;
        border-radius: 5px;
        cursor: pointer;
    }
    .btn-agregar { background-color: #4CAF50; color: white; }
    .btn-bloquear { background-color: #FF5722; color: white; }
    .btn-modificar { background-color: #2196F3; color: white; }
    .btn-cambiar-pass { background-color: #FFC107; color: black; }
</style>
`);