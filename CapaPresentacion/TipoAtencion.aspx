<%@ Page Title="" Language="C#" MasterPageFile="~/HomeMaster.Master" AutoEventWireup="true" CodeBehind="TipoAtencion.aspx.cs" Inherits="CapaPresentacion.TipoAtencion" %>

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

        .tiempo-box {
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
        <h4>Tipos de Atención</h4>
        <p>Registro de trámites bancarios y tiempos estimados de atención para la simulación.</p>
    </div>

    <div class="row">

        <!-- FORMULARIO -->
        <div class="col-md-4 mb-4">

            <div class="card">
                <div class="card-header">
                    <i class="fas fa-list-alt"></i>
                    Datos del Tipo de Atención
                </div>

                <div class="card-body">

                    <asp:HiddenField ID="txtIdTipoAtencion" runat="server" />

                    <div class="form-group">
                        <label class="form-label">Nombre del Tipo de Atención</label>
                        <asp:TextBox ID="txtNombreTipo" runat="server" CssClass="form-control" placeholder="Ej: Retiro, Depósito, Pago de servicios"></asp:TextBox>
                    </div>

                    <div class="form-group">
                        <label class="form-label">Tiempo Mínimo</label>
                        <div class="input-group">
                            <asp:TextBox ID="txtTiempoMinimo" runat="server" CssClass="form-control" TextMode="Number" placeholder="Ej: 3"></asp:TextBox>
                            <div class="input-group-append">
                                <span class="input-group-text">min</span>
                            </div>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="form-label">Tiempo Máximo</label>
                        <div class="input-group">
                            <asp:TextBox ID="txtTiempoMaximo" runat="server" CssClass="form-control" TextMode="Number" placeholder="Ej: 8"></asp:TextBox>
                            <div class="input-group-append">
                                <span class="input-group-text">min</span>
                            </div>
                        </div>
                    </div>

                    <div class="alert alert-info small">
                        <i class="fas fa-info-circle"></i>
                        Estos tiempos se usarán para simular cuánto tarda cada cliente en ser atendido.
                    </div>

                    <div class="mt-3">
                        <asp:Button ID="btnGuardar" runat="server" Text="Guardar" CssClass="btn btn-primary btn-block" />
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
                        Lista de Tipos de Atención
                    </span>

                    <span class="badge badge-primary">
                        Activos
                    </span>
                </div>

                <div class="card-body">

                    <div class="table-responsive">

                        <asp:GridView ID="gvTipoAtencion" runat="server"
                            CssClass="table table-bordered table-hover"
                            AutoGenerateColumns="False"
                            EmptyDataText="No existen tipos de atención registrados.">

                            <Columns>

                                <asp:BoundField DataField="IdTipoAtencion" HeaderText="ID" />

                                <asp:BoundField DataField="NombreTipo" HeaderText="Tipo de Atención" />

                                <asp:TemplateField HeaderText="Tiempo Mínimo">
                                    <ItemTemplate>
                                        <span class="tiempo-box">
                                            <%# Eval("TiempoMinimo") %> min
                                        </span>
                                    </ItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="Tiempo Máximo">
                                    <ItemTemplate>
                                        <span class="tiempo-box">
                                            <%# Eval("TiempoMaximo") %> min
                                        </span>
                                    </ItemTemplate>
                                </asp:TemplateField>

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
                                            CommandArgument='<%# Eval("IdTipoAtencion") %>'>
                                            <i class="fas fa-edit"></i> Editar
                                        </asp:LinkButton>

                                        <asp:LinkButton ID="btnEliminar" runat="server"
                                            CssClass="btn btn-danger btn-sm btn-action"
                                            CommandName="Eliminar"
                                            CommandArgument='<%# Eval("IdTipoAtencion") %>'
                                            OnClientClick="return confirm('¿Está seguro de eliminar este tipo de atención?');">
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