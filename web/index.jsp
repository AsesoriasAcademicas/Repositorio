<%-- 
    Document   : index
    Created on : 20/02/2018, 10:45:51 AM
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

                if ('<%= session.getAttribute("confirmacionExitosaInicio")%>' == "") {
                    document.getElementById("confirmacionFallidaInicio").innerHTML = '<%= session.getAttribute("confirmacionFallidaInicio")%>';
                } else if ('<%= session.getAttribute("confirmacionFallidaInicio")%>' == "") {
                    document.getElementById("confirmacionExitosaInicio").innerHTML = '<%= session.getAttribute("confirmacionExitosaInicio")%>';
                    document.getElementById("confirmacionExitosaInicio").style.display = "block";
                }
                
                if('<%= session.getAttribute("confirmacionExitosaInicio")%>' == "0"){
                    document.getElementById("confirmacionFallidaInicio").style.display = "hidden";
                }
                if('<%= session.getAttribute("confirmacionFallidaInicio")%>' == "0"){
                    document.getElementById("confirmacionExitosaInicio").style.display = "hidden";
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
            
            La funcion confirmacionSalirVista() elimina el contenido de las variables confirmacionExitosa
            El evento onbeforeunload se lanza cuando la pagina es descargada
            
           */
            
            window.onbeforeunload = confirmacionSalirVista;
            
            function confirmacionSalirVista(){
                <% session.setAttribute("confirmacionExitosaInicio", "");%>
                <% session.setAttribute("confirmacionFallidaInicio", "");%>
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
                <li>Usted se encuentra aquí: Inicio</li>
            </ul></br>

            <p id="confirmacionExitosaInicio" class="confirmacionExitosa"></p>
            <p id="confirmacionFallidaInicio" class="confirmacionFallida"></p>
            <article>
                <p class="contenido"><b>Asesorías académicas</b> es una idea que surgió en 2016 con el propósito de ayudar a estudiantes atendiendo sus necesidades en el proceso de aprendizaje y formación académica de forma oportuna. Un estudiante que recibe una tutoría de manera eficaz tiene más posibilidades de mejorar su rendimiento académico.</p>

                <hr/>

                <p><b>Metodología</b></p>

                <p>Es importante plantear una estrategia que comprende principios y métodos que definen una herramienta concreta utilizada para transmitir el contenido, procedimientos y principios al estudiante, a continuación se define la metodología utilizada:</p>

                <ul>
                    <li>Inicialmente se realiza la revisión de la temática que se desea estudiar, identificando dudas expuestas por el estudiante.</li>
                    <li>En seguida se inicia la tutoría a través del acompañamiento en el estudio teórico y práctico mediante ejercicios fortaleciendo de esta manera el conocimiento a enseñar.</li>
                    <li>Al final de la sesión se entrega material adicional al estudiante para reforzar los conceptos de manera independiente.</li>
                </ul>

                <p><i>En el proceso de enseñanza se aconseja al estudiante sobre la mejor manera de abordar cada ejercicio y/o problema.</i></p>

                <hr/>

                <h4>¿Porqué elegirnos?</h4>
                <ol>
                    <li>Ofrecemos <b>tutorías, solución de talleres y trabajos</b> en: 
                        <ul>
                            <li>Matemáticas.</li>
                            <li>Geometría.</li>
                            <li>Probabilidad y estadística.</li>
                            <li>Cálculo diferencial e integral.</li>
                            <li>Física.</li>
                            <li>Html, Css y JavaScript.</li>
                            <li>Algoritmia y programación.</li>
                            <li>SQL.</li>
                            <li>Herramientas ofimáticas.</li>
                        </ul>
                    </li>
                    <li>Disponemos de <b>horarios flexibles</b> que se ajustan a sus necesidades.</li>
                    <li>Brindamos <b>tutorías a domicilio</b> para su comodidad.</li>
                </ol>

                <hr/>

                <p class="contenido"><i>Las ventajas que ofrece una tutoría académica radica en el descubrimiento de talentos, la motivación al estudiante en su desempeño y la elevación del rendimiento académico.</i><p>	
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
