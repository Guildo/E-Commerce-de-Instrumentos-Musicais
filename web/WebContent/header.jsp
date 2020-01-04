<%@page import="core.aplicacao.Resultado"%>
<%@page import="dominio.*"%>
<%@page import="auxiliar.DadosDeCadastro"%>
<%@page import="java.util.*"%>

<!DOCTYPE html>
<html lang="pt">

<head>
	
<%
	Resultado login = (Resultado) session.getAttribute("login");
	
	List<EntidadeDominio> cliente = login.getEntidades();		
	
	Cliente cli = (Cliente)cliente.get(0);	
	int idUser = cli.getId();
	
	Resultado resultado = (Resultado) session.getAttribute("produtos");
	List<EntidadeDominio> DadosProd = resultado.getEntidades();
	Produto prd;
	
	StringBuilder sb = new StringBuilder();
%>
</head>

<body>
<!-- HEADER -->
	<header>
		<!-- top Header -->
		<div id="top-header">
			<div class="container">
				<div class="pull-left">
					<span>Welcome to E-shop!</span>
				</div>
				<div class="pull-right">
					<ul class="header-top-links">
						<li><a href="#">Store</a></li>
						<li><a href="#">Newsletter</a></li>
						<li><a href="#">FAQ</a></li>
						<li class="dropdown default-dropdown">
							<a class="dropdown-toggle" data-toggle="dropdown" aria-expanded="true">ENG <i class="fa fa-caret-down"></i></a>
							<ul class="custom-menu">
								<li><a href="#">English (ENG)</a></li>
								<li><a href="#">Russian (Ru)</a></li>
								<li><a href="#">French (FR)</a></li>
								<li><a href="#">Spanish (Es)</a></li>
							</ul>
						</li>
						<li class="dropdown default-dropdown">
							<a class="dropdown-toggle" data-toggle="dropdown" aria-expanded="true">USD <i class="fa fa-caret-down"></i></a>
							<ul class="custom-menu">
								<li><a href="#">USD ($)</a></li>
								<li><a href="#">EUR </a></li>
							</ul>
						</li>
					</ul>
				</div>
			</div>
		</div>
		<!-- /top Header -->

		<!-- header -->
		<div id="header">
			<div class="container">
				<div class="pull-left">
					<!-- Logo -->
					<div class="header-logo">
						<a class="logo" href="Produtos?operacao=INDEX">
							<img src="./img/logo.png" alt="">
						</a>
					</div>
					<!-- /Logo -->

					<!-- Search -->
					<div class="header-search">
						<form>
							<input class="input search-input" type="text" placeholder="Enter your keyword">
							<select class="input search-categories">
								<option value="0">All Categories</option>
								<option value="1">Category 01</option>
								<option value="1">Category 02</option>
							</select>
							<button class="search-btn"><i class="fa fa-search"></i></button>
						</form>
					</div>
					<!-- /Search -->
				</div>
				<div class="pull-right">
					<ul class="header-btns">
						<!-- Account -->
						<li class="header-account dropdown default-dropdown">
							<div class="dropdown-toggle" role="button" data-toggle="dropdown" aria-expanded="true">
								<div class="header-btns-icon">
									<i class="fa fa-user-o"></i>
								</div>
								<strong class="text-uppercase">Minha conta <i class="fa fa-caret-down"></i></strong>
							</div>
							<a href="login.jsp" class="text-uppercase">Login</a> / <a href="cadastrar_cliente.jsp" class="text-uppercase">Join</a>
							<ul class="custom-menu">
								<li><a href="Cliente?idusr=<%out.print(idUser); %>&operacao=CONSULTAR"><i class="fa fa-user-o"></i> Meus dados</a></li>
								<li><a href="logout.jsp"><i class="fa fa-unlock-alt"></i> Logout</a></li>
								<li><a href="Pedidos?idusr=<%out.print(idUser); %>&status=abertos&operacao=CONSULTAR"><i class="fa fa-shopping-cart"></i> Meus pedidos</a></li>
								<li><a href="Pedidos?idusr=<%out.print(idUser); %>&status=trocas&operacao=CONSULTAR"><i class="fa fa-shopping-cart"></i> Meus pedidos de troca</a></li>
								<li><a href="Cliente?idusr=<%out.print(idUser); %>&operacao=CONSULTAR-CUPONS"><i class="fa fa-shopping-cart"></i> Meus cupons de troca</a></li>
							</ul>
						</li>
						<!-- /Account -->

						<!-- Cart -->
						<li name="meu_carrinho" class="header-cart dropdown default-dropdown">
							<a class="dropdown-toggle" data-toggle="dropdown" aria-expanded="true">
								<div class="header-btns-icon">
									<i class="fa fa-shopping-cart"></i>
								</div>
								<strong class="text-uppercase">My Cart:</strong>
								<br>
							</a>
							<div class="custom-menu">
								<div id="shopping-cart">
									<div class="shopping-cart-btns">
										<a href="meu-carrinho.jsp" class="main-btn">Visualizar Carrinho </a>
										<button class="primary-btn">Checkout <i class="fa fa-arrow-circle-right"></i></button>
									</div>
								</div>
							</div>
						</li>
						<!-- /Cart -->

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
	
</body>
</html>