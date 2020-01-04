<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->

	<title>Cadastrar Cliente</title>

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

	<!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
	<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
	<!--[if lt IE 9]>
		  <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
		  <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
		<![endif]-->
	<link rel="stylesheet" href="https://unpkg.com/purecss@1.0.0/build/pure-min.css" integrity="sha384-nn4HPE8lTHyVtfCBi5yW9d20FjT8BJwUXyWZT9InLYax14RDjBj46LmSztkmNP9w" crossorigin="anonymous">
	
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
						<a class="logo" href="#">
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
								<div class="header-btns-icon">
									<i class="fa fa-user-o"></i>
								</div>
							<a href="login.jsp" class="text-uppercase">Login</a> / <a href="cadastrar-cliente.jsp" class="text-uppercase">Join</a>
						</li> 
						<!-- /Account -->

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

<div class="section">
	<div class="container" style="text-align: center">
		<h2>Cadastro de Usuario</h2>
		<form id="form-cadastro" action="Cliente" method="POST" class="form-horizontal">
			<section class="panel">
				<div class="panel-body" style="padding-right:100px">
				
					<div class="container">
						<div class="form-group">
							<label class="col-sm-3 control-label">Nome <span class="required">*</span></label>
							<div class="col-sm-6">
								<input id="nome_cliente" type="text" name="nome_cliente" class="col-sm-3 form-control" required oninvalid="this.setCustomValidity('O campo nome é obrigatório!')" oninput="setCustomValidity('')"/>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-3 control-label">Email <span class="required">*</span></label>
							<div class="col-sm-6">
								<input id="email_cliente" type="text" name="email_cliente" class="col-sm-3 form-control" required oninvalid="this.setCustomValidity('O campo nome é obrigatório!')" oninput="setCustomValidity('')"/>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-3 control-label">Telefone <span class="required">*</span></label>
							<div class="col-sm-6">
								<input id="telefone" type="text" name="telefone_cliente" class="col-sm-3 form-control" required oninvalid="this.setCustomValidity('O campo nome é obrigatório!')" oninput="setCustomValidity('')"/>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-3 control-label">Senha <span class="required">*</span></label>
							<div class="col-sm-6">
								<input id="senha" type="text" name="senha_cliente" class="col-sm-3 form-control" required oninvalid="this.setCustomValidity('O campo nome é obrigatório!')" oninput="setCustomValidity('')"/>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-3 control-label">Digite a Senha novamente<span class="required">*</span></label>
							<div class="col-sm-6">
								<input id="conf_senha" type="text" name="conf_senha_cliente" class="col-sm-3 form-control" required oninvalid="this.setCustomValidity('O campo nome é obrigatório!')" oninput="setCustomValidity('')"/>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-3 control-label">Tipo de Residência <span class="required">*</span></label>
							<div class="col-sm-6">
								<input id="tipoResid" type="text" placeholder="Ex: Casa, apartamento, etc" name="tipo_residencia" class="col-sm-3 form-control" required oninvalid="this.setCustomValidity('O campo nome é obrigatório!')" oninput="setCustomValidity('')"/>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-3 control-label">Tipo de Logradouro <span class="required">*</span></label>
							<div class="col-sm-6">
								<input id="tipoLogra" type="text" placeholder="Ex: Rua, Avenida, etc" name="tipo_logradouro" class="col-sm-3 form-control" required oninvalid="this.setCustomValidity('O campo nome é obrigatório!')" oninput="setCustomValidity('')"/>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-3 control-label">Logradouro <span class="required">*</span></label>
							<div class="col-sm-6">
								<input id="logradouro" type="text" name="logradouro" class="col-sm-3 form-control" required oninvalid="this.setCustomValidity('O campo nome é obrigatório!')" oninput="setCustomValidity('')"/>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-3 control-label">Numero <span class="required">*</span></label>
							<div class="col-sm-6">
								<input id="numero" type="text" name="numero" class="col-sm-3 form-control" required oninvalid="this.setCustomValidity('O campo nome é obrigatório!')" oninput="setCustomValidity('')"/>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-3 control-label">Bairro <span class="required">*</span></label>
							<div class="col-sm-6">
								<input id="bairro" type="text" name="bairro" class="col-sm-3 form-control" required oninvalid="this.setCustomValidity('O campo nome é obrigatório!')" oninput="setCustomValidity('')"/>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-3 control-label">CEP <span class="required">*</span></label>
							<div class="col-sm-6">
								<input id="cep" type="text" name="cep" class="col-sm-3 form-control" required oninvalid="this.setCustomValidity('O campo nome é obrigatório!')" oninput="setCustomValidity('')"/>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-3 control-label">Cidade <span class="required">*</span></label>
							<div class="col-sm-6">
								<input id="cidade" type="text" name="cidade" class="col-sm-3 form-control" required oninvalid="this.setCustomValidity('O campo nome é obrigatório!')" oninput="setCustomValidity('')"/>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-3 control-label">Estado <span class="required">*</span></label>
							<div class="col-sm-6">
								<input id="estado" type="text" name="estado" class="col-sm-3 form-control" required oninvalid="this.setCustomValidity('O campo nome é obrigatório!')" oninput="setCustomValidity('')"/>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-3 control-label">País <span class="required">*</span></label>
							<div class="col-sm-6">
								<input id="pais" type="text" name="pais" class="col-sm-3 form-control" required oninvalid="this.setCustomValidity('O campo nome é obrigatório!')" oninput="setCustomValidity('')"/>
							</div>
						</div>	
					</div>							
				</div>
				<footer class="panel-footer">
					<div class="row" style="padding-left:100px">
						<div class="col-sm-9 col-sm-offset-3">
							<button type="submit" name="operacao" value="SALVAR" class="btn btn-success">Cadastrar</button>
							<button style="background-color:grey" type="reset" class="btn btn-success">Resetar campos</button>
							<div><a style="background-color:red" class="btn btn-success" href="dashboard-cliente.jsp">Cancelar </a></div>
						</div>
					</div>
				</footer>
			</section>
		</form>
	</div>
</div>	
<!-- jQuery Plugins -->
	<script src="js/jquery.min.js"></script>
	<script src="js/bootstrap.min.js"></script>
	<script src="js/slick.min.js"></script>
	<script src="js/nouislider.min.js"></script>
	<script src="js/jquery.zoom.min.js"></script>
	<script src="js/main.js"></script>
</body>
</html>