<%-- 
    Document   : recuperarContrasena
    Created on : 24/02/2018, 09:35:30 PM
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
        <script type="text/javascript">

            /*
             
             La funcion mostrarConfirmacion() muestra el mensaje de confirmacion del envio de datos.
             
             */

            function mostrarConfirmacion() {              
                if ('<%= session.getAttribute("confirmacionFallidaRecuperarContrasena")%>' != "" && '<%= session.getAttribute("confirmacionExitosaRecuperarContrasena")%>' == "") {
                    document.getElementById("confirmacionFallidaRecuperarContrasena").innerHTML = '<%= session.getAttribute("confirmacionFallidaRecuperarContrasena")%>';
                    document.getElementById("confirmacionFallidaRecuperarContrasena").style.display = "block";
                    document.getElementById("confirmacionExitosaRecuperarContrasena").style.display = "none";
                } else if ('<%= session.getAttribute("confirmacionFallidaRecuperarContrasena")%>' == "" && '<%= session.getAttribute("confirmacionExitosaRecuperarContrasena")%>' != "") {
                    document.getElementById("confirmacionExitosaRecuperarContrasena").innerHTML = '<%= session.getAttribute("confirmacionExitosaRecuperarContrasena")%>';
                    document.getElementById("confirmacionExitosaRecuperarContrasena").style.display = "block";
                    document.getElementById("confirmacionFallidaRecuperarContrasena").style.display = "none";
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
        
            La funcion main crea la animación del menu desplegable y adaptable a dispositivos móviles.

             */
             
             /*
            
            La funcion confirmacionSalirVista() muestra el mensaje de confirmacion para cambio entre paginas, además elimina el contenido de las variables confirmacionExitosa
            El evento onbeforeunload se lanza cuando la pagina es descargada
            
           */
            
            window.onbeforeunload = confirmacionSalirVista;
            
            function confirmacionSalirVista(){
                <% session.setAttribute("confirmacionExitosaRecuperarContrasena", "");%>
                <% session.setAttribute("confirmacionFallidaRecuperarContrasena", "");%>
            }

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
            <article class="ingresar">
                <div class="cabeceraIngresar">
                    <p id="tituloIngresar"><b>Asesorías Académicas</b></p>
                    <p id="contenidoIngresar"><b>Justo lo que necesitabas!</b></p>
                </div>
                <form id="formRecuperarContrasena" action="recuperar" method="POST" onsubmit="return validar()">
                    <p id="confirmacionExitosaRecuperarContrasena" class="confirmacionExitosa"></p>
                    <p id="confirmacionFallidaRecuperarContrasena"class="confirmacionFallida"></p>
                    <h4>Recuperar contraseña</h4>
                    <p>Por favor ingresa tu email. Recibirás un link para recuperar tu contraseña.</p>
                    <article>
                        <section>
                            <input type="text" name="email" id="email" class="contformulario" pattern="^([a-zA-Z0-9-_.]+@[a-zA-Z0-9-_.]+.[a-zA-Z]{2,4})$" placeholder="Email" required>
                        </section>
                        <section>
                            <input type="submit" id="btnrecuperarContrasena" value="Enviar">
                        </section>
                        <section>
                            <a href="login.jsp">Iniciar sesión</a>
                        </section>
                    </article>
                </form>
            </article>
            <article class="imgIngresar">
                <a href="recuperarContrasena.jsp" id="enlaceImagen">
                    <img src="imagenes/recuperarContrasena.png" alt="tutor" id="imagenIngresar">
                </a>
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
