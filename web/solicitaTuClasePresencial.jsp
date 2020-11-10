<%-- 
    Document   : solicitaTuClasePresencial
    Created on : 21/02/2018, 07:43:32 AM
    Author     : Alex
--%>

<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.*" session="true" %>
<%@ page import="modelo.Tutoria"%>
<%@ page import="modelo.Clase"%>
<%@ page import="modelo.Persona"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.ArrayList"%>
<!DOCTYPE html>
<%! HttpSession sesion = null;%>
<%! List classList = null;%>
<%! int i;%>
<%! Clase cls = null;%>
<%  
    sesion = request.getSession();
    if (sesion != null) {
        classList = (ArrayList) sesion.getAttribute("listaClases");
    }%>
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
        <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
        <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.4.2/jquery.min.js"></script>
        <script type="text/javascript" src="js/jquery.pajinate.js"></script>
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
                
                if ('<%= session.getAttribute("confirmacionFallidaSolicitaTuClasePresencial")%>' != "" && '<%= session.getAttribute("confirmacionExitosaSolicitaTuClasePresencial")%>' == "") {
                    document.getElementById("confirmacionFallidaSolicitaTuClasePresencial").innerHTML = '<%= session.getAttribute("confirmacionFallidaSolicitaTuClasePresencial")%>';
                    document.getElementById("confirmacionFallidaSolicitaTuClasePresencial").style.display = "block";
                    document.getElementById("confirmacionExitosaSolicitaTuClasePresencial").style.display = "none";
                } else if ('<%= session.getAttribute("confirmacionFallidaSolicitaTuClasePresencial")%>' == "" && '<%= session.getAttribute("confirmacionExitosaSolicitaTuClasePresencial")%>' != "") {
                    document.getElementById("confirmacionExitosaSolicitaTuClasePresencial").innerHTML = '<%= session.getAttribute("confirmacionExitosaSolicitaTuClasePresencial")%>';
                    document.getElementById("confirmacionExitosaSolicitaTuClasePresencial").style.display = "block";
                    document.getElementById("confirmacionFallidaSolicitaTuClasePresencial").style.display = "none";
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
            
            /*
             
            Aquí paginamos la tabla que contiene las tutorias solicitadas.
            
             */
                
	    jQuery331(document).ready(function($){
		$('#paging_container1').pajinate({
                    nav_label_first : '<<',
                    nav_label_last : '>>',
                    nav_label_prev : '<',
                    nav_label_next : '>',
                    num_page_links_to_display : 3,
                    items_per_page : 20
		});
            });
            
            /*
            
            Aquí capturamos la entrada del Input para realizar la búsqueda y aplicar el filtro en la tabla que contiene las tutorías solicitadas. 

            */
            
            $(document).ready(function(){
                $("#myInput").on("keyup", function() {
                  var value = $(this).val().toLowerCase();
                  $("#myTable tr").filter(function() {
                    $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
                  });
                });
              });
              
              
            /*
            
            La funcion confirmacionSalirVista() muestra el mensaje de confirmacion para cambio entre paginas, además elimina el contenido de las variables confirmacionExitosa
            El evento onbeforeunload se lanza cuando la pagina es descargada
            
           */
            
            window.onbeforeunload = confirmacionSalirVista;
            
            function confirmacionSalirVista(){
                <% session.setAttribute("confirmacionExitosaSolicitaTuClasePresencial", "");%>
                <% session.setAttribute("confirmacionFallidaSolicitaTuClasePresencial", "");%>
                /*if(ingresarTexto){
                    return "Está seguro(a) que quieres salir?";
                }*/
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
                <li>Usted se encuentra aquí: Solicita tu clase Presencial</li>
            </ul></br>

            <article>
                <p id="confirmacionExitosaSolicitaTuClasePresencial" class="confirmacionExitosa"></p>
                <p id="confirmacionFallidaSolicitaTuClasePresencial" class="confirmacionFallida"></p>
                <p>A continuación usted encontrará en detalle las tutorías de tipo presencial solicitadas:</p>
                <form id="formBusqueda" action="buscar" method="POST">
                    <section class="confirmarformulario">
                        <a href="NuevaClasePresencial.jsp"><button type="button" id="btnSolicitarCalse">Nueva Clase</button></a>
                    </section>
                </form>
                <input id="myInput" type="text" placeholder="Buscar..">
                <section id="paging_container1" class="container">
                    <table id="datos">
                        <thead id="myHead">
                            <tr>
                                <th>Asignatura</th>
                                <th>Tema</th>
                                <th class="columnDudas">Dudas/inquietudes</th>
                                <th>Acciones</th>
                            </tr>
                        </thead>
                        <tbody id="myTable">
                            <%for (i = 0; i < classList.size(); i++) {%>
                            <% cls = (Clase) classList.get(i);%>
                            <tr class="content">
                                <td><%= cls.getTutoria().getAsignaturaTutoria()%></td>
                                <td><%= cls.getTutoria().getTemaTutoria()%></td>
                                <td class="columnDudas"><%= cls.getTutoria().getDudasInquietudesTutoria()%></td>					
                                <td><div class="acciones">
                                        <ul>
                                            <li><a href="VerClasePresencial.jsp?CodigoTutoria=<%= cls.getTutoria().getCodigoTutoria()%>" class="icon-zoom-in"></a></li>
                                            <li><a href="EditarClasePresencial.jsp?CodigoTutoria=<%= cls.getTutoria().getCodigoTutoria()%>" class="icon-pencil"></a></li>
                                            <li><a href="EliminarClasePresencial.jsp?CodigoTutoria=<%= cls.getTutoria().getCodigoTutoria()%>" class="icon-cross"></a></li>
                                        </ul>
                                    </div>
                                </td>
                            </tr>
                            <%}%>
                        </tbody>
                    </table>
                    <section class="bloqueIzquierdo"></section>
                    <section class="page_navigation"></section>
                    <section class="bloqueDerecho"></section>
                </section>
            </article>
            <div class="holder">
            </div>
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

