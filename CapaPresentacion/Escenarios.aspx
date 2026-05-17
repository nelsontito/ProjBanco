<%@ Page Title="" Language="C#" MasterPageFile="~/HomeMaster.Master" AutoEventWireup="true" CodeBehind="Escenarios.aspx.cs" Inherits="CapaPresentacion.Escenarios" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <style>
        .btn-action {
            padding: 5px 10px;
            border-radius: 8px;
            font-size: 13px;
        }

        .form-label {
            font-weight: 600;
            color: #374151;
        }

        .badge-activo {
            background: #dcfce7;
            color: #166534;
            padding: 6px 12px;
            border-radius: 20px;
            font-weight: 600;
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
    </style>

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">

    <div class="page-title">
        <h4>Escenarios de Simulación</h4>
        <p>Configuración de escenarios como día normal, hora pico, pago de sueldos o fin de mes.</p>
    </div>

    <div class="row">

        <!-- FORMULARIO -->
        <div class="col-md-4 mb-4">

            <div class="card">
                <div class="card-header">
                    <i class="fas fa-project-diagram"></i>
                    Datos del Escenario
                </div>

                <div class="card-body">

                    <asp:HiddenField ID="txtIdEscenario" runat="server" />

                    <div class="form-group">
                        <label class="form-label">Nombre del Escenario</label>
                        <asp:TextBox ID="txtNombreEscenario" runat="server" CssClass="form-control" placeholder="Ej: Día de pago de sueldos"></asp:TextBox>
                    </div>

                    <div class="form-group">
                        <label class="form-label">Tipo de Escenario</label>
                        <asp:DropDownList ID="cboTipoEscenario" runat="server" CssClass="form-control">
                            <asp:ListItem Text="Seleccione..." Value=""></asp:ListItem>
                            <asp:ListItem Text="Día normal" Value="Día normal"></asp:ListItem>
                            <asp:ListItem Text="Hora pico" Value="Hora pico"></asp:ListItem>
                            <asp:ListItem Text="Pago de sueldos" Value="Pago de sueldos"></asp:ListItem>
                            <asp:ListItem Text="Fin de mes" Value="Fin de mes"></asp:ListItem>
                            <asp:ListItem Text="Alta demanda" Value="Alta demanda"></asp:ListItem>
                        </asp:DropDownList>
                    </div>

                    <div class="form-row">

                        <div class="form-group col-md-6">
                            <label class="form-label">Clientes</label>
                            <asp:TextBox ID="txtCantidadClientes" runat="server" CssClass="form-control" TextMode="Number" placeholder="Ej: 100"></asp:TextBox>
                        </div>

                        <div class="form-group col-md-6">
                            <label class="form-label">Cajeros</label>
                            <asp:TextBox ID="txtCantidadCajeros" runat="server" CssClass="form-control" TextMode="Number" placeholder="Ej: 3"></asp:TextBox>
                        </div>

                    </div>

                    <div class="form-group">
                        <label class="form-label">Tiempo entre llegadas</label>
                        <div class="input-group">
                            <asp:TextBox ID="txtTiempoEntreLlegadas" runat="server" CssClass="form-control" TextMode="Number" placeholder="Ej: 2"></asp:TextBox>
                            <div class="input-group-append">
                                <span class="input-group-text">min</span>
                            </div>
                        </div>
                        <small class="text-muted">Cada cuántos minutos llega un cliente al banco.</small>
                    </div>

                    <div class="form-row">

                        <div class="form-group col-md-6">
                            <label class="form-label">Hora Inicio</label>
                            <asp:TextBox ID="txtHoraInicio" runat="server" CssClass="form-control" TextMode="Time"></asp:TextBox>
                        </div>

                        <div class="form-group col-md-6">
                            <label class="form-label">Hora Fin</label>
                            <asp:TextBox ID="txtHoraFin" runat="server" CssClass="form-control" TextMode="Time"></asp:TextBox>
                        </div>

                    </div>

                    <div class="alert alert-info small">
                        <i class="fas fa-info-circle"></i>
                        El escenario define las condiciones que usará el simulador para calcular filas, espera y saturación.
                    </div>

                    <div class="mt-3">
                        <asp:Button ID="btnGuardar" runat="server" Text="Guardar Escenario" CssClass="btn btn-primary btn-block" />
                        <asp:Button ID="btnCancelar" runat="server" Text="Cancelar" CssClass="btn btn-outline-secondary btn-block mt-2" />
                    </div>

                </div>
            </div>

        </div>

        <!-- LISTADO -->
        <div class="col-md-8 mb-4">

            <div class="card">
                <div class="card-header d-flex justify-content-between align-items-center">
                    <span>
                        <i class="fas fa-table"></i>
                        Lista de Escenarios
                    </span>

                    <span class="badge badge-primary">
                        Activos
                    </span>
                </div>

                <div class="card-body">

                    <div class="table-responsive">

                        <asp:GridView ID="gvEscenarios" runat="server"
                            CssClass="table table-bordered table-hover"
                            AutoGenerateColumns="False"
                            EmptyDataText="No existen escenarios registrados.">

                            <Columns>

                                <asp:BoundField DataField="IdEscenario" HeaderText="ID" />

                                <asp:BoundField DataField="NombreEscenario" HeaderText="Escenario" />

                                <asp:TemplateField HeaderText="Tipo">
                                    <ItemTemplate>
                                        <span class="badge-escenario">
                                            <%# Eval("TipoEscenario") %>
                                        </span>
                                    </ItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="Clientes">
                                    <ItemTemplate>
                                        <span class="dato-box">
                                            <%# Eval("CantidadClientes") %>
                                        </span>
                                    </ItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="Cajeros">
                                    <ItemTemplate>
                                        <span class="dato-box">
                                            <%# Eval("CantidadCajeros") %>
                                        </span>
                                    </ItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="Llegada">
                                    <ItemTemplate>
                                        <span class="dato-box">
                                            <%# Eval("TiempoEntreLlegadas") %> min
                                        </span>
                                    </ItemTemplate>
                                </asp:TemplateField>

                                <asp:BoundField DataField="HoraInicio" HeaderText="Inicio" />
                                <asp:BoundField DataField="HoraFin" HeaderText="Fin" />

                                <asp:TemplateField HeaderText="Estado">
                                    <ItemTemplate>
                                        <span class="badge-activo">Activo</span>
                                    </ItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="Acciones">
                                    <ItemTemplate>

                                        <asp:LinkButton ID="btnEditar" runat="server"
                                            CssClass="btn btn-warning btn-sm btn-action"
                                            CommandName="Editar"
                                            CommandArgument='<%# Eval("IdEscenario") %>'>
                                            <i class="fas fa-edit"></i> Editar
                                        </asp:LinkButton>

                                        <asp:LinkButton ID="btnEliminar" runat="server"
                                            CssClass="btn btn-danger btn-sm btn-action"
                                            CommandName="Eliminar"
                                            CommandArgument='<%# Eval("IdEscenario") %>'
                                            OnClientClick="return confirm('¿Está seguro de eliminar este escenario?');">
                                            <i class="fas fa-trash"></i> Eliminar
                                        </asp:LinkButton>

                                    </ItemTemplate>
                                </asp:TemplateField>

                            </Columns>

                        </asp:GridView>

                    </div>

                </div>
            </div>

        </div>

    </div>

</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="footer" runat="server">
</asp:Content>