<%-- 
    Document   : solicitaTuClaseVirtual
    Created on : 21/02/2018, 07:47:44 AM
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
    if(sesion != null){
        usu = (Persona)sesion.getAttribute("usuario");
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
                if (document.getElementById("solicitaTuClaseVirtual").firstChild.href == window.location.href) {
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
            <%if(usu != null){%>
                <a href="logout" class="enlaceLogin" onclick="return confirm('¿Está seguro(a) de cerrar sesión?');">Cerrar sesión</a></br>
                <a href="miCuenta.jsp" class="enlaceLogin">Mi cuenta</a>
            <%}else{%>
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
                <%if(usu != null){%>
                <li id="solicitaTuClase"><a href="#">Solicita tu clase</a>
                    <ul id="l02">
                        <li id="solicitaTuClasePresencial"><a href="solicitaTuClasePresencial.jsp" onclick="establecerElementoSubmenu()">Presencial</a></li>
                        <li id="solicitaTuClaseVirtual"><a href="solicitaTuClaseVirtual.jsp" onclick="establecerElementoSubmenu()">Virtual</a></li>
                    </ul>
                </li>
                <li id="dejanosTuTrabajo"><a href="dejanosTuTrabajo.jsp" onclick="establecerElemento(this)">Dejanos tu trabajo</a></li>
                <%}else{%>
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
                <li>Usted se encuentra aquí: Solicita tu clase Vitual</li>
            </ul></br>
            
            <article class="contenido">
                <p><b>Asesorías académicas</b> brinda tutorías virtuales mediante plataformas de videoconferencia (Google Meet, Zoom, WhatsApp o Skype) al igual 
                         que en un aula de clase tradicional, es posible conformar grupos, utilizar pizarras virtuales, presentar diferentes recursos como videos, 
                         audios y diapositivas desde la funcionalidad de compartir pantalla e incluso grabar las sesiones.
                </p>
                
                 <hr/>
                 
                 <section id="working">
                     <i><b>Estamos trabajando en una nueva página web y pronto quedará lista.</b></br>
                     A través de esta sección usted podrá solicitar asesorías de manera virtual desde la comodidad de su hogar.</i>
                     
                     <img id="imgworking" src="imagenes/working.png" alt="working">
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
