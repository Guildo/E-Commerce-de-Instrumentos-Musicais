<%@page import="core.aplicacao.Resultado"%>
<%@page import="dominio.*"%>
<%@page import="dominio.Produto"%>
<%@page import="auxiliar.DadosDeCadastro"%>
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
		<%
			// dados para as opções de categoria
			Resultado resultado = (Resultado) session.getAttribute("dados");
			List<EntidadeDominio> DadosProd = resultado.getEntidades();
			//String erro = "";
			
			try{
			Resultado resultProdutos = (Resultado)session.getAttribute("produto");
			//erro = resultProdutos.getMsg().trim();
			//session.removeAttribute("produto");
			} catch (Exception e){
				
			}
			DadosDeCadastro itens = (DadosDeCadastro)DadosProd.get(0);
			StringBuilder sb;
			Produto prd;
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
							<a href="#" class="text-uppercase">Sair</a>
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
							<li class="dropdown default-dropdown"><a class="dropdown-toggle" data-toggle="dropdown" aria-expanded="true">Categorias <i class="fa fa-caret-down"></i></a>
								<ul class="custom-menu">
									<li><a href="products.html">Visualizar categorias</a></li>
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
		<div class="container" style="text-align: center">
			<!-- row -->
			<!-- dashboard admin -->
			<div style="text-align: center">
				<form id="form-cadastro" action="Produtos" method="POST" class="form-horizontal">
					<section class="panel">
						<header class="panel-heading" style="padding-right:200px">						
						<h2 class="panel-title">Digite os dados do produto</h2>
						</header>
						<div class="panel-body" style="padding-right:100px">
							<div class="form-group">
								<label class="col-sm-3 control-label">Modelo do produto <span class="required">*</span></label>
								<div class="col-sm-6">
									<input id="modelo" type="text" name="modelo-produto" class="col-sm-3 form-control" required oninvalid="this.setCustomValidity('O campo nome é obrigatório!')" oninput="setCustomValidity('')"/>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-3 control-label">Categoria do produto<span class="required">*</span></label>
								<div class="col-sm-4">
									<select name="categoria-produto" id="categoria" class="form-control" required oninvalid="this.setCustomValidity('O campo categoria é obrigatorio!')" oninput="setCustomValidity('')">
										<option value="">Selecione uma categoria</option>
											<% 
												sb = new StringBuilder();
												for(Categoria cat : itens.getCategorias()){
											
													sb.append("<option value='"+ cat.getId()+"'>");
													sb.append(cat.getNomeCategoria()+"</option>");
												}
												out.print(sb.toString());
											%>
									</select>									
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-3 control-label">Marca do produto<span class="required">*</span></label>
								<div class="col-sm-4">
									<input type="text" id="marca" name="marca-produto" class="col-sm-3 form-control" required oninvalid="this.setCustomValidity('O campo valor é obrigatorio!')" oninput="setCustomValidity('')"/>
									<label class="error" for="marca"></label>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-3 control-label">Cor do produto</span></label>
								<div class="col-sm-4">
									<input type="text" id="cor" name="cor-produto" class="col-sm-3 form-control" oninput="setCustomValidity('')"/>
									<label class="error" for="marca"></label>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-3 control-label">Valor do produto em reais <span class="required">*</span></label>
								<div class="col-sm-4">
									<input type="text" id="valor" name="valor-produto" class="col-sm-3 form-control" required oninvalid="this.setCustomValidity('O campo valor é obrigatorio!')" oninput="setCustomValidity('')"/>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-3 control-label">Imagem do produto <span class="required">*</span></label>
								<div class="col-sm-6">
									<input type="text" id="imagem" name="img-produto" placeholder="Link da imagem do produto..." class="col-sm-3 form-control" required oninvalid="this.setCustomValidity('O campo valor é obrigatorio!')" oninput="setCustomValidity('')"/>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-3 control-label">Descricao do produto </label>
								<div class="col-sm-9">
									<textarea id="descricao" name="descricao-produto" rows="5" class="form-control" oninput="setCustomValidity('')"/></textarea>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-3 control-label">Quantidade em estoque </label>
								<div class="col-sm-2">
									<input id="estoque" name="qtd-estoque" rows="5" class="form-control" oninput="setCustomValidity('')"/>
								</div>
							</div>									
						</div>
						<footer class="panel-footer">
							<div class="row" style="padding-left:100px">
								<div class="col-sm-9 col-sm-offset-3">
									<button type="submit" name="operacao" value="SALVAR" class="btn btn-success">Cadastrar produto</button>
									<button style="background-color:grey; color:white" type="reset" class="btn btn-default">Resetar campos</button>
									<a id="listagem" href="Produtos?operacao=CONSULTAR" style="background-color:red; color:white" class="btn btn-default">Cancelar</a>
									
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