<%-- 
    Document   : miCuenta
    Created on : 4/03/2018, 10:26:48 PM
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
             
             La funcion paginaActiva() modifica el color a blanco (#FDFDFD) de la pestaña cargada.
             
             */

            function paginaActiva() {
                if (document.getElementById("index").firstChild.href == window.location.href) {
                    sessionStorage.clear();
                    document.getElementById("index").style.backgroundColor = "#FDFDFD";
                    document.getElementById("index").firstChild.style.color = "#1C242A";
                }

                if (!sessionStorage.getItem("submenuActivo") && sessionStorage.getItem("clickPag")) {
                    document.getElementById(sessionStorage.getItem("clickPag")).style.backgroundColor = "#FDFDFD";
                    document.getElementById(sessionStorage.getItem("clickPag")).firstChild.style.color = "#1C242A";
                }
                else if (sessionStorage.getItem("submenuActivo") == "solicitaTuClase") {
                    document.getElementById("solicitaTuClase").style.backgroundColor = "#FDFDFD";
                    document.getElementById("solicitaTuClase").firstChild.style.color = "#1C242A";
                }
                
                if ('<%= session.getAttribute("confirmacionFallidaMiCuenta")%>' != "" && '<%= session.getAttribute("confirmacionExitosaMiCuenta")%>' == "") {
                    document.getElementById("confirmacionFallidaMiCuenta").innerHTML = '<%= session.getAttribute("confirmacionFallidaMiCuenta")%>';
                    document.getElementById("confirmacionFallidaMiCuenta").style.display = "block";
                    document.getElementById("confirmacionExitosaMiCuenta").style.display = "none";
                } else if ('<%= session.getAttribute("confirmacionFallidaMiCuenta")%>' == "" && '<%= session.getAttribute("confirmacionExitosaMiCuenta")%>' != "") {
                    document.getElementById("confirmacionExitosaMiCuenta").innerHTML = '<%= session.getAttribute("confirmacionExitosaMiCuenta")%>';
                    document.getElementById("confirmacionExitosaMiCuenta").style.display = "block";
                    document.getElementById("confirmacionFallidaMiCuenta").style.display = "none";
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
             
             La funcion mostrarPublicidad muestra el div "publicidad"
             
             */

            function mostrarPublicidad() {
                document.getElementById("publicidad").style.display = "block";
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
                <% session.setAttribute("confirmacionExitosaMiCuenta", "");%>
                <% session.setAttribute("confirmacionFallidaMiCuenta", "");%>
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
            <div>
                <div class="cabecera">
                    <h1>Asesorías Académicas</h1>
                    <h3>Justo lo que necesitabas!</h3>
                </div>
                <div class="imgcabecera">
                    <img src="imagenes/banner.png" alt="banner" id="imagenCabecera">
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
            <li>Usted se encuentra aquí: Mi Cuenta</li>
        </ul></br>

        <article>
            <p id="confirmacionExitosaMiCuenta" class="confirmacionExitosa"></p>
            <p id="confirmacionFallidaMiCuenta" class="confirmacionFallida"></p>
            <h4>Mi Cuenta</h4>
            <p id="indicadorRequerido">* Campos requeridos</p>
            <form id="formLogin" action="editarCuenta" method="GET">
                <fieldset id="datosPersonales">
                    <legend>Datos Personales</legend>
                    <article>
                        <section class="datoformulario">
                            <label for="nombre" class="obligatorio">Nombre</label>
                            <label id="validnombre"></label>
                            <input type="text" name="nombre" id="nombre" class="contformulario" pattern="^([a-zA-ZñÑáéíóúÁÉÍÓÚ\s])*$" maxlength="50" <%if (usu != null) {%> value="<%= usu.getNombrePersona()%>" <%}%> required>
                        </section>
                        <section class="datoformulario">
                            <label for="direccion" class="obligatorio">Dirección</label>
                            <label id="validdireccion"></label>
                            <input type="text" name="direccion" id="direccion" class="contformulario" <%if (usu != null) {%> value="<%= usu.getDireccionPersona()%>" <%}%> required>
                        </section>
                        <section class="datoformulario">
                            <label for="barrio" class="obligatorio">Barrio</label>
                            <label id="validbarrio"></label>
                            <input type="text" name="barrio" id="barrio" class="contformulario" <%if (usu != null) {%> value="<%= usu.getBarrioResidenciaPersona()%>" <%}%> required>
                        </section>
                        <section class="datoformulario">
                            <label for="telefono" class="obligatorio">Teléfono</label>
                            <label id="validtelefono"></label>
                            <input type="tel" name="telefono" id="telefono"  class="contformulario" pattern="^[0-9]{7}|[0-9]{10}$" placeholder="Fijo 8****** - Móvil 3*********" <%if (usu != null) {%> value="<%= usu.getTelefonoPersona()%>" <%}%> required>
                        </section>
                        <section class="datoformulario">
                            <label for="email" class="obligatorio">Email</label>
                            <label id="validemail"></label>
                            <input type="email" name="email" id="email" class="contformulario" pattern="^([a-zA-Z0-9-_.]+@[a-zA-Z0-9-_.]+.[a-zA-Z]{2,4})$" placeholder="example@example.com" <%if (usu != null) {%> value="<%= usu.getEmailPersona()%>" <%}%> required>
                        </section>
                        <section class="datoformulario">
                            <label for="password" class="obligatorio">Password</label>
                            <label id="validpassword"></label>
                            <input type="password" name="password" id="password" class="contformulario"  <%if (usu != null) {%> value="<%= usu.getPasswordPersona()%>" <%}%> required>
                        </section>
                        <section class="confirmarformulario">
                            <input type="submit" id="btnEnviar" value="Guardar" onclick="return confirm('¿Está seguro(a) de guardar los cambios de su Cuenta?');">
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