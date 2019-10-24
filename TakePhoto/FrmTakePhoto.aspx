<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="FrmTakePhoto.aspx.cs" Inherits="TakePhoto.FrmTakePhoto" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <link rel="stylesheet" href="Content/bootstrap.min.css" />
    <link href="Content/CSS/geral.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <div class="modal fade bd-example-modal-lg" id="modalPhoto" tabindex="-1" role="dialog" aria-labelledby="myExtraLargeModalLabel" aria-modal="true">
                <div class="modal-dialog modal-lg heightModal">
                    <div class="modal-content insideModalHeight">
                        <div class="modal-header">
                            <h5 class="modal-title h4" id="myExtraLargeModalLabel">Envio de fotos</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">×</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <div class="row insideModalHeight">
                                <div class="col-lg-12">
                                    <iframe src="FrmSalvarImagem.aspx?idUsuario=500" style="width: 100%; height: 100%;"></iframe>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <script src="Scripts/jquery-3.0.0.min.js"></script>
        <script src="Scripts/bootstrap.min.js"></script>
        <script>
            $(document).ready(function () {
                $('#modalPhoto').modal('show');
            });
        </script>
    </form>
</body>
</html>
