<%@ Page Title="" Language="C#" MasterPageFile="~/HomeMaster.Master" AutoEventWireup="true" CodeBehind="HistorialSimulaciones.aspx.cs" Inherits="CapaPresentacion.HistorialSimulaciones" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <style>
        .btn-action {
            padding: 5px 10px;
            border-radius: 8px;
            font-size: 13px;
        }

        .badge-escenario {
            background: #e0e7ff;
            color: #3730a3;
            padding: 6px 12px;
            border-radius: 20px;
            font-weight: 600;
        }

        .dato-box {
            background: #f3f4f6;
            padding: 6px 10px;
            border-radius: 8px;
            font-weight: 600;
            color: #374151;
        }

        .recomendacion-box {
            background: #eff6ff;
            border-left: 4px solid #2563eb;
            padding: 8px 10px;
            border-radius: 8px;
            color: #1f2937;
            font-size: 13px;
        }
    </style>

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">

    <div class="page-title">
        <h4>Historial de Simulaciones</h4>
        <p>Consulta de simulaciones realizadas y resultados obtenidos en cada escenario.</p>
    </div>

    <div class="card">
        <div class="card-header d-flex justify-content-between align-items-center">
            <span>
                <i class="fas fa-history"></i>
                Simulaciones Registradas
            </span>

            <a href="Dashboard.aspx" class="btn btn-primary btn-sm">
                <i class="fas fa-play"></i> Nueva Simulación
            </a>
        </div>

        <div class="card-body">

            <div class="table-responsive">

                <asp:GridView ID="gvHistorial" runat="server"
                    CssClass="table table-bordered table-hover"
                    AutoGenerateColumns="False"
                    EmptyDataText="No existen simulaciones registradas.">

                    <Columns>

                        <asp:BoundField DataField="IdSimulacion" HeaderText="ID" />

                        <asp:BoundField DataField="NombreEscenario" HeaderText="Escenario" />

                        <asp:TemplateField HeaderText="Tipo">
                            <ItemTemplate>
                                <span class="badge-escenario">
                                    <%# Eval("TipoEscenario") %>
                                </span>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:BoundField DataField="FechaSimulacion" HeaderText="Fecha" DataFormatString="{0:dd/MM/yyyy HH:mm}" />

                        <asp:TemplateField HeaderText="Clientes">
                            <ItemTemplate>
                                <span class="dato-box">
                                    <%# Eval("TotalClientes") %>
                                </span>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Cajeros">
                            <ItemTemplate>
                                <span class="dato-box">
                                    <%# Eval("TotalCajeros") %>
                                </span>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Espera Prom.">
                            <ItemTemplate>
                                <span class="dato-box">
                                    <%# Eval("TiempoPromedioEspera") %> min
                                </span>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Atención Prom.">
                            <ItemTemplate>
                                <span class="dato-box">
                                    <%# Eval("TiempoPromedioAtencion") %> min
                                </span>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Saturación">
                            <ItemTemplate>
                                <span class="dato-box">
                                    <%# Eval("PorcentajeSaturacion") %> %
                                </span>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Recomendación">
                            <ItemTemplate>
                                <div class="recomendacion-box">
                                    <%# Eval("Recomendacion") %>
                                </div>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Acción">
                            <ItemTemplate>
                                <asp:HyperLink ID="btnVerDetalle" runat="server"
                                    CssClass="btn btn-info btn-sm btn-action"
                                    NavigateUrl='<%# "DetalleSimulacion.aspx?id=" + Eval("IdSimulacion") %>'>
                                    <i class="fas fa-eye"></i> Ver Detalle
                                </asp:HyperLink>
                            </ItemTemplate>
                        </asp:TemplateField>

                    </Columns>

                </asp:GridView>

            </div>

        </div>
    </div>

</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="footer" runat="server">
</asp:Content>