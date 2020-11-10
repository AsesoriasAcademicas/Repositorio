<%-- 
    Document   : contacto
    Created on : 21/02/2018, 07:50:38 AM
    Author     : Alex
--%>

<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.*" session="true" %>
<%@ page import="modelo.Persona"%>
<!DOCTYPE html>
<%! HttpSession sesion = null;%>
<%! Persona usu = null;%>
<%
    sesion = request.getSession();
    if (sesion != null) {
        usu = (Persona) sesion.getAttribute("usuario");
    }
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8, width=device-width, initial-scale=1.0">
        <title>Asesorías Académicas</title>
        <link rel="stylesheet" type="text/css" href="css/style.css">
        <link rel="stylesheet" type="text/css" href="fonts.css">
        <script src="http://code.jquery.com/jquery-latest.js"></script>
        <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
        <script type="text/javascript">

            /*
             * 
             * @type @exp;jQuery@call;noConflict
             * 
             * La variable jQuery331 permite utilizar diferentes versiones de la libreria jQuery
             * sin entrar en conflicto
             * 
             */
            
            var ingresarTexto = false;
            var jQuery331 = jQuery.noConflict();
            window.jQuery = jQuery331;
            
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
             
             La funcion paginaActiva() modifica el color a blanco (#FDFDFD) de la pestaña cargada.
             
             */

            function paginaActiva() {
                if (document.getElementById("contacto").firstChild.href == window.location.href) {
                    sessionStorage.clear();
                    document.getElementById("contacto").style.backgroundColor = "#FDFDFD";
                    document.getElementById("contacto").firstChild.style.color = "#1C242A";
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
                
                if ('<%= session.getAttribute("confirmacionFallidaContacto")%>' != "" && '<%= session.getAttribute("confirmacionExitosaContacto")%>' == "") {
                    document.getElementById("confirmacionFallidaContacto").innerHTML = '<%= session.getAttribute("confirmacionFallidaContacto")%>';
                    document.getElementById("confirmacionFallidaContacto").style.display = "block";
                    document.getElementById("confirmacionExitosaContacto").style.display = "none";
                } else if ('<%= session.getAttribute("confirmacionFallidaContacto")%>' == "" && '<%= session.getAttribute("confirmacionExitosaContacto")%>' != "") {
                    document.getElementById("confirmacionExitosaContacto").innerHTML = '<%= session.getAttribute("confirmacionExitosaContacto")%>';
                    document.getElementById("confirmacionExitosaContacto").style.display = "block";
                    document.getElementById("confirmacionFallidaContacto").style.display = "none";
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
            
            La Funcion jQuery permite identificar si en los input se ha ingresado texto, modificando la variable ingresarTexto a Verdadero.
            

             */
            
            $(document).ready(function(){
                $("input").keydown(function() {
                    ingresarTexto = true;
                });
            });
            
            /*
            
            La funcion confirmacionSalirVista() muestra el mensaje de confirmacion para cambio entre paginas, además elimina el contenido de las variables confirmacionExitosa
            El evento onbeforeunload se lanza cuando la pagina es descargada
            
           */
            
            window.onbeforeunload = confirmacionSalirVista;
            
            function confirmacionSalirVista(){
                <% session.setAttribute("confirmacionExitosaContacto", "");%>
                <% session.setAttribute("confirmacionFallidaContacto", "");%>
                /*if(ingresarTexto){
                    return "Está seguro(a) que quieres salir?";
                }*/
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
    <body onload="paginaActiva()">
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
                <li>Usted se encuentra aquí: Contacto</li>
            </ul></br>

            <article>
                <p id="confirmacionExitosaContacto" class="confirmacionExitosa"></p>
                <p id="confirmacionFallidaContacto" class="confirmacionFallida"></p>
                <h4>¿Tienes alguna pregunta? Estamos encantados de ayudarte!</h4>
                <p id="indicadorRequerido">* Campos requeridos</p>
                <form action="contacto" method="POST" onsubmit="return validar()">
                    <fieldset>
                        <legend>Formulario de Contacto</legend>
                        <article>
                            <section class="datoformulario">
                                <label for="nombre" class="obligatorio">Nombre</label>
                                <label id="validnombre"></label>
                                <input type="text" name="nombre" id="nombre" class="contformulario" pattern="^([a-zA-ZñÑáéíóúÁÉÍÓÚ\s])*$" maxlength="50" placeholder="Nombre" <%if (usu != null) {%> value="<%= usu.getNombrePersona()%>" <%}%> required autofocus>
                            </section>
                            <section class="datoformulario">
                                <label for="email" class="obligatorio">Email</label>
                                <label id="validemail"></label>
                                <input type="email" name="email" id="email" class="contformulario" pattern="^([a-zA-Z0-9-_.]+@[a-zA-Z0-9-_.]+.[a-zA-Z]{2,4})$" placeholder="example@example.com" <%if (usu != null) {%> value="<%= usu.getEmailPersona()%>" <%}%> required>
                            </section>
                            <section class="datoformulario">
                                <label for="telefono" class="obligatorio">Teléfono</label>
                                <label id="validtelefono"></label>
                                <input type="tel" name="telefono" id="telefono" class="contformulario" pattern="[0-9]{7}|[0-9]{10}" placeholder="Fijo 8****** - Móvil 3*********" <%if (usu != null) {%> value="<%= usu.getTelefonoPersona()%>" <%}%> required>
                            </section>
                            <section class="datoformulario">
                                <label for="mensaje" class="obligatorio">Mensaje</label>
                                <label id="validmensaje"></label>
                                <textarea name="mensaje" id="mensaje" placeholder="Escriba aquí su mensaje..." class="contformulario" maxlength="500" required></textarea>
                            </section>
                            <section class="confirmarformulario">
                                <input type="submit" value="Enviar" onclick="return confirm('¿Está seguro(a) de enviar el Mensaje?');">
                            </section>
                        </article>
                    </fieldset>
                </form>
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
