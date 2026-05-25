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
    min-height: 220px;
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
    gap: 8px;
}

.cliente-fila {
    display: flex;
    align-items: center;
    gap: 8px;
    background: #dbeafe;
    border-left: 5px solid #2563eb;
    padding: 8px 10px;
    border-radius: 10px;
    color: #1e3a8a;
    font-weight: 600;
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

.cliente-persona.verde {
    background: #16a34a;
    box-shadow: 0 6px 12px rgba(22,163,74,0.25);
}

.cliente-persona.rojo {
    background: #dc2626;
    box-shadow: 0 6px 12px rgba(220,38,38,0.25);
}

.cliente-caminando {
    position: fixed;
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
    </style>

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">

    <div class="page-title">
        <h4>Dashboard de Simulación</h4>
        <asp:HiddenField ID="hdnTotalClientesAnimacion" runat="server" Value="0" />
        <asp:HiddenField ID="hdnTotalCajerosAnimacion" runat="server" Value="0" />
        <asp:HiddenField ID="hdnClientesAtendidosAnimacion" runat="server" Value="0" />
        <asp:HiddenField ID="hdnClientesNoAtendidosAnimacion" runat="server" Value="0" />
        <p>Panel principal para ejecutar escenarios de atención bancaria y analizar resultados.</p>
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
    <div class="mt-3 d-flex flex-wrap align-items-center">

    <div class="mr-4 mb-2">
        <span class="cliente-animado" style="background:#2563eb;">
            <i class="fas fa-user"></i>
        </span>
        <small>Cliente en proceso</small>
    </div>

    <div class="mr-4 mb-2">
        <span class="cliente-animado cliente-atendido">
            <i class="fas fa-user-check"></i>
        </span>
        <small>Cliente atendido</small>
    </div>

    <div class="mr-4 mb-2">
        <span class="cliente-animado cliente-no-atendido">
            <i class="fas fa-user-times"></i>
        </span>
        <small>Cliente no atendido</small>
    </div>

</div>
</div>

    <!-- CONFIGURACIÓN Y RESUMEN -->
    <div class="row">
        <div class="col-md-4 mb-4">

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
                    </div>

                    <button type="button"
                        class="btn btn-outline-primary btn-block"
                        onclick="mostrarConfiguracion()">
                        <i class="fas fa-eye"></i>
                        Ver configuración
   
                    </button>

                    <asp:Button ID="btnEjecutar" runat="server"
                        Text="Ejecutar Simulación"
                        CssClass="btn btn-primary btn-block mt-3"
                        OnClick="btnEjecutar_Click" />

                </div>

            </div>

        </div>

        <div class="col-md-8 mb-4">

            <div class="card h-100">
                <div class="card-header">
                    <i class="fas fa-info-circle"></i>
                    Resumen del Resultado
               
                </div>

                <div class="card-body">

                    <div class="resumen-item resumen-atendido">
                        <strong>Clientes atendidos</strong>
                        <span class="resumen-numero">
                            <asp:Label ID="lblClientesAtendidos" runat="server" Text="0"></asp:Label>
                        </span>
                        <div class="clearfix"></div>
                    </div>

                    <div class="resumen-item resumen-no-atendido">
                        <strong>Clientes no atendidos</strong>
                        <span class="resumen-numero">
                            <asp:Label ID="lblClientesNoAtendidos" runat="server" Text="0"></asp:Label>
                        </span>
                        <div class="clearfix"></div>
                    </div>

                    <div class="resumen-item resumen-cola">
                        <strong>Clientes atendidos que esperaron en cola</strong>
                        <span class="resumen-numero">
                            <asp:Label ID="lblClientesCola" runat="server" Text="0"></asp:Label>
                        </span>
                        <div class="clearfix"></div>
                    </div>

                    <hr />

                </div>
            </div>

        </div>

    </div>

    <!-- RECOMENDACIÓN -->
    <div class="row">

        <div class="col-md-12 mb-4">
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

        zonaEntrada.innerHTML = `<small class="text-primary">Cliente ${numero} ingresando...</small>`;

        var cliente = crearClienteCaminando(numero, "");

        moverElementoA(cliente, "zonaEntrada", 20, 35, function () {
            moverElementoA(cliente, "puntoFila", 20, 20, function () {
                cliente.remove();

                zonaEntrada.innerHTML = `<span class="text-muted">Clientes ingresan</span>`;

                if (!document.getElementById("contenedorCola")) {
                    zonaCola.innerHTML = `<div id="contenedorCola" class="contenedor-cola"></div>`;
                }

                colaClientes.push({
                    numero: numero,
                    tipo: tipoCliente.tipo,
                    prioridad: tipoCliente.prioridad,
                    clase: tipoCliente.clase,
                    badge: tipoCliente.badge
                });

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
                    <span>Cliente ${cliente.numero}</span>
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

        cambiarEstadoAnimacion("Cliente " + numero + " avanza al cajero " + cajeroNumero + ".");

        var rectCliente = clienteFila.getBoundingClientRect();

        var cliente = crearClienteCaminando(numero, "");
        cliente.style.left = rectCliente.left + "px";
        cliente.style.top = rectCliente.top + "px";

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
            <small class="text-danger">Atendiendo cliente ${numero}</small>
        `;

            var tiempoAtencion = generarTiempoAtencionAleatorio();

            cambiarEstadoAnimacion(
                "Cajero " + cajeroNumero + " atiende al cliente " + numero +
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

        document.getElementById("zonaEntrada").innerHTML = "<span class='text-muted'>Clientes ingresan</span>";
        document.getElementById('<%= pnlClientesCola.ClientID %>').innerHTML = "";
    document.getElementById('<%= pnlCajerosVisual.ClientID %>').innerHTML = "";
    document.getElementById('<%= pnlClientesAtendidos.ClientID %>').innerHTML = "";

    cambiarEstadoAnimacion("Esperando inicio de animación.");
    actualizarContadores();
}

function crearClienteCaminando(numero, colorClase) {
    var cliente = document.createElement("div");
    cliente.id = "clienteCaminando_" + numero;
    cliente.className = "cliente-persona cliente-caminando " + (colorClase || "");
    cliente.innerHTML = '<i class="fas fa-user"></i>';
    document.body.appendChild(cliente);
    return cliente;
}

function moverElementoA(elemento, destinoId, ajusteX, ajusteY, callback) {
    var destino = document.getElementById(destinoId);
    if (!destino || !elemento) return;

    var rect = destino.getBoundingClientRect();

    elemento.style.left = (rect.left + (ajusteX || 10)) + "px";
    elemento.style.top = (rect.top + (ajusteY || 10)) + "px";

    setTimeout(function () {
        if (callback) callback();
    }, 950);
}

function actualizarContadores() {
    var atendidos = document.querySelectorAll(".cliente-atendido").length;
    var noAtendidos = document.querySelectorAll(".cliente-no-atendido").length;
    var enCola = document.querySelectorAll("#contenedorCola .cliente-fila").length;

    document.getElementById("contadorAtendidos").innerText = atendidos;
    document.getElementById("contadorNoAtendidos").innerText = noAtendidos;
    document.getElementById("contadorCola").innerText = enCola;
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