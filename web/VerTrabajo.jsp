<%-- 
    Document   : VerTrabajo
    Created on : 14/03/2018, 12:07:08 PM
    Author     : Alex
--%>

<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.*" session="true" %>
<%@ page import="modelo.Persona"%>
<%@ page import="modelo.Tutoria"%>
<%@ page import="modelo.Taller"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.ArrayList"%>
<!DOCTYPE html>
<%! HttpSession sesion = null;%>
<%! int i;%>
<%! Persona usu = null;%>
<%! List workList = null;%>
<%! Taller tls = null;%>
<%
    sesion = request.getSession();
    if (sesion != null) {
        usu = (Persona) sesion.getAttribute("usuario");
    }
%>

<%  
    sesion = request.getSession();
    if (sesion != null) {
        workList = (ArrayList) sesion.getAttribute("listaTalleres");
    }
%>

<%
    for (i = 0; i < workList.size(); i++) {
        tls = (Taller) workList.get(i);
        if (tls.getTutoria().getCodigoTutoria() == Integer.parseInt(request.getParameter("CodigoTutoria"))) {
            i = workList.size();
        }
    }
%>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8, width=device-width, initial-scale=1.0">
        <title>Asesorías Académicas</title>
        <link rel="stylesheet" type="text/css" href="css/style.css">
        <link rel="stylesheet" type="text/css" href="fonts.css">
        <script src="http://code.jquery.com/jquery-latest.js"></script>
        <script type="text/javascript">

            /*
             
             La funcion paginaActiva() modifica el color a blanco (#FDFDFD) de la pestaña cargada.
             
             */
            function personalizarElementos() {
                if (document.getElementById("solicitaTuClasePresencial").firstChild.href == window.location.href) {
                    sessionStorage.clear();
                    document.getElementById("solicitaTuClase").style.backgroundColor = "#FDFDFD";
                    document.getElementById("solicitaTuClase").firstChild.style.color = "#1C242A";
                }

                if (!sessionStorage.getItem("submenuActivo") && sessionStorage.getItem("clickPag")) {
                    document.getElementById(sessionStorage.getItem("clickPag")).style.backgroundColor = "#FDFDFD";
                    document.getElementById(sessionStorage.getItem("clickPag")).firstChild.style.color = "#1C242A";
                }
                else if (sessionStorage.getItem("submenuActivo") == "solicitaTuClase") {
                    sessionStorage.clear();
                    document.getElementById("solicitaTuClase").style.backgroundColor = "#FDFDFD";
                    document.getElementById("solicitaTuClase").firstChild.style.color = "#1C242A";
                }
                
                if ('<%= session.getAttribute("confirmacionFallidaVerTrabajo")%>' != "" && '<%= session.getAttribute("confirmacionExitosaVerTrabajo")%>' == "") {
                    document.getElementById("confirmacionFallidaVerTrabajo").innerHTML = '<%= session.getAttribute("confirmacionFallidaVerTrabajo")%>';
                    document.getElementById("confirmacionFallidaVerTrabajo").style.display = "block";
                    document.getElementById("confirmacionExitosaVerTrabajo").style.display = "none";
                } else if ('<%= session.getAttribute("confirmacionFallidaVerTrabajo")%>' == "" && '<%= session.getAttribute("confirmacionExitosaVerTrabajo")%>' != "") {
                    document.getElementById("confirmacionExitosaVerTrabajo").innerHTML = '<%= session.getAttribute("confirmacionExitosaVerTrabajo")%>';
                    document.getElementById("confirmacionExitosaVerTrabajo").style.display = "block";
                    document.getElementById("confirmacionFallidaVerTrabajo").style.display = "none";
                }
            }

            function anteriorStep(fieldset) {
                var steps = document.getElementsByTagName("fieldset");
                for (var i = 0; i < steps.length; i++) {
                    if (steps[i].id == fieldset) {
                        steps[i].style.display = "none";
                        steps[i - 1].style.display = "block";
                    }
                }
            }

            function siguienteStep(fieldset) {
                var steps = document.getElementsByTagName("fieldset");
                for (var i = 0; i < steps.length; i++) {
                    if (steps[i].id == fieldset) {
                        if (fieldset == "datosClase") {
                            if (document.getElementById("mensaje").value == "") {
                                document.getElementById("mensaje").required = true;
                            }
                            else {
                                steps[i].style.display = "none";
                                steps[i + 1].style.display = "block";
                            }
                        }
                        else if (fieldset == "datosHorario") {
                            if (document.getElementById("duracion").value == "") {
                                document.getElementById("duracion").required = true;
                            }
                            else {
                                steps[i].style.display = "none";
                                steps[i + 1].style.display = "block";
                            }
                        }
                        else {
                            steps[i].style.display = "none";
                            steps[i + 1].style.display = "block";
                        }
                    }
                }
            }

            /*
             
             La funcion validar() verifica los campos del formulario, retorna "false" si algun campo no cumple con las restricciones definidas.
             
             */

            function validar() {
                var campos = document.getElementsByClassName("contformulario");
                for (var i = 0; i < campos.length; i++) {
                    if (!campos[i].checkValidity()) {
                        return false;
                    }
                }
            }

            /*
             
             La funcion establecerElemento(pagina) define el objeto sessionStorage "clickPag" como el id del Nodo padre del elemento sobre el que sea hace click.
             
             */

            function establecerElemento(pagina) {
                sessionStorage.setItem("clickPag", pagina.parentNode.id);
            }

            /*
             
             La funcion establecerElementoSubmenu() define el objeto sessionStorage "submenuActivo" como el id "solicitaTuClase" que contiene los elementos del submenu sobre el que se hace click.
             
             */

            function establecerElementoSubmenu() {
                sessionStorage.setItem("submenuActivo", "solicitaTuClase");
            }
            
            /*
        
            La funcion main crea la animación del menu desplegable y adaptable a dispositivos móviles.

             */    

            $(document).ready(main);
            var contador = 1;

            function main () {
                $('.menu_bar').click(function(){
                        if (contador == 1) {
                                $('nav').animate({
                                        left: '0'
                                });
                                contador = 0;
                        } else {
                                contador = 1;
                                $('nav').animate({
                                        left: '-100%'
                                });
                        }
                });

                $('#solicitaTuClase').click(function(){
                        $(this).children('#l02').slideToggle();
                });
            }
        </script>
    </head>
    <body onload="personalizarElementos()">
        <header>
            <%if (usu != null) {%>
                <a href="logout" class="enlaceLogin" onclick="return confirm('¿Está seguro(a) de cerrar sesión?');">Cerrar sesión</a></br>
                <a href="miCuenta.jsp" class="enlaceLogin">Mi cuenta</a>
            <%} else {%>
                <a href="login.jsp" class="enlaceLogin">Iniciar sesión</a>
            <%}%>
            <a href="index.jsp" id="enlaceBanner">
                <div>
                    <div class="cabecera">
                        <h1>Asesorías Académicas</h1>
                        <h3>Justo lo que necesitabas!</h3>
                    </div>
                    <div class="imgcabecera">
                        <a href="index.jsp"><img src="imagenes/banner.png" alt="banner" id="imagenCabecera"></a>
                    </div>
                </div>
            </a>
        </header>
        <div class="menu_bar">
            <a href="#" class="bt-menu"><span class="icon-menu"></span>Menú</a>
        </div>
        <nav>
            <ul id="l01">
                <li id="index"><a href="index.jsp" onclick="establecerElemento(this)">Inicio</a></li>
                <li id="asignaturas"><a href="asignaturas.jsp" onclick="establecerElemento(this)">Asignaturas</a></li>
                    <%if (usu != null) {%>
                <li id="solicitaTuClase"><a href="#">Solicita tu clase</a>
                    <ul id="l02">
                        <li id="solicitaTuClasePresencial"><a href="solicitaTuClasePresencial.jsp" onclick="establecerElementoSubmenu()">Presencial</a></li>
                        <li id="solicitaTuClaseVirtual"><a href="solicitaTuClaseVirtual.jsp" onclick="establecerElementoSubmenu()">Virtual</a></li>
                    </ul>
                </li>
                <li id="dejanosTuTrabajo"><a href="dejanosTuTrabajo.jsp" onclick="establecerElemento(this)">Dejanos tu trabajo</a></li>
                    <%} else {%>
                <li id="solicitaTuClase"><a href="#">Solicita tu clase</a>
                    <ul id="l02">
                        <li id="solicitaTuClasePresencial"><a href="NuevaClasePresencial.jsp" onclick="establecerElementoSubmenu()">Presencial</a></li>
                        <li id="solicitaTuClaseVirtual"><a href="solicitaTuClaseVirtual.jsp" onclick="establecerElementoSubmenu()">Virtual</a></li>
                    </ul>
                </li>
                <li id="dejanosTuTrabajo"><a href="NuevoTrabajo.jsp" onclick="establecerElemento(this)">Dejanos tu trabajo</a></li>
                    <%}%>
                <li id="contacto"><a href="contacto.jsp" onclick="establecerElemento(this)">Contacto</a></li>
            </ul>
        </nav>

        <section id="contenido">

            <ul class="breadcrumb">
                <li>Usted se encuentra aquí: <a href="dejanosTuTrabajo.jsp">Dejanos tu trabajo</a></li>
                <li>Ver Trabajo</li>
            </ul></br>

            <article>
                <p id="confirmacionExitosaVerTrabajo" class="confirmacionExitosa"></p>
                <p id="confirmacionFallidaVerTrabajo" class="confirmacionFallida"></p>
                <p>A continuación usted encontrará en detalle el trabajo seleccionado:</p>
                <section class="datoformulario">
                    <table id="datos">
                        <tr>
                            <th>Datos trabajo</th>
                        </tr>
                        <tr>
                            <td>
                                <p id="fecha"><b>Fecha entrega:</b> <%if (tls != null) {%> <%= tls.getFechaEntregaTaller()%> <%}%></p>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <p id="hora" class="contformulario"><b>Hora entrega:</b> <%if (tls != null) {%> <%= tls.getHoraEntregaTaller()%> <%}%></p>
                            </td>
                        </tr>
                    </table>
                </section>
                <section class="datoformulario">
                    <table id="datos">
                        <tr>
                            <th>Datos Estudiante</th>
                        </tr>
                        <tr>
                            <td>
                                <p id="nombre" class="contformulario"><b>Nombre:</b> <%if (usu != null) {%> <%= usu.getNombrePersona()%> <%}%></p>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <p id="direccion" class="contformulario"><b>Dirección</b> <%if (usu != null) {%> <%= usu.getDireccionPersona()%> <%}%></p>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <p id="barrio" class="contformulario"><b>Barrio:</b> <%if (usu != null) {%> <%= usu.getBarrioResidenciaPersona()%> <%}%></p>
                            </td>
                        </tr>   
                        <tr>
                            <td>
                                <p id="telefono" class="contformulario"><b>Teléfono:</b> <%if (usu != null) {%> <%= usu.getTelefonoPersona()%> <%}%></p>
                            </td>
                        </tr>
                    </table>
                </section>
                <section>
                    <table id="datos">
                        <tr>
                            <th>Datos Tutoría</th>
                        </tr>
                        <tr>
                            <td>
                                <p id="materia" class="contformulario"><b>Materia:</b> <%if (tls != null) {%> <%= tls.getTutoria().getAsignaturaTutoria()%> <%}%></p>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <p id="tema" class="contformulario"><b>Tema:</b> <%if (tls != null) {%> <%= tls.getTutoria().getTemaTutoria()%> <%}%></p>
                            </td>
                        </tr>    
                        <tr>
                            <td>
                                <p id="mensaje" class="contformulario"><b>Dudas/Inquietudes:</b> <%if (tls != null) {%> <%= tls.getTutoria().getDudasInquietudesTutoria()%> <%}%></p>
                            </td>
                        </tr>
                    </table>
                </section>
                <section class="confirmarformulario">
                    <a href="dejanosTuTrabajo.jsp"><button type="button" id="btnAtras">Atrás</button></a>
                    <a href="EditarTrabajo.jsp?CodigoTutoria=<%= tls.getTutoria().getCodigoTutoria()%>"><button type="button" id="btnAtras">Editar trabajo</button></a>                    
                </section>
            </article>
        </section>

        <aside>
            <div class="social">
                <ul>
                    <li><a href="https://www.facebook.com/AsesoriaAcademicaVirtual/" target="_blank" class="icon-facebook"></a></li>
                    <li><a href="https://web.whatsapp.com/send?phone=573137632643&text=" target="_blank" class="icon-whatsapp"></a></li>
                </ul>
            </div>
        </aside>

        <footer>
            <div class="textFooter">
                <p>Copyright &copy; by AsesoriasAcademicas.com</p>
            </div>
        </footer>
    </body>
</html>