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

	<title>Meus cupons de troca</title>

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
	String nomeUser="";
	int id=0;
	int error = 0;
	String erro = "";
	Cliente us;
	Resultado login = (Resultado) session.getAttribute("login");
	if(session.getAttribute("login")==null){
		pageContext.forward("index.jsp");
	}
	try{
		List<EntidadeDominio> user = login.getEntidades();
		} catch (Exception e){
			error = 1;
	}
	
	if(session.getAttribute("dadosUser")==null){
		pageContext.forward("User?operacao=CONSULTAR");
	}
	
	Resultado dadosUser = (Resultado) session.getAttribute("dadosUser");
	List<EntidadeDominio> dadosUsuario = dadosUser.getEntidades();
	
	if(error==0){
	List<EntidadeDominio> user = login.getEntidades();
	us = (Cliente)user.get(0);
	nomeUser = us.getNomeCliente();
	id = us.getId();
	}
	int t = 0;
	
	
	for(EntidadeDominio ent : dadosUsuario){
		us = (Cliente)ent;
		if(us.getId() == id){
			for(CupomTroca cupom:us.getCupons()){
				t++;
			}
			break;
		}
	}
		
	StringBuilder sb = new StringBuilder();
	
%>

</head>

<body>
	<jsp:include page="header.jsp" />
	
	<!-- NAVIGATION -->
	<div id="navigation">
		<!-- container -->
		<div class="container">
			<div id="responsive-nav">
				<!-- category nav -->
				<div class="category-nav show-on-click">
					<span class="category-header">Categorias <i class="fa fa-list"></i></span>
					<ul class="category-list">						
						<li><a href="#">Instrumentos de corda</a></li>						
						<li><a href="#">Instrumentos acústicos</a></li>
						<li><a href="#">Instrumentos Eletrônicos</a></li>
						<li><a href="#">Instrumentos de Sopro</a></li>
					</ul>
				</div>
				<!-- /category nav -->

				<!-- menu nav -->
				<div class="menu-nav">
					<span class="menu-header">Menu <i class="fa fa-bars"></i></span>
					<ul class="menu-list">
						<li><a href="#">Home</a></li>
						<li><a href="#">Shop</a></li>						
						<li><a href="#">Sales</a></li>
						<li class="dropdown default-dropdown"><a class="dropdown-toggle" data-toggle="dropdown" aria-expanded="true">Pages <i class="fa fa-caret-down"></i></a>
							<ul class="custom-menu">
								<li><a href="index.html">Home</a></li>
								<li><a href="products.html">Products</a></li>
								<li><a href="product-page.html">Product Details</a></li>
								<li><a href="checkout.html">Checkout</a></li>
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
									<h3 class='title'>Todos seus cupons de troca</h3>
								</div>
							</div>
						</div>
						<div style="padding-top:5px"><a href="Produtos?operacao=INDEX" class="primary-btn">Voltar</a></div>
					</div>
					<div class='col-md-12'>
							<div class='billing-details'>
							<%
							if(t==0){
								out.print("<br><br><br><div style='display:flex; justify-content:space-around'>");
								out.print("<img height='200px' src='https://image.flaticon.com/icons/png/512/18/18296.png'>");
								out.print("</div><br><br>");
								
								out.print("<div style='display:flex; justify-content:space-around'>");
								out.print("<p><strong>Você não tem nenhum cupom de troca ...</strong></p>");
								out.print("</div>");
							}else{
								out.print("<br><br>");
								out.print("<table class='shopping-cart-table table'>");
								out.print("<thead>");
								out.print("<th>Pedido que gerou o cupom");
								out.print("</th>");
								out.print("<th>Valor");
								out.print("</th>");
								out.print("<th>Data do cupom");
								out.print("</th>");
								out.print("<th>Status do cupom");
								out.print("</th>");
								out.print("</thead>");
								
								for(EntidadeDominio ent : dadosUsuario){
									us = (Cliente)ent;
									if(us.getId() == id){
										for(CupomTroca cupom:us.getCupons()){								
											out.print("<tr>");
											out.print("<td><strong>"+cupom.getId_pedido_cupom()+"</strong><br></td>");
											out.print("<td><strong>R"+String.format("$%,.2f", cupom.getValor())+"</strong></td>");
											java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("dd/MM/yyyy");
											String currentTime = sdf.format(cupom.getData_cupom());
											out.print("<td><strong>"+currentTime+"</strong></td>");
											if(cupom.isHabilitar()){
												if(cupom.getStatus_cupom()){
													out.print("<td><strong>Válido</strong><br></td>");
												}else{
													out.print("<td><strong>Já usado</strong><br></td>");
												}
											}else{
												out.print("<form action='Cliente' method='POST'>");
												out.print("<input type='hidden' name='id-cup' value='"+cupom.getId()+"'/>");
												out.print("<td><strong><button id='ativ' class='primary-btn' type='submit' name='operacao' value='ATIVAR-CUPOM'>Ativar Cupom</button></strong><br></td>");
												out.print("</form>");
											}
											out.print("</tr>");
										}
										break;
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