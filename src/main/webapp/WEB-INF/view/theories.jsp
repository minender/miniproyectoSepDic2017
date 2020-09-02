<%-- 
    Document   : theories
    Created on : Mar 1, 2020, 4:21:08 AM
    Author     : jt
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html>
<tiles:insertDefinition name="header" />
<script type="text/x-mathjax-config">
          MathJax.Hub.Config({
          tex2jax: {
          inlineMath: [ ['$','$'], ["\\(","\\)"] ],
          processEscapes: true
          }
         });
</script>
<script type="text/javascript" src="http://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-AMS-MML_HTMLorMML"></script>
<script type="text/javascript" charset="utf8" src="https://cdn.datatables.net/1.10.20/js/jquery.dataTables.js"></script>
<link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.10.20/css/jquery.dataTables.css">
   
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto|Varela+Round">
<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">

<style type="text/css">
    body {
        color: #566787;
		background: #f5f5f5;
		font-family: 'Varela Round', sans-serif;
		font-size: 13px;
	}
	.table-wrapper {
        background: #fff;
        padding: 20px 25px;
        margin: 30px 0;
		border-radius: 3px;
        box-shadow: 0 1px 1px rgba(0,0,0,.05);
    }
	.table-title {        
		padding-bottom: 15px;
		background: #435d7d;
		color: #fff;
		padding: 16px 30px;
		margin: -20px -25px 10px;
		border-radius: 3px 3px 0 0;
    }
    .table-title h2 {
		margin: 5px 0 0;
		font-size: 24px;
	}
	.table-title .btn-group {
		float: right;
	}
	.table-title .btn {
		color: #fff;
		float: right;
		font-size: 13px;
		border: none;
		min-width: 50px;
		border-radius: 2px;
		border: none;
		outline: none !important;
		margin-left: 10px;
	}
	.table-title .btn i {
		float: left;
		font-size: 21px;
		margin-right: 5px;
	}
	.table-title .btn span {
		float: left;
		margin-top: 2px;
	}
    table.table tr th, table.table tr td {
        border-color: #e9e9e9;
		padding: 12px 15px;
		vertical-align: middle;
    }
	table.table tr th:first-child {
		width: 60px;
	}
	table.table tr th:last-child {
		width: 40px;
	}
    table.table-striped tbody tr:nth-of-type(odd) {
    	background-color: #fcfcfc;
	}
	table.table-striped.table-hover tbody tr:hover {
		background: #f5f5f5;
	}
    table.table th i {
        font-size: 13px;
        margin: 0 5px;
        cursor: pointer;
    }	
    table.table td:last-child i {
		opacity: 0.9;
		font-size: 22px;
        margin: 0 5px;
    }
	table.table td a {
		font-weight: bold;
		color: #566787;
		display: inline-block;
		text-decoration: none;
		outline: none !important;
	}
	table.table td a:hover {
		color: #2196F3;
	}
	table.table td a.edit {
        color: #FFC107;
    }
    table.table td a.delete {
        color: #F44336;
    }
    table.table td i {
        font-size: 19px;
    }
	table.table .avatar {
		border-radius: 50%;
		vertical-align: middle;
		margin-right: 10px;
	}
    .pagination {
        float: right;
        margin: 0 0 5px;
    }
    .pagination li a {
        border: none;
        font-size: 13px;
        min-width: 30px;
        min-height: 30px;
        color: #999;
        margin: 0 2px;
        line-height: 30px;
        border-radius: 2px !important;
        text-align: center;
        padding: 0 6px;
    }
    .pagination li a:hover {
        color: #666;
    }	
    .pagination li.active a, .pagination li.active a.page-link {
        background: #03A9F4;
    }
    .pagination li.active a:hover {        
        background: #0397d6;
    }
	.pagination li.disabled i {
        color: #ccc;
    }
    .pagination li i {
        font-size: 16px;
        padding-top: 6px
    }
    .hint-text {
        float: left;
        margin-top: 10px;
        font-size: 13px;
    }    
	/* Custom checkbox */
	.custom-checkbox {
		position: relative;
	}
	.custom-checkbox input[type="checkbox"] {    
		opacity: 0;
		position: absolute;
		margin: 5px 0 0 3px;
		z-index: 9;
	}
	.custom-checkbox label:before{
		width: 18px;
		height: 18px;
	}
	.custom-checkbox label:before {
		content: '';
		margin-right: 10px;
		display: inline-block;
		vertical-align: text-top;
		background: white;
		border: 1px solid #bbb;
		border-radius: 2px;
		box-sizing: border-box;
		z-index: 2;
	}
	.custom-checkbox input[type="checkbox"]:checked + label:after {
		content: '';
		position: absolute;
		left: 6px;
		top: 3px;
		width: 6px;
		height: 11px;
		border: solid #000;
		border-width: 0 3px 3px 0;
		transform: inherit;
		z-index: 3;
		transform: rotateZ(45deg);
	}
	.custom-checkbox input[type="checkbox"]:checked + label:before {
		border-color: #03A9F4;
		background: #03A9F4;
	}
	.custom-checkbox input[type="checkbox"]:checked + label:after {
		border-color: #fff;
	}
	.custom-checkbox input[type="checkbox"]:disabled + label:before {
		color: #b8b8b8;
		cursor: auto;
		box-shadow: none;
		background: #ddd;
	}
	/* Modal styles */
	.modal .modal-dialog {
		max-width: 400px;
	}
	.modal .modal-header, .modal .modal-body, .modal .modal-footer {
		padding: 20px 30px;
	}
	.modal .modal-content {
		border-radius: 3px;
	}
	.modal .modal-footer {
		background: #ecf0f1;
		border-radius: 0 0 3px 3px;
	}
    .modal .modal-title {
        display: inline-block;
    }
	.modal .form-control {
		border-radius: 2px;
		box-shadow: none;
		border-color: #dddddd;
	}
	.modal textarea.form-control {
		resize: vertical;
	}
	.modal .btn {
		border-radius: 2px;
		min-width: 100px;
	}	
	.modal .form label {
		font-weight: normal;
	}	
</style>


<script type="text/javascript">
$(document).ready(function(){
	// Activate tooltip
	$('[data-toggle="tooltip"]').tooltip();
	
	// Select/Deselect checkboxes
	var checkbox = $('table tbody input[type="checkbox"]');
	$("#selectAll").click(function(){
		if(this.checked){
			checkbox.each(function(){
				this.checked = true;                        
			});
		} else{
			checkbox.each(function(){
				this.checked = false;                        
			});
		} 
	});
	checkbox.click(function(){
		if(!this.checked){
			$("#selectAll").prop("checked", false);
		}
	});
});
</script>
<body>
        <tiles:insertDefinition name="nav" />
    
    <div class="container-fluid">
        <div class="table-wrapper" style="overflow-x:auto;">
            <div class="table-title">
                <div class="row">
                    <div class="col-sm-6">
			<h2>Simbols<b>Manage</b></h2>
                    </div>
                    <div class="col-sm-6">
			<a href="#addEmployeeModal" class="btn btn-success" data-toggle="modal"><i class="material-icons">&#xE147;</i> <span>Add a new symbol</span></a>
                    </div>
                </div>
            </div>
            <table class="table table-striped table-hover" id="table_id">
                <thead>
                    <tr>

                        <th>ID</th>
                        <th>Simbol</th>
                        <th>Latex notation</th>
                        <th>Arguments</th>
                        <th>Is infix</th>
                        <th>Associativity</th>
                        <th>Precedence</th>
                        <th>Notation</th>
                        <th>Theory</th>
                        <th>Actions</th>
                        
                        
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="simbolo" items="${listaSimbolos}" varStatus="loop"> 
                    <tr>
                        <td>${simbolo.getId()}</td>
                        <td>$$${simbolo.getNotacion_latex()}$$</td>
			<td>${simbolo.getNotacion_latex()}</td>
                        <td>${simbolo.getArgumentos()}</td>
                        <c:choose>
                            <c:when test="${simbolo.isEsInfijo() == true}">
                                <td>Yes</td>
                            </c:when>   
                            <c:when test="${simbolo.isEsInfijo() == false}">
                                <td>No</td>
                            </c:when>
                        </c:choose>
                                <td></td>
                        <td>${simbolo.getPrecedencia()}</td>
                        <td>${simbolo.getNotacion()}</td>
                        <td>${simbolo.getTeoria().getNombre()}</td>
                        <td>
                            <a href="#editEmployeeModal" class="edit" data-toggle="modal" onclick="editSimbol(${loop.index})"><i class="material-icons" data-toggle="tooltip" title="Edit">&#xE254;</i></a>
                        </td>
                    </tr>
                    </c:forEach>
                </tbody>
            </table>

        </div>
    </div>
	<!-- Edit Modal HTML -->
	<div id="addEmployeeModal" class="modal fade">
		<div class="modal-dialog">
			<div class="modal-content">
				<sf:form class="form" method="POST" modelAttribute="agregarSimbolo">
                                        <sf:input path="modificar" name="edit" type="hidden" value="false"/>
					<div class="modal-header">						
						<h4 class="modal-title">Add Symbol</h4>
						<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
					</div>
					<div class="modal-body">					
						<div class="form-group">
							<label>Latex Notation (*)</label>
                                                        <sf:input path="notacion_latex" name="notacion_latex" type="text" class="form-control"/>

						</div>
						<div class="form-group">
							<label>Arguments (*)</label>
                                                        <sf:input path="argumentos" type="number" name="argumentos" class="form-control"/>
						</div>
						<div class="form-group form-check form-check-inline" style="width: 100%;">
                                                    <div class="row" style="width: 60%;">
                                                        <div class="col-3">
                                                            <label>Is Infix (*)</label>

                                                        </div>
                                                        <div class="col-3">
                                                            <form:radiobutton path="esInfijo" value="true" id="es-infijo" name="esInfijo" class="form-control form-check-input"/>
                                                            <label for="true" class="form-check-label">Yes</label><br>                                                        
                                                        </div>
                                                        <div class="col-3">
                                                            <form:radiobutton path="esInfijo" value="false" id="es-infijo" name="esInfijo" class="form-control form-check-input"/>
                                                            <label for="false" class="form-check-label">No</label><br>   
                                                            
                                                        </div>
                                                    </div>

						</div>
                                            	<div class="form-group" id="asociatividad-box">
                                                    <div style="width:100%;">
                                                    <label>Asociativity (*)</label>
                                                    </div>
                                                    <div style="width:100%;">
                                                    <form:select path="asociatividad">
                                                        <form:option value="0" label="Left"/>
                                                        <form:option value="1" label="Right"/>
                                                        <form:option value="2" label="Left/Right"/>
                                                        <form:option value="3" label="None"/>
                                                    </form:select>                                                          
                                                    </div>
                                                                                                       
                                                                                                        
						</div>
                                            	<div class="form-group">
							<label>Precedence (*)</label>
                                                        <sf:input path="precedencia" type="number" class="form-control"/>

						</div>
                                            	<div class="form-group" id="notacion-box">
							<label>Notation (*)</label>
                                                        <sf:input path="notacion" type="text" class="form-control"/>
						</div>
                                            	<div class="form-group">
                                                    <div style="width:100%">
                                                    <label>Theory (*)</label>                                                   
                                                    </div>
                                                    <div style="width:100%">
                                                    <form:select path="teoriaid">
                                                        <c:forEach items="${listaTeorias}" var="teoria">
                                                            <form:option value="${teoria.getId()}" label="${teoria.getNombre()}"/>
                                                        </c:forEach>
                                                    </form:select>                                                        
                                                    </div>

                                                    
  
                                                    
						</div>
                                            <label>All fields with (*) are required</label>
					</div>
                                    
					<div class="modal-footer">
						<input type="button" class="btn btn-default" data-dismiss="modal" value="Cancel">
						<input type="submit" class="btn btn-success" value="Add">
					</div>
				</sf:form>
			</div>
		</div>
	</div>
	<!-- Edit Modal HTML -->
	<div id="editEmployeeModal" class="modal fade">
		<div class="modal-dialog">
			<div class="modal-content">
				<sf:form class="form" method="PUT" modelAttribute="agregarSimbolo">
					<div class="modal-header">						
						<h4 class="modal-title">Modify Simbol</h4>
                                                <button type="button" class="close" data-dismiss="modal" aria-hidden="true" onclick="revertirNotacionInfijaEdit()">&times;</button>
					</div>
					<div class="modal-body">
                                                <sf:input path="modificar" name="edit" type="hidden" value="true"/>
                                                <sf:input path="id" name="id-edit" type="hidden" id="id-edit"/>
						<div class="form-group">
							<label>Latex Notation(*)</label>
                                                        <sf:input path="notacion_latex" name="notacion_latex" type="text" class="form-control" id="notacion-latex-edit"/>

						</div>
						<div class="form-group">
							<label>Arguments (*)</label>
                                                        <sf:input path="argumentos" type="number" name="argumentos" class="form-control" id="argumentos-edit"/>
						</div>
						<div class="form-group form-check form-check-inline" style="width: 100%;">
                                                    <div class="row" style="width: 60%;">
                                                        <div class="col-3">
                                                            <label>Is Infix (*)</label>

                                                        </div>
                                                        <div class="col-3">
                                                            <form:radiobutton path="esInfijo" value="true" id="es-infijo-edit1" name="esInfijo" class="form-control form-check-input"/>
                                                            <label for="true" class="form-check-label">Yes</label><br>                                                        
                                                        </div>
                                                        <div class="col-3">
                                                            <form:radiobutton path="esInfijo" value="false" id="es-infijo-edit2" name="esInfijo" class="form-control form-check-input"/>
                                                            <label for="false" class="form-check-label">No</label><br>   
                                                            
                                                        </div>
                                                    </div>

						</div>
                                            	<div class="form-group" id="asociatividad-box-edit">
                                                    <div style="width:100%;">
                                                    <label>Asociativity (*)</label>
                                                    </div>
                                                    <div style="width:100%;">
                                                    <form:select path="asociatividad" id="asociatividad-edit">
                                                        <form:option value="0" label="Left"/>
                                                        <form:option value="1" label="Right"/>
                                                        <form:option value="2" label="Left/Right"/>
                                                        <form:option value="3" label="None"/>
                                                    </form:select>                                                          
                                                    </div>
                                                                                                       
                                                                                                        
						</div>
                                            	<div class="form-group">
							<label>Precedence (*)</label>
                                                        <sf:input path="precedencia" type="number" class="form-control" id="precedencia-edit"/>

						</div>
                                            	<div class="form-group" id="notacion-box-edit">
							<label>Notación (*)</label>
                                                        <sf:input path="notacion" type="text" class="form-control" id="notacion-edit"/>
						</div>
                                            	<div class="form-group">
                                                    <div style="width:100%">
                                                    <label>Teoría (*)</label>                                                   
                                                    </div>
                                                    <div style="width:100%">
                                                    <form:select path="teoriaid" id="teoria-edit">
                                                        <c:forEach items="${listaTeorias}" var="teoria">
                                                            <form:option value="${teoria.getId()}" label="${teoria.getNombre()}"/>
                                                        </c:forEach>
                                                    </form:select>                                                        
                                                    </div>

                                                    
  
                                                    
						</div>
                                            <label>All fields with (*) are required</label>
					</div>
                                    
					<div class="modal-footer">
						<input type="button" class="btn btn-default" data-dismiss="modal" value="Cancel">
						<input type="submit" class="btn btn-success" value="Modify">
					</div>
				</sf:form>
			</div>
		</div>
	</div>
                            		                            
        <tiles:insertDefinition name="footer" />
        <script>
                var regex_none = /%\(a2\)\s*%\(op\)\s*%\(a1\)/
                var regex_left = /%\(aa2\)\s*%\(op\)\s*%\(a1\)/
                var regex_right = /%\(a2\)\s*%\(op\)\s*%\(aa1\)/
                var regex_left_right = /%\(aa2\)\s*%\(op\)\s*%\(aa1\)/
                var table = $('#table_id').DataTable({
                        "drawCallback": function( settings ) {
                        MathJax.Hub.Queue(["Typeset",MathJax.Hub]); 
                    }
                    
                        });
                for (let i = 0; i < table.rows().count(); i ++){
                    var temp = table.row(i).data();
                    if (temp[4] == 'Yes'){
                        if (temp[7].match(regex_left)){
                            temp[5] = 'Left';
                        }else if (temp[7].match(regex_right)){
                            temp[5] = 'Right';
                        }else if (temp[7].match(regex_left_right)){
                            temp[5] = 'Left/Right';
                        }else if (temp[7].match(regex_none)){
                            temp[5] = 'None';
                        }else{
                            temp[5] = 'None'
                        }                        
                    }else{
                        temp[5] = 'None'
                    }

                    table.row(i).data(temp).invalidate().draw();
                }
                function editSimbol(row_number){
                    fields = table.row(row_number).data();
                    $('#id-edit').val(fields[0]);
                    $('#notacion-latex-edit').val(fields[2]);
                    $('#argumentos-edit').val(fields[3]);
                    console.log(fields[4]);
                    if (fields[4] === 'Yes'){
                       $('#es-infijo-edit1').prop("checked", true);
                       $('#es-infijo-edit2').prop("checked", false);
                    }else{
                        $('#es-infijo-edit1').prop("checked", false);
                       $('#es-infijo-edit2').prop("checked", true);
                    }
//                    if (fields[5] === 'Izquierda'){
//                       $('#asociatividad-edit').val(0)
//                    }else if (fields[5] === 'Derecha'){
//                       $('#asociatividad-edit').val(1)
//                    }else if (fields[5] === 'Izquierda y Derecha'){
//                       $('#asociatividad-edit').val(2)
//                    }else if (fields[5] === 'Ninguno'){
//                       $('#asociatividad-edit').val(3)
//                    }
                    $('#precedencia-edit').val(fields[6]);
                    $('#notacion-edit').val(fields[7])
                    //Modificacion para infijos
                    if(fields[4]== 'Yes'){
                        notacionInfijaEditFill();
                        
                    }else{
                        $("#asociatividad-box-edit").hide();
                        $('#notacion-edit').val(fields[7]);
                        if (fields[5] === 'Left'){
                            $('#asociatividad-edit').val(0)
                        }else if (fields[5] === 'Right'){
                            $('#asociatividad-edit').val(1)
                        }else if (fields[5] === 'Left/Right'){
                            $('#asociatividad-edit').val(2)
                        }else if (fields[5] === 'None'){
                            $('#asociatividad-edit').val(3)
                        }
                    }
                    if (fields[8] == 'Logica Proposicional'){
                        $('#teoria-edit').val(1);
                    }                
                }
        </script>
        <script>
            
            function writeNotacionByAso(asociatividad){
                if (asociatividad.val()==0){
                    $("#notacion").val("%(aa2) %(op) %(a1)")
                }
                else if (asociatividad.val()==1){
                    $("#notacion").val("%(a2) %(op) %(aa1)")
                }
                else if (asociatividad.val()==2){
                    $("#notacion").val("%(aa2) %(op) %(aa1)")
                }
                else if (asociatividad.val()==3){
                    $("#notacion").val("%(a2) %(op) %(a1)")
                }
                
            }
            function writeNotacionByAsoEdit(asociatividad){
                if (asociatividad.val()==0){
                    $("#notacion-edit").val("%(aa2) %(op) %(a1)")
                }
                else if (asociatividad.val()==1){
                    $("#notacion-edit").val("%(a2) %(op) %(aa1)")
                }
                else if (asociatividad.val()==2){
                    $("#notacion-edit").val("%(aa2) %(op) %(aa1)")
                }
                else if (asociatividad.val()==3){
                    $("#notacion-edit").val("%(a2) %(op) %(a1)")
                }
                
            }
            function notacionInfija(){
                $("#notacion-box").hide();
                $("#asociatividad-box").show();
                $("#argumentos").val(2).prop("readonly", true);
                $("#asociatividad").val(0)
                asociatividad = $("#asociatividad")
                writeNotacionByAso(asociatividad);
                asociatividad.change(()=>{
                    writeNotacionByAso(asociatividad)
                })
            }
            function notacionInfijaEditFill(){
                $("#notacion-box-edit").hide();
                $("#asociatividad-box-edit").show();
                $("#argumentos-edit").val(2).prop("readonly", true);
                if ($('#notacion-edit').val().match(regex_left)){
                     $('#asociatividad-edit').val(0)
                }else if($('#notacion-edit').val().match(regex_right)){

                    $('#asociatividad-edit').val(1)
                }else if($('#notacion-edit').val().match(regex_left_right)){

                    $('#asociatividad-edit').val(2)
                }else if($('#notacion-edit').val().match(regex_none)){

                    $('#asociatividad-edit').val(3)
                }
                asociatividad = $("#asociatividad-edit");
                asociatividad.change(()=>{
                    writeNotacionByAsoEdit(asociatividad)
                })

            }
            function notacionInfijaEdit(){
                $("#notacion-box-edit").hide();
                $("#asociatividad-box-edit").show();
                $("#asociatividad-edit").val(0)
                $("#argumentos-edit").val(2).prop("readonly", true);
                asociatividad = $("#asociatividad-edit")
                writeNotacionByAsoEdit(asociatividad);
                asociatividad.change(()=>{
                    writeNotacionByAsoEdit(asociatividad)
                })
            }
            function revertirNotacionInfija(){
                $("#notacion-box").show();
                $("#asociatividad").val(3)
                $("#asociatividad-box").hide()
                $("#argumentos").val("").prop("readonly", false);
                $("")
            }
            function revertirNotacionInfijaEdit(){
                $("#notacion-box-edit").show();
                $("#asociatividad-edit").val(3)
                $("#asociatividad-box-edit").hide();
                $("#argumentos-edit").val("").prop("readonly", false);
            }
            revertirNotacionInfija();
            if ($('input[name="esInfijo"]').val() == true){
                notacionInfija();
            }
            $('input[name="esInfijo"]').change(()=>{
               if ($('input[name="esInfijo"]:checked').val() == 'true'){
                notacionInfija();
            }else{
                revertirNotacionInfija()
            }
            })
            $('input[name="esInfijo"]').change(()=>{
               if ($('#es-infijo-edit1').prop("checked")){
                notacionInfijaEdit();
            }else{
                revertirNotacionInfijaEdit()
            }
            })
        </script>
</body>
</html>

