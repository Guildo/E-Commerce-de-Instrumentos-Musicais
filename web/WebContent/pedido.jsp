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

	<title>Meus dados</title>

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
	int idped = Integer.parseInt(request.getParameter("id-pedido"));
	List<EntidadeDominio> pedidos = resultado.getEntidades();
	//dados de login
	int error = 0;
	Resultado login = (Resultado) session.getAttribute("login");
	if(session.getAttribute("login")==null){
		pageContext.forward("index.jsp");
	}
	try{
		List<EntidadeDominio> user = login.getEntidades();
		} catch (Exception e){
			error = 1;
	}
	String nomeUser = "";
	int id = 0;
	List<EntidadeDominio> user = login.getEntidades();
	Cliente us = (Cliente)user.get(0);
	nomeUser = us.getNomeCliente();
	id = us.getId();
	StringBuilder sb = new StringBuilder();
	Pedido ped;
	int produtosDoPedido=0;
	String motivo="";
	String status="";
	for(EntidadeDominio ent:pedidos){
		ped = (Pedido)ent;
		t = pedidos.size();
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
					<div style="display:flex; justify-content: space-around">
							<div class='col-md-10'style='height:20px'>
								<div class='billing-details'>
									<div class='section-title'>
										<h3 class='title'>Pedido - Numero <%out.print(idped); %></h3>
									</div>
								</div>
							</div>
							<%
						if(request.getParameter("status").equals("abertos")){
							out.print("<div style='padding-top:5px'><a href='Pedidos?status=abertos&idusr="+id+"&operacao=CONSULTAR' class='primary-btn'>Voltar</a></div>");
						}else{
							out.print("<div style='padding-top:5px'><a href='Pedidos?status=trocas&idusr="+id+"&operacao=CONSULTAR' class='primary-btn'>Voltar</a></div>");
						}
						%>
						</div>
						<div class='col-md-12'>
							<div class='billing-details'>
					<%
					for(EntidadeDominio ent:pedidos){
						ped = (Pedido)ent;
						if(idped == ped.getId()){
							status = ped.getStatus();
							motivo = ped.getMotivoTroca();
							out.print("<br><br><strong>Status do pedido: "+ped.getStatus()+"</strong><br>");
							if(ped.getStatus().equals("Pagamento em analise")){
								out.print("<strong>Proximo status: Pagamento autorizado</strong><br>");
							}else if(ped.getStatus().equals("Pedido negado")){
								out.print("<strong>Descriçao do problema: Oops... Parece que seu pedido foi negado</strong><br>");
							}else if(ped.getStatus().equals("Pedido entregue")){
								out.print("<strong>Seu pedido já foi entregue</strong><br>");
							}
							else if(ped.getStatus().equals("Pagamento autorizado")){
								out.print("<strong>Proximo status: Produto em rota de entrega</strong><br>");
							}
							else if(ped.getStatus().equals("Troca solicitada")){
								out.print("<strong>Uma troca foi solicitada para esse pedido</strong><br>");
							}
							else if(ped.getStatus().equals("Troca autorizada")){
								out.print("<strong>A troca solicitada foi autorizada</strong><br>");
							}
							java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("dd/MM/yyyy");
							String currentTime = sdf.format(ped.getDataPedido());
							out.print("<strong>Data do pedido: "+currentTime+"</strong>");
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
						out.print("<td style='font-size:15px'><strong>"+prod.getQtd_pedido()+"</strong></td>");
						out.print("<td style='font-size:15px'><strong class='primary-color'>R"+String.format("$%,.2f", prod.getSubtotal())+"</strong></td>");
						out.print("</tr>");
						produtosDoPedido++;
					}
					out.print("</table>");
					
						}
					}
			%>
				</div>
			</div>
			<%
						for(EntidadeDominio ent:pedidos){
							ped = (Pedido)ent;
							if(idped == ped.getId()){
								if(!ped.isStatus_troca_pedido()){
									out.print("<div class='col-md-10 col-md-offset-1'>");
									out.print("<div class='billing-details'>");
									out.print("<div class='section-title'>");
									out.print("<h3 class='title'>Forma de pagamento</h3>");
									out.print("</div>");
									out.print("<p><strong>Dados do pagamento deste pedido</strong></p>");
									out.print("</div>");					
						
									sb = new StringBuilder();
									if(!ped.getCartoes().isEmpty()){
										sb = new StringBuilder();
										sb.append("<div class='col-md-6 col-md-offset-3'>");
										sb.append("<table class='shopping-cart-table table'>");
										sb.append("<thead>");
										sb.append("<th>Numero Cartao</th>");
										sb.append("<th>Bandeira Cartao</th>");
										sb.append("</thead>");
										int i=1;
										String num="";
										for(Cartao card:ped.getCartoes()){
											if(card.getPedido()==ped.getId()){
												sb.append("<tr>");
												sb.append("<td style='letter-spacing:1px'>");
												sb.append("<strong>************"+card.getNumero_cartao().substring(12)+"</strong><br>");
												sb.append("</td>");
												sb.append("<td>");
												if(card.getId_bandeira_cartao()==1){
													sb.append("<i id='icone-cartao' class='fab fa-cc-mastercard fa-3x'></i><br>");
												} else if(card.getId_bandeira_cartao()==2){
													sb.append("<i id='icone-cartao' class='fab fa-cc-visa fa-3x'></i><br>");
												} else if(card.getId_bandeira_cartao()==3){
													sb.append("<i id='icone-cartao' class='fab fa-cc-diners-club fa-3x'></i><br>");
												} else if(card.getId_bandeira_cartao()==4){
													sb.append("<i id='icone-cartao' class='fab fa-cc-jcb fa-3x'></i><br>");
												} else if(card.getId_bandeira_cartao()==5){
													sb.append("<i id='icone-cartao' class='fab fa-cc-discover fa-3x'></i><br>");
												} else if(card.getId_bandeira_cartao()==6){
													sb.append("<i id='icone-cartao' class='fab fa-cc-amex fa-3x'></i><br>");
												}												
												sb.append("</td>");
												sb.append("</tr>");
											}
										}
									}
									sb.append("</table>");
									sb.append("</div><br><br>");
									out.print(sb.toString());
									
									if(!ped.getCuponsTroca().isEmpty()){
										sb = new StringBuilder();
										sb.append("<br><br><div class='col-md-6 col-md-offset-3'>");
										sb.append("<table class='shopping-cart-table table'>");
										sb.append("<thead>");
										sb.append("<th>Código cupom</th>");
										sb.append("<th>Valor do cupom</th>");
										sb.append("</thead>");
										for(CupomTroca cupom:ped.getCuponsTroca()){
											sb.append("<tr>");
											sb.append("<td>"+cupom.getId_pedido_cupom()+"</td>");
											sb.append("<td>"+String.format("R$%,.2f", cupom.getValor())+"</td>");
											sb.append("</tr>");
										}
										sb.append("</table>");
										sb.append("</div>");
										out.print(sb.toString());
									}
								}
							}
						}
						
					%>
			</div>
			
					<%
					for(EntidadeDominio ent:pedidos){
						ped = (Pedido)ent;
						if(idped == ped.getId()){
							if(!ped.isStatus_troca_pedido()){
								out.print("<div class='col-md-12'>");
								out.print("<div class='billing-details'>");
								out.print("<div class='section-title'>");
								out.print("<h3 class='title'>Dados de endereço</h3>");
								out.print("</div>");
								out.print("<p><strong>Dados de endereço do pedido.</strong></p>");
								out.print("</div>");
								sb = new StringBuilder();
								sb.append("<table class='shopping-cart-table table'>");
								sb.append("<thead>");
								sb.append("<th>Tipo do endereço</th>");
								sb.append("<th>CEP</th>");
								sb.append("<th>Numero</th>");
								sb.append("</thead>");													
							
								if(ped.getEndCobranca().getCEP().equals(ped.getEndEntrega().getCEP())
										&& ped.getEndCobranca().getNumero().equals(ped.getEndEntrega().getNumero())){
									sb.append("<tr>");
									sb.append("<td style='letter-spacing:1px'><strong>Cobrança e entrega</strong></td>");
									sb.append("<td style='letter-spacing:1px'>"+ped.getEndCobranca().getCEP()+"</td>");
									sb.append("<td style='letter-spacing:1px'>"+ped.getEndCobranca().getNumero()+"</td>");
									sb.append("</tr>");
								}else{
									sb.append("<tr>");
									sb.append("<td style='letter-spacing:1px'><strong>Cobrança</strong></td>");
									sb.append("<td style='letter-spacing:1px'>"+ped.getEndCobranca().getCEP()+"</td>");
									sb.append("<td style='letter-spacing:1px'>"+ped.getEndCobranca().getNumero()+"</td>");
									sb.append("</tr>");
									sb.append("<tr>");
									sb.append("<td style='letter-spacing:1px'><strong>Entrega</strong></td>");
									sb.append("<td style='letter-spacing:1px'>"+ped.getEndEntrega().getCEP()+"</td>");
									sb.append("<td style='letter-spacing:1px'>"+ped.getEndEntrega().getNumero()+"</td>");
									sb.append("</tr>");
								}
								sb.append("</table>");
								out.print(sb.toString());
							}	
						}
					}
					%>
					
				</div>
				<div style="padding-top:50px" class='col-md-12'>
					<div class='billing-details'>
						<div class='section-title'>
							<h3 class='title'>Dados de troca</h3>
						</div>
							<p><strong>Dados para troca</strong></p>
							<p><strong>Uma solicitação de troca só pode ser feita após a confirmação da entrega dos produtos!</strong></p>
					</div>
				<%					
						sb = new StringBuilder();
						out.print("<br>");
						sb.append("<table class='shopping-cart-table table'>");
						sb.append("<thead>");
						sb.append("<th>Tipo pedido</th>");
						sb.append("<th>Solicitar troca</th>");
						sb.append("<th>Status</th>");
						//if(!motivo.equals("normal")){
							//sb.append("<th>Motivo da troca</th>");
						//}
						sb.append("</thead>");
								
						if(status.equals("Entregue")){
							sb.append("<td style='letter-spacing:1px'><strong>Pedido</strong></td>");
							sb.append("<td style='letter-spacing:1px'><button id='troca' data-toggle='modal' data-target='#Troca' class='primary-btn'>Solicitar troca</button></td>");
						}
						else if(status.equals("Pedido negado")){
							sb.append("<td style='letter-spacing:1px'><strong>Pedido</strong></td>");
							sb.append("<td style='letter-spacing:1px'>Não é possível solicitar uma troca para este pedido.</td>");
						}
						else if(status.equals("Troca solicitada")){
							sb.append("<td style='letter-spacing:1px'><strong>Troca</strong></td>");
							sb.append("<td style='letter-spacing:1px'>Você já solicitou uma troca para este pedido!</td>");
						}
						else if(status.equals("Troca autorizada")){
							sb.append("<td style='letter-spacing:1px'><strong>Troca</strong></td>");
							sb.append("<td style='letter-spacing:1px'>Sua troca foi autorizada! Geramos um cupom de troca para você!</td>");
						}else{
							sb.append("<td style='letter-spacing:1px'><strong>Pedido</strong></td>");
							sb.append("<td style='letter-spacing:1px'>Você só pode solicitar uma troca quando o pedido for entregue!</td>");
						}
						sb.append("<td style='letter-spacing:1px'><strong>"+status+"</strong></td>");
						/*if(!motivo.equals("normal")){
							sb.append("<td style='letter-spacing:1px'><strong>"+motivo+"</strong></td>");
						}*/
						sb.append("</tr>");
						sb.append("</table><br><br>");
						out.print(sb.toString());					
					%>					
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
				
	<div class="modal fade" id="Troca" role="dialog">
	    <div class="modal-dialog">
	    	    
		    <!-- Modal content-->
		    <div style="background-color:white" class="col-md-12">
				<div class="billing-details">
					<div class="section-title">
						<h3 class="title">Solicitação de troca</h3>
					</div>
					<form action="Pedidos" method="POST">
					<div class="form-group">
						<input type="hidden" name="idusr" <%out.print("value='"+id+"'"); %>/>
						<input type="hidden" name="id-pedido" <%out.print("value='"+idped+"'"); %>/>
						<input type="hidden" name="status-pedido" <%out.print("value='"+status+"'"); %>"/>
					</div>
					<%
					int a = 1;
					int to = 0;
					if(produtosDoPedido>1){
						out.print("<p style='font-size:17px'>Escolha os produtos a serem trocados:");
					}else{
						out.print("<p style='font-size:17px'>Produto a ser trocado:");
					}
					for(EntidadeDominio ent:pedidos){
						ped = (Pedido)ent;
						
						for(Produto prd:ped.getProdutos()){
							if(idped == ped.getId()){
								out.print("<table class='shopping-cart-table table'>");
								out.print("<thead>");
								out.print("<th>Produto</th>");
								out.print("<th>Subtotal</th>");
								out.print("<th>Quantidade</th>");
								if(produtosDoPedido>1){
									out.print("<th>Selecionar</th>");
								}
								out.print("</thead>");
								break;
							}
						}
					}						
					
					for(EntidadeDominio ent:pedidos){
						ped = (Pedido)ent;
						for(Produto prd:ped.getProdutos()){
							if(idped == ped.getId()){
								out.print("<tr>");
								out.print("<td>"+prd.getModeloProduto()+"</td>");
								out.print("<td>"+String.format("R$%,.2f", prd.getPrecoUnitario())+"</td>");
								if(prd.getQtd_pedido()>1){
									to = prd.getQtd_pedido();
									out.print("<td>");
									out.print("<select name='qtd-troca"+a+"'>");
									for(int n = 1; n<=to; n++){
										out.print("<option value='"+n+"'>"+n+"</option>");
									}
									out.print("</select");
									out.print("</td>");										
								}else{
									out.print("<td>");
									out.print("<input type='hidden' name='qtd-troca"+a+"' value='1'/>1");
									out.print("</td>");
								}
								if(produtosDoPedido>1){ // caso um pedido tenha mais de 1 produto
									out.print("<td><input type='checkbox' value='sim' name='trocar"+a+"'/></td>");
								}
								out.print("</tr>");
								a++;
							}
						}
					}
					out.print("</table>");					
					%>
					<br>
					<p style="font-size:17px">Qual o motivo da troca?</p>
					<div class="form-group">
						<textarea style="height:100px; resize:none" class="input" name="motivo-troca" required oninvalid="this.setCustomValidity('O campo é obrigatório!')" oninput="setCustomValidity('')"></textarea>
					</div>
					<div style="text-align:center" class="form-group">
						<button class="primary-btn" type="submit" name="operacao" value="SOLICITAR-TROCA">Confirmar troca</button>
						<button style="background-color:gray" type="button" class="primary-btn" data-dismiss="modal">Fechar</button>
					</div>
					</form>
				</div>
			</div>      
		</div>
	</div>
				
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
   		 window.onload = function () {
    	// do the work after everything was loaded (DOM, media elements)
    	var value = "<%=erro%>";
        if(value!=""){
        alert(value);
        	}
    	}
	</script>	
</body>
</html>