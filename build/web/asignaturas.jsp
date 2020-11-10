<%-- 
    Document   : asignaturas
    Created on : 21/02/2018, 07:36:47 AM
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
            function IdTabla(id, estado) {
                this.id = id;
                this.estado = estado;
            }

            /*
             
             La funcion paginaActiva() modifica el color a blanco (#FDFDFD) de la pestaña cargada.
             
             */

            var idTabla = [];
            function inicializarEstados() {
                if (document.getElementById("asignaturas").firstChild.href == window.location.href) {
                    sessionStorage.clear();
                    document.getElementById("asignaturas").style.backgroundColor = "#FDFDFD";
                    document.getElementById("asignaturas").firstChild.style.color = "#1C242A";
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

                var tablas = document.getElementsByClassName("tblasignaturas");
                for (var i = 0; i < tablas.length; i++) {
                    idTabla.push(new IdTabla(tablas[i].id, "oculto"));
                }
            }

            function obtenerImagen(encabezado) {
                var img;
                for (var l = 0; l < encabezado.length; l++) {
                    img = encabezado[l].getElementsByTagName("img");
                }
                return img;
            }

            function desplegarTemas(elemento) {
                var tabla = document.getElementById(elemento.id);
                var tds = tabla.getElementsByTagName("td");
                var ths = tabla.getElementsByTagName("th");
                var img = obtenerImagen(ths);

                for (var j = 0; j < idTabla.length; j++) {
                    for (var k = 0; k < tds.length; k++) {
                        if (idTabla[j].id == elemento.id) {
                            if (idTabla[k].estado == "oculto") {
                                //elemento.style.width = "100%";
                                //elemento.style.WebkitTransition = "width 2s";
                                //elemento.style.transition = "width 2s";
                                tds[k].style.display = "block";
                                idTabla[k].estado = "visible";
                                img[0].src = "imagenes/eliminar.png";
                            }
                            else {
                                //elemento.style.width = "0%"; 
                                tds[k].style.display = "none";
                                idTabla[k].estado = "oculto";
                                img[0].src = "imagenes/ampliar.png";
                            }
                        }
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
    <body onload="inicializarEstados()">
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
                <li>Usted se encuentra aquí: Asignaturas</li>
            </ul></br>

            <article>
                <p>Te ofrecemos nuestros servicios para afianzar tus conocimientos de manera que puedas obtener mejores resultados en las siguientes asignaturas:</p>
                <article class="asignaturas">
                    <table class="tblasignaturas" id="matematicas3" onclick="desplegarTemas(this)">
                        <tr>
                            <th><img src="imagenes/ampliar.png" alt="ampliar"> Matemáticas 3<sup>o</sup></th>
                        </tr>
                        <tr>
                            <td>
                                <ul>
                                    <li>Los números naturales.</li>
                                    <li>Composición y descomposición de números naturales en unidades, decenas, centenas, unidades de mil, ...</li>
                                    <li>Orden de números naturales.</li>
                                    <li>Comparación y ordenación de números naturales usando las relaciones "&gt;", "&lt;",  "=".</li>
                                    <li>Noción de fracciones.</li>
                                    <li>Representación gráfica de fracciones.</li>
                                    <li>Fracciones equivalentes.</li>
                                    <li>Adición y sustracción de números naturales y sus propiedades.</li>
                                    <li>Problemas de adición y sustracción.</li>
                                    <li>Multiplicación y división de números naturales y sus propiedades.</li>
                                    <li>Mitad, tercio y cuarto.</li>
                                    <li>Problemas de multiplicación y división.</li>
                                </ul>
                            </td>
                        </tr>
                    </table>
                </article>
                <article class="asignaturas">
                    <table class="tblasignaturas" id="matematicas4" onclick="desplegarTemas(this)">
                        <tr>
                            <th><img src="imagenes/ampliar.png" alt="ampliar"> Matemáticas 4<sup>o</sup></th>
                        </tr>
                        <tr>
                            <td>
                                <ul>
                                    <li>Los números naturales.</li>
                                    <li>Adición de números naturales llevando.</li>
                                    <li>Sustracción de números naturales llevando.</li>
                                    <li>Multiplicación de números naturales por 2 y 3 cifras.</li>
                                    <li>División con ceros en el cociente.</li>
                                    <li>División de naturales con divisores de 2 o más cifras.</li>
                                    <li>Operaciones combinadas.</li>
                                    <li>Los números fraccionarios.</li>
                                    <li>Operaciones con fracciones.</li>
                                    <li>Los números decimales.</li>
                                    <li>Adición y sustracción de números decimales.</li>
                                    <li>Multiplicación y división de números decimales.</li>
                                    <li>Múltiplos y divisores.</li>
                                </ul>
                            </td>
                        </tr>
                    </table>
                </article>
                <article class="asignaturas">
                    <table class="tblasignaturas" id="matematicas5" onclick="desplegarTemas(this)">
                        <tr>
                            <th><img src="imagenes/ampliar.png" alt="ampliar"> Matemáticas 5<sup>o</sup></th>
                        </tr>
                        <tr>
                            <td>
                                <ul>
                                    <li>Los números naturales.</li>
                                    <li>Adición y sustracción de números naturales.</li>
                                    <li>Multiplicación de números naturales.</li>
                                    <li>División con ceros en el cociente.</li>
                                    <li>División de naturales con divisores de 2 y más cifras.</li>
                                    <li>Operaciones combinadas.</li>
                                    <li>Los números decimales.</li>
                                    <li>Lectura y escritura de fracciones.</li>
                                    <li>Comparación de fracciones.</li>
                                    <li>Operaciones con fracciones.</li>
                                    <li>Adición y sustracción de números decimales.</li>
                                    <li>Multiplicación y división de números decimales.</li>
                                    <li>Sistemas de numeración: Los números Romanos.</li>
                                </ul>
                            </td>
                        </tr>
                    </table>
                </article>
                <article class="asignaturas">
                    <table class="tblasignaturas" id="matematicas6" onclick="desplegarTemas(this)">
                        <tr>
                            <th><img src="imagenes/ampliar.png" alt="ampliar"> Matemáticas 6<sup>o</sup></th>
                        </tr>
                        <tr>
                            <td>
                                <ul>
                                    <li>Sistemas de numeración: Romano, binario y decimal.</li>
                                    <li>Los números naturales.</li>
                                    <li>Operaciones con números naturales.</li>
                                    <li>Potenciación, radicación y logaritmación.</li>
                                    <li>Múltiplos y divisores.</li>
                                    <li>Descomposición factorial.</li>
                                    <li>Los números enteros y la recta numérica(Plano cartesiano).</li>
                                    <li>Operaciones con números enteros.</li>
                                    <li>Ecuaciones simples con números enteros.</li>
                                    <li>Los números fraccionarios.</li>
                                    <li>Operaciones con números fraccionarios.</li>
                                    <li>Problemas verbales con números fraccionarios.</li>
                                </ul>
                            </td>
                        </tr>
                    </table>
                </article>
                <article class="asignaturas">
                    <table class="tblasignaturas" id="matematicas7" onclick="desplegarTemas(this)">
                        <tr>
                            <th><img src="imagenes/ampliar.png" alt="ampliar"> Matemáticas 7<sup>o</sup></th>
                        </tr>
                        <tr>
                            <td>
                                <ul>
                                    <li>Números enteros, polinomios aritméticos.</li>
                                    <li>Expresiones con signos de agrupación.</li>
                                    <li>Los números racionales.</li>
                                    <li>Operaciones con numeros racionales.</li>
                                    <li>Problemas verbales con números racionales.</li>
                                    <li>Los números decimales.</li>
                                    <li>Operaciones con números decimales.</li>
                                    <li>Ecuaciones, planteamiento y resolución de problemas.</li>
                                    <li>Proporcionalidad.</li>
                                    <li>Magnitudes directa e inversamente proporcionales.</li>
                                    <li>Regla de tres simple.</li>
                                    <li>Problemas de aplicación.</li>
                                </ul>
                            </td>
                        </tr>
                    </table>
                </article>
                <article class="asignaturas">
                    <table class="tblasignaturas" id="matematicas8" onclick="desplegarTemas(this)">
                        <tr>
                            <th><img src="imagenes/ampliar.png" alt="ampliar"> Matemáticas 8<sup>o</sup></th>
                        </tr>
                        <tr>
                            <td>
                                <ul>
                                    <li>Conjuntos numéricos, números naturales, enteros, racionales e irracionales.</li>
                                    <li>Expresiones algebraicas.</li>
                                    <li>Monomios, trinomios y polinomios.</li>
                                    <li>Operaciones con expresiones algebraicas.</li>
                                    <li>Productos y cocientes notables.</li>
                                    <li>Triángulo de Pascal.</li>
                                    <li>Casos de factorización.</li>
                                    <li>Fracciones algebraicas.</li>
                                    <li>Sistema de ecuaciones lineales 2x2.</li>
                                    <li>Metodos de solución por reducción, igualación y sustitución de sistemas de ecuaciones.</li>
                                    <li>Problemas de aplicación.</li>
                                </ul>
                            </td>
                        </tr>
                    </table>
                </article>
                <article class="asignaturas">
                    <table class="tblasignaturas" id="matematicas9" onclick="desplegarTemas(this)">
                        <tr>
                            <th><img src="imagenes/ampliar.png" alt="ampliar"> Matemáticas 9<sup>o</sup></th>
                        </tr>
                        <tr>
                            <td>
                                <ul>
                                    <li>Proporcionalidad, regla de tres simple y compuesta.</li>
                                    <li>Expresiones algebraicas.</li>
                                    <li>Casos de factorización.</li>
                                    <li>Función lineal, ecuación de la recta.</li>
                                    <li>Sistema de ecuaciones lineales 2x2.</li>
                                    <li>Metodos de solución, sistemas de ecuaciones 2x2.</li>
                                    <li>Sistema de ecuaciones lineales 3x3.</li>
                                    <li>Metodos de solución, sistemas de ecuaciones 3x3.</li>
                                    <li>Función cuadrática.</li>
                                    <li>Ceros, raíces o soluciones de la función cuadrática.</li>
                                    <li>Función exponencial y logarítmica.</li>
                                    <li>Sucesiones y progresiones.</li>
                                </ul>
                            </td>
                        </tr>
                    </table>
                </article>
                <article class="asignaturas">
                    <table class="tblasignaturas" id="matematicas10" onclick="desplegarTemas(this)">
                        <tr>
                            <th><img src="imagenes/ampliar.png" alt="ampliar"> Matemáticas 10<sup>o</sup></th>
                        </tr>
                        <tr>
                            <td>
                                <ul>
                                    <li>Razones trigonométricas.</li>
                                    <li>Triángulos rectángulos.</li>
                                    <li>Funciones trigonométricas.</li>
                                    <li>Gráfica de las funciones seno, coseno, tangente, cotangente, secante y cosecante.</li>
                                    <li>Identidades trigonométricas.</li>
                                    <li>Ecuaciones trigonométricas.</li>
                                    <li>Teorema o ley del seno.</li>
                                    <li>Teorema o ley del coseno.</li>
                                    <li>Vectores en el plano, en el espacio, producto punto y producto vectorial.</li>
                                    <li>Geometría analítica.</li>
                                    <li>Distancia entre dos puntos, ecuación de la recta, ecuación punto-pendiente.</li>
                                    <li>La parábola, elipse e hipérbola.</li>
                                </ul>
                            </td>
                        </tr>
                    </table>
                </article>
                <article class="asignaturas">
                    <table class="tblasignaturas" id="matematicas11" onclick="desplegarTemas(this)">
                        <tr>
                            <th><img src="imagenes/ampliar.png" alt="ampliar"> Matemáticas 11<sup>o</sup></th>
                        </tr>
                        <tr>
                            <td>
                                <ul>
                                    <li>Ecuaciones, proporcionalidad y regla de tres.</li>
                                    <li>Funciones y gráficas.</li>
                                    <li>Función lineal, cuadrática, polinómica, parte entera y valor absoluto.</li>
                                    <li>Función inversa, racional, exponencial y logarítmica.</li>
                                    <li>Fuciones periódicas y trigonométricas.</li>
                                    <li>Límites y continuidad.</li>
                                    <li>Cálculo de límites, álgebra de límites.</li>
                                    <li>Límite de funciones indeterminadas.</li>
                                    <li>Continuidad y discontinuidad.</li>
                                    <li>Derivadas, propiedades de las derivadas.</li>
                                    <li>Regla de la cadena.</li>
                                    <li>la antiderivada, integrales.</li>
                                </ul>
                            </td>
                        </tr>
                    </table>
                </article>
                <article class="asignaturas">
                    <table class="tblasignaturas" id="geometria" onclick="desplegarTemas(this)">
                        <tr>
                            <th><img src="imagenes/ampliar.png" alt="ampliar"> Geometría</th>
                        </tr>
                        <tr>
                            <td>
                                <ul>
                                    <li>Conceptos básicos, recta, semirecta y segmento.</li>
                                    <li>Ángulos.</li>
                                    <li>Clasificación y relacion de ángulos.</li>
                                    <li>Triángulos.</li>
                                    <li>Clasificación y propiedades de los triángulos.</li>
                                    <li>Teorema de Pitágoras.</li>
                                    <li>Cuadriláteros y polígonos.</li>
                                    <li>Circunferencia y círculo.</li>
                                    <li>Perímetros y áreas.</li>
                                    <li>Cuadrado, rectángulo, paralelogramo, rombo, trapecio, triángulo, polígonos regulares, circunferencia y círculo.</li>
                                    <li>Semejanza de triángulos, teorema de Thales.</li>
                                    <li>Áreas y volúmenes.</li>
                                </ul>
                            </td>
                        </tr>
                    </table>
                </article>
                <article class="asignaturas">
                    <table class="tblasignaturas" id="probabilidadYestadistica" onclick="desplegarTemas(this)">
                        <tr>
                            <th><img src="imagenes/ampliar.png" alt="ampliar"> Probabilidad y Estadística</th>
                        </tr>
                        <tr>
                            <td>
                                <ul>
                                    <li>Teoria de conjuntos.</li>
                                    <li>Operaciones de conjuntos.</li>
                                    <li>Técnicas de conteo.</li>
                                    <li>Principio multiplicativo y aditivo.</li>
                                    <li>Permutaciones y combinaciones.</li>
                                    <li>Probabilidad, términos básicos.</li>
                                    <li>Probabilidad clásica.</li>
                                    <li>Estadística descriptiva, tratamiento de datos agrupados y no agrupados.</li>
                                    <li>Medidas de tendencia central.</li>
                                    <li>Media aritmética, mediana, moda, cuartiles, deciles y perceptiles.</li>
                                </ul>
                            </td>
                        </tr>
                    </table>
                </article>
                <article class="asignaturas">
                    <table class="tblasignaturas" id="precalculo" onclick="desplegarTemas(this)">
                        <tr>
                            <th><img src="imagenes/ampliar.png" alt="ampliar"> Precálculo</th>
                        </tr>
                        <tr>
                            <td>
                                <ul>
                                    <li>Función y relación.</li>
                                    <li>Gráficar y tabular una función.</li>
                                    <li>Operaciones con funciones, funciones compuestas.</li>
                                    <li>Intervalos, intervalo cerrado y abierto.</li>
                                    <li>Dominio y rango de una función.</li>
                                    <li>Funciones polinominales.</li>
                                    <li>Ceros de una función polinominal.</li>
                                    <li>División sintética o Ruffini</li>
                                    <li>Funciones cuadráticas.</li>
                                    <li>Funciones racionales, asíndotas de una función racional.</li>
                                </ul>
                            </td>
                        </tr>
                    </table>
                </article>
                <article class="asignaturas">
                    <table class="tblasignaturas" id="fisica" onclick="desplegarTemas(this)">
                        <tr>
                            <th><img src="imagenes/ampliar.png" alt="ampliar"> Física</th>
                        </tr>
                        <tr>
                            <td>
                                <ul>
                                    <li>Magnitudes física y derivadas.</li>
                                    <li>Sistema de conversión de unidades</li>
                                    <li>Movimiento uniforme rectilíneo (MUR).</li>
                                    <li>Movimiento uniforme rectilíneo acelerado (MURA).</li>
                                    <li>Caída libre.</li>
                                    <li>Movimiento de proyectiles.</li>
                                    <li>Movimiento circular uniforme.</li>
                                    <li>Leyes de Newton.</li>
                                    <li>Energía de un sistema.</li>
                                    <li>Conservación de la energía.</li>
                                </ul>
                            </td>
                        </tr>
                    </table>
                </article>
                <article class="asignaturas">
                    <table class="tblasignaturas" id="htmlCssJavascript" onclick="desplegarTemas(this)">
                        <tr>
                            <th><img src="imagenes/ampliar.png" alt="ampliar"> Html, Css y JavaScript</th>
                        </tr>
                        <tr>
                            <td>
                                <ul>
                                    <li>HTML: Conceptos básicos.</li>
                                    <li>Estructura de una página HTML.</li>
                                    <li>Párrafos, imágenes, tablas, listas y formularios.</li>
                                    <li>CSS: Conceptos básicos.</li>
                                    <li>JavaScript: Conceptos básicos.</li>
                                    <li>Elementos básicos de JavaScript.</li>
                                    <li>Objetos predefinidos en JavaScript.</li>
                                    <li>Estructuras de control: if, while, for.</li>
                                    <li>Funciones en JavaScript.</li>
                                    <li>DOM (Document Object Model).</li>
                                </ul>
                            </td>
                        </tr>
                    </table>
                </article>
                <article class="asignaturas">
                    <table class="tblasignaturas" id="algoritmiaYprogramacion" onclick="desplegarTemas(this)">
                        <tr>
                            <th><img src="imagenes/ampliar.png" alt="ampliar"> Algoritmia y Programación</th>
                        </tr>
                        <tr>
                            <td>
                                <ul>
                                    <li>Concepto de algoritmo.</li>
                                    <li>Pseudocódigo y diagramas de flujo.</li>
                                    <li>Tipos de datos y operadores.</li>
                                    <li>Constantes y variables.</li>
                                    <li>Funciones y procedimientos.</li>
                                    <li>Programación estructurada.</li>
                                    <li>POO, Objetos y clases.</li>
                                    <li>Modularidad y encapsulamiento.</li>
                                    <li>Herencia.</li>
                                    <li>Tipos de datos compuestos, arreglos unidimensionales y multidimensionales.</li>
                                    <li>Polimorfismo.</li>
                                    <li>Estructuras secuencial, condicionales y repetitivas.</li>
                                    <li>Manejo de archivos.</li>
                                </ul>
                            </td>
                        </tr>
                    </table>
                </article>
                <article class="asignaturas">
                    <table class="tblasignaturas" id="sql" onclick="desplegarTemas(this)">
                        <tr>
                            <th><img src="imagenes/ampliar.png" alt="ampliar"> SQL</th>
                        </tr>
                        <tr>
                            <td>
                                <ul>
                                    <li>Introducción a SQL.</li>
                                    <li>Modelo de datos relacional MER.</li>
                                    <li>Elementos del lenguaje.</li>
                                    <li>Tipos de datos e identificadores.</li>
                                    <li>Operadores y expresiones.</li>
                                    <li>Funciones predefinidas.</li>
                                    <li>Tipos de sentencias SQL.</li>
                                    <li>Sentencias de definición de datos DDL, CREATE, ALTER, DROP.</li>
                                    <li>Sentencias de manipulación de datos DML, SELECT, UPDATE, INSERT, DELETE.</li>
                                    <li>Consultas simples.</li>
                                    <li>Creación de vistas SQL.</li>
                                    <li>Creación de rutinas invocadas SQL.</li>
                                </ul>
                            </td>
                        </tr>
                    </table>
                </article>
                <article class="asignaturas">
                    <table class="tblasignaturas" id="herramientasOfimaticas" onclick="desplegarTemas(this)">
                        <tr>
                            <th><img src="imagenes/ampliar.png" alt="ampliar"> Herramientas Ofimáticas</th>
                        </tr>
                        <tr>
                            <td>
                                <ul>
                                    <li>Microsoft Word.</li>
                                    <li>Microsoft Excel.</li>
                                    <li>Microsoft PowerPoint.</li>
                                    <li>Microsoft Access.</li>
                                </ul>
                            </td>
                        </tr>
                    </table>
                </article>
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
