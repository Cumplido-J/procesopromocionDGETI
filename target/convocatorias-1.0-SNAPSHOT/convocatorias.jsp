<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <title>DGETI | gob.mx</title>
        <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@500&display=swap" rel="stylesheet">
        <link href="/favicon.ico" rel="shortcut icon">
        <link href="https://framework-gb.cdn.gob.mx/assets/styles/main.css" rel="stylesheet">

        <!-- Respond.js soporte de media queries para Internet Explorer 8 -->
        <!-- ie8.js EventTarget para cada nodo en Internet Explorer 8 -->
        <!--[if lt IE 9]>
          <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
          <script src="https://cdnjs.cloudflare.com/ajax/libs/ie8/0.2.2/ie8.js"></script>
        <![endif]-->
        <!--Termina  para el framework del gobierno-->
        <link rel="stylesheet" href="convocatoria/recursos/font-awesome-4.7.0/css/font-awesome.min.css">
        <link rel="stylesheet" href="convocatoria/recursos/css/estilos.css">
        <script type="text/javascript" src="convocatoria/recursos/js/convocatorias.js"></script>
        <script src="https://code.jquery.com/jquery-1.12.4.js"></script> 
    </head>
    <body>
        <jsp:include page="layout/navbar.jsp"/>
        <div class="padre">

            <jsp:include page="layout/header.jsp"/>
            <jsp:include page="paginas/convocatoria/componentes.jsp"/>

            <jsp:include page="layout/footer.jsp"/>

        </div>
        <div class="modal fade" id="modalMensaje" role="dialog">
            <div class="modal-dialog">

              <!-- Modal content-->
              <div class="modal-content panel">
                <div class="modal-header">
                  <button type="button" class="close" data-dismiss="modal">&times;</button>
                  <h4 class="modal-title">Aviso</h4>
                </div>
                <div class="modal-body">
                  <p id="mensaje">Generando documento.</p>
                  <iframe src="" id="ifArchivo" width="100%" height="300px" hidden ></iframe>
                </div>
                <div class="modal-footer">
                  <button type="button" class="btn btn-sm btn-default" data-dismiss="modal">Cerrar</button>
                </div>
              </div>

            </div>
          </div>
    </body>
</html>
