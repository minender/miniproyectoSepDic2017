
<div class="row"><h1 class="span6">Bienvenido, ${usuario.login}.</h1></div>
<table>
    <tr><td>Nombre:</td><td>${usuario.getNombre()}</td></tr>
    <tr><td>Apellido:</td><td>${usuario.getApellido()}</td></tr>
    <tr><td>Correo:</td><td>${usuario.getCorreo()}</td></tr>
    <tr><td>Materia:</td><td>${usuario.getMateria().getNombre()}</td></tr>
</table>
<br>
<div class="row" style="margin-left: 1%"><a href="editar"><button type="button" class="btn row">Editar Perfil</button></a></div>
