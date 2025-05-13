var dir = "http://localhost:54914/api/facultad";
var facultadActual = null;

jQuery(function () {
    $("#dvMenu").load("../Paginas/Menu.html");

    cargarTabla();

    $("#btnAgre").on("click", Agregar);
    $("#btnModi").on("click", Modificar);
    $("#btnBusc").on("click", Buscar);
    $("#btnCanc").on("click", Cancelar);
    $("#btnImpr").on("click", function () {
        alert("Impresión no implementada aún");
    });

    $("#tablaDatos tbody").on("click", ".btn-editar", function () {
        const fila = $(this).closest("tr");
        console.log(fila)
        const codigo = fila.find("td:eq(1)").text();
        console.log(codigo)
        cargarAFomulario(parseInt(codigo));
    });
});

function cargarTabla() {
    fetch(dir)
        .then(res => res.json())
        .then(data => {
            const tabla = $("#tablaDatos tbody");
            tabla.empty();

            data.forEach(fac => {
                tabla.append(`
                    <tr>
                        <td><button type="button" class="btn btn-sm btn-warning btn-editar">✎</button></td>
                        <td>${fac.Codigo}</td>
                        <td>${fac.Nombre}</td>
                        <td>${fac.Activo ? "Sí" : "No"}</td>
                    </tr>
                `);
            });
        })
        .catch(err => mensajeError("Error cargando facultades: " + err));
}

function cargarAFomulario(codigo) {
    fetch(`${dir}/${codigo}`)
        .then(res => res.json())
        .then(response => {
            if (response.Exitoso) {
                const fac = response.Data;
                $("#txtCodigo").val(fac.Codigo).prop("disabled", true);
                $("#txtNombre").val(fac.Nombre);
                $("#chkActivo").prop("checked", fac.Activo);
                facultadActual = fac;
                mensajeInfo("Facultad cargada");
            } else {
                mensajeError(response.Mensaje);
            }
        })
        .catch(err => mensajeError("Error consultando: " + err));
}

function Agregar() {
    const fac = capturarDatosFormulario();
    if (!fac.Nombre) return mensajeError("Nombre es requerido");

    fetch(dir, {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify(fac)
    })
        .then(res => res.json())
        .then(resp => {
            mensajeOk("Facultad agregada correctamente");
            cargarTabla();
            Cancelar();
        })
        .catch(err => mensajeError("Error agregando: " + err));
}

function Modificar() {
    if (!facultadActual) return mensajeError("Primero seleccione una facultad");

    const fac = capturarDatosFormulario();
    fac.Codigo = facultadActual.Codigo;

    fetch(dir, {
        method: "PUT",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify(fac)
    })
        .then(res => res.json())
        .then(resp => {
            mensajeOk("Facultad modificada correctamente");
            cargarTabla();
            Cancelar();
        })
        .catch(err => mensajeError("Error modificando: " + err));
}

function Buscar() {
    const cod = $("#txtCodigo").val();
    if (!cod) return mensajeError("Ingrese un código");
    cargarAFomulario(parseInt(cod));
}

function Cancelar() {
    $("#txtCodigo").val("").prop("disabled", false);
    $("#txtNombre").val("");
    $("#chkActivo").prop("checked", false);
    facultadActual = null;
    mensajeInfo("Formulario limpio");
}

function capturarDatosFormulario() {
    return {
        Codigo: parseInt($("#txtCodigo").val()) || 0,
        Nombre: $("#txtNombre").val(),
        Activo: $("#chkActivo").prop("checked")
    };
}

function mensajeError(texto) {
    $("#dvMensaje").removeClass().addClass("alert alert-danger").html(texto);
}

function mensajeInfo(texto) {
    $("#dvMensaje").removeClass().addClass("alert alert-info").html(texto);
}

function mensajeOk(texto) {
    $("#dvMensaje").removeClass().addClass("alert alert-success").html(texto);
}