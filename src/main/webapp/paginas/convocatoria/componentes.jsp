<jsp:useBean id="catalogo" class="herramientas.Catalogos" />
<section class="sectionreg">
    <div class="row">
        <div class="col-md-2">
            <p>Entidad</p>
        </div>
        <div class="col-md-4">
            <div>
                <select name="cboentidad" id="cboentidad" onchange="listarPlanteles(this.value);" class="form-control">
                    ${catalogo.desplegarOpcionesEstado()}
                </select>
            </div>
        </div>
        <div class="col-md-2">
            <p>Plantel</p>

        </div>
        <div class="col-md-4">
            <div>
                <select name="cboplantel" id="cboplantel" onchange="crearVacancias(this.value)" class="form-control">
                    <option value='-1'>Seleccione un plantel</option> 

                </select>
            </div>
        </div>
    </div>

    <div>
        <h4><span id="nombrePlantel"></span></h4>
        <table class="table table-responsive table-bordered table-striped">
            <thead>
                <tr>
                    <th>Convocatorias</th><th>Descargar</th>
                </tr>
            </thead>
            <tbody id="vacanciaData">

            </tbody>
        </table>    
    </div>

</section>

                        
