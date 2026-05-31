  <%@ Page Title="" Language="C#" MasterPageFile="~/HomeMaster.Master" AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs" Inherits="CapaPresentacion.Dashboard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <style>
        .section-title {
            font-weight: 700;
            color: #1f2937;
        }

        .recommend-box {
            background: #eff6ff;
            border-left: 5px solid #2563eb;
            border-radius: 10px;
            padding: 18px;
        }

        .modelo-simulacion {
            background: #fff;
            border-radius: 16px;
            padding: 20px;
            box-shadow: 0 6px 18px rgba(0,0,0,0.06);
        }

        .zona-simulacion {
            min-height: 230px;
            overflow: hidden;
            background: #f9fafb;
            border: 2px dashed #d1d5db;
            border-radius: 14px;
            padding: 15px;
        }

        .titulo-zona {
            font-weight: 700;
            color: #374151;
            margin-bottom: 12px;
        }

        .cajero-box {
            background: #f3f4f6;
            border-radius: 12px;
            padding: 15px;
            margin-bottom: 10px;
            border-left: 5px solid #16a34a;
            transition: all .3s ease;
        }

        .cajero-atendiendo {
            background: #fee2e2 !important;
            border-left: 5px solid #dc2626 !important;
            transform: scale(1.02);
        }

        .cajero-disponible {
            background: #dcfce7 !important;
            border-left: 5px solid #16a34a !important;
        }

        .cliente-animado {
            display: inline-flex;
            width: 42px;
            height: 42px;
            border-radius: 50%;
            background: #2563eb;
            color: white;
            align-items: center;
            justify-content: center;
            margin: 6px;
            font-size: 18px;
            animation: aparecerCliente .4s ease-in-out;
        }

        .cliente-atendido {
            background: #16a34a;
        }

        .cliente-no-atendido {
            background: #dc2626;
        }

        .cliente-volando {
            position: fixed;
            z-index: 9999;
            width: 42px;
            height: 42px;
            border-radius: 50%;
            background: #2563eb;
            color: white;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 18px;
            transition: all .8s ease-in-out;
            pointer-events: none;
        }

        .estado-simulacion {
            font-size: 14px;
            font-weight: 600;
            padding: 10px 14px;
            border-radius: 10px;
            background: #eff6ff;
            color: #1d4ed8;
            margin-bottom: 12px;
        }

        .resumen-item {
            background: #f9fafb;
            border-radius: 12px;
            padding: 16px;
            margin-bottom: 12px;
            border-left: 5px solid #2563eb;
        }

            .resumen-item strong {
                color: #374151;
            }

        .resumen-numero {
            font-size: 24px;
            font-weight: 700;
            color: #111827;
            float: right;
        }

        .resumen-atendido {
            border-left-color: #16a34a;
        }

        .resumen-no-atendido {
            border-left-color: #dc2626;
        }

        .resumen-cola {
            border-left-color: #f59e0b;
        }

        @keyframes aparecerCliente {
            from {
                opacity: 0;
                transform: scale(0.4);
            }

            to {
                opacity: 1;
                transform: scale(1);
            }
        }
        .banco-mapa {
    background: linear-gradient(135deg, #f8fafc, #eef2ff);
    border: 2px solid #dbeafe;
    border-radius: 18px;
    padding: 20px;
    position: relative;
}

.banco-zona {
    min-height: 260px;
    background: #ffffff;
    border-radius: 16px;
    padding: 16px;
    border: 1px solid #e5e7eb;
    box-shadow: 0 4px 12px rgba(0,0,0,0.05);
}

.banco-zona-titulo {
    font-weight: 700;
    color: #1f2937;
    margin-bottom: 12px;
    border-bottom: 1px solid #e5e7eb;
    padding-bottom: 8px;
}

.zona-entrada {
    border-left: 5px solid #2563eb;
}

.zona-fila {
    border-left: 5px solid #f59e0b;
}

.zona-cajeros {
    border-left: 5px solid #16a34a;
}

.zona-salida {
    border-left: 5px solid #6366f1;
}

.flecha-flujo {
    text-align: center;
    font-size: 28px;
    color: #2563eb;
    margin-top: 85px;
}
.contenedor-cola {
    display: flex;
    flex-direction: column;
    gap: 6px;
    max-height: 300px;
    overflow-y: auto;
    padding-right: 6px;
}

.cliente-fila {
    display: flex;
    align-items: center;
    gap: 6px;
    background: #dbeafe;
    border-left: 4px solid #2563eb;
    padding: 5px 8px;
    border-radius: 8px;
    color: #1e3a8a;
    font-weight: 600;
    font-size: 12px;
    animation: aparecerCliente .4s ease;
}

.cliente-fila i {
    color: #2563eb;
}

        .cliente-persona {
            width: 46px;
            height: 46px;
            border-radius: 50%;
            background: #2563eb;
            color: white;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            font-size: 20px;
            box-shadow: 0 6px 12px rgba(37,99,235,0.25);
        }
    .cliente-normal {
    background: #2563eb;
}

.cliente-vip {
    background: #7c3aed;
}

.cliente-tercera {
    background: #f97316;
}

.cliente-atendido-icono {
    background: #16a34a;
}


.cliente-persona.verde {
    background: #16a34a;
    box-shadow: 0 6px 12px rgba(22,163,74,0.25);
}

.cliente-persona.rojo {
    background: #dc2626;
    box-shadow: 0 6px 12px rgba(220,38,38,0.25);
}

.cliente-caminando {
    position: absolute;
    z-index: 9999;
    transition: all .9s ease-in-out;
    pointer-events: none;
}

.punto-zona {
    position: relative;
    min-height: 40px;
}
.cliente-vip {
    background: #7c3aed !important;
    color: white !important;
    border-left-color: #7c3aed !important;
}
.cliente-vip {
    background: #ede9fe !important;
    border-left-color: #7c3aed !important;
    color: #4c1d95 !important;
}

.cliente-vip i {
    color: #7c3aed !important;
}

.cliente-tercera {
    background: #ffedd5 !important;
    border-left-color: #f97316 !important;
    color: #9a3412 !important;
}

.cliente-tercera i {
    color: #f97316 !important;
}

.badge-vip {
    background: #7c3aed;
    color: white;
    padding: 3px 7px;
    border-radius: 8px;
    font-size: 11px;
    font-weight: 700;
}

.badge-tercera {
    background: #f97316;
    color: white;
    padding: 3px 7px;
    border-radius: 8px;
    font-size: 11px;
    font-weight: 700;
}
.salida-resumen {
    background: #dcfce7;
    color: #166534;
    border-radius: 14px;
    padding: 14px;
    text-align: center;
    font-weight: 700;
}

.salida-numero {
    font-size: 34px;
    font-weight: 800;
    display: block;
}

.salida-icono {
    font-size: 28px;
    margin-bottom: 6px;
}
.kpi-panel {
    display: grid;
    grid-template-columns: repeat(7, 1fr);
    gap: 12px;
    margin-top: 15px;
}

.kpi-box {
    background: #ffffff;
    border-radius: 14px;
    padding: 12px;
    text-align: center;
    box-shadow: 0 4px 12px rgba(0,0,0,0.06);
    font-weight: 700;
}

.kpi-box span {
    display: block;
    font-size: 26px;
    color: #111827;
}

.kpi-label {
    font-size: 12px;
    color: #6b7280;
}

.validacion-modelo {
    margin-top: 15px;
    border-radius: 12px;
    padding: 12px 15px;
    font-weight: 700;
}

.validacion-ok {
    background: #dcfce7;
    color: #166534;
    border-left: 5px solid #16a34a;
}

.validacion-error {
    background: #fee2e2;
    color: #991b1b;
    border-left: 5px solid #dc2626;
}

#panelSimulacion {
    min-height: 650px;
}
.conclusion-gerencial {
    background: #f8fafc;
    border-left: 5px solid #0ea5e9;
    border-radius: 10px;
    padding: 18px;
}
    </style>

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">


    <div id="panelValidacionModelo" class="validacion-modelo validacion-ok">
    <i class="fas fa-check-circle"></i>
    Modelo pendiente de validación.
</div>
        <!-- CONFIGURACIÓN Y RESUMEN -->
    <div class="row">
        <div class="col-md-5 mb-4">

            <div class="card">

                <div class="card-header">
                    <i class="fas fa-sliders-h"></i>
                    Escenario Seleccionado
       
                </div>

                <div class="card-body">

                    <div class="form-group">
                        <label>Escenario</label>
                        <asp:DropDownList ID="cboEscenario" runat="server"
                            CssClass="form-control"
                            AutoPostBack="true"
                            OnSelectedIndexChanged="cboEscenario_SelectedIndexChanged">
                        </asp:DropDownList>
                    </div>

                    <h5 class="mb-3">
                        <asp:Label ID="lblEscenarioActual" runat="server" Text="Sin escenario"></asp:Label>
                    </h5>

                    <div style="display: none;">
                        <asp:TextBox ID="txtCantidadClientes" runat="server" Text="0"></asp:TextBox>
                        <asp:TextBox ID="txtCantidadCajeros" runat="server" Text="0"></asp:TextBox>
                        <asp:TextBox ID="txtTiempoLlegada" runat="server" Text="0"></asp:TextBox>
                        <asp:TextBox ID="txtHoraInicio" runat="server"></asp:TextBox>
                        <asp:TextBox ID="txtHoraFin" runat="server"></asp:TextBox>
                        <asp:Label ID="lblClientesAtendidos" runat="server" Text="0"></asp:Label>
                        <asp:Label ID="lblClientesNoAtendidos" runat="server" Text="0"></asp:Label>
                        <asp:Label ID="lblClientesCola" runat="server" Text="0"></asp:Label>
                    </div>

                   

                    <asp:Button ID="btnEjecutar" runat="server"
                        Text="Ejecutar Simulación"
                        CssClass="btn btn-primary btn-block mt-3"
                        OnClick="btnEjecutar_Click" />

                </div>

            </div>

        </div>
                <div class="col-md-7 mb-4">
            <div class="recommend-box">
                <h5 class="section-title">
                    <i class="fas fa-lightbulb text-primary"></i>
                    Recomendación Organizacional
                </h5>

                <p class="mb-0">
                    <asp:Label ID="lblRecomendacion" runat="server" Text="Ejecute una simulación para generar una recomendación sobre la cantidad adecuada de cajeros."></asp:Label>
                </p>
            </div>
        </div>
    <%--        <div class="col-md-12 mb-4">
    <div class="conclusion-gerencial">
        <h5 class="section-title">
            <i class="fas fa-chart-line text-primary"></i>
            Conclusión Gerencial del Escenario
        </h5>

        <p id="lblConclusionGerencial" class="mb-0">
            Ejecute una simulación para generar una conclusión gerencial del escenario.
        </p>
    </div>
</div>--%>



    </div>
        <div class="page-title">
        <h4>Dashboard de Simulación</h4>
        <asp:HiddenField ID="hdnTotalClientesAnimacion" runat="server" Value="0" />
        <asp:HiddenField ID="hdnTotalCajerosAnimacion" runat="server" Value="0" />
        <asp:HiddenField ID="hdnClientesAtendidosAnimacion" runat="server" Value="0" />
        <asp:HiddenField ID="hdnClientesNoAtendidosAnimacion" runat="server" Value="0" />
        <p>Panel principal para ejecutar escenarios de atención bancaria y analizar resultados.</p>
    </div>
        <div class="kpi-panel">
    <div class="kpi-box">
        <span id="kpiAtendidos">0</span>
        <div class="kpi-label">Atendidos</div>
    </div>

    <div class="kpi-box">
        <span id="kpiNoAtendidos">0</span>
        <div class="kpi-label">No atendidos</div>
    </div>

    <div class="kpi-box">
        <span id="kpiCola">0</span>
        <div class="kpi-label">En cola</div>
    </div>

    <div class="kpi-box">
        <span id="kpiCajerosOcupados">0</span>
        <div class="kpi-label">Cajeros ocupados</div>
    </div>

    <div class="kpi-box">
        <span id="kpiEficiencia">0%</span>
        <div class="kpi-label">Eficiencia</div>
    </div>
            <div class="kpi-box">
    <span id="kpiEsperaPromedio">0s</span>
    <div class="kpi-label">Espera promedio</div>
</div>

<div class="kpi-box">
    <span id="kpiUtilizacionCajeros">0%</span>
    <div class="kpi-label">Utilización cajeros</div>
</div>
</div>
    <!-- MODELO VISUAL DE SIMULACIÓN TIPO BANCO -->
<div class="row mb-4">
    <div class="col-md-12">

        <div class="modelo-simulacion">

            <div class="d-flex justify-content-between align-items-center mb-3">
                <div>
                    <h5 class="section-title mb-0">
                        <i class="fas fa-university text-primary"></i>
                        Modelo Visual del Banco
                    </h5>
                    <small class="text-muted">
                        Representación del flujo: entrada, fila de espera, cajeros y salida del cliente.
                    </small>
                </div>

                <div>
                    <button type="button" class="btn btn-success btn-sm" onclick="iniciarSimulacionVisual()">
                        <i class="fas fa-play"></i> Iniciar Animación
                    </button>

                    <button type="button" class="btn btn-danger btn-sm" onclick="detenerSimulacionVisual()">
                        <i class="fas fa-stop"></i> Detener
                    </button>

                    <button type="button" class="btn btn-secondary btn-sm" onclick="reiniciarSimulacionVisual()">
                        <i class="fas fa-redo"></i> Reiniciar
                    </button>
                </div>
            </div>

            <div class="banco-mapa">

                <div class="row">

                    <div class="col-md-2 mb-3">
                        <div class="banco-zona zona-entrada">
                            <div class="banco-zona-titulo">
                                <i class="fas fa-door-open text-primary"></i>
                                Entrada
                            </div>

                            <div id="zonaEntrada" class="punto-zona">
    <span class="text-muted">Clientes ingresan</span>
</div>
                        </div>
                    </div>

                    <div class="col-md-1 d-none d-md-block">
                        <div class="flecha-flujo">
                            <i class="fas fa-arrow-right"></i>
                        </div>
                    </div>

                    <div class="col-md-3 mb-3">
                        <div class="banco-zona zona-fila">
                            <div class="banco-zona-titulo">
                                <i class="fas fa-users text-warning"></i>
                                Fila de espera
                            </div>
                            <div id="puntoFila"></div>
                            <asp:Panel ID="pnlClientesCola" runat="server">
                                <span class="text-muted">Sin simulación</span>
                            </asp:Panel>
                        </div>
                    </div>

                    <div class="col-md-1 d-none d-md-block">
                        <div class="flecha-flujo">
                            <i class="fas fa-arrow-right"></i>
                        </div>
                    </div>

                    <div class="col-md-3 mb-3">
                        <div class="banco-zona zona-cajeros">
                            <div class="banco-zona-titulo">
                                <i class="fas fa-user-tie text-success"></i>
                                Cajeros
                            </div>
                            <div id="puntoCajero"></div>
                            <asp:Panel ID="pnlCajerosVisual" runat="server">
                                <span class="text-muted">Sin cajeros asignados</span>
                            </asp:Panel>
                        </div>
                    </div>

                    <div class="col-md-1 d-none d-md-block">
                        <div class="flecha-flujo">
                            <i class="fas fa-arrow-right"></i>
                        </div>
                    </div>

                    <div class="col-md-2 mb-3">
                        <div class="banco-zona zona-salida">
                            <div class="banco-zona-titulo">
                                <i class="fas fa-sign-out-alt text-info"></i>
                                Salida
                            </div>
                            <div id="puntoSalida"></div>
                            <asp:Panel ID="pnlClientesAtendidos" runat="server">
                                <span class="text-muted">Sin atención</span>
                            </asp:Panel>
                        </div>
                    </div>

                </div>

                <div class="estado-simulacion">
                    <div class="mt-2">

    <span class="badge badge-success mr-2">
        Atendidos:
        <span id="contadorAtendidos">0</span>
    </span>

    <span class="badge badge-danger mr-2">
        No atendidos:
        <span id="contadorNoAtendidos">0</span>
    </span>

    <span class="badge badge-warning">
        En cola:
        <span id="contadorCola">0</span>
    </span>

</div>
                    <i class="fas fa-info-circle"></i>
                    <span id="lblEstadoAnimacion">Esperando inicio de animación...</span>
                </div>

            </div>

        </div>

    </div>
  
</div>




    <!-- RECOMENDACIÓN -->
    <div class="row">


    </div>
 
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="footer" runat="server">

<script>
    var clienteActual = 1;
    var totalClientesVisual = 0;
    var totalCajerosVisual = 0;
    var totalNoAtendidosVisual = 0;
    var colaClientes = [];
    var intervaloLlegadas = null;
    var intervaloAtencion = null;
    var cajerosOcupados = [];
    var simulacionDetenida = false;
    var totalAtendidosSalida = 0;
    var clientesSimulados = [];
    var totalTiempoEspera = 0;
    var totalClientesConEspera = 0;
    var tiempoOcupadoCajeros = [];
    var horaInicioSimulacion = null;

    function generarConclusionGerencial(esperaPromedio, utilizacionPromedio, enCola) {

        var conclusion = document.getElementById("lblConclusionGerencial");

        if (!conclusion) return;

        var esperaSegundos = esperaPromedio / 1000;

        if (totalAtendidosSalida === 0) {
            conclusion.innerText =
                "Aún no existen datos suficientes para emitir una conclusión gerencial.";
            return;
        }

        if (utilizacionPromedio >= 85 && enCola >= 10) {
            conclusion.innerText =
                "El escenario presenta alta saturación operativa. La demanda supera la capacidad actual de atención, por lo que se recomienda aumentar la cantidad de cajeros o redistribuir recursos.";
        }
        else if (esperaSegundos >= 6) {
            conclusion.innerText =
                "El escenario muestra tiempos de espera considerables. Se recomienda revisar la asignación de cajeros y reforzar la atención en horarios de mayor demanda.";
        }
        else if (utilizacionPromedio < 40) {
            conclusion.innerText =
                "El escenario presenta baja utilización de cajeros. Existe capacidad ociosa, por lo que se podría optimizar la asignación del personal.";
        }
        else {
            conclusion.innerText =
                "El escenario mantiene un funcionamiento estable, con una relación adecuada entre demanda, cantidad de cajeros y tiempo de atención.";
        }
    }
    function validarModelo() {
        var atendidos = totalAtendidosSalida;
        var noAtendidos = document.querySelectorAll(".cliente-no-atendido").length;
        var enCola = document.querySelectorAll("#contenedorCola .cliente-fila").length;

        var enAtencion = 0;

        for (var i = 0; i < cajerosOcupados.length; i++) {
            if (cajerosOcupados[i] === true) {
                enAtencion++;
            }
        }

        var totalCalculado = atendidos + noAtendidos + enCola + enAtencion;

        var panel = document.getElementById("panelValidacionModelo");

        if (!panel) return;

        if (totalCalculado === totalClientesVisual) {
            panel.className = "validacion-modelo validacion-ok";
            panel.innerHTML =
                "<i class='fas fa-check-circle'></i> Modelo válido: " +
                totalClientesVisual + " clientes = " +
                atendidos + " atendidos + " +
                noAtendidos + " no atendidos + " +
                enCola + " en cola + " +
                enAtencion + " en atención.";
        } else {
            panel.className = "validacion-modelo validacion-error";
            panel.innerHTML =
                "<i class='fas fa-exclamation-triangle'></i> Modelo en proceso: " +
                totalClientesVisual + " clientes esperados / " +
                totalCalculado + " contabilizados actualmente.";
        }
    }
    function generarOperacionBancaria() {
        var operaciones = [
            {
                nombre: "Depósito",
                min: 2000,
                max: 4000
            },
            {
                nombre: "Retiro",
                min: 3000,
                max: 5000
            },
            {
                nombre: "Pago de servicios",
                min: 2000,
                max: 3000
            },
            {
                nombre: "Transferencia",
                min: 4000,
                max: 7000
            },
            {
                nombre: "Apertura de cuenta",
                min: 8000,
                max: 12000
            },
            {
                nombre: "Crédito",
                min: 10000,
                max: 15000
            }
        ];

        var operacion = operaciones[Math.floor(Math.random() * operaciones.length)];

        var tiempo = Math.floor(Math.random() * (operacion.max - operacion.min + 1)) + operacion.min;

        return {
            nombre: operacion.nombre,
            tiempoAtencion: tiempo
        };
    }
    function iniciarSimulacionVisual() {
        reiniciarSimulacionVisual();

        totalClientesVisual = parseInt(document.getElementById('<%= lblClientesAtendidos.ClientID %>').innerText) || 0;
    totalCajerosVisual = parseInt(document.getElementById('<%= txtCantidadCajeros.ClientID %>').value) || 0;
    totalNoAtendidosVisual = parseInt(document.getElementById('<%= lblClientesNoAtendidos.ClientID %>').innerText) || 0;

        if (totalClientesVisual <= 0 || totalCajerosVisual <= 0) {
            alert("Primero debe ejecutar una simulación con clientes atendidos.");
            return;
        }

        simulacionDetenida = false;
        clienteActual = 1;
        colaClientes = [];
        cajerosOcupados = new Array(totalCajerosVisual).fill(false);
        tiempoOcupadoCajeros = new Array(totalCajerosVisual).fill(0);
        horaInicioSimulacion = new Date();
        clientesSimulados = [];

        crearCajerosVisuales();
        cambiarEstadoAnimacion("Simulación iniciada. Los clientes ingresan y esperan turno.");

        iniciarLlegadasClientes();
        iniciarAtencionCajeros();
    }

    function generarTipoCliente() {
        var r = Math.random();

        if (r < 0.15) {
            return {
                tipo: "VIP",
                prioridad: 1,
                clase: "cliente-vip",
                badge: "<span class='badge-vip'>VIP</span>"
            };
        }

        if (r < 0.35) {
            return {
                tipo: "TERCERA_EDAD",
                prioridad: 2,
                clase: "cliente-tercera",
                badge: "<span class='badge-tercera'>3RA EDAD</span>"
            };
        }

        return {
            tipo: "NORMAL",
            prioridad: 3,
            clase: "",
            badge: ""
        };
    }

    function iniciarLlegadasClientes() {
        function llegada() {
            if (simulacionDetenida) return;

            if (clienteActual > totalClientesVisual) return;

            var numeroCliente = clienteActual;
            clienteActual++;

            agregarClienteACola(numeroCliente);

            var tiempoLlegada = generarTiempoLlegadaPoisson();
            intervaloLlegadas = setTimeout(llegada, tiempoLlegada);
        }

        llegada();
    }

    function iniciarAtencionCajeros() {
        intervaloAtencion = setInterval(function () {
            if (simulacionDetenida) return;
            if (colaClientes.length === 0) return;

            for (var i = 1; i <= totalCajerosVisual; i++) {
                if (colaClientes.length === 0) break;

                if (cajerosOcupados[i - 1] === false) {
                    cajerosOcupados[i - 1] = true;

                    var clienteSeleccionado = obtenerClientePrioritario();

                    if (clienteSeleccionado == null) {
                        cajerosOcupados[i - 1] = false;
                        return;
                    }

                    moverClienteACajero(clienteSeleccionado.numero, i, function (numeroCajero) {
                        cajerosOcupados[numeroCajero - 1] = false;

                        if (clienteActual > totalClientesVisual && colaClientes.length === 0 && todosCajerosLibres()) {
                            finalizarSimulacionVisual();
                        }
                    });
                }
            }

        }, 700);
    }
    function todosCajerosLibres() {
        for (var i = 0; i < cajerosOcupados.length; i++) {
            if (cajerosOcupados[i] === true) {
                return false;
            }
        }

        return true;
    }
    function obtenerClientePrioritario() {
        if (colaClientes.length === 0) return null;

        var indiceSeleccionado = 0;
        var mejorPrioridad = colaClientes[0].prioridad;

        for (var i = 1; i < colaClientes.length; i++) {
            if (colaClientes[i].prioridad < mejorPrioridad) {
                mejorPrioridad = colaClientes[i].prioridad;
                indiceSeleccionado = i;
            }
        }

        return colaClientes[indiceSeleccionado];
    }

    function agregarClienteACola(numero) {
        var zonaEntrada = document.getElementById("zonaEntrada");
        var zonaCola = document.getElementById('<%= pnlClientesCola.ClientID %>');
        var tipoCliente = generarTipoCliente();
        var operacion = generarOperacionBancaria();

        zonaEntrada.innerHTML = `<small class="text-primary">Cliente ${numero} ingresando...</small>`;

        var cliente = crearClienteCaminando(
            numero,
            tipoCliente.clase
        );
       

        moverElementoA(cliente, "zonaEntrada", 20, 35, function () {
            moverElementoA(cliente, "puntoFila", 20, 20, function () {
                cliente.remove();

                zonaEntrada.innerHTML = `<span class="text-muted">Clientes ingresan</span>`;

                if (!document.getElementById("contenedorCola")) {
                    zonaCola.innerHTML = `<div id="contenedorCola" class="contenedor-cola"></div>`;
                }

                var nuevoCliente = {
                    numero: numero,
                    tipo: tipoCliente.tipo,
                    prioridad: tipoCliente.prioridad,
                    clase: tipoCliente.clase,
                    badge: tipoCliente.badge,
                    operacion: operacion.nombre,
                    tiempoAtencion: operacion.tiempoAtencion,
                    horaLlegada: new Date()
                };

                colaClientes.push(nuevoCliente);
                clientesSimulados.push(nuevoCliente);

                dibujarColaClientes();

                cambiarEstadoAnimacion(
                    "Cliente " + numero + " (" + tipoCliente.tipo + ") ingresó a la sala de espera."
                );
            });
        });
    }

    function dibujarColaClientes() {
        var contenedor = document.getElementById("contenedorCola");
        if (!contenedor) return;

        contenedor.innerHTML = "";

        colaClientes.forEach(function (cliente) {
            contenedor.innerHTML += `
                <div id="cliente_${cliente.numero}" class="cliente-fila ${cliente.clase}">
                    <i class="fas fa-user"></i>
                   <span>
    Cliente ${cliente.numero}
    <small class="d-block">
        ${cliente.operacion}
    </small>
</span>
${cliente.badge}
                </div>
            `;
        });

        actualizarContadores();
    }

    function removerClienteDeCola(numero) {
        colaClientes = colaClientes.filter(function (cliente) {
            return cliente.numero != numero;
        });

        dibujarColaClientes();
    }

    function moverClienteACajero(numero, cajeroNumero, callback) {
        var clienteFila = document.getElementById("cliente_" + numero);

        if (!clienteFila) {
            if (callback) callback(cajeroNumero);
            return;
        }

        var cajero = document.getElementById("cajeroVisual_" + cajeroNumero);

        if (!cajero) {
            if (callback) callback(cajeroNumero);
            return;
        }

        var clienteData = obtenerDatosCliente(numero);

        var tiempoAtencion = clienteData
            ? clienteData.tiempoAtencion
            : generarTiempoAtencionAleatorio();
        tiempoOcupadoCajeros[cajeroNumero - 1] += tiempoAtencion;

        var operacionCliente = clienteData && clienteData.operacion
            ? clienteData.operacion
            : "Operación bancaria";
        if (clienteData && clienteData.horaLlegada) {
            var esperaMs = new Date() - clienteData.horaLlegada;
            totalTiempoEspera += esperaMs;
            totalClientesConEspera++;
        }

        cambiarEstadoAnimacion("Cliente " + numero + " avanza al cajero " + cajeroNumero + ".");

        var rectCliente = clienteFila.getBoundingClientRect();

        var claseCliente = clienteData && clienteData.clase
            ? clienteData.clase
            : "";

        var cliente = crearClienteCaminando(
            numero,
            claseCliente
        );
        cliente.style.left = (rectCliente.left + window.scrollX) + "px";
        cliente.style.top = (rectCliente.top + window.scrollY) + "px";

        clienteFila.remove();
        removerClienteDeCola(numero);
        actualizarContadores();

        moverElementoA(cliente, obtenerPuntoCajero(cajeroNumero), 210, 25, function () {

            if (simulacionDetenida) {
                cliente.remove();
                if (callback) callback(cajeroNumero);
                return;
            }

            cajero.className = "cajero-box cajero-atendiendo";
            cajero.innerHTML = `
    <strong><i class="fas fa-user-tie"></i> Cajero ${cajeroNumero}</strong><br/>
    <small class="text-danger">
        Cliente ${numero}<br/>
        Operación: ${operacionCliente}
    </small>
`;

            cambiarEstadoAnimacion(
                "Cajero " + cajeroNumero + " atiende al cliente " + numero +
                " en operación de " + operacionCliente +
                " durante " + (tiempoAtencion / 1000).toFixed(1) + " segundos."
            );

            setTimeout(function () {

                if (simulacionDetenida) {
                    cliente.remove();
                    if (callback) callback(cajeroNumero);
                    return;
                }

                cajero.className = "cajero-box cajero-disponible";
                cajero.innerHTML = `
                <strong><i class="fas fa-user-tie"></i> Cajero ${cajeroNumero}</strong><br/>
                <small class="text-success">Disponible</small>
            `;

                cambiarEstadoAnimacion("Cliente " + numero + " finalizó la atención y se dirige a la salida.");

                moverElementoA(cliente, "puntoSalida", 20, 30, function () {

                    if (simulacionDetenida) {
                        cliente.remove();
                        if (callback) callback(cajeroNumero);
                        return;
                    }

                    cliente.remove();
                    pasarClienteAAtendidos(numero);
                    actualizarContadores();

                    cambiarEstadoAnimacion("Cliente " + numero + " salió del banco.");

                    if (callback) callback(cajeroNumero);
                });

            }, tiempoAtencion);
        });
    }
    function obtenerDatosCliente(numero) {
        for (var i = 0; i < clientesSimulados.length; i++) {
            if (clientesSimulados[i].numero == numero) {
                return clientesSimulados[i];
            }
        }

        return null;
    }

    function obtenerPuntoCajero(cajeroNumero) {
        var cajero = document.getElementById("cajeroVisual_" + cajeroNumero);
        return cajero ? cajero.id : "puntoCajero";
    }

    function crearCajerosVisuales() {
        var zonaCajeros = document.getElementById('<%= pnlCajerosVisual.ClientID %>');
        zonaCajeros.innerHTML = "";

        for (var i = 1; i <= totalCajerosVisual; i++) {
            zonaCajeros.innerHTML += `
                <div id="cajeroVisual_${i}" class="cajero-box cajero-disponible">
                    <strong><i class="fas fa-user-tie"></i> Cajero ${i}</strong><br/>
                    <small class="text-success">Disponible</small>
                </div>
            `;
        }
    }
    function pasarClienteAAtendidos(numero) {

        totalAtendidosSalida++;

        var zonaAtendidos = document.getElementById('<%= pnlClientesAtendidos.ClientID %>');

    zonaAtendidos.innerHTML = `
        <div class="salida-resumen">
            <div class="salida-icono">
                <i class="fas fa-user-check"></i>
            </div>

            <span class="salida-numero">
                ${totalAtendidosSalida}
            </span>

            Clientes atendidos
        </div>
    `;
}

    function finalizarSimulacionVisual() {
        if (simulacionDetenida) return;

        simulacionDetenida = true;

        clearTimeout(intervaloLlegadas);
        clearInterval(intervaloAtencion);

        mostrarNoAtendidosEnCola();

        cambiarEstadoAnimacion(
            "Simulación finalizada: " +
            totalClientesVisual + " atendidos y " +
            totalNoAtendidosVisual + " no atendidos."
        );

        actualizarContadores();
    }

    function mostrarNoAtendidosEnCola() {
        var zonaCola = document.getElementById('<%= pnlClientesCola.ClientID %>');
        zonaCola.innerHTML = `<div id="contenedorCola" class="contenedor-cola"></div>`;

        var contenedor = document.getElementById("contenedorCola");

        for (var i = 1; i <= totalNoAtendidosVisual; i++) {
            contenedor.innerHTML += `
                <div class="cliente-fila cliente-no-atendido">
                    <i class="fas fa-user-times"></i>
                    <span>Cliente sin atención ${i}</span>
                </div>
            `;
        }

        actualizarContadores();
    }

    function detenerSimulacionVisual() {
        simulacionDetenida = true;

        clearTimeout(intervaloLlegadas);
        clearInterval(intervaloAtencion);

        cambiarEstadoAnimacion("Simulación detenida.");
    }

    function reiniciarSimulacionVisual() {
        clearTimeout(intervaloLlegadas);
        clearInterval(intervaloAtencion);

        clienteActual = 1;
        colaClientes = [];
        cajeroOcupado = false;
        simulacionDetenida = true;
        totalAtendidosSalida = 0;
        clientesSimulados = [];
        totalTiempoEspera = 0;
        totalClientesConEspera = 0;
        tiempoOcupadoCajeros = [];
        horaInicioSimulacion = null;

        document.getElementById("kpiEsperaPromedio").innerText = "0s";
        document.getElementById("kpiUtilizacionCajeros").innerText = "0%";

        document.getElementById("zonaEntrada").innerHTML =
            "<span class='text-muted'>Clientes ingresan</span>";

        document.getElementById('<%= pnlClientesCola.ClientID %>').innerHTML = "";
       document.getElementById('<%= pnlCajerosVisual.ClientID %>').innerHTML = "";
       document.getElementById('<%= pnlClientesAtendidos.ClientID %>').innerHTML = "";

       // RESET KPI
       document.getElementById("kpiAtendidos").innerText = "0";
       document.getElementById("kpiNoAtendidos").innerText = "0";
       document.getElementById("kpiCola").innerText = "0";
       document.getElementById("kpiCajerosOcupados").innerText = "0";
        document.getElementById("kpiEficiencia").innerText = "0%";
        document.getElementById("panelValidacionModelo").className =
            "validacion-modelo validacion-ok";

        document.getElementById("panelValidacionModelo").innerHTML =
            "<i class='fas fa-check-circle'></i> Modelo pendiente de validación.";

       cambiarEstadoAnimacion("Esperando inicio de animación.");

       actualizarContadores();
   }

    function crearClienteCaminando(numero, colorClase) {

        var cliente = document.createElement("div");

        cliente.id = "clienteCaminando_" + numero;

        cliente.className =
            "cliente-persona cliente-caminando " +
            colorClase;

        cliente.innerHTML =
            '<i class="fas fa-user"></i>';

        document.body.appendChild(cliente);

        return cliente;
    }

    function moverElementoA(elemento, destinoId, ajusteX, ajusteY, callback) {
        var destino = document.getElementById(destinoId);

        if (!destino || !elemento) {
            if (callback) callback();
            return;
        }

        var rect = destino.getBoundingClientRect();

        elemento.style.left =
            (rect.left + window.scrollX + (ajusteX || 10)) + "px";

        elemento.style.top =
            (rect.top + window.scrollY + (ajusteY || 10)) + "px";

        setTimeout(function () {
            if (callback) callback();
        }, 950);
    }

    function actualizarContadores() {
        var atendidos = totalAtendidosSalida;
        var noAtendidos = document.querySelectorAll(".cliente-no-atendido").length;
        var enCola = document.querySelectorAll("#contenedorCola .cliente-fila").length;

        var ocupados = 0;

        for (var i = 0; i < cajerosOcupados.length; i++) {
            if (cajerosOcupados[i] === true) {
                ocupados++;
            }
        }

        var totalProcesados = atendidos + noAtendidos;
        var eficiencia = 0;

        if (totalClientesVisual > 0) {
            eficiencia = Math.round((atendidos / totalClientesVisual) * 100);
        }

        document.getElementById("contadorAtendidos").innerText = atendidos;
        document.getElementById("contadorNoAtendidos").innerText = noAtendidos;
        document.getElementById("contadorCola").innerText = enCola;

        document.getElementById("kpiAtendidos").innerText = atendidos;
        document.getElementById("kpiNoAtendidos").innerText = noAtendidos;
        document.getElementById("kpiCola").innerText = enCola;
        document.getElementById("kpiCajerosOcupados").innerText = ocupados;
        document.getElementById("kpiEficiencia").innerText = eficiencia + "%";
        generarRecomendacionAutomatica(esperaPromedio, utilizacionPromedio, enCola);
        generarConclusionGerencial(esperaPromedio, utilizacionPromedio, enCola);
        generarRecomendacionAutomatica(0, eficiencia, enCola, noAtendidos);
        validarModelo();
        var esperaPromedio = 0;

        if (totalClientesConEspera > 0) {
            esperaPromedio = totalTiempoEspera / totalClientesConEspera;
        }

        var utilizacionPromedio = 0;

        if (horaInicioSimulacion && tiempoOcupadoCajeros.length > 0) {
            var tiempoTranscurrido = new Date() - horaInicioSimulacion;
            var capacidadTotal = tiempoTranscurrido * totalCajerosVisual;

            var tiempoTotalOcupado = 0;

            for (var j = 0; j < tiempoOcupadoCajeros.length; j++) {
                tiempoTotalOcupado += tiempoOcupadoCajeros[j];
            }

            if (capacidadTotal > 0) {
                utilizacionPromedio = Math.round((tiempoTotalOcupado / capacidadTotal) * 100);
            }

            if (utilizacionPromedio > 100) {
                utilizacionPromedio = 100;
            }
        }

        document.getElementById("kpiEsperaPromedio").innerText =
            (esperaPromedio / 1000).toFixed(1) + "s";

        document.getElementById("kpiUtilizacionCajeros").innerText =
            utilizacionPromedio + "%";

        generarRecomendacionAutomatica(esperaPromedio, utilizacionPromedio, enCola, noAtendidos);

    }

    function generarRecomendacionAutomatica(esperaPromedio, utilizacionPromedio, enCola) {

        var recomendacion = document.getElementById('<%= lblRecomendacion.ClientID %>');

        if (!recomendacion) return;

        var eficienciaReal = 0;

        var totalRealClientes = totalAtendidosSalida + enCola;

        if (totalRealClientes > 0) {
            eficienciaReal = (totalAtendidosSalida / totalRealClientes) * 100;
        }

        if (totalAtendidosSalida === 0) {
            recomendacion.innerHTML =
                "<strong>Estado operativo: SIN DATOS</strong><br/>" +
                "Ejecute una simulación para generar una recomendación organizacional.";
            return;
        }

        if (eficienciaReal < 60 || enCola > 0) {
            recomendacion.innerHTML =
                "<strong>Estado operativo: SATURACIÓN ALTA</strong><br/>" +
                "Solo se atendió al " + eficienciaReal.toFixed(0) +
                "% de los clientes. Se recomienda habilitar más cajeros o ampliar el tiempo de atención.";
            return;
        }

        if (eficienciaReal >= 60 && eficienciaReal < 85) {
            recomendacion.innerHTML =
                "<strong>Estado operativo: SATURACIÓN MODERADA</strong><br/>" +
                "La atención es aceptable, pero se recomienda reforzar cajeros en horarios de mayor demanda.";
            return;
        }

        if (eficienciaReal >= 85 && utilizacionPromedio >= 80) {
            recomendacion.innerHTML =
                "<strong>Estado operativo: OPERACIÓN ÓPTIMA</strong><br/>" +
                "La atención es eficiente, aunque los cajeros presentan alta utilización.";
            return;
        }

        recomendacion.innerHTML =
            "<strong>Estado operativo: OPERACIÓN ESTABLE</strong><br/>" +
            "La estructura actual de atención es adecuada para el escenario simulado.";
    }
function cambiarEstadoAnimacion(texto) {
    var estado = document.getElementById("lblEstadoAnimacion");

    if (estado) {
        estado.innerText = texto;
    }
}

function mostrarConfiguracion() {
    var escenario = document.getElementById('<%= cboEscenario.ClientID %>').selectedOptions[0].text;
    var clientes = document.getElementById('<%= txtCantidadClientes.ClientID %>').value;
    var cajeros = document.getElementById('<%= txtCantidadCajeros.ClientID %>').value;
    var llegada = document.getElementById('<%= txtTiempoLlegada.ClientID %>').value;
    var inicio = document.getElementById('<%= txtHoraInicio.ClientID %>').value;
        var fin = document.getElementById('<%= txtHoraFin.ClientID %>').value;

        alert(
            "ESCENARIO: " + escenario + "\n\n" +
            "Clientes: " + clientes + "\n" +
            "Cajeros: " + cajeros + "\n" +
            "Tiempo entre llegadas: " + llegada + " min\n" +
            "Hora inicio: " + inicio + "\n" +
            "Hora fin: " + fin
        );
    }

    function generarTiempoAtencionAleatorio() {
        return Math.floor(Math.random() * 4000) + 2000;
    }

    function generarTiempoLlegadaPoisson() {
        var lambda = 0.5;
        var u = Math.random();
        var tiempo = -Math.log(1 - u) / lambda;
        var tiempoMs = tiempo * 1000;

        if (tiempoMs < 800) tiempoMs = 800;
        if (tiempoMs > 5000) tiempoMs = 5000;

        return tiempoMs;
    }
</script>
</asp:Content>