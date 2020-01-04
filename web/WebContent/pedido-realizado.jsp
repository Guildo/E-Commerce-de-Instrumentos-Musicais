<%@page import="core.aplicacao.Resultado"%>
<%@page import="dominio.Cliente"%>
<%@page import="dominio.EntidadeDominio"%>
<%@page import="java.util.*"%>
<!DOCTYPE html>
<html lang="en">

<head>

	<%
	int erro = 0;
	Resultado login = (Resultado) session.getAttribute("login");
	try{
		List<EntidadeDominio> user = login.getEntidades();
		} catch (Exception e){
			erro = 1;
	}
	session.removeAttribute("carrinho");
	String nomeUser = "";
	int idUser = 0;
	List<EntidadeDominio> user = login.getEntidades();
	Cliente us = (Cliente)user.get(0);
	nomeUser = us.getNomeCliente();
	idUser = us.getId();
	%>

	<meta charset="utf-8">
	<meta http-equiv="refresh" content="3;Pedidos?idusr=<%out.print(idUser); %>&status=abertos&operacao=CONSULTAR" />
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

<body>
	<!-- section -->
	<div class="section">
		<!-- container -->
		<div class="container" style="text-align: center">
			<!-- row -->
			<!-- dashboard admin -->
			<div style="text-align: center; margin-top:100px; padding-top:100px">
					
					<h1><%out.print(nomeUser);%>, seu pedido foi realizado com sucesso!</h1>
					<h1>Você será redirecionado em instantes...</h1>
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