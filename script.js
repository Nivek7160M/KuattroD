document.getElementById('togglePassword').addEventListener('click', function() {
    const passwordInput = document.getElementById('password');
    
    // Comprobar si el tipo del input es 'password' o 'text'
    if (passwordInput.type === 'password') {
        passwordInput.type = 'text';
        // Cambiar la imagen del candado a uno abierto (opcional)
        this.style.backgroundImage = "url('public/imagenes/candado-abierto.png')"; // Cambia a la imagen de candado abierto
    } else {
        passwordInput.type = 'password';
        // Cambiar la imagen del candado a uno cerrado (opcional)
        this.style.backgroundImage = "url('public/imagenes/candado-abierto.png')"; // Cambia a la imagen de candado cerrado
    }
});