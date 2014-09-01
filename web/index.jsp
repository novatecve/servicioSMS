<%-- 
    Document   : index
    Created on : 07/08/2014, 10:04:44 AM
    Author     : akuma
--%>
<%@page import="com.siclhos.servicios.sms.servicioSMS"%>
<%
        servicioSMS servicio = new servicioSMS();
        String mensaje = servicio.enviarSMS(0, 0, 0, null, 1);

%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Hello World <%=mensaje%>!</h1>
    </body>
</html>
