import $ from "jquery";
window.$ = $;

console.log("CONTRATOS.JS CARGADO ✔");

$(document).on("turbo:load", function () {
    console.log("turbo:load en contratos.js");

    // ============================
    // AGREGAR FILA
    // ============================
    $(document).on("click", "#add-detalle", function (e) {   // OJO: id con guion
        e.preventDefault();

        let template = $("#detalle_template").html();
        let newId = Date.now();

        template = template.replace(/NEW_RECORD/g, newId);

        $("#detalle-container").append(template);
    });

    // ============================
    // ELIMINAR FILA
    // ============================
    $(document).on("click", ".remove_fields", function (e) {
        e.preventDefault();
        $(this).closest("tr").remove();
        recalcularTotal();
    });

    // ============================
    // CAMBIAR SERVICIO → AUTOCOMPLETAR PRECIO (sin AJAX)
    $(document).on("change", ".servicio-select", function () {
        let select = $(this);
        let row    = select.closest("tr");

        let prices = JSON.parse(select.attr("data-prices"));
        let servicioId = select.val();
        let precio = prices[servicioId] || 0;

        row.find(".precio-input").val(precio);

        let cantidad = parseFloat(row.find(".cantidad-input").val()) || 1;
        row.find(".subtotal-input").val(precio * cantidad);

        recalcularTotal();
    });


    // ============================
    // CAMBIOS EN CANTIDAD O PRECIO
    // ============================
    $(document).on("input", ".cantidad-input, .precio-input", function () {
        actualizarSubtotal($(this).closest("tr"));
        recalcularTotal();
    });

    // ============================
    // FUNCIONES
    // ============================
    function actualizarSubtotal(row) {
        let cantidad = parseFloat(row.find(".cantidad-input").val()) || 0;
        let precio   = parseFloat(row.find(".precio-input").val()) || 0;

        row.find(".subtotal-input").val((cantidad * precio).toFixed(0));
    }

    function recalcularTotal() {
        let total = 0;

        $(".subtotal-input").each(function () {
            total += parseFloat($(this).val()) || 0;
        });

        $("#contrato_monto_total").val(total);
    }
});
