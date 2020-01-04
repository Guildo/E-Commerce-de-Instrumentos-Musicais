<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="core.aplicacao.Resultado"%>
<%@page import="dominio.*"%>
<%@page import="dominio.Cliente"%>
<%@page import="auxiliar.DadosDeCadastro"%>
<%@page import="java.util.*"%>
<!DOCTYPE html>
<html>
<head>
<%
	int erro = 0;
	Resultado login = (Resultado) session.getAttribute("login");
	try{
		List<EntidadeDominio> cli = login.getEntidades();
	} catch (Exception e){
		erro = 1;
	}
	
	int id = 0;
	String nomeUser = "";
	if(erro==0){
		List<EntidadeDominio> cli = login.getEntidades();
		Cliente objCli = (Cliente)cli.get(0);
		//nomeUser = objCli.getNomeCliente();
		id = objCli.getId();
	}
	StringBuilder sb = new StringBuilder();
	
	String x = request.getParameter("pagina");
%>
<meta charset="utf-8">
<%
	if(x == null)
		out.print("<meta http-equiv='refresh' content='3;Enderecos?idusr="+id+"&operacao=CONSULTAR'/>");
	else
		out.print("<meta http-equiv='refresh' content='3;finalizar-compra.jsp' />");
%>
<meta name="viewport" content="width=device-width, initial-scale=1">
	<!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->

	<title>Redirecionando...</title>

	<!-- Google font -->
	<link href="https://fonts.googleapis.com/css?family=Hind:400,700" rel="stylesheet">

	<!-- Bootstrap -->
	<link type="text/css" rel="stylesheet" href="css/bootstrap.min.css" />

	<!-- Slick -->
	<link type="text/css" rel="stylesheet" href="css/slick.css" />
	<link type="text/css" rel="stylesheet" href="css/slick-theme.css" />

	<!-- nouislider -->
	<link type="text/css" rel="stylesheet" href="css/nouislider.min.css" />

	<!-- Font Awesome Icon -->
	<link rel="stylesheet" href="css/font-awesome.min.css">

	<!-- Custom stlylesheet -->
	<link type="text/css" rel="stylesheet" href="css/style.css" />


</head>
<body onload="refresh()">
<!-- section -->
	<div class="section">
		<!-- container -->
		<div class="container" style="text-align: center">
			<!-- row -->
			<!-- dashboard admin -->
			<div style="text-align: center; margin-top:100px; padding-top:50px">
					<h1>O endereço foi alterado com sucesso!</h1><br>
					<h2>Você será redirecionado em instantes...</h2>
			</div>
			<!-- dashboard admin -->
			<!-- /row -->
		</div>
		<!-- /container -->
	</div>
	<!-- /section -->

	<!-- jQuery Plugins -->
	<script src="js/jquery.min.js"></script>
	<script src="js/bootstrap.min.js"></script>
	<script src="js/slick.min.js"></script>
	<script src="js/nouislider.min.js"></script>
	<script src="js/jquery.zoom.min.js"></script>
	<script src="js/main.js"></script>
</body>
</html>