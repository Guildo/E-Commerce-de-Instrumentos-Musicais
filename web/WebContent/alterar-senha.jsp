<%@page import="core.aplicacao.Resultado"%>
<%@page import="dominio.*"%>
<%@page import="dominio.Produto"%>
<%@page import="auxiliar.DadosDeCadastro"%>
<%@page import="java.util.*"%>
<!DOCTYPE html>
<html lang="pt">

<head>
<title>Alterar senha do cliente</title>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="description" content="OneTech shop project">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="https://fonts.googleapis.com/css?family=Hind:400,700" rel="stylesheet">
<link type="text/css" rel="stylesheet" href="css/bootstrap.min.css" />
<link rel="stylesheet" type="text/css" href="styles/bootstrap4/bootstrap.min.css">
<link href="plugins/fontawesome-free-5.0.1/css/fontawesome-all.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" type="text/css" href="plugins/OwlCarousel2-2.2.1/owl.carousel.css">
<link rel="stylesheet" type="text/css" href="plugins/OwlCarousel2-2.2.1/owl.theme.default.css">
<link rel="stylesheet" type="text/css" href="plugins/OwlCarousel2-2.2.1/animate.css">
<link rel="stylesheet" type="text/css" href="plugins/slick-1.8.0/slick.css">
<link rel="stylesheet" type="text/css" href="styles/main_styles.css">
<link rel="stylesheet" type="text/css" href="styles/responsive.css">
<link type="text/css" rel="stylesheet" href="css/slick.css" />
<link type="text/css" rel="stylesheet" href="css/slick-theme.css" />
<link type="text/css" rel="stylesheet" href="css/nouislider.min.css" />
<link rel="stylesheet" href="css/font-awesome.min.css">
<link type="text/css" rel="stylesheet" href="css/style.css" />

	<link rel="stylesheet" href="https://unpkg.com/purecss@1.0.0/build/pure-min.css" integrity="sha384-nn4HPE8lTHyVtfCBi5yW9d20FjT8BJwUXyWZT9InLYax14RDjBj46LmSztkmNP9w" crossorigin="anonymous">

</head>

<body>
		<%		
			Resultado ResultadoCliente = (Resultado) session.getAttribute("cliente");
			
			int id = Integer.parseInt(request.getParameter("idCli"));
			
			List<EntidadeDominio> cliente = ResultadoCliente.getEntidades();
	
			Cliente cli;
			
			StringBuilder sb;	
		%>
	
	<!-- HEADER -->
	<header class="header">
		<!-- Top Bar -->

		<div class="top_bar">
			<div class="container">
				<div class="row">
					<div class="col d-flex flex-row">
						<div class="top_bar_contact_item"><div class="top_bar_icon"><img src="images/phone.png" alt=""></div>+55 11 94555-2087</div>
						<div class="top_bar_contact_item"><div class="top_bar_icon"><img src="images/mail.png" alt=""></div><a href="#">guilherme.kajimura@fatec.sp.gov.br</a></div>
						<div class="top_bar_content ml-auto">
							<div class="top_bar_menu">
								<ul class="standard_dropdown top_bar_dropdown">
									<li>
										<a href="#">Português BR<i class="fas fa-chevron-down"></i></a>
										<ul>
											<li><a href="#">English</a></li>
											<li><a href="#">Spanish</a></li>
											<li><a href="#">Japanese</a></li>											
										</ul>
									</li>
								</ul>
							</div>
							<div class="top_bar_user">
								<div class="user_icon"><img src="images/user.svg" alt=""></div>
									<%
									sb = new StringBuilder();
									for(EntidadeDominio ent : cliente){
										cli = (Cliente)ent;
										if(cli.getId() == id){
											sb.append("<a id='perfil' class='navbar-brand' href='Cliente?idCli=");
											sb.append(cli.getId());
											sb.append("&");
											sb.append("operacao=CONSULTAR'>");
											sb.append("Bem Vindo, ");
											sb.append(cli.getNomeCliente());
											sb.append("</a>");
										}
									}								
									out.print(sb.toString());
									%>								
							</div>
						</div> 
					</div>
				</div>
			</div>		
		</div>
		<!-- container -->
	</header>
	<!-- /HEADER -->

	<!-- Main Navigation -->

		<div class="header_main">
			<div class="container">
				<div class="row">

					<!-- Logo -->
					<div class="col-lg-2 col-sm-3 col-3 order-1">
						<div class="logo_container">
							<div class="logo"><a href="dashboard_clienteLogado">Just in CASE</a></div>
						</div>
					</div>

					<!-- Search -->
					<div class="col-lg-6 col-12 order-lg-2 order-3 text-lg-left text-right">
						<div class="header_search">
							<div class="header_search_content">
								<div class="header_search_form_container">
									<form action="#" class="header_search_form clearfix">
										<input type="search" required="required" class="header_search_input" placeholder="Search for products...">
										<div class="custom_dropdown">
											<div class="custom_dropdown_list">
												<span class="custom_dropdown_placeholder clc">All Categories</span>
												<i class="fas fa-chevron-down"></i>
												<ul class="custom_list clc">
													<li><a class="clc" href="#">All Categories</a></li>
													<li><a class="clc" href="#">Computers</a></li>
													<li><a class="clc" href="#">Laptops</a></li>
													<li><a class="clc" href="#">Cameras</a></li>
													<li><a class="clc" href="#">Hardware</a></li>
													<li><a class="clc" href="#">Smartphones</a></li>
												</ul>
											</div>
										</div>
										<button type="submit" class="header_search_button trans_300" value="Submit"><img src="images/search.png" alt=""></button>
									</form>
								</div>
							</div>
						</div>
					</div>

					<!-- Wishlist -->
					<div class="col-lg-4 col-9 order-lg-3 order-2 text-lg-left text-right">
						<div class="wishlist_cart d-flex flex-row align-items-center justify-content-end">
							<div class="wishlist d-flex flex-row align-items-center justify-content-end">
								<div class="wishlist_icon"><img src="images/heart.png" alt=""></div>
								<div class="wishlist_content">
									<div class="wishlist_text"><a href="#">Wishlist</a></div>
									<div class="wishlist_count">115</div>
								</div>
							</div>

							<!-- Cart -->
							<div class="cart">
								<div class="cart_container d-flex flex-row align-items-center justify-content-end">
									<div class="cart_icon">
										<img src="images/cart.png" alt="">
										<div class="cart_count"><span>10</span></div>
									</div>
									<div class="cart_content">
										<div class="cart_text"><a href="#">Cart</a></div>
										<div class="cart_price">$85</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>

	<!-- /NAVIGATION -->
	<!-- section -->
	<div class="section">
		<!-- container -->
		<div class="container" style="text-align: center">
			<!-- row -->
			<!-- dashboard admin -->
			<div style="text-align: center">
				<form id="form" action="Cliente" method="POST" class="form-horizontal">
					<section class="panel">
						<header class="panel-heading" style="padding-right:100px">
							<h2 class="panel-title">Alterar Senha</h2>
						</header>
						<div class="panel-body" style="padding-right:50px">
						    <div class="form-group">
								<div class="col-sm-6">
									<%
									sb = new StringBuilder();
									sb.append("<input id='id' type='hidden' name='idCli' value='"+id+"'/>");
									out.print(sb.toString());
									%>
								</div>
							</div>  
							<div class="form-group">
								<div class="col-sm-6">
									<%
									sb = new StringBuilder();
									for(EntidadeDominio ent : cliente){
										cli = (Cliente)ent;
										if(cli.getId() == id){
											sb.append("<input id='senha1' type='hidden' name='senha_cliente' value='"+cli.getSenhaCliente()+"'/>");
										}
									}
									out.print(sb.toString());
									%>
								</div>
							</div>  
							<div class="form-group">
								<label class="col-sm-3 control-label">Senha atual<span class="required">*</span></label>
								<div class="col-sm-6">
									<input id="senha2" type="password" name="conf_senha_cliente" class="col-sm-10 form-control" inputpass" minlength="3" maxlength="16" required oninvalid="this.setCustomValidity('O campo obrigatório!')" oninput="setCustomValidity('')"/>
									  <div id="errLast"></div>
								</div>								
							</div>
							<div class="form-group">
								<label class="col-sm-3 control-label">Nova Senha <span class="required">*</span></label>
								<div class="col-sm-6">
									<input id="nova_senha" type="password" name="nova_senha_cliente" class="col-sm-10 form-control" inputpass" minlength="3" maxlength="16" required oninvalid="this.setCustomValidity('O campo obrigatório!')" oninput="setCustomValidity('')"/>
									<span id="confirmMessage" class="confirmMessage"></span>
									<div id="errLast"></div>
								</div>
							</div>		
						<footer class="panel-footer">
							<div class="row" style="padding-left:100px">
								<div class="col-sm-9 col-sm-offset-3">
									 <button type="submit" name="operacao" value="ALTERAR-SENHA" class="btn btn-primary">Salvar Nova Senha</button>
								</div>
							</div>
						</footer>
					</section>				
				</form>
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