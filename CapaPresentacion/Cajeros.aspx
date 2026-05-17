<%@ Page Title="" Language="C#" MasterPageFile="~/HomeMaster.Master" AutoEventWireup="true" CodeBehind="Cajeros.aspx.cs" Inherits="CapaPresentacion.Cajeros" %>

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
    </style>

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">

    <div class="page-title">
        <h4>Gestión de Cajeros</h4>
        <p>Registro y administración de cajeros disponibles para la simulación bancaria.</p>
    </div>

    <div class="row">

        <!-- FORMULARIO -->
        <div class="col-md-4 mb-4">

            <div class="card">
                <div class="card-header">
                    <i class="fas fa-user-tie"></i>
                    Datos del Cajero
                </div>

                <div class="card-body">

                    <asp:HiddenField ID="txtIdCajero" runat="server" />

                    <div class="form-group">
                        <label class="form-label">Nombre del Cajero</label>
                        <asp:TextBox ID="txtNombreCajero" runat="server" CssClass="form-control" placeholder="Ej: Cajero 1"></asp:TextBox>
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
                        <i class="fas fa-list"></i>
                        Lista de Cajeros
                    </span>

                    <span class="badge badge-primary">
                        Activos
                    </span>
                </div>

                <div class="card-body">

                    <div class="table-responsive">

                        <asp:GridView ID="gvCajeros" runat="server"
                            CssClass="table table-bordered table-hover"
                            AutoGenerateColumns="False"
                            EmptyDataText="No existen cajeros registrados.">

                            <Columns>

                                <asp:BoundField DataField="IdCajero" HeaderText="ID" />

                                <asp:BoundField DataField="NombreCajero" HeaderText="Nombre Cajero" />

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
                                            CommandArgument='<%# Eval("IdCajero") %>'>
                                            <i class="fas fa-edit"></i> Editar
                                        </asp:LinkButton>

                                        <asp:LinkButton ID="btnEliminar" runat="server"
                                            CssClass="btn btn-danger btn-sm btn-action"
                                            CommandName="Eliminar"
                                            CommandArgument='<%# Eval("IdCajero") %>'
                                            OnClientClick="return confirm('¿Está seguro de eliminar este cajero?');">
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