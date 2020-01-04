<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="core.aplicacao.Resultado"%>
<%@page import="dominio.Cliente"%>
<%@page import="dominio.*"%>
<%@page import="java.util.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Alterar Endere�o</title>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="description" content="OneTech shop project">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link type="text/css" rel="stylesheet" href="css/bootstrap.min.css" />
<link rel="stylesheet" type="text/css" href="styles/bootstrap4/bootstrap.min.css">
<link href="plugins/fontawesome-free-5.0.1/css/fontawesome-all.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" type="text/css" href="plugins/OwlCarousel2-2.2.1/owl.carousel.css">
<link rel="stylesheet" type="text/css" href="plugins/OwlCarousel2-2.2.1/owl.theme.default.css">
<link rel="stylesheet" type="text/css" href="plugins/OwlCarousel2-2.2.1/animate.css">
<link rel="stylesheet" type="text/css" href="plugins/slick-1.8.0/slick.css">
<link rel="stylesheet" type="text/css" href="styles/main_styles.css">
<link rel="stylesheet" type="text/css" href="styles/responsive.css">
</head>
<body>
	<%		
		Resultado endereco = (Resultado) session.getAttribute("dadosEndereco");
		
		int id = Integer.parseInt(request.getParameter("idEnd"));					
		
		List<EntidadeDominio> enderecos = endereco.getEntidades();
		Endereco end;
		
		Resultado login = (Resultado) session.getAttribute("login");
		
		List<EntidadeDominio> cliente = login.getEntidades();
		Cliente cli = (Cliente)cliente.get(0); 
		String nomeCliente = cli.getNomeCliente();
		int idCliente = cli.getId();
		
		StringBuilder sb;	
	%>
<!-- HEADER -->
	<header class="header">
		<!-- header -->
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
										<a href="#">Portugu�s BR<i class="fas fa-chevron-down"></i></a>
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
									
											sb.append("<a id='perfil' class='navbar-brand' href='Cliente?idCli=");
											sb.append(idCliente);
											sb.append("&");
											sb.append("operacao=CONSULTAR'>");
											sb.append("Bem Vindo, ");
											sb.append(nomeCliente);
											sb.append("</a>");
																	
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
							<div class="logo"><a href="dashboard_clienteLogado.jsp">Just in CASE</a></div>
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
				<form id="form" action="Enderecos" method="POST" class="form-horizontal">
					<section class="panel">
						<header class="panel-heading" style="padding-right:100px">
							<h2 class="panel-title">Informa��es do Endere�o</h2>
						</header>
						<div class="panel-body" style="padding-right:50px">
						    <div class="form-group">
								<div class="col-sm-6">
									<%
									sb = new StringBuilder();
									sb.append("<input id='id' type='hidden' name='idEnd' value='"+id+"'/>");
									out.print(sb.toString());
									%>
								</div>
							</div>  	
													
							<div class="form-group">
								<label class="col-sm-3 control-label">Estado <span class="required">*</span></label>
								<div class="col-sm-6">
								<%
								sb = new StringBuilder();
								for(EntidadeDominio ent : enderecos){
									end = (Endereco)ent;
									if(end.getId() == id){
										sb.append("<input id='estado' type='text' name='estado_endereco' value='"+end.getEstado());
										sb.append(" 'class='col-sm-10 form-control' ");
										sb.append("required oninvalid='this.setCustomValidity");
										sb.append("('O campo � obrigat�rio!') oninput='setCustomValidity('')/>");
									}
								}
								out.print(sb.toString());
								%>									
								</div>
							</div>				
							<div class="form-group">
								<label class="col-sm-3 control-label">Cidade <span class="required">*</span></label>
								<div class="col-sm-6">
								<%
								sb = new StringBuilder();
								for(EntidadeDominio ent : enderecos){
									 end = (Endereco)ent;
									 if(end.getId() == id){
										sb.append("<input id='cidade' type='text' name='cidade_endereco' value='"+end.getCidade());
										sb.append(" 'class='col-sm-10 form-control' ");
										sb.append("required oninvalid='this.setCustomValidity");
										sb.append("('O campo � obrigat�rio!') oninput='setCustomValidity('')/>");
									 }
								}
								out.print(sb.toString());
								%>									
								</div>
							</div>			
							<div class="form-group">
								<label class="col-sm-3 control-label">Bairro <span class="required">*</span></label>
								<div class="col-sm-6">
								<%
								sb = new StringBuilder();
								for(EntidadeDominio ent : enderecos){
									 end = (Endereco)ent;
									 if(end.getId() == id){
										sb.append("<input id='bairro' type='text' name='bairro_endereco' value='"+end.getBairro());
										sb.append(" 'class='col-sm-10 form-control' ");
										sb.append("required oninvalid='this.setCustomValidity");
										sb.append("('O campo � obrigat�rio!') oninput='setCustomValidity('')/>");
									 }
								}
								out.print(sb.toString());
								%>									
								</div>
							</div>	
							<div class="form-group">
								<label class="col-sm-3 control-label">CEP <span class="required">*</span></label>
								<div class="col-sm-6">
								<%
								sb = new StringBuilder();
								for(EntidadeDominio ent : enderecos){
									 end = (Endereco)ent;
									 if(end.getId() == id){
										sb.append("<input id='cep' type='text' name='cep_endereco' value='"+end.getCEP());
										sb.append(" 'class='col-sm-10 form-control' ");
										sb.append("required oninvalid='this.setCustomValidity");
										sb.append("('O campo � obrigat�rio!') oninput='setCustomValidity('')/>");
									 }
								}
								out.print(sb.toString());
								%>									
								</div>
							</div>	
							<div class="form-group">
								<label class="col-sm-3 control-label">Complemento <span class="required">*</span></label>
								<div class="col-sm-6">
								<%
								sb = new StringBuilder();
								for(EntidadeDominio ent : enderecos){
									 end = (Endereco)ent;
									 if(end.getId() == id){
										sb.append("<input id='complemento' type='text' name='complemento_endereco' value='"+end.getComplemento());
										sb.append(" 'class='col-sm-10 form-control' ");
										sb.append("required oninvalid='this.setCustomValidity");
										sb.append("('O campo � obrigat�rio!') oninput='setCustomValidity('')/>");
									 }
								}
								out.print(sb.toString());
								%>									
								</div>
							</div>	
						</div>
						<footer class="panel-footer">
							<div class="row" style="padding-left:100px">
								<div class="col-sm-9 col-sm-offset-3">
									 <button type="submit" name="operacao" value="ALTERAR" class="btn btn-primary">Salvar Altera��es</button>
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