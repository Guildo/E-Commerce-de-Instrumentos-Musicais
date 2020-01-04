<%@page import="com.sun.istack.internal.Builder"%>
<%@page import="core.aplicacao.Resultado"%>
<%@page import="dominio.EntidadeDominio"%>
<%@page import="dominio.*"%>
<%@page import="java.util.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta http-equiv="refresh" content="3;Capinha?operacao=CONSULTAR" />
<title>Erro</title>
</head>
<%		
			Resultado resultado = (Resultado)session.getAttribute("erro");
			StringBuilder sb;
%>
<body>
<%
	out.print("<h1>"+resultado.getMsg()+"</h1>");
%>
</body>
</html>