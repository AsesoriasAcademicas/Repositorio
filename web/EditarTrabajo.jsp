<%-- 
   Document   : EditarTrabajo
   Created on : 14/03/2018, 11:36:15 PM
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
<%! List classList = null;%>
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
        classList = (ArrayList) sesion.getAttribute("listaTalleres");
    }
%>

<%for (i = 0; i < classList.size(); i++) {
        tls = (Taller) classList.get(i);
        if (tls.getTutoria().getCodigoTutoria() == Integer.parseInt(request.getParameter("CodigoTutoria"))) {
            i = classList.size();
        }
    }%>

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
            <% session.setAttribute("codTall", request.getParameter("CodigoTutoria"));%>
                if (document.getElementById("solicitaTuClasePresencial").firstChild.href == window.location.href) {
                    sessionStorage.clear();
                    document.getElementById("solicitaTuClase").style.backgroundColor = "#FDFDFD";
                    document.getElementById("solicitaTuClase").firstChild.style.color = "#1C242A";
                }

                if (!sessionStorage.getItem("submenuActivo") && sessionStorage.getItem("clickPag")) {
                    document.getElementById(sessionStorage.getItem("clickPag")).style.backgroundColor = "#FDFDFD";
                    document.getElementById(sessionStorage.getItem("clickPag")).firstChild.style.color = "#1C242A";
                } else if (sessionStorage.getItem("submenuActivo") == "solicitaTuClase") {
                    sessionStorage.clear();
                    document.getElementById("solicitaTuClase").style.backgroundColor = "#FDFDFD";
                    document.getElementById("solicitaTuClase").firstChild.style.color = "#1C242A";
                }

                document.getElementById("fecha").value = "<%= tls.getFechaEntregaTaller()%>";
                document.getElementById("hora").value = "<%= tls.getHoraEntregaTaller()%>";
                //document.getElementById("datosEstudiante").style.display = "none";
                //document.getElementById("datosClase").style.display = "none";

                if ('<%= session.getAttribute("confirmacionFallidaEditaTrabajo")%>' != "" && '<%= session.getAttribute("confirmacionExitosaEditaTrabajo")%>' == "") {
                    document.getElementById("confirmacionFallidaEditaTrabajo").innerHTML = '<%= session.getAttribute("confirmacionFallidaEditaTrabajo")%>';
                    document.getElementById("confirmacionFallidaEditaTrabajo").style.display = "block";
                    document.getElementById("confirmacionExitosaEditaTrabajo").style.display = "none";
                } else if ('<%= session.getAttribute("confirmacionFallidaEditaTrabajo")%>' == "" && '<%= session.getAttribute("confirmacionExitosaEditaTrabajo")%>' != "") {
                    document.getElementById("confirmacionExitosaEditaTrabajo").innerHTML = '<%= session.getAttribute("confirmacionExitosaEditaTrabajo")%>';
                    document.getElementById("confirmacionExitosaEditaTrabajo").style.display = "block";
                    document.getElementById("confirmacionFallidaEditaTrabajo").style.display = "none";
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
                            } else {
                                steps[i].style.display = "none";
                                steps[i + 1].style.display = "block";
                            }
                        } else {
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

            function main() {
                $('.menu_bar').click(function () {
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

                $('#solicitaTuClase').click(function () {
                    $(this).children('#l02').slideToggle();
                });
            }

            /*
             
             La función jQuery define las materias y sus temas corelacionados.
             
             */

            var options = {
                Matemáticas3: ["Los números naturales", "Composición y descomposición de números naturales", "Orden de números naturales",
                    "Comparación y ordenación de números naturales >, <,  =", "Noción de fracciones", "Representación gráfica de fracciones", "Fracciones equivalentes",
                    "Adición y sustracción de números naturales y sus propiedades", "Problemas de adición y sustracción", "Multiplicación y división de números naturales y sus propiedades",
                    "Mitad, tercio y cuarto", "Problemas de multiplicación y división"],
                Matemáticas4: ["Los números naturales", "Adición de números naturales llevando", "Sustracción de números naturales llevando", "Multiplicación de números naturales por 2 y 3 cifras",
                    "División con ceros en el cociente", "División de naturales con divisores de 2 o más cifras", "Operaciones combinadas", "Los números fraccionarios", "Operaciones con fracciones",
                    "Los números decimales", "Adición y sustracción de números decimales", "Multiplicación y división de números decimales", "Múltiplos y divisores"],
                Matemáticas5: ["Los números naturales", "Adición y sustracción de números naturales", "Multiplicación de números naturales", "División con ceros en el cociente",
                    "División de naturales con divisores de 2 y más cifras", "Operaciones combinadas", "Los números decimales", "Lectura y escritura de fracciones", "Comparación de fracciones",
                    "Operaciones con fracciones", "Adición y sustracción de números decimales", "Multiplicación y división de números decimales", "Sistemas de numeración: Los números Romanos"],
                Matemáticas6: ["Sistemas de numeración: Romano, binario y decimal", "Los números naturales", "Operaciones con números naturales", "Potenciación, radicación y logaritmación",
                    "Múltiplos y divisores", "Descomposición factorial", "Los números enteros y la recta numérica(Plano cartesiano)", "Operaciones con números enteros", "Ecuaciones simples con números enteros",
                    "Los números fraccionarios", "Operaciones con números fraccionarios", "Problemas verbales con números fraccionarios"],
                Matemáticas7: ["Números enteros, polinomios aritméticos", "Expresiones con signos de agrupación", "Los números racionales", "Operaciones con numeros racionales", "Problemas verbales con números racionales",
                    "Los números decimales", "Operaciones con números decimales", "Ecuaciones, planteamiento y resolución de problemas", "Proporcionalidad", "Magnitudes directa e inversamente proporcionales",
                    "Regla de tres simple", "Problemas de aplicación"],
                Matemáticas8: ["Conjuntos numéricos, números naturales, enteros, racionales e irracionales", "Expresiones algebraicas", "Monomios, trinomios y polinomios", "Operaciones con expresiones algebraicas",
                    "Productos y cocientes notables", "Triángulo de Pascal", "Casos de factorización", "Fracciones algebraicas", "Sistema de ecuaciones lineales 2x2", "Metodos de solución para sistemas de ecuaciones",
                    "Problemas de aplicación"],
                Matemáticas9: ["Proporcionalidad, regla de tres simple y compuesta", "Expresiones algebraicas", "Función lineal, ecuación de la recta", "Sistema de ecuaciones lineales 2x2", "Metodos de solución, sistemas de ecuaciones 2x2",
                    "Sistema de ecuaciones lineales 3x3", "Metodos de solución, sistemas de ecuaciones 3x3", "Función cuadrática", "Ceros, raíces o soluciones de la función cuadrática", "Función exponencial y logarítmica",
                    "Sucesiones y progresiones"],
                Matemáticas10: ["Razones trigonométricas", "Triángulos rectángulos", "Funciones trigonométricas", "Gráfica de las funciones trigonométricas",
                    "Identidades trigonométricas", "Ecuaciones trigonométricas", "Teorema o ley del seno", "Teorema o ley del coseno", "Vectores en el plano, en el espacio, producto punto y producto vectorial",
                    "Geometría analítica", "Distancia entre dos puntos, ecuación de la recta, ecuación punto-pendiente", "La parábola, elipse e hipérbola"],
                Matemáticas11: ["Ecuaciones, proporcionalidad y regla de tres", "Funciones y gráficas", "Función lineal, cuadrática, polinómica, parte entera y valor absoluto", "Función inversa, racional, exponencial y logarítmica",
                    "Fuciones periódicas y trigonométricas", "Límites y continuidad", "Cálculo de límites, álgebra de límites", "Límite de funciones indeterminadas", "Continuidad y discontinuidad",
                    "Derivadas, propiedades de las derivadas", "Regla de la cadena", "la antiderivada, integrales"],
                Geometría: ["Conceptos básicos, recta, semirecta y segmento", "Ángulos", "Clasificación y relacion de ángulos", "Triángulos", "Clasificación y propiedades de los triángulos",
                    "Teorema de Pitágoras", "Cuadriláteros y polígonos", "Circunferencia y círculo", "Perímetros y áreas", "Figuras Geométricas",
                    "Semejanza de triángulos, teorema de Thales", "Áreas y volúmenes"],
                ProbabilidadyEstadística: ["Teoria de conjuntos", "Operaciones de conjuntos", "Técnicas de conte", "Principio multiplicativo y aditivo", "Permutaciones y combinaciones",
                    "Probabilidad, términos básicos", "Probabilidad clásica", "Estadística descriptiva", "Medidas de tendencia central",
                    "Media aritmética, mediana, moda, Qk, Dk, Pk"],
                Precálculo: ["Función y relación", "Gráficar y tabular una función", "Operaciones con funciones, funciones compuestas", "Intervalos, intervalo cerrado y abierto",
                    "Dominio y rango de una función", "Funciones polinominales", "Ceros de una función polinominal", "División sintética o Ruffini", "Funciones cuadráticas",
                    "Funciones racionales, asíndotas de una función racional"],
                Física: ["Magnitudes física y derivadas", "Sistema de conversión de unidades", "Movimiento uniforme rectilíneo (MUR)", "Movimiento uniforme rectilíneo acelerado (MURA)",
                    "Caída libre", "Movimiento de proyectiles", "Movimiento circular uniforme", "Leyes de Newton", "Energía de un sistema", "Conservación de la energía"],
                HtmlCssyJavaScript: ["HTML: Conceptos básicos", "Estructura de una página HTML", "Párrafos, imágenes, tablas, listas y formularios", "CSS: Conceptos básicos",
                    "JavaScript: Conceptos básicos", "Elementos básicos de JavaScript", "Objetos predefinidos en JavaScript", "Estructuras de control: if, while, for", "Funciones en JavaScript",
                    "DOM (Document Object Model)"],
                AlgoritmiayProgramación: ["Concepto de algoritmo", "Pseudocódigo y diagramas de flujo", "Tipos de datos y operadores", "Constantes y variables", "Funciones y procedimientos",
                    "Programación estructurada", "POO, Objetos y clases", "Modularidad y encapsulamiento", "Herencia", "Tipos de datos compuestos, arreglos uni y multidimensionales",
                    "Polimorfismo", "Estructuras secuencial, condicionales y repetitivas", "Manejo de archivos"],
                SQL: ["Introducción a SQL", "Modelo de datos relacional MER", "Elementos del lenguaje", "Tipos de datos e identificadores", "Operadores y expresiones", "Funciones predefinidas",
                    "Tipos de sentencias SQL", "Sentencias DDL, CREATE, ALTER, DROP", "Sentencias DML, SELECT, UPDATE, INSERT, DELETE", "Consultas simples",
                    "Creación de vistas SQL", "Creación de rutinas invocadas SQL"],
                HerramientasOfimáticas: ["Microsoft Word", "Microsoft Excel", "Microsoft PowerPoint", "Microsoft Access"]
            }

            $(function () {
                var fillSecondary = function () {
                    var selected = $('#primary').val();
                    $('#secondary').empty();
                    options[selected].forEach(function (element, index) {
                        $('#secondary').append('<option value="' + element + '">' + element + '</option>');
                    });
                }
                $('#primary').change(fillSecondary);
                fillSecondary();
            });

            $(function () {
                document.getElementById("primary").value = "<%= tls.getTutoria().getAsignaturaTutoria()%>";

                var fillSecondary = function () {
                    var selected = $('#primary').val();
                    $('#secondary').empty();
                    options[selected].forEach(function (element, index) {
                        $('#secondary').append('<option value="' + element + '">' + element + '</option>');
                    });
                }
                $('#primary').change(fillSecondary);
                fillSecondary();

                document.getElementById("secondary").value = "<%= tls.getTutoria().getTemaTutoria()%>";
            })

            /*Funcion Javascript para mostrar el nombre del archivo cargado*/
            $(function () {
                document.getElementById("archivo").title = '<%= tls.getNombreArchivo()%>';
                //alert("Hola");
            })


            /*Funcion Javascript que limita el tamaño del archivo que se desea cargar*/
            function limitarTamaño() {
                var fileSize = document.getElementById("archivo").size;
                alert("Prueba");
                if(fileSize > 2097152){
                    alert("El archivo supera el tamaño de carga permitido (2MB)");
                    document.getElementById("archivo").value='';
                    document.getElementById("archivo").name='';
                }
            }
        </script>
    </head>
    <div class="menu_bar">
        <a href="#" class="bt-menu"><span class="icon-menu"></span>Menú</a>
    </div>    
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
                <li>Editar Trabajo</li>
            </ul></br>

            <article>
                <p id="confirmacionExitosaEditaTrabajo" class="confirmacionExitosa"></p>
                <p id="confirmacionFallidaEditaTrabajo" class="confirmacionFallida"></p>
                <h4>Es indispensable completar los datos solicitados para acordar una asesoría de manera satisfactoria.</h4>
                <p id="indicadorRequerido">* Campos requeridos</p>
                <form id="formUpload" action="editarArchivo" method="POST" enctype="multipart/form-data" >
                    <article>
                        <section class="datoformulario">
                            <input type="file" <%if (tls != null) {%> title="<%= tls.getNombreArchivo()%>" <%}%> id="archivo" name="archivo" accept="image/jpeg,image/gif,image/png,application/pdf,.txt,.doc,.docx" required/>
                        </section>
                        <section class="confirmarformulario">
                            <input type="submit" value="Subir archivo"/>
                        </section>
                    </article>
                </form>
                <form id="formRegistro" action="EditarTrabajo" method="POST" onsubmit="return validar()">
                    <fieldset id="datosHorario">
                        <legend>Dejanos tu trabajo (Paso 1 de 3)</legend>
                        <article>
                            <section class="datoformulario">
                                <label for="fecha" class="obligatorio">Fecha entrega</label>
                                <label id="validfecha"></label>
                                <input type="date" name="fecha" id="fecha" class="contformulario" <%if (tls != null) {%> value="<%= tls.getFechaEntregaTaller()%>" <%}%>srequired>
                            </section>
                            <section class="datoformulario">
                                <label for="hora" class="obligatorio">Hora entrega</label>
                                <label id="validhora"></label>
                                <input type="time" name="hora" min="07:00" max="18:00" id="hora" class="contformulario" <%if (tls != null) {%> value="<%= tls.getHoraEntregaTaller()%>" <%}%>required>
                            </section>
                            <!--<section class="confirmarformulario">
                                <button type="button" id="btnSiguiente" onclick="siguienteStep('datosHorario')">Siguiente</button>
                            </section>-->
                        </article>
                    </fieldset>

                    </br>

                    <fieldset id="datosClase">
                        <legend>Dejanos tu trabajo (Paso 1 de 2)</legend>
                        <article>
                            <section class="datoformulario">
                                <label for="materia" class="obligatorio">Materia</label>
                                <label id="validmateria"></label>
                                <select id="primary" name="materia" id="materia" class="contformulario" autofocus>
                                    <option value="Matemáticas3">Matemáticas 3</option>
                                    <option value="Matemáticas4">Matemáticas 4</option>
                                    <option value="Matemáticas5">Matemáticas 5</option>
                                    <option value="Matemáticas6">Matemáticas 6</option>
                                    <option value="Matemáticas7">Matemáticas 7</option>
                                    <option value="Matemáticas8">Matemáticas 8</option>
                                    <option value="Matemáticas9">Matemáticas 9</option>
                                    <option value="Matemáticas10">Matemáticas 10</option>
                                    <option value="Matemáticas11">Matemáticas 11</option>
                                    <option value="Geometría">Geometría</option>
                                    <option value="ProbabilidadyEstadística">Probabilidad y Estadística</option>
                                    <option value="Precálculo">Precálculo</option>
                                    <option value="Física">Física</option>
                                    <option value="HtmlCssyJavaScript">Html, Css y JavaScript</option>
                                    <option value="AlgoritmiayProgramación">Algoritmia y Programación</option>
                                    <option value="SQL">SQL</option>
                                    <option value="HerramientasOfimáticas">Herramientas Ofimáticas</option>
                                </select>
                            </section>
                            <section class="datoformulario">
                                <label for="tema" class="obligatorio">Tema</label>
                                <label id="validtema"></label>
                                <select id="secondary" name="tema" id="tema" class="contformulario">
                                </select>
                            </section>
                            <section class="datoformulario">
                                <label for="mensaje" class="obligatorio">Dudas/inquietudes</label>
                                <label id="validmensaje"></label>
                                <textarea name="mensaje" id="mensaje" placeholder="Escriba aquí sus dudas e inquietudes..." class="contformulario" maxlength="500" required><%= tls.getTutoria().getDudasInquietudesTutoria()%></textarea>
                            </section>
                            <!--<section class="confirmarformulario">
                                <button type="button" id="btnAnterior" onclick="anteriorStep('datosClase')">Anterior</button>
                                <button type="button" id="btnSiguiente" onclick="siguienteStep('datosClase')">Siguiente</button>
                            </section>-->
                        </article>
                    </fieldset>

                    </br>

                    <fieldset id="datosEstudiante">
                        <legend>Dejanos tu trabajo (Paso 2 de 2)</legend>
                        <article>
                            <section class="datoformulario">
                                <label for="nombre" class="obligatorio">Nombre</label>
                                <label id="validnombre"></label>
                                <input type="text" name="nombre" id="nombre" class="contformulario" pattern="^([a-zA-Z\s])*$" maxlength="50" <%if (usu != null) {%> value="<%= usu.getNombrePersona()%>" <%}%> required>
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
                                <input type="tel" name="telefono" id="telefono" class="contformulario" pattern="^[0-9]{7}|[0-9]{10}$" placeholder="Fijo 8****** - Móvil 3*********" <%if (usu != null) {%> value="<%= usu.getTelefonoPersona()%>" <%}%> required>
                            </section>
                            <section class="confirmarformulario">
                                <!--<button type="button" class="btnAnterior" onclick="anteriorStep('datosEstudiante')">Anterior</button>-->
                                <input type="submit" id="btnEnviar" value="Enviar" onclick="return confirm('¿Está seguro(a) de guardar los cambios del Trabajo?');">
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
