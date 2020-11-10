<%-- 
    Document   : registro
    Created on : 20/02/2018, 11:12:49 AM
    Author     : Alex
--%>

<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.*" session="true" %>
<%@ page import="modelo.Persona"%>
<!DOCTYPE html>
<%! HttpSession sesion = null;%>
<%! Persona usu = null;%>
<%! String nombre = null;%>
<%! String email = null;%>
<%
    sesion = request.getSession();
    if (sesion != null) {
        usu = (Persona) sesion.getAttribute("usuario");
        nombre = (String)sesion.getAttribute("nombre");
        email = (String) sesion.getAttribute("email");
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
             
             La funcion mostrarConfirmacion() muestra el mensaje de confirmacion del envio de datos.
             
             */

            function mostrarConfirmacion() {               
                if ('<%= session.getAttribute("confirmacionFallidaRegistrarUsuario")%>' != "" && '<%= session.getAttribute("confirmacionExitosaRegistrarUsuario")%>' == "") {
                    document.getElementById("confirmacionFallidaRegistrarUsuario").innerHTML = '<%= session.getAttribute("confirmacionFallidaRegistrarUsuario")%>';
                    document.getElementById("confirmacionFallidaRegistrarUsuario").style.display = "block";
                    document.getElementById("confirmacionExitosaRegistrarUsuario").style.display = "none";
                } else if ('<%= session.getAttribute("confirmacionFallidaSolicitaTuClasePresencial")%>' == "" && '<%= session.getAttribute("confirmacionExitosaRegistrarUsuario")%>' != "") {
                    document.getElementById("confirmacionExitosaRegistrarUsuario").innerHTML = '<%= session.getAttribute("confirmacionExitosaRegistrarUsuario")%>';
                    document.getElementById("confirmacionExitosaRegistrarUsuario").style.display = "block";
                    document.getElementById("confirmacionFallidaRegistrarUsuario").style.display = "none";
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
                <% session.setAttribute("confirmacionExitosaRegistrarUsuario", "");%>
                <% session.setAttribute("confirmacionFallidaRegistrarUsuario", "");%>
                <% session.setAttribute("nombre", "");%>
                <% session.setAttribute("email", "");%>
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
    <body onload="mostrarConfirmacion()">
        <header id="headerIngresar">
            <a href="login.jsp" id="enlaceBanner">
                <div>
                    <p id="tituloCabecera">Asesorías Académicas.com</p>
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
            <article class="imgIngresar">
                <a href="registro.jsp" id="enlaceImagen">
                    <img src="imagenes/clasesOnline.png" alt="clasesOnline" id="imagenIngresar">
                </a>
                <p>Ya estás registrado? <a href="login.jsp">Iniciar sesión</a></p>
            </article>
            <article class="ingresar">
                <div class="cabeceraIngresar">
                    <p id="tituloIngresar"><b>Asesorías Académicas</b></p>
                    <p id="contenidoIngresar"><b>Justo lo que necesitabas!</b></p>
                </div>
                <form id="formRegistrar" action="registro" method="POST" onsubmit="return validar()">
                    <p id="confirmacionExitosaRegistrarUsuario" class="confirmacionExitosa"></p>
                    <p id="confirmacionFallidaRegistrarUsuario" class="confirmacionFallida"></p>
                    <h4>Registrarse</h4>
                    <article>
                        <section>
                            <input type="text" name="nombre" id="nombre" class="contformulario" pattern="^([a-zA-ZñÑáéíóúÁÉÍÓÚ\s])*$" maxlength="50" placeholder="Nombre" <%if (nombre != null) {%> value="<%= nombre%>" <%}%> required>
                        </section>
                        <section>
                            <input type="email" name="email" id="email" class="contformulario" pattern="^([a-zA-Z0-9-_.]+@[a-zA-Z0-9-_.]+.[a-zA-Z]{2,4})$" placeholder="Email" <%if (email != null) {%> value="<%= email%>" <%}%> required>
                        </section>
                        <section>
                            <input type="password" name="password" id="password" class="contformulario" placeholder="Password" required>
                        </section>
                        <section>
                            <input type="password" name="repeatPassword" id="repeatPassword" class="contformulario" placeholder="Confirm password" required>
                        </section>
                        <section>
                            <input type="submit" id="btnEnviar" value="Enviar">
                        </section>
                    </article>
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
