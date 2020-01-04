<%@page import="core.aplicacao.Resultado"%>
<%@page import="dominio.*"%>
<%@page import="auxiliar.DadosDeCadastro"%>
<%@page import="java.util.*"%>

<!DOCTYPE html>
<html lang="pt">

<head>
	<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->

	<title>Home</title>

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

<%
	String erro="";
	try{
		Resultado resultProdutos = (Resultado)session.getAttribute("erro");
		erro = resultProdutos.getMsg().trim();
		session.removeAttribute("erro");
	} catch (Exception e){
		
	}
	
	//dados carrinho
	Pedido carrinho = new Pedido();
	try{
		carrinho = (Pedido) session.getAttribute("carrinho");
	}catch(Exception e){
		
	}
		
	int t = 0;
	double valor = 0;
	
	if(session.getAttribute("carrinho") != null){
		Pedido ped = (Pedido)session.getAttribute("carrinho");
		t = ped.getProdutos().size();
		valor = carrinho.getValor_total();
	}
	else{
		t = 0;
	}
	Pedido ped = (Pedido)session.getAttribute("carrinho");
	
	//dados de login
	int error = 0;
	Resultado login = (Resultado) session.getAttribute("login");
	if(session.getAttribute("login")!=null){
		String nomeUser = "";
		int id = 0;
		if(error==0){
			List<EntidadeDominio> user = login.getEntidades();
			Cliente us = (Cliente)user.get(0);
			nomeUser = us.getNomeCliente();
			id = us.getId();
		}
		StringBuilder sb = new StringBuilder();
		
	} else {
		error=1;
	}
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
					<div style="display:flex; justify-content:space-around">
					
						<div class='col-md-10'style='height:20px'>
							<div class='billing-details'>
								<div class='section-title'>
									<h3 class='title'>Carrinho de compras</h3>
								</div>
							</div>
						</div>
						<div style="padding-top:5px"><a href="Produtos?operacao=INDEX" class="primary-btn">Voltar às compras!</a></div>
					</div>
						<div class='col-md-12'>
							<div class='billing-details'>
					<%
					if(error==1){						
						out.print("<br><br><br><div style='display:flex; justify-content:space-around'>");
						out.print("<h3>Seu carrinho está vazio</h3>");
						out.print("</div>");
					}else{
						if(t==0){							
							out.print("<br><br><br><div style='display:flex; justify-content:space-around'>");
							out.print("<h3>Seu carrinho está vazio</h3>");
							out.print("</div>");
						}else{
							out.print("<br><br>");
							out.print("<table class='shopping-cart-table table'>");
							out.print("<thead>");
							out.print("<th>Produto");
							out.print("</th>");
							out.print("<th>Preço");
							out.print("</th>");
							out.print("<th>Quantidade");
							out.print("</th>");
							out.print("<th>Subtotal");
							out.print("</th>");
							out.print("<th>Ações");
							out.print("</th>");
							out.print("</thead>");
							for(Produto prod:ped.getProdutos()){
								out.print("<tr>");
								out.print("<td class='details'><a href='Produtos?id-produto="+prod.getId()+"&operacao=VISUALIZAR'>"+prod.getModeloProduto()+"</a></td>");
								out.print("<td style='font-size:15px'><strong>R"+String.format("$%,.2f", prod.getPrecoUnitario())+"</strong></td>");
								out.print("<td style='font-size:15px'><strong>"+prod.getQtdtotal()+"</strong></td>");
								out.print("<td style='font-size:15px'><strong class='primary-color'>R"+String.format("$%,.2f", prod.getSubtotal())+"</strong></td>");
								out.print("<td>"+
										"<div style='display:flex; justify-content:space-around'>"+
										"<form action='Pedidos' method='POST'>"+
										"<input type='hidden' id='nome' name='id-produto' value='"+prod.getId()+"'>"+
										"<input type='hidden' name='qtd-estoque' value='"+prod.getQtd_estoque()+"'>" +
										"<input type='hidden' name='modelo-produto' value='"+prod.getModeloProduto()+"'>" +
										"<input type='hidden' name='valor-produto' value='"+prod.getPrecoUnitario()+"'>" +
										"<input type='hidden' name='pagina' value='meu-carrinho'>" +
										"<button type='submit'name='operacao' value='REMOVECARRINHO' class='primary-btn'>Remover</button>"+
										"<input value='0' style='width:60px' class='input' type='number' min='1' name='qtd'>"+
										"<button id='botao-addcar' type='submit' name='operacao' value='ADDCARRINHO' class='primary-btn add-to-cart'>Adicionar</button>" +
										"</form>"+
										"</div>"+
										"</td>");
								out.print("</tr>");
							}
							out.print("</table>");
							out.print("<br><br>");
							out.print("<div style='text-align: center'><a class='primary-btn' href='Pedidos?operacao=FINALIZAR-COMPRA'>Finalizar compra</a></div>");
						}
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
</body>
</html>