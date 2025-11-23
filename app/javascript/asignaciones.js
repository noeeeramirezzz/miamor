document.addEventListener("turbo:load", () => {
    const servicioSelect = document.getElementById("select-servicio");
    const empleadoSelect = document.getElementById("select-empleado");

    if (!servicioSelect) return;

    servicioSelect.addEventListener("change", () => {
        const servicioId = servicioSelect.value;

        fetch(`/servicios/${servicioId}/empleados.json`)
            .then(response => response.json())
            .then(data => {
                empleadoSelect.innerHTML = "<option>Seleccione un empleado</option>";

                data.forEach(empleado => {
                    const option = document.createElement("option");
                    option.value = empleado.id;
                    option.textContent = empleado.nombre;
                    empleadoSelect.appendChild(option);
                });
            });
    });
});
