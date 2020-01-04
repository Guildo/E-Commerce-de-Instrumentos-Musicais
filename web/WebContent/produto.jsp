<%@page import="core.aplicacao.Resultado"%>
<%@page import="dominio.*"%>
<%@page import="auxiliar.DadosDeCadastro"%>
<%@page import="java.util.*"%>

<!DOCTYPE html>
<html lang="pt">
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- Google font -->
	<link href="https://fonts.googleapis.com/css?family=Hind:400,700" rel="stylesheet">
	<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.1/css/all.css" integrity="sha384-50oBUHEmvpQ+1lW4y57PTFmhCaXp0ML5d60M1M7uH2+nqUivzIebhndOJK28anvf" crossorigin="anonymous">
	

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
	String nomeUser = "";
	int id=0;
	int error = 0;
	Cliente us;
	Resultado login = (Resultado) session.getAttribute("login");
	Resultado dados = (Resultado) session.getAttribute("produtos");
	int idProduto = Integer.parseInt(request.getParameter("id-produto"));
	if(session.getAttribute("produtos")!=null){
		List<EntidadeDominio>produto = dados.getEntidades();
	}else{
		String redirectURL = "Produtos?operacao=INDEX";
		pageContext.forward(redirectURL);
	}
	List<EntidadeDominio>produto = dados.getEntidades();
	try{
		List<EntidadeDominio> user = login.getEntidades();
	} catch (Exception e){
			error = 1;
	}
	Produto prd;
	if(error==0){
		List<EntidadeDominio> user = login.getEntidades();
		us = (Cliente)user.get(0);
		nomeUser = us.getNomeCliente();
		id = us.getId();
	}
	String modelo = "";
	String descricao = "";
	double valor = 0;
	String categoria = "";
	String img = "";
	int est = 0;
	for(EntidadeDominio ent:produto){
		prd = (Produto)ent;
		if(idProduto==prd.getId()){
			modelo = prd.getModeloProduto();
			descricao = prd.getDescricaoProduto();
			valor = prd.getPrecoUnitario();
			categoria = prd.getCategoria().getNomeCategoria();
			img = "./img/" + prd.getImagemProduto();
			est = prd.getQtd_estoque();
		}
	}
	StringBuilder sb;
	String erro = "";
	try{
		Resultado resultProdutos = (Resultado)session.getAttribute("erro");
		erro = resultProdutos.getMsg().trim();
		session.removeAttribute("erro");
	} catch (Exception e){
		
	}
%>
<title><%out.print(modelo); %></title>
</head>
<body onload="Erro()">
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
					<div class="col-md-6">
						<div style="width:400px" id="product-main-view">
							<img src="<%out.print(img);%>" alt="">
						</div>
					</div>
					<div class="col-md-6">
						<div class="product-body">
							<div class="product-label">
							<div style="display:flex; justify-content:space-between">
							
							<div class="product-label">
							<% 
								out.print("<span>"+categoria+"</span>");
							%>
							</div>
							<div><a style="height:35px" href="Produtos?operacao=INDEX" class="primary-btn">Voltar</a></div>
							</div>
							<h2 class="product-name"><%out.print(modelo); %></h2>
							<h3 class="product-price">R<%out.print(String.format("$%,.2f", valor)); %></h3>
							<div>
								<div class="product-rating">
									<i class="fa fa-star"></i>
									<i class="fa fa-star"></i>
									<i class="fa fa-star"></i>
									<i class="fa fa-star"></i>
									<i class="fa fa-star-o empty"></i>
								</div>
							</div>
							<p><strong>Disponibilidade:</strong> <%if(est!=0){out.print("Temos "+est+" em estoque!");}else{out.print("Indisponivel");} %></p>
							<%
								sb = new StringBuilder();
								if(descricao != null){									
									sb.append("<p><strong>Descrição:</strong></p>");
									sb.append("<p>"+descricao+"</p>");
								} else {
									sb.append("<br></br>");
									sb.append("<br></br>");
								}
							%>												
							<div style="display:flex; justify-content:space-around" class="product-btns">
							<%sb = new StringBuilder();
							sb.append("<form action='Pedidos' method='POST'>");
							if(est!=0){
								sb.append("<div class='qty-input'>");
								sb.append("<span class='text-uppercase'>Quantidade </span>");
								sb.append("<input value='0' id='qtd' class='input' min='0' name='qtd' type='number' required>");
								sb.append("</div>");
							}
								
							sb.append("<input type='hidden' name='id-produto' value='"+idProduto+"'>");
							sb.append("<input type='hidden' name='qtd-estoque' value='"+est+"'>");
							sb.append("<input type='hidden' name='modelo-produto' value='"+modelo+"'>");
							sb.append("<input type='hidden' name='valor-produto' value='"+valor+"'>");
							if(est==0){
								sb.append("<button type='button' style='background-color:red' name='operacao' value='ADDCARRINHO' class='primary-btn add-to-cart'><i class='fas fa-shipping-fast'></i>  Produto esgotado</button>");
							} else {
								sb.append("<button id='botao-addcar' type='submit' name='operacao' value='ADDCARRINHO' class='primary-btn add-to-cart'><i class='fa fa-shopping-cart'></i> Adicionar ao carrinho</button>");
							}
							sb.append("</form>");
							out.print(sb.toString());
							%>
							</div>
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
	
<script type="text/javascript">
   		 function Check () {
	    	// do the work after everything was loaded (DOM, media elements)
	    	var quantidade = document.getElementById("qtd");
	    	var botao = document.getElementById("botao-addcar");
	    	var value = "<%=error%>";
	    	if(value!=1){
		    	if(quantidade.value!=0){
				      botao.setAttribute('type', 'submit');
		    	}else{
		    		botao.setAttribute('type', 'button');
		    	}
    		}
   		 }	
   		 
   		function Check2(){
   			var quantidade = document.getElementById("qtd");
   	    	var value = "<%=error%>";
   			if(value!=0){
   	   		    alert("Para adicionar ao carrinho, voce fazer login!");
   		    }
   			else if(quantidade.value == 0){
   				alert("Para adicionar ao carrinho, voce precisa selecionar a quantidade!");
   			}
   		}
</script>

<script type="text/javascript">
   		 function Erro () {
	    	// do the work after everything was loaded (DOM, media elements)
	    	var value = "<%=erro%>";
	        if(value!=""){
	        alert(value);
        }
    }
</script>

	<!-- jQuery Plugins -->
	<script src="js/jquery.min.js"></script>
	<script src="js/bootstrap.min.js"></script>
	<script src="js/slick.min.js"></script>
	<script src="js/nouislider.min.js"></script>
	<script src="js/jquery.zoom.min.js"></script>
	<script src="js/main.js"></script>
</body>
</html>