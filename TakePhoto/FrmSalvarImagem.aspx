<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="FrmSalvarImagem.aspx.cs" Inherits="TakePhoto.FrmSalvarImagem" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <link rel="stylesheet" href="Content/bootstrap.min.css" />
    <link rel="stylesheet" href="Fontsawesome/css/all.min.css" />
    <link href="Content/CSS/geral.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <br />
            <div class="row tamanhoLinha" style="margin:auto;">
                <div class="col-lg-12" style="display:inline-flex;text-align:center;">
                    <div class="col-lg-6">
                        <button class="btn btn-info" id="btnAbrirWebCam" onclick="iniciarWebCam();return false;" style="width: 250px; margin-left: 3px;"><i class="fas fa-video"></i>&nbsp Abrir WebCam</button>
                        <button class="btn btn-danger" id="btnCancelarOperacao" style="width: 250px; margin-left: 3px;display:none;"><i class="fas fa-times"></i>&nbsp Cancelar</button>
                        <button class="btn btn-primary" id="btnTentarNovamente" style="width: 250px; margin-left: 3px;display:none;"><i class="fas fa-backward"></i>&nbsp Capturar Novamente</button>
                    </div>
                    <div class="col-lg-6">
                        <button id="btnCapturar" onclick="capturarImagem();return false;" style="width: 250px; margin-left: 3px; display: none;" class="btn btn-primary form-control"><i class="fas fa-camera-retro"></i>&nbsp Capturar</button>
                        <button id="btnSalvar" onclick="requestSaveImage();return false;" class="btn btn-success" style="width: 250px; margin-left: 3px;display:none;"><i class='far fa-save'></i>&nbsp Salvar</button>
                    </div>
                </div>
            </div>
            <br />
            <div class="video-wrap" id="webCamVideo">
                <video id="video" playsinline autoplay class="imagemUsuario" style="margin: auto;"></video>
         <%--       <div class="row">
                    <div class="col-lg-12">
                        <button id="btnCapturar" onclick="capturarImagem();return false;" style="width: 500px; margin-left: 3px; display: none;" class="btn btn-primary form-control">Capturar</button>
                    </div>
                </div>--%>
            </div>
            <div id="imageArea" class="imageArea" style="display: none;" runat="server">
                <div class="row tamanhoLinha">
                    <div class="col-lg-12" style="text-align:center;">      
                        <div style="width: 500px; margin-left: 3px; text-align: center; margin-top: 5px;">
                            <p id="fileName"></p>
                        </div>
                        <canvas id="canvas" width="640" height="480"></canvas>
                        <asp:Image ID="imgUsuario" CssClass="img-thumbnail img-responsive imagemUsuario" runat="server" />
                        <asp:TextBox runat="server" ID="txtBaseImage" Style="visibility: hidden;"></asp:TextBox>
                    </div>
                </div>
            </div>
            <!--MODAL MENSAGEM--->
            <div class="modal fade" tabindex="-1" role="dialog" id="modalMensagem">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="modalTitle"></h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <label id="modalBody"></label>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-danger" data-dismiss="modal">Fechar</button>
                        </div>
                    </div>
                </div>
            </div>
            <!--/MODAL MENSAGEM-->
        </div>
        <script src="Scripts/jquery-3.0.0.min.js"></script>
        <script src="Scripts/bootstrap.min.js"></script>
        <script>
            //Script de captura de imagem da webcam
            'use strict';

            const video = document.getElementById('video');
            const canvas = document.getElementById('canvas');
            const snap = document.getElementById('btnCapturar');
            const imagemUsuario = document.getElementById('<%=imgUsuario.ClientID%>');
            const constraints =
            {
                audio: false,
                video:
                {
                    width: 1920,
                    height: 1080
                }
            };

            //Inicia a captura da webcam
            async function iniciarWebCam() {
                try {
                    const stream = await navigator.mediaDevices.getUserMedia(constraints);
                    handleSuccess(stream);
                    $("#btnAbrirWebCam").css({ "display": "none" });
                    $("#btnCancelarOperacao").css({ "display": "block" });
                    $('#btnCapturar').fadeIn('fast');
                    $('.imageArea').css({ 'display': 'none' });
                    $('#btnSalvar').css({ 'display': 'none' });
                    $('#webCamVideo').css({ 'display': 'block' });
                }
                catch (e) {
                    alert(`navigator.getUserMedia.error:${e.toString()}`);
                }
            }

            //Cancela a operação de capturar a foto
            $('#btnCancelarOperacao').on("click", function () {
                var idUsuario = <%=Request.QueryString["idUsuario"].ToString()%>;
                window.location.href = "FrmSalvarImagem.aspx?idUsuario="+idUsuario;
            })

            //Transmite a webcam no componente video
            function handleSuccess(stream) {
                window.stream = stream;
                video.srcObject = stream;
            }

            var context = canvas.getContext('2d');

            //Captura a imagem da webcam
            function capturarImagem() {  
                context.imageSmoothingQuality = true;
                context.drawImage(video, 0, 0, 640, 480);
               // context.drawImage(video, 0, 0, 600, 600);
                $('.imageArea').css({ 'display': 'block' });
                $('#btnSalvar').css({ 'display': 'block' });
                $('#webCamVideo').css({ 'display': 'none' });
                canvas.style.display = 'none';
                imagemUsuario.src = convertCanvasToImage(canvas);
                var baseResult = imagemUsuario.src;
                baseResult = baseResult.split(',')[1];
                $('#<%=txtBaseImage.ClientID%>').val(baseResult);
                $('#btnCapturar').css({ "display": "none" });
                $('#btnCancelarOperacao').css({ "display": "none" });
                $('#btnTentarNovamente').css({ "display": "block" });
            }

            //Converte o canvas para uma imagem e retorna o base64
            function convertCanvasToImage(canvas) {
                var image = new Image();
                image.src = canvas.toDataURL("image/jpeg", 1.0);
                return image.src;
            }

            //Evento de realizar uma nova captura
            $('#btnTentarNovamente').on("click", function () {
                $('.imageArea').css({ 'display': 'none' });
                $('#btnSalvar').css({ 'display': 'none' });
                $('#webCamVideo').css({ 'display': 'block' });
                $('#btnCapturar').css({ "display": "block" });
                $('#btnCancelarOperacao').css({ "display": "block" });
                $('#btnTentarNovamente').css({ "display": "none" });
                imagemUsuario.src = "";
                return false;
            })
        </script>
        <script>
            //Script modal
            function modalMensagem(titulo, mensagem) {
                $('#modalTitle').text(titulo);
                $('#modalBody').text(mensagem);
                $('#modalMensagem').modal('show');
            }
        </script>
        <script>
            //Realiza a requisição para salvar a foto
            function requestSaveImage() {
                var baseImage = $('#<%=txtBaseImage.ClientID%>').val();
                var userId = <%=Request.QueryString["idUsuario"].ToString()%>;
            var data =
            {
                sFotoUsuarioBase: baseImage,
            }

            $.ajax({
                url: "gravafoto.ashx?idUsuario=" + userId,
                data: JSON.stringify(data),
                type: "POST",
                contentType: "application/json",
                success: function () {
                    modalMensagem("Atenção", "Dados cadastrados com sucesso!!");
                    $('.imageArea').css({ 'display': 'none' });
                    $('#btnSalvar').css({ 'display': 'none' });
                    $('#btnTentarNovamente').css({ 'display': 'none' });
                    $('#btnAbrirWebCam').css({ 'display': 'block' });
                },
                error: function () {
                    modalMensagem("Atenção", "Ocorreu um erro ao gravar os dados, contate o administrador do sistema!!");
                }
            })
        }
        </script>
    </form>
</body>
</html>
