<%@page import="core.aplicacao.Resultado"%>
<%@page import="dominio.*"%>
<%@page import="java.util.*"%>
<!DOCTYPE html>
<html lang="pt">

<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->

	<title>Dashboard Administrador</title>

	
	<!-- Google font -->
	<link href="https://fonts.googleapis.com/css?family=Hind:400,700" rel="stylesheet"/>

	<!-- Bootstrap -->
	<link type="text/css" rel="stylesheet" href="css/bootstrap.min.css" />

	<!-- Slick -->
	<link type="text/css" rel="stylesheet" href="css/slick.css" />
	<link type="text/css" rel="stylesheet" href="css/slick-theme.css" />

	<!-- nouislider -->
	<link type="text/css" rel="stylesheet" href="css/nouislider.min.css" />

	<!-- Font Awesome Icon -->
	<link rel="stylesheet" href="css/font-awesome.min.css"/>

	<!-- Custom stlylesheet -->
	<link type="text/css" rel="stylesheet" href="css/style.css" />

	<!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
	<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
	<!--[if lt IE 9]>
		  <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
		  <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
		<![endif]-->

	<link rel="stylesheet" href="geral.css" type="text/css"/>
	<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">

</head>

<body>

		<%
	String erro = "";
	//recebendo dados de pedidos
	
	int t = 0;
	double valor = 0;
	
	String abertos = request.getParameter("status");
	if(abertos==null){
		abertos = "todos";
	}
	
	Resultado resultado = (Resultado) session.getAttribute("dadosPedido");
	
	if(session.getAttribute("dadosPedido") != null){
		List<EntidadeDominio> pedidos = resultado.getEntidades();
	}else{
		pageContext.forward("User?operacao=CONSULTAR");
	}
	
	List<EntidadeDominio> pedidos = resultado.getEntidades();
	
	StringBuilder sb = new StringBuilder();
	
	Pedido ped;
	int w = 0;
	for(EntidadeDominio ent:pedidos){
		ped = (Pedido)ent;
		t = pedidos.size();
		if(ped.getStatus().equals("Em processamento") || ped.getStatus().equals("Em trânsito")){
			w++;
		}
	
	}
		%>

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
								<%
									if(abertos.equals("todos")){
										out.print("<li><a href='Pedidos?status=abertos&operacao=CONSULTAR-ADMIN'>Visualizar pedidos em aberto</a></li>");										
									} else {
										out.print("<li><a href='Pedidos?operacao=CONSULTAR-ADMIN'>Visualizar todos os pedidos</a></li>");
									}
								%>								
								<li><a href="Pedidos?status=trocas&operacao=CONSULTAR-TROCAS">Visualizar pedidos de troca</a></li>
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

			<!-- dashboard admin -->
			<div style="text-align: center">
				<div class="container">
				<div class="row">
					<div class="table-wrapper">
						<div class="table-title">
							<div class="row">
								<div class="col-sm-3">
								<% 
								if(abertos.equals("todos")){
									out.print("<h2>Todos os pedidos</h2>");
								}else{
									out.print("<h2>Pedidos em aberto</h2>");
								}
								%>
								</div>
								<%
								/*if(abertos.equals("todos")){
								out.print("<button type='button' class='btn btn-success' data-toggle='modal' data-target='#exampleModalCenter'>");
								out.print("Filtrar pedidos");
								out.print("</button>");
								}*/
								 %>
							</div>
						</div>
						<div class="col-sm-15">
							<% 
							if(t==0){								
								out.print("<br><br><br><div style='display:flex; justify-content:space-around'>");
								out.print("<p><strong>Não tem nenhum pedido no sistema por enquanto...</strong></p>");
								out.print("</div>");
							}							
							else if(abertos.equals("abertos") && w == 0){								
								out.print("<br><br><br><div style='display:flex; justify-content:space-around'>");
								out.print("<p><strong>Não tem nenhum pedido no sistema por enquanto...</strong></p>");
								out.print("</div>");
							}else{
								out.print("<table class='table table-striped table-hover'>");
								out.print("<thead>");
								out.print("<th style='font-size: 14px'>#ID");
								out.print("</th>");
								out.print("<th style='font-size: 14px'>Produtos");
								out.print("</th>");
								out.print("<th style='font-size: 14px; width:10%'>Quantidade");
								out.print("</th>");
								out.print("<th style='font-size: 14px'>Subtotal");
								out.print("</th>");
								out.print("<th style='font-size: 14px'>Forma de pagamento");
								out.print("</th>");
								out.print("<th style='font-size: 14px'>Total");
								out.print("</th>");
								out.print("<th style='font-size: 14px'>Status Atual");
								out.print("</th>");
								if(abertos.equals("abertos")){
									out.print("<th style='font-size: 14px'>Modificar status</th>");
								}
								
								out.print("</thead>");
								Pedido ped1;
							
								for(EntidadeDominio ent:pedidos){
									ped = (Pedido)ent;
									if(!abertos.equals("todos")){
										if(!ped.getStatus().equals("Entregue") && !ped.getStatus().equals("Pedido negado")){
											out.print("<tr>");
											out.print("<td>"+ped.getId()+"</td>");
											out.print("<td style='font-size:14px'>");
											for(Produto prod:ped.getProdutos()){
												if(prod.getPedido()==ped.getId()){
													out.print(prod.getModeloProduto()+"<br>");
												}
											}
											out.print("</td>");
											out.print("<td>");
											for(Produto prod:ped.getProdutos()){
												out.print(prod.getQtd_pedido()+"<br>");
											}
											out.print("</td>");
											
											out.print("<td>");
											for(Produto prod:ped.getProdutos()){
												if(prod.getPedido()==ped.getId()){
												out.print("R"+String.format("$%,.2f", prod.getSubtotal())+"<br>");
												}
											}
											out.print("</td>");
											int i = 0;
											int z = 0;
											out.print("<td style='letter-spacing:1px'>");
											if(!ped.getCartoes().isEmpty()){
												for(Cartao card:ped.getCartoes()){
													if(card.getPedido()==ped.getId()){														
														i++; // contador de cartões 
													}
												}
											}
											if(!ped.getCuponsTroca().isEmpty()){
												for(CupomTroca cupom:ped.getCuponsTroca()){
													if(cupom.getId_pedido_cupom()==ped.getId()){
														z++; // contador de cupons
													}
												}
											}
											if(!ped.getStatus().equals("Troca solicitada") && !ped.getStatus().equals("Troca autorizada")) {
												if(i==1){
													if(z>0){
														out.print("Pagamento com 1 cartão e "+z+" cupons de troca");
													}else{
														out.print("Pagamento com 1 cartão");
													}
												}
												else if(i==2){
													if(z>0){
														out.print("Pagamento com 2 cartões e "+z+" cupons de troca");
													}else{
														out.print("Pagamento com 2 cartões");
													}
												}else{
													out.print("Pagamento com "+z+" cupons de troca");
												}
											} else{
												out.print(" - ");
											}
											out.print("</td>");
											
											out.print("<td>R"+String.format("$%,.2f", ped.getValor_total())+"</td>");
											out.print("<td>"+ped.getStatus()+"</td>");
											if(abertos.equals("abertos")){
												if(ped.getStatus().equals("Em processamento")){
													out.print("<td><div><form action='Pedidos' method='POST'>"+
													"<input type='hidden' name='id-pedido' value='"+ped.getId()+"'/>"+
													"<input type='hidden' name='status-pedido' value='"+ped.getStatus()+"'/>"+
													"<button style='background: none; border:none' type='submit' name='operacao' value='CONFIRMAR-PEDIDO'><i style='color:green' class='material-icons'>check_box</i></button>"+
													"</form></div>"+
													"<div><form action='Pedidos' method='POST'>"+
														"<input type='hidden' name='id-pedido' value='"+ped.getId()+"'/>"+
														"<button style='background: none; border:none' type='submit' name='operacao' value='NEGAR-PEDIDO'><i style='color:red' class='material-icons'>cancel</i></button>"+
													"</form></div>"+
													"</td>");
												}else if(ped.getStatus().equals("Pedido negado")){
													out.print("<td><strong>Nao é possivel alterar</strong></td>");
												}else if(ped.getStatus().equals("Entregue")){
													out.print("<td><strong>Pedido entregue</strong></td>");
												}else if(ped.getStatus().equals("Troca solicitada")){
													out.print("<td><form action='Pedidos' method='POST'>"+
													"<input type='hidden' name='id-pedido' value='"+ped.getId()+"'/>"+
													"<input type='hidden' name='idusr' value='"+ped.getCliente().getId()+"'/>"+
													"<input type='hidden' name='valor-pedido' value='"+ped.getValor_total()+"'/>"+
													"<input type='hidden' name='status-pedido' value='"+ped.getStatus()+"'/>"+
													"<button style='background-color:green' class='btn btn-primary' type='submit' name='operacao' value='AUTORIZAR-TROCA'>Autorizar troca</button>"+
													"</form>"+
													"</td>");
												}
												else if(ped.getStatus().equals("Troca autorizada")){
													out.print("<td><strong>Nao é possivel alterar</strong></td>");
												}
												else{
													out.print("<td><form action='Pedidos' method='POST'>"+
													"<input type='hidden' name='id-pedido' value='"+ped.getId()+"'/>"+
													"<input type='hidden' name='status-pedido' value='"+ped.getStatus()+"'/>"+
													"<button class='btn btn-success' type='submit' name='operacao' value='CONFIRMAR-ENTREGA'>Confirmar entrega</button>"+
													"</form>"+
													"</td>");
												}
											}										
											out.print("</tr>");
										}
									}else{ //if(abertos.equals("todos"))
											out.print("<tr>");
											out.print("<td>"+ped.getId()+"</td>");
											out.print("<td style='font-size:14px'>");
											for(Produto prod:ped.getProdutos()){
												if(prod.getPedido()==ped.getId()){
													out.print(prod.getModeloProduto()+"<br>");
												}
											}
											out.print("</td>");
											out.print("<td>");
											for(Produto prod:ped.getProdutos()){
												out.print(prod.getQtd_pedido()+"<br>");
											}
											out.print("</td>");
											
											out.print("<td>");
											for(Produto prod:ped.getProdutos()){
												if(prod.getPedido()==ped.getId()){
												out.print("R"+String.format("$%,.2f", prod.getSubtotal())+"<br>");
												}
											}
											out.print("</td>");
											int i=0;
											int z=0;
											out.print("<td style='letter-spacing:1px'>");
											for(Cartao card:ped.getCartoes()){
												if(card.getPedido()==ped.getId()){												
													i++;
												}
											}
											if(!ped.getCuponsTroca().isEmpty()){
												for(CupomTroca cupom:ped.getCuponsTroca()){
													if(cupom.getId_pedido_cupom()==ped.getId()){
														z++;
													}
												}
											}											
											if(!ped.getStatus().equals("Troca solicitada") && !ped.getStatus().equals("Troca autorizada")) {
												if(i==1){
													if(z>0){
														out.print("Pagamento com 1 cartão e "+z+" cupons de troca");
													}else{
														out.print("Pagamento com 1 cartão");
													}
												}
												else if(i==2){
													if(z>0){
														out.print("Pagamento com 2 cartões e "+z+" cupons de troca");
													}else{
														out.print("Pagamento com 2 cartões");
													}
												}else{
													out.print("Pagamento com "+z+" cupons de troca");
												}
											} else{
												out.print(" - ");
											}
											out.print("</td>");
											out.print("<td>R"+String.format("$%,.2f", ped.getValor_total())+"</td>");
											out.print("<td>"+ped.getStatus()+"</td>");									
											out.print("</tr>");
										}								
								}
								out.print("</table>");
							}							
							%>
						</div>
					</div>
				</div>
			</div>
		</div>
			<!-- dashboard admin -->
			<!-- /row -->
		<!-- /container -->
  
  <div class="modal fade" id="exampleModalCenter" role="dialog">
    <div class="modal-dialog">
    
      <!-- Modal content-->
      <div style="background-color:white" class="col-md-6 col-md-offset-3">
		<div class="billing-details">
			<div>
			<br>
			<h3 class="title">Filtros</h3>
       		</div>
           <div class="modal-body">
        <div>
			<form action="Pedidos" method="GET">
				<span>Forma de pagamento: </span>
				<select name="pagamento" class="form-control">
					<option value="">Escolha</option>
					<option value="pag1">Pagamento com 1 cartão</option>
					<option value="pag2">Pagamento com 2 cartões</option>
				</select>
				<br>
				<p>
				<span>Incluir pagamentos com cupons?</span>
				<input type="checkbox" name="cupons" value="sim"/>
				</p>
				<p>
				<span>Status do pedido: </span>
				<select name="pedido" class="form-control">
					<option value="">Escolha</option>
					<option value="Pagamento em analise">Pagamento em análise</option>
					<option value="Pedido entregue">Pedido entregue</option>
					<option value="Troca solicitada">Troca solicitada</option>
					<option value="Troca autorizada">Troca autorizada</option>
					<option value="Pedido negado">Pedido negado</option>
					<option value="Pagamento autorizado">Pagamento autorizado</option>
				</select>
				</p>
				<div class="modal-footer">
		        <button type="button" class="btn btn-secondary" data-dismiss="modal">Fechar</button>
		        <button type="submit" name="operacao" value="FILTRAR-PEDIDOS" class="btn btn-primary">Aplicar filtro</button>
	     	</div>
			</form>
		</div>
      </div>
      </div>
      </div>
      
    </div>
         
  </div>
  <div class="loader-wrapper">
      <span class="loader"><span class="loader-inner"></span></span>
    </div>
		
	<!-- /section -->
	<!-- jQuery Plugins -->
	<script src="js/jquery.min.js"></script>
	<script src="js/bootstrap.min.js"></script>
	<script src="js/slick.min.js"></script>
	<script src="js/nouislider.min.js"></script>
	<script src="js/jquery.zoom.min.js"></script>
	<script src="js/main.js"></script>
	<script>
	$(window).on("load",function(){
	     $(".loader-wrapper").fadeOut("slow");
	});
	</script>
	<script type="text/javascript">
	window.onload = function () {
	    	// do the work after everything was loaded (DOM, media elements)
	    	var value = "<%=erro%>";
	    	var i = 0;
	        if(value!=""){
	        alert(value);
	    	}
	}
	</script>
</body>

</html>