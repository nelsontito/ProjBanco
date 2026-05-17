<%@ Page Title="" Language="C#" MasterPageFile="~/HomeMaster.Master" AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs" Inherits="CapaPresentacion.Dashboard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <style>
        .stat-card {
            border-radius: 16px;
            border: none;
            box-shadow: 0 6px 18px rgba(0,0,0,0.07);
            transition: all .2s;
        }

        .stat-card:hover {
            transform: translateY(-3px);
        }

        .stat-icon {
            width: 52px;
            height: 52px;
            border-radius: 14px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 22px;
            color: white;
        }

        .bg-blue {
            background: #2563eb;
        }

        .bg-green {
            background: #16a34a;
        }

        .bg-yellow {
            background: #f59e0b;
        }

        .bg-red {
            background: #dc2626;
        }

        .stat-title {
            color: #6b7280;
            font-size: 14px;
            margin-bottom: 4px;
        }

        .stat-value {
            color: #111827;
            font-size: 26px;
            font-weight: 700;
            margin: 0;
        }

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

        .simulation-status {
            padding: 8px 14px;
            border-radius: 20px;
            font-size: 13px;
            font-weight: 600;
        }

        .status-normal {
            background: #dcfce7;
            color: #166534;
        }

        .status-alerta {
            background: #fef3c7;
            color: #92400e;
        }

        .status-critico {
            background: #fee2e2;
            color: #991b1b;
        }
    </style>

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">

    <div class="page-title">
        <h4>Dashboard de Simulación</h4>
        <p>Panel principal para ejecutar escenarios de atención bancaria y analizar resultados.</p>
    </div>

    <!-- TARJETAS RESUMEN -->
    <div class="row">

        <div class="col-md-3 mb-4">
            <div class="card stat-card">
                <div class="card-body d-flex align-items-center justify-content-between">
                    <div>
                        <div class="stat-title">Clientes Simulados</div>
                        <p class="stat-value">
                            <asp:Label ID="lblTotalClientes" runat="server" Text="0"></asp:Label>
                        </p>
                    </div>
                    <div class="stat-icon bg-blue">
                        <i class="fas fa-users"></i>
                    </div>
                </div>
            </div>
        </div>

        <div class="col-md-3 mb-4">
            <div class="card stat-card">
                <div class="card-body d-flex align-items-center justify-content-between">
                    <div>
                        <div class="stat-title">Cajeros Activos</div>
                        <p class="stat-value">
                            <asp:Label ID="lblTotalCajeros" runat="server" Text="0"></asp:Label>
                        </p>
                    </div>
                    <div class="stat-icon bg-green">
                        <i class="fas fa-user-tie"></i>
                    </div>
                </div>
            </div>
        </div>

        <div class="col-md-3 mb-4">
            <div class="card stat-card">
                <div class="card-body d-flex align-items-center justify-content-between">
                    <div>
                        <div class="stat-title">Promedio Espera</div>
                        <p class="stat-value">
                            <asp:Label ID="lblPromedioEspera" runat="server" Text="0"></asp:Label>
                            <small>min</small>
                        </p>
                    </div>
                    <div class="stat-icon bg-yellow">
                        <i class="fas fa-clock"></i>
                    </div>
                </div>
            </div>
        </div>

        <div class="col-md-3 mb-4">
            <div class="card stat-card">
                <div class="card-body d-flex align-items-center justify-content-between">
                    <div>
                        <div class="stat-title">Saturación</div>
                        <p class="stat-value">
                            <asp:Label ID="lblSaturacion" runat="server" Text="0"></asp:Label>
                            <small>%</small>
                        </p>
                    </div>
                    <div class="stat-icon bg-red">
                        <i class="fas fa-exclamation-triangle"></i>
                    </div>
                </div>
            </div>
        </div>

    </div>

    <!-- PANEL PRINCIPAL -->
    <div class="row">

        <!-- CONFIGURACIÓN DE SIMULACIÓN -->
        <div class="col-md-4 mb-4">

            <div class="card">
                <div class="card-header">
                    <i class="fas fa-sliders-h"></i>
                    Configuración de Escenario
                </div>

                <div class="card-body">

                    <div class="form-group">
                        <label>Escenario</label>
                        <asp:DropDownList ID="cboEscenario" runat="server" CssClass="form-control">
                        </asp:DropDownList>
                    </div>

                    <div class="form-group">
                        <label>Cantidad de Clientes</label>
                        <asp:TextBox ID="txtCantidadClientes" runat="server" CssClass="form-control" TextMode="Number" Text="0"></asp:TextBox>
                    </div>

                    <div class="form-group">
                        <label>Cantidad de Cajeros</label>
                        <asp:TextBox ID="txtCantidadCajeros" runat="server" CssClass="form-control" TextMode="Number" Text="0"></asp:TextBox>
                    </div>

                    <div class="form-group">
                        <label>Tiempo entre llegadas</label>
                        <div class="input-group">
                            <asp:TextBox ID="txtTiempoLlegada" runat="server" CssClass="form-control" TextMode="Number" Text="0"></asp:TextBox>
                            <div class="input-group-append">
                                <span class="input-group-text">min</span>
                            </div>
                        </div>
                    </div>

                    <div class="form-row">

                        <div class="form-group col-md-6">
                            <label>Hora Inicio</label>
                            <asp:TextBox ID="txtHoraInicio" runat="server" CssClass="form-control" TextMode="Time"></asp:TextBox>
                        </div>

                        <div class="form-group col-md-6">
                            <label>Hora Fin</label>
                            <asp:TextBox ID="txtHoraFin" runat="server" CssClass="form-control" TextMode="Time"></asp:TextBox>
                        </div>

                    </div>

                    <asp:Button ID="btnEjecutar" runat="server" Text="Ejecutar Simulación" CssClass="btn btn-primary btn-block" />

                    <asp:Button ID="btnLimpiar" runat="server" Text="Limpiar" CssClass="btn btn-outline-secondary btn-block mt-2" />

                </div>
            </div>

        </div>

        <!-- GRÁFICO -->
        <div class="col-md-8 mb-4">

            <div class="card">
                <div class="card-header d-flex justify-content-between align-items-center">
                    <span>
                        <i class="fas fa-chart-bar"></i>
                        Análisis de Resultados
                    </span>

                    <span class="simulation-status status-normal">
                        Estado: Normal
                    </span>
                </div>

                <div class="card-body">
                    <canvas id="graficoSimulacion" style="height: 280px;"></canvas>
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

    <!-- DETALLE DE CLIENTES -->
    <div class="row">

        <div class="col-md-12">

            <div class="card">
                <div class="card-header">
                    <i class="fas fa-list"></i>
                    Detalle de Clientes Simulados
                </div>

                <div class="card-body">

                    <div class="table-responsive">
                        <asp:GridView ID="gvDetalleSimulacion" runat="server"
                            CssClass="table table-bordered table-hover"
                            AutoGenerateColumns="False"
                            EmptyDataText="No existen datos de simulación.">

                            <Columns>
                                <asp:BoundField DataField="NumeroCliente" HeaderText="Cliente" />
                                <asp:BoundField DataField="NombreTipo" HeaderText="Tipo Atención" />
                                <asp:BoundField DataField="NombreCajero" HeaderText="Cajero" />
                                <asp:BoundField DataField="HoraLlegada" HeaderText="Hora Llegada" />
                                <asp:BoundField DataField="TiempoEspera" HeaderText="Espera (min)" />
                                <asp:BoundField DataField="TiempoAtencion" HeaderText="Atención (min)" />
                                <asp:BoundField DataField="EstadoCliente" HeaderText="Estado" />
                            </Columns>

                        </asp:GridView>
                    </div>

                </div>
            </div>

        </div>

    </div>

</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="footer" runat="server">

    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

    <script>
        var ctx = document.getElementById('graficoSimulacion').getContext('2d');

        var graficoSimulacion = new Chart(ctx, {
            type: 'bar',
            data: {
                labels: ['Clientes', 'Cajeros', 'Espera', 'Atención', 'Saturación'],
                datasets: [{
                    label: 'Resultado de Simulación',
                    data: [0, 0, 0, 0, 0],
                    backgroundColor: [
                        '#2563eb',
                        '#16a34a',
                        '#f59e0b',
                        '#0ea5e9',
                        '#dc2626'
                    ],
                    borderRadius: 8
                }]
            },
            options: {
                responsive: true,
                plugins: {
                    legend: {
                        display: false
                    }
                },
                scales: {
                    y: {
                        beginAtZero: true
                    }
                }
            }
        });
    </script>

</asp:Content>