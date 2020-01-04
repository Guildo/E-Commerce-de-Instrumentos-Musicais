<%@page import="core.aplicacao.Resultado"%>
<%@page import="dominio.*"%>
<%@page import="auxiliar.DadosDeCadastro"%>
<%@page import="java.util.*"%>

<!DOCTYPE html>
<html lang="pt">

<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->

	<title>Pedidos de troca</title>

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
	<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.1/css/all.css" integrity="sha384-50oBUHEmvpQ+1lW4y57PTFmhCaXp0ML5d60M1M7uH2+nqUivzIebhndOJK28anvf" crossorigin="anonymous">

<%
	String erro = "";
	//recebendo dados de pedidos
	
	int t = 0;
	double valor = 0;
	
	Resultado resultado = (Resultado) session.getAttribute("dadosPedido");
	
	if(session.getAttribute("dadosPedido") != null){
		List<EntidadeDominio> pedidos = resultado.getEntidades();
	}else{
		pageContext.forward("User?operacao=CONSULTAR");
	}
	
	List<EntidadeDominio> pedidos = resultado.getEntidades();
	
	StringBuilder sb = new StringBuilder();
	
	Pedido ped;
	
	for(EntidadeDominio ent:pedidos){
		ped = (Pedido)ent;
		t = pedidos.size();
		
	}
	
	/* sb = new StringBuilder();
	sb.append(us.getNome_usuario());
	sb.append(us.getEnderecos().get(0).getRua());
out.print(sb.toString()); */
%>

</head>

<body>
	<!-- HEADER -->
	<header>
		<!-- header -->
		<div id="header">
			<div class="container">
				<div class="pull-left">
					<!-- Logo -->
					<div class="header-logo">
						<a class="logo" href="#">
							<img src="./img/logo.png" alt="">
						</a>
					</div>
					<!-- /Logo -->
				</div>
				<div class="pull-right">
					<ul class="header-btns">
						<!-- Account -->
						<li class="header-account dropdown default-dropdown">
							<div class="dropdown-toggle" role="button" data-toggle="dropdown" aria-expanded="true">
								<div class="header-btns-icon">
									<i class="fa fa-user-o"></i>
								</div>
								<strong class="text-uppercase">Olá, Administrador <i class="fa fa-caret-down"></i></strong>
							</div>
							<a href="logout.jsp" class="text-uppercase">logout</a>
							<ul class="custom-menu">
								<li><a href="#"><i class="fa fa-user-o"></i> Minha conta</a></li>
							</ul>
						</li>
						<!-- /Account -->

						<!-- Mobile nav toggle-->
						<li class="nav-toggle">
							<button class="nav-toggle-btn main-btn icon-btn"><i class="fa fa-bars"></i></button>
						</li>
						<!-- / Mobile nav toggle -->
					</ul>
				</div>
				<div class="pull-right">
					<ul class="header-btns">
						<!-- Mobile nav toggle-->
						<li class="nav-toggle">
							<button class="nav-toggle-btn main-btn icon-btn"><i class="fa fa-bars"></i></button>
						</li>
						<!-- / Mobile nav toggle -->
					</ul>
				</div>
			</div>
			<!-- header -->
		</div>
		<!-- container -->
	</header>
	<!-- /HEADER -->

	<!-- NAVIGATION -->
	<div id="navigation">
		<!-- container -->
		<div class="container">
			<div id="responsive-nav">
				<!-- menu nav -->
				<div class="menu-nav">
					<span class="menu-header">Menu Administrador <i class="fa fa-bars"></i></span>
					<ul class="menu-list">
						<li>
							<a href="dashboard-admin.jsp">Pagina Principal</a>
						</li>
						<li class="dropdown default-dropdown"><a class="dropdown-toggle" data-toggle="dropdown" aria-expanded="true">Produtos <i class="fa fa-caret-down"></i></a>
							<ul class="custom-menu">
								<li><a href="Produtos?operacao=CONSULTAR">Visualizar produtos</a></li>
								<li><a href="DadosProduto?operacao=CONSULTAR&editar=0">Cadastrar produtos</a></li>
							</ul>
						</li>
						<li class="dropdown default-dropdown"><a class="dropdown-toggle" data-toggle="dropdown" aria-expanded="true">Pedidos <i class="fa fa-caret-down"></i></a>
							<ul class="custom-menu">
								<li><a href="Pedidos?operacao=CONSULTAR-ADMIN">Visualizar todos os pedidos</a></li>
								<li><a href="Pedidos?status=abertos&operacao=CONSULTAR-ADMIN">Visualizar pedidos em aberto</a></li>
							</ul>
						</li>
						<li class="dropdown default-dropdown"><a class="dropdown-toggle" data-toggle="dropdown" aria-expanded="true">Dashboard <i class="fa fa-caret-down"></i></a>
							<ul class="custom-menu">
								<li><a href="Graficos?operacao=DASHBOARD">Gráficos analíticos</a></li>
							</ul>
						</li>
					</ul>
				</div>
				<!-- menu nav -->
			</div>
		</div>
		<!-- /container -->
	</div>
	<!-- /NAVIGATION -->
	<!-- section -->
	<div class="section">
		<!-- container -->
		<div class="container">
			<!-- row -->
			<div class="row">
				<!--  Product Details -->
				<div class="product product-details clearfix">
					<div style="display:flex; justify-content: space-around">
						<div class='col-md-10'style='height:20px'>
							<div class='billing-details'>
								<div class='section-title'>
									<h3 class='title'>Todos os pedidos de troca</h3>
								</div>
							</div>
						</div>
					</div>
					<div class='col-md-12'>
						<div class='billing-details'>
						<%
						if(t==0){
							out.print("<br><br><br><div style='display:flex; justify-content:space-around'>");
							out.print("<img height='200px' src='https://image.flaticon.com/icons/png/512/18/18296.png'>");
							out.print("</div><br><br>");
							
							out.print("<div style='display:flex; justify-content:space-around'>");
							out.print("<p><strong>Opa... Você não tem nenhum pedido ainda...</strong></p>");
							out.print("</div>");
						}else{
							out.print("<br><br>");
							out.print("<table class='shopping-cart-table table'>");
							out.print("<thead>");
							out.print("<th width='80px'>ID");
							out.print("</th>");
							out.print("<th>Produtos");
							out.print("</th>");
							out.print("<th width='100px'>Quantidade");
							out.print("</th>");
							out.print("<th>Subtotal");
							out.print("</th>");
							out.print("<th>Forma de pagamento");
							out.print("</th>");
							out.print("<th>Total");
							out.print("</th>");
							out.print("<th>Status");
							out.print("</th>");
							out.print("</thead>");
							Pedido ped1;
							
							for(EntidadeDominio ent:pedidos){
								ped = (Pedido)ent;
								if(ped.getStatus().equals("Troca solicitada")){
									out.print("<tr>");
									out.print("<td><strong>"+ped.getId()+"</strong><br></td>");
									out.print("<td style='font-size:15px'><strong>");
									for(Produto prod:ped.getProdutos()){
										if(prod.getPedido()==ped.getId()){
											out.print("<a href='Produtos?id-produto="+prod.getId()+"&operacao=VISUALIZAR'>"+prod.getModeloProduto()+"</a><br>");
										}
									}
									out.print("</strong></td>");
									out.print("<td><strong>");
									for(Produto prod:ped.getProdutos()){
										out.print(prod.getQtd_pedido()+"<br>");
									}
									out.print("</strong></td>");
									
									out.print("<td><strong>");
									for(Produto prod:ped.getProdutos()){
										if(prod.getPedido()==ped.getId()){
										out.print("R"+String.format("$%,.2f", prod.getSubtotal())+"<br>");
										}
									}
									out.print("</strong></td>");
									
									out.print("<td style='letter-spacing:1px'>");
									for(Cartao card:ped.getCartoes()){
										if(card.getPedido()==ped.getId()){
											sb = new StringBuilder();
											out.print("<strong>************"+card.getNumero_cartao().substring(12)+"</strong><br>");
											if(card.getId_bandeira_cartao()==1){
												sb.append("<i id='icone-cartao' class='fab fa-cc-mastercard fa-2x'></i><br>");
											} else if(card.getId_bandeira_cartao()==2){
												sb.append("<i id='icone-cartao' class='fab fa-cc-visa fa-2x'></i><br>");
											} else if(card.getId_bandeira_cartao()==3){
												sb.append("<i id='icone-cartao' class='fab fa-cc-diners-club fa-2x'></i><br>");
											} else if(card.getId_bandeira_cartao()==4){
												sb.append("<i id='icone-cartao' class='fab fa-cc-jcb fa-2x'></i><br>");
											} else if(card.getId_bandeira_cartao()==5){
												sb.append("<i id='icone-cartao' class='fab fa-cc-discover fa-2x'></i><br>");
											} else if(card.getId_bandeira_cartao()==6){
												sb.append("<i id='icone-cartao' class='fab fa-cc-amex fa-2x'></i><br>");
											}
											out.print(sb.toString());
										}
									}
									out.print("</td>");
									
									out.print("<td><strong>R"+String.format("$%,.2f", ped.getValor_total())+"</strong></td>");
									
									out.print("<td><strong>"+ped.getStatus()+"</strong></td>");
									
									out.print("<td><a id='autorizar' class='primary-btn' href='Pedidos?id-pedido="+ped.getId()+"&status-pedido="+ped.getStatus()+"&operacao=AUTORIZAR-TROCA'>Autorizar troca</a></td>");
									out.print("</tr>");	
								}
							}
							out.print("</table>");
						}						
						%>
						</div>
					</div>							
				</div>
				<!-- /Product Details -->
			</div>
			<!-- /row -->
		</div>
		<!-- /container -->
	</div>
	<!-- /section -->


	<!-- FOOTER -->
	<footer id="footer" class="section section-grey">
			<!-- container -->
			<div class="container">
				<!-- row -->
				<div class="row">
	
				</div>
				<!-- /row -->
				<hr>
				<!-- row -->
				<div class="row">
					<div class="col-md-8 col-md-offset-2 text-center">
						<!-- footer copyright -->
						<div class="footer-copyright">
								<div class="footer-logo">
										<a class="logo" href="#">
								<img src="./img/logo.png" alt="">
							  </a>
									</div>
							<!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. -->
							Copyright &copy;<script>document.write(new Date().getFullYear());</script> All rights reserved | This template is made with <i class="fa fa-heart-o" aria-hidden="true"></i> by <a href="https://colorlib.com" target="_blank">Colorlib</a>
							<!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. -->
							<!-- footer social -->
							<ul class="footer-social">
									<li><a href="#"><i class="fa fa-facebook"></i></a></li>
									<li><a href="#"><i class="fa fa-twitter"></i></a></li>
									<li><a href="#"><i class="fa fa-instagram"></i></a></li>
									<li><a href="#"><i class="fa fa-google-plus"></i></a></li>
									<li><a href="#"><i class="fa fa-pinterest"></i></a></li>
								</ul>
								<!-- /footer social -->
						</div>
						<!-- /footer copyright -->
					</div>
				</div>
				<!-- /row -->
			</div>
			<!-- /container -->
			
		</footer>
		<!-- /FOOTER -->
	

	<!-- jQuery Plugins -->
	<script src="js/jquery.min.js"></script>
	<script src="js/bootstrap.min.js"></script>
	<script src="js/slick.min.js"></script>
	<script src="js/nouislider.min.js"></script>
	<script src="js/jquery.zoom.min.js"></script>
	<script src="js/main.js"></script>
	
	<script type="text/javascript">
	</script>
</body>
</html>