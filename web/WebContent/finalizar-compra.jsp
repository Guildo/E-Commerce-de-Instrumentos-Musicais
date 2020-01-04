<%@page import="core.aplicacao.Resultado"%>
<%@page import="dominio.*"%>
<%@page import="auxiliar.DadosDeCadastro"%>
<%@page import="java.util.*"%>

<!DOCTYPE html>
<html lang="pt">

<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
	
	<title>Finalizar compra</title>

	<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.1/css/all.css" integrity="sha384-50oBUHEmvpQ+1lW4y57PTFmhCaXp0ML5d60M1M7uH2+nqUivzIebhndOJK28anvf" crossorigin="anonymous">
	
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
		//carrinho
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
		}else{
			t = 0;
			String redirectURL = "Pedidos?operacao=VER-CARRINHO";
			pageContext.forward(redirectURL);
		}
		Pedido ped = (Pedido)session.getAttribute("carrinho");
		Cliente usr;
		//login
		int error = 0;
		Resultado login = (Resultado) session.getAttribute("login");
		try{
			List<EntidadeDominio> user = login.getEntidades();
		} catch (Exception e){
			error = 1;
		}
		
		int idUser = 0;
		String nomeUser = "";
		double frete = 0;
		double valor_total = 0;
		
		List<EntidadeDominio> user = login.getEntidades();
		Cliente us = (Cliente)user.get(0);
		idUser = us.getId();
		nomeUser = us.getNomeCliente();
		frete = us.getFrete();
		
		// somando o frete ao valor total do pedido
		//if(!us.isCom_frete()){
			if(!ped.isFrete_add()){
				valor_total = ped.getValor_total() + frete;
				ped.setValor_total(valor_total); 
				//us.setCom_frete(true);
				ped.setFrete_add(true);
			}
		//}
		
		StringBuilder sb = new StringBuilder();
		int id0=0;
		int id1=0;
		int id2=0;
		
		int cupativos = 0;
		for(CupomTroca cupzin:us.getCupons()){
			if(cupzin.getStatus_cupom() && cupzin.isHabilitar()){
				cupativos++;
			}
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
									<h3 class='title'>Resumo do pedido</h3>
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
						out.print("<img height='200px' src='https://www.compraserrana.com.br/shopping/img/carrinho_vazio.png'>");
						out.print("</div><br><br>");
						
						out.print("<div style='display:flex; justify-content:space-around'>");
						out.print("<p><strong>Seu carrinho está vazio</strong></p>");
						out.print("</div>");
					}else{
						if(t==0){
							out.print("<br><br><br><div style='display:flex; justify-content:space-around'>");
							out.print("<img height='200px' src='https://www.compraserrana.com.br/shopping/img/carrinho_vazio.png'>");
							out.print("</div><br><br>");
							
							out.print("<div style='display:flex; justify-content:space-around'>");
							out.print("<p><strong>Seu carrinho está vazio</strong></p>");
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
							out.print("</thead>");
							for(Produto prod:ped.getProdutos()){
								out.print("<tr>");
								out.print("<td class='details'><a href='Produtos?id-produto="+prod.getId()+"&operacao=VISUALIZAR'>"+prod.getModeloProduto()+"</a></td>");
								out.print("<td style='font-size:15px'><strong>R"+String.format("$%,.2f", prod.getPrecoUnitario())+"</strong></td>");
								out.print("<td style='font-size:15px'><strong>"+prod.getQtdtotal()+"</strong></td>");
								out.print("<td style='font-size:15px'><strong class='primary-color'>R"+String.format("$%,.2f", prod.getSubtotal())+"</strong></td>");
								out.print("</tr>");
							}
							out.print("</table>");
							out.print("<div class='col-md-6 col-md-offset-3'>");
							out.print("<div style='text-align: center'>"+
										"<table class='shopping-cart-table table'>"+
										"<thead>"+
										"<th>Frete</th>"+
										"<th>Valor total</th>"+
										"</thead>"+
									"</div>");
							out.print("<tr>");
							out.print("<td style='font-size:15px'><strong>R"+String.format("$%,.2f", frete)+"</strong></td>");
							out.print("<td style='font-size:15px'><strong class='primary-color'>R"+String.format("$%,.2f", ped.getValor_total())+"</strong></td>");
							out.print("</tr>");
							out.print("</table>");
						out.print("</div>");
						out.print("<br><br>");
						}
					}
					%>
						</div>
					</div>
					<form action="Pedidos" method="POST">
					<div class='col-md-12'>
						<div class='billing-details'>
							<div class='section-title'>
								<h3 class='title'>Forma de pagamento</h3>
							</div>
								<p><strong>Abaixo, selecione os cartões que deseja usar para efetuar o pagamento, e digite o valor pago por cartão.</strong></p>
						</div>
						<%
						//sb = new StringBuilder();
						if(!us.getCartoes().isEmpty()){
							out.print("<br>");
							out.print("<div class='col-md-6 col-md-offset-3'>");
							out.print("<table class='shopping-cart-table table'>");
							out.print("<thead>");
							out.print("<th>Numero Cartao</th>");
							out.print("<th>Usar cartao nesta compra</th>");
							out.print("<th>Valor</th>");
							out.print("</thead>");
							int i=1;
							String num="";
							for(Cartao card:us.getCartoes()){
								out.print("<tr>");
								out.print("<td ");
								out.print("style='letter-spacing:2px'><strong>************"+card.getNumero_cartao().substring(12)+"</strong>");
								if(card.getId_bandeira_cartao()==1){
									out.print("<i id='icone-cartao' class='fab fa-cc-mastercard fa-2x'></i>");
								} else if(card.getId_bandeira_cartao()==2){
									out.print("<i id='icone-cartao' class='fab fa-cc-visa fa-2x'></i>");
								} else if(card.getId_bandeira_cartao()==3){
									out.print("<i id='icone-cartao' class='fab fa-cc-diners-club fa-2x'></i>");
								} else if(card.getId_bandeira_cartao()==4){
									out.print("<i id='icone-cartao' class='fab fa-cc-jcb fa-2x'></i>");
								} else if(card.getId_bandeira_cartao()==5){
									out.print("<i id='icone-cartao' class='fab fa-cc-discover fa-2x'></i>");
								} else if(card.getId_bandeira_cartao()==6){
									out.print("<i id='icone-cartao' class='fab fa-cc-amex fa-2x'></i>");
								}
								out.print("</td>");
								out.print("<td><input type='checkbox' value='sim' name='usarcartao"+i+"'></td>");
								out.print("<td><strong>R$   </strong><input style='width:100px' placeholder='Ex: 100,00'class='input' type='text' name='valor-cartao"+i+"'></td>");
								out.print("</tr>");
								i++;
							}
							out.print("</table>");
							out.print("</div>");
							out.print(sb.toString());
						}else {
							out.print("<br>");
							out.print("<div class='col-md-6 col-md-offset-3'>");
							out.print("<div style='text-align:center'>");
							out.print("<p style='font-size:15px'>Voce nao possui nenhum cartao cadastrado!</p>");
							out.print("<p style='font-size:15px'>Para continuar com seu pedido, cadastre ao menos 1 cartão</p>");
							out.print("<div><a class='primary-btn' href='Cartoes?idusr="+us.getId()+"&operacao=CONSULTAR'>Cadastrar cartão</a></div>");
							out.print("</div>");
							out.print("</div>");
						}
						//out.print(sb.toString());
						%>
					</div>
					<%
					out.print("<div class='col-md-12'>");
					if(!us.getCupons().isEmpty()){
						out.print("<div class='billing-details'>");
						out.print("<br><br>");
						out.print("	<p><strong>Você também pode pagar seu pedido utilizando um cupom de troca</strong></p>");
						out.print("	<p><strong>Você possui um total de: <span class='primary-color'>"+cupativos+" Cupons disponíveis!</span></strong></p>");
						out.print("	</div>");
						
						int b = 1;
						for(CupomTroca cupom:us.getCupons()){
							if(cupom.isHabilitar()){
								if(cupom.getStatus_cupom()){
									out.print("<div class='col-md-10 col-md-offset-1'>");
									out.print("<table class='shopping-cart-table table'>");
									out.print("<thead>");
									out.print("<th>ID Cupom</th>");
									out.print("<th>Data</th>");
									out.print("<th>Valor</th>");
									out.print("<th>Usar cupom na compra?</th>");
									out.print("</thead>");
									break;
								}
							}
						}
						
						for(CupomTroca cupom:us.getCupons()){
							if(cupom.isHabilitar()){
								if(cupom.getStatus_cupom()){
									out.print("<tr>");
									out.print("<td>"+cupom.getId()+"</td>");
									java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("dd/MM/yyyy");
									String data_criacao = sdf.format(cupom.getData_cupom());
									out.print("<td>"+data_criacao+"</td>");
									out.print("<td>R"+String.format("$%,.2f", cupom.getValor())+"</td>");
									out.print("<td><input type='checkbox' value='sim' name='usarcupom"+b+"'></td>");
									out.print("</tr>");
									b++;
								}
							}					
						}
						out.print("</table>");
						out.print("	</div>");
					} else {
						out.print("<br><br>");
						out.print("<div class='billing-details'>");
						out.print("	<p><strong>Você não possui cupons de troca...</strong></p>");
						out.print("</div>");
					}
					out.print("	</div>");
					%>
					<br><br>
					<div style="padding-top:50px" class='col-md-12'>
							<div class='billing-details'>
								<div class='section-title'>
									<h3 class='title'>Dados de endereço</h3>
								</div>
									<p><strong>Verifique corretamente os dados de endereço.</strong></p>
							</div>
							<%
							//sb = new StringBuilder();
							out.print("<br>");
							out.print("<table class='shopping-cart-table table'>");
							out.print("<thead>");
							out.print("<th>Rua</th>");
							out.print("<th>Bairro</th>");
							out.print("<th>Cidade</th>");
							out.print("<th>Numero</th>");
							out.print("<th>CEP</th>");
							out.print("<th>Estado</th>");
							out.print("</thead>");
							int i=0;
							String num="";
							
							for(Endereco end:us.getEnderecos()){
								out.print("<tr>");
								out.print("<td style='letter-spacing:1px'>"+end.getLogradouro()+"</td>");
								out.print("<td style='letter-spacing:1px'>"+end.getBairro()+"</td>");
								out.print("<td style='letter-spacing:1px'>"+end.getCidade()+"</td>");
								out.print("<td style='letter-spacing:1px'>"+end.getNumero()+"</td>");
								out.print("<td style='letter-spacing:1px'>"+end.getCEP()+"</td>");
								out.print("<td style='letter-spacing:1px'>"+end.getEstado()+"</td>");
								out.print("<td style='letter-spacing:1px'><a name='cad' class='primary-btn' href='Enderecos?idusr="+idUser+"&operacao=CONSULTAR'>Alterar endereço</a></td>");
								out.print("</tr>");
								i++;
							}
							out.print("</table><br><br>");							
							out.print("<div style='text-align:center'><button class='primary-btn' type='submit' name='operacao' value='FAZER-PEDIDO'>Confirmar pedido</button></div>");
							//out.print(sb.toString());
							%>
						</div>
					</form>
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
   		function Carrinho () {
    	// do the work after everything was loaded (DOM, media elements)
	    	var value = "<%=erro%>";
	        if(value==="1"){
	       		alert("Para adicionar itens no carrinho, você precisa estar logado!");
        	}
   		}
	</script>

	<script type="text/javascript">
   		window.onload = function () {
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