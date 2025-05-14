var urlFacultad = "http://localhost:54914/api/facultad";
var urlPrograma = "http://localhost:54914/api/programa";

jQuery(function () {
    //Carga el menú
    $("#dvMenu").load("../Paginas/Menu.html");

    cargarFacultades();
    // Cuando cambie el combo de facultades
    $("#cboFacultad").on("change", function () {
        let idFAC = $(this).val();
        if (idFAC) {
            cargarProgramas(idFAC);
        } else {
            $("#cboPrograma").empty().append('<option value="">Seleccione Programa...</option>');
        }
    });

    //Registrar los botones para responder al evento click
    $("#btnAgre").on("click", function () {
        alert("Agregar");
        //Agregar();
    });
    $("#btnModi").on("click", function () {
        alert("Modificar");
        //Modificar();
    });
    $("#btnBusc").on("click", function () {
        alert("Buscar");
        //Consultar();
    });
    $("#btnCanc").on("click", function () {
        mensajeInfo("Formulario limpio");
    });
    $("#btnImpr").on("click", function () {
        alert("Impresión");
        //Imprimir();
    });


});  //Del: jQuery


function mensajeError(texto) {
    $("#dvMensaje").removeClass("alert alert-success");
    $("#dvMensaje").addClass("alert alert-danger");
    $("#dvMensaje").html(texto);
}
function mensajeInfo(texto) {
    $("#dvMensaje").removeClass("alert alert-success");
    $("#dvMensaje").addClass("alert alert-info");
    $("#dvMensaje").html(texto);
}
function mensajeOk(texto) {
    $("#dvMensaje").removeClass("alert alert-success");
    $("#dvMensaje").addClass("alert alert-success");
    $("#dvMensaje").html(texto);
}

function cargarFacultades() {
    fetch(urlFacultad)
        .then(res => res.json())
        .then(data => {
            let combo = $("#cboFacultad");
            combo.empty().append('<option value="">Seleccione Facultad...</option>');

            data.forEach(fac => {
                combo.append(`<option value="${fac.Codigo}">${fac.Nombre}</option>`);
            });
        })
        .catch(err => mensajeError("Error cargando facultades: " + err));
}

function cargarProgramas(idFAC) {
    fetch(`${urlPrograma}/${idFAC}`)
        .then(res => {
            if (!res.ok) throw new Error("Error consultando la API");
            return res.json();
        })
        .then(response => {
            let combo = $("#cboPrograma");
            combo.empty().append('<option value="">Seleccione Programa...</option>');

            // Verificar si hay programas
            if (Array.isArray(response.Data) && response.Data.length > 0) {
                response.Data.forEach(prog => {
                    combo.append(`<option value="${prog.Codigo}">${prog.Nombre}</option>`);
                });
            } else {
                // No hay programas disponibles
                mensajeInfo("No se encontraron programas para esta facultad.");
            }
        })
        .catch(err => {
            $("#cboPrograma").empty().append('<option value="">Seleccione Programa...</option>');
            mensajeError("Error cargando programas: " + err.message);
        });
}


async function ejecutarComando(accion) {
    //Capturar los datos de entrada
    let _vr1 = $("#txtXXX").val();
    let _vr2 = $("#cboXXX").val();
    let _vr3 = $("#txtXXX").val();

    let _vr4 = $("#chkXXX").prop("checked");
    _vr4 = (_vr4 == true) ? 1 : 0;

    //Json es un lenguaje que permite gestionar datos con 
    //formato de estructura: Clave - Valor, y que puede contener 
    //estructuras complejas dentro de sus valores
    //Nombre: Valor
    let datosOut = {
        campo1: _vr1,
        campo2: _vr2,
        campo3: _vr3,
        campo4: _vr4
    }
    //Invocar el servicio con fetch
    try {
        const response = await fetch(dir + "nombre servicio", {
            method: accion,
            headers: {
                "Content-Type": "application/json",
            },
            body: JSON.stringify(datosOut),
        });   // stringify() convierte un objeto o valor de JavaScript en una cadena de texto JSON

        const Respuesta = await response.json();
        MensajeOk(Respuesta);

    } catch (error) {
        MensajeError("Error: ", error);
    }
}