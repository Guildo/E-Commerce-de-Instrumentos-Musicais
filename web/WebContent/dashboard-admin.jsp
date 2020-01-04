<%@page import="org.apache.jasper.tagplugins.jstl.core.ForEach"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page import="core.aplicacao.Resultado"%>
<%@page import="dominio.*"%>
<%@page import="auxiliar.*"%>
<%@page import="java.util.*"%>
<!DOCTYPE html>
<html lang="pt">

<%
	String erro = "";
	//recebendo dados de pedidos

	int t = 0;
	double valor = 0;

	//dados de login
	int error = 0;
	Resultado login = (Resultado) session.getAttribute("login");
	if (session.getAttribute("login") == null) {
		pageContext.forward("index.jsp");
	}
	try {
		List<EntidadeDominio> user = login.getEntidades();
	} catch (Exception e) {
		error = 1;
	}

	Resultado dadosGrafico = (Resultado) session.getAttribute("grafico");

	if (dadosGrafico == null) {
		out.print("aaaaaaa");
	}

	Map<String, LinkedHashMap<String, List<Integer>>> dadosPorMes = new LinkedHashMap<String, LinkedHashMap<String, List<Integer>>>();
	Map<String, LinkedHashMap<String, List<Integer>>> produtosPorMes = new LinkedHashMap<String, LinkedHashMap<String, List<Integer>>>();
	List<String> listaMesAno = new ArrayList<String>();
	List<String> listaMesAno2 = new ArrayList<String>();
	
	List<EntidadeDominio> dados = dadosGrafico.getEntidades();
	List<EntidadeDominio> dados2 = dadosGrafico.getEntidades();

	Grafico graph;

	String nomeUser = "";
	int id = 0;
	if (error == 0) {
		List<EntidadeDominio> user = login.getEntidades();
		Cliente us = (Cliente) user.get(0);
		nomeUser = us.getNomeCliente();
		id = us.getId();
	}
	StringBuilder sb = new StringBuilder();

	Pedido ped;
	int o = 0;

	//mapa para setar os dados da query de pequisa
	for (EntidadeDominio ent : dados) {
		graph = (Grafico) ent;
		for (ItemsGrafico itens : graph.getItems()) {
			int indexes = -1;
			
			listaMesAno = itens.getProdutos().stream()
					.map(p -> new String(p.getGraficoMes() + "/" + p.getGraficoAno()))
					.distinct()
					.collect(java.util.stream.Collectors.toList());
					
			for (Produto prd : itens.getProdutos()) {
				
				if(dadosPorMes.get(prd.getGraficoMes() + "/" + prd.getGraficoAno()) == null) {
					indexes++;
				}
				
				LinkedHashMap<String, List<Integer>> mapOfCurrentProduct = null;
				String keyOfCurrentProduct = "";
				
				for(Map.Entry<String, LinkedHashMap<String, List<Integer>>> key : dadosPorMes.entrySet())  {
					for(Map.Entry<String, List<Integer>> pair : key.getValue().entrySet()) {
						if(pair.getKey().equalsIgnoreCase(prd.getCategoria().getNomeCategoria())) {
							int indexNext  = 0;
							
							for (String dateYear : listaMesAno) {
								System.out.println(listaMesAno.indexOf(dateYear));
								if(dateYear.equalsIgnoreCase(new String(prd.getGraficoMes() + "/" + prd.getGraficoAno()))) {
									indexNext = listaMesAno.indexOf(dateYear);
								}
							}
							
							keyOfCurrentProduct = key.getKey();
							mapOfCurrentProduct = dadosPorMes.get(key.getKey());
							List<Integer> itensC = mapOfCurrentProduct.get(prd.getCategoria().getNomeCategoria());
							itensC.set(indexNext, prd.getQtdtotal());
							mapOfCurrentProduct.put(prd.getCategoria().getNomeCategoria(), itensC);
							break;
						}
					}
				}
				
				if(mapOfCurrentProduct != null) {
					dadosPorMes.put(keyOfCurrentProduct, mapOfCurrentProduct);
					break;
				}
				
				if(dadosPorMes.get(prd.getGraficoMes() + "/" + prd.getGraficoAno()) == null) {
					LinkedHashMap<String, List<Integer>> map = new LinkedHashMap<String, List<Integer>>();
					List<Integer> itensP = Arrays.asList(Collections.nCopies(listaMesAno.size(), 0).toArray(new Integer[0]));
					itensP.set(indexes, prd.getQtdtotal());
					map.put(prd.getCategoria().getNomeCategoria(), itensP);
					dadosPorMes.put(new String(prd.getGraficoMes() + "/" + prd.getGraficoAno()), map);
				} else {
					String keyMap = new String(prd.getGraficoMes() + "/" + prd.getGraficoAno());
					int indexMonth = 0;
					LinkedHashMap<String, List<Integer>> map = dadosPorMes.get(keyMap);
					
					for(int m=0; m < listaMesAno.size(); m++) {
						String key = (String)dadosPorMes.keySet().toArray()[m];
						if(key.equals(keyMap)) {
							indexMonth = m;
							break;
						}
					}
					
					if(map.get(prd.getCategoria().getNomeCategoria()) == null){
						List<Integer> itensC = Arrays.asList(Collections.nCopies(listaMesAno.size(), 0).toArray(new Integer[0]));
						itensC.set(indexMonth, prd.getQtdtotal());
						map.put(prd.getCategoria().getNomeCategoria(), itensC);
						dadosPorMes.put(keyMap, map);
					}else{
						List<Integer> itensC = map.get(prd.getCategoria().getNomeCategoria());
						itensC.set(indexMonth, prd.getQtdtotal());
						map.put(prd.getCategoria().getNomeCategoria(), itensC);
						dadosPorMes.put(keyMap, map);
					}
				}
			}
		
		}
		for (ItemsGrafico itens2 : graph.getItems()) {
			
			int indexes2 = -1;
			
			listaMesAno2 = itens2.getProdutos2().stream()
					.map(p -> new String(p.getGraficoMes() + "/" + p.getGraficoAno()))
					.distinct()
					.collect(java.util.stream.Collectors.toList());
					
			for (Produto prd2 : itens2.getProdutos2()) {
				if(produtosPorMes.get(prd2.getGraficoMes() + "/" + prd2.getGraficoAno()) == null) {
					indexes2++;
				}
				
				LinkedHashMap<String, List<Integer>> mapOfCurrentProduct2 = null;
				String keyOfCurrentProduct2 = "";
				
				for(Map.Entry<String, LinkedHashMap<String, List<Integer>>> key : produtosPorMes.entrySet())  {
					for(Map.Entry<String, List<Integer>> pair2 : key.getValue().entrySet()) {
						if(pair2.getKey().equalsIgnoreCase(prd2.getModeloProduto()+ " - " +prd2.getMarcaProduto())) {
							int indexNext2  = 0;
							
							for (String dateYear2 : listaMesAno2) {
								System.out.println(listaMesAno2.indexOf(dateYear2));
								if(dateYear2.equalsIgnoreCase(new String(prd2.getGraficoMes() + "/" + prd2.getGraficoAno()))) {
									indexNext2 = listaMesAno2.indexOf(dateYear2);
								}
							}
							
							keyOfCurrentProduct2 = key.getKey();
							mapOfCurrentProduct2 = produtosPorMes.get(key.getKey());
							List<Integer> itensC2 = mapOfCurrentProduct2.get(prd2.getModeloProduto()+ " - " +prd2.getMarcaProduto());
							itensC2.set(indexNext2, prd2.getQtdtotal());
							mapOfCurrentProduct2.put(prd2.getModeloProduto()+ " - " +prd2.getMarcaProduto(), itensC2);
							break;
						}
					}
				}
				
				if(mapOfCurrentProduct2 != null) {
					produtosPorMes.put(keyOfCurrentProduct2, mapOfCurrentProduct2);
					break;
				}
				
				if(produtosPorMes.get(prd2.getGraficoMes() + "/" + prd2.getGraficoAno()) == null) {
					LinkedHashMap<String, List<Integer>> map2 = new LinkedHashMap<String, List<Integer>>();
					List<Integer> itensP2 = Arrays.asList(Collections.nCopies(listaMesAno2.size(), 0).toArray(new Integer[0]));
					itensP2.set(indexes2, prd2.getQtdtotal());
					map2.put(prd2.getModeloProduto()+ " - " +prd2.getMarcaProduto(), itensP2);
					produtosPorMes.put(new String(prd2.getGraficoMes() + "/" + prd2.getGraficoAno()), map2);
				} else {
					String keyMap2 = new String(prd2.getGraficoMes() + "/" + prd2.getGraficoAno());
					int indexMonth2 = 0;
					LinkedHashMap<String, List<Integer>> map2 = produtosPorMes.get(keyMap2);
					
					for(int m=0; m < listaMesAno2.size(); m++) {
						String key = (String)produtosPorMes.keySet().toArray()[m];
						if(key.equals(keyMap2)) {
							indexMonth2 = m;
							break;
						}
					}
					
					if(map2.get(prd2.getModeloProduto()+ " - " +prd2.getMarcaProduto()) == null){
						List<Integer> itensC2 = Arrays.asList(Collections.nCopies(listaMesAno2.size(), 0).toArray(new Integer[0]));
						itensC2.set(indexMonth2, prd2.getQtdtotal());
						map2.put(prd2.getModeloProduto()+ " - " +prd2.getMarcaProduto(), itensC2);
						produtosPorMes.put(keyMap2, map2);
					}else{
						List<Integer> itensC2 = map2.get(prd2.getModeloProduto()+ " - " +prd2.getMarcaProduto());
						itensC2.set(indexMonth2, prd2.getQtdtotal());
						map2.put(prd2.getModeloProduto()+ " - " +prd2.getMarcaProduto(), itensC2);
						produtosPorMes.put(keyMap2, map2);
					}
				}
			}
		}
	}
	
%>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->

<title>Dashboard Administrador</title>

<script type="text/javascript"
	src="https://www.gstatic.com/charts/loader.js"></script>

</head>

<!-- Google font -->
<link href="https://fonts.googleapis.com/css?family=Hind:400,700"
	rel="stylesheet">

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

<link rel="stylesheet" href="geral.css" type="text/css" />
<link rel="stylesheet"
	href="https://unpkg.com/purecss@1.0.0/build/pure-min.css"
	integrity="sha384-nn4HPE8lTHyVtfCBi5yW9d20FjT8BJwUXyWZT9InLYax14RDjBj46LmSztkmNP9w"
	crossorigin="anonymous">
<link rel="stylesheet" href="loader.css" type="text/css" />
<link type="text/css" rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.8.0/Chart.min.css" />
</head>

<body onload="addData()">

	<script type="text/javascript"
		src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.8.0/Chart.min.js"></script>
	<!-- HEADER -->
	<header>
		<!-- header -->
		<div id="header">
			<div class="container">
				<div class="pull-left">
					<!-- Logo -->
					<div class="header-logo">
						<a class="logo" href="#"> <img src="./img/logo.png" alt="">
						</a>
					</div>
					<!-- /Logo -->
				</div>
				<div class="pull-right">
					<ul class="header-btns">
						<!-- Account -->
						<li class="header-account dropdown default-dropdown">
							<div class="dropdown-toggle" role="button" data-toggle="dropdown"
								aria-expanded="true">
								<div class="header-btns-icon">
									<i class="fa fa-user-o"></i>
								</div>
								<strong class="text-uppercase">Olá, Administrador <i
									class="fa fa-caret-down"></i></strong>
							</div> <a href="logout.jsp" class="text-uppercase">logout</a>
							<ul class="custom-menu">
								<li><a href="#"><i class="fa fa-user-o"></i> Minha
										conta</a></li>
							</ul>
						</li>
						<!-- /Account -->

						<!-- Mobile nav toggle-->
						<li class="nav-toggle">
							<button class="nav-toggle-btn main-btn icon-btn">
								<i class="fa fa-bars"></i>
							</button>
						</li>
						<!-- / Mobile nav toggle -->
					</ul>
				</div>
				<div class="pull-right">
					<ul class="header-btns">
						<!-- Mobile nav toggle-->
						<li class="nav-toggle">
							<button class="nav-toggle-btn main-btn icon-btn">
								<i class="fa fa-bars"></i>
							</button>
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
					<span class="menu-header">Menu Administrador <i
						class="fa fa-bars"></i></span>
					<ul class="menu-list">
						<li><a href="dashboard-admin.jsp">Pagina Principal</a></li>
						<li class="dropdown default-dropdown"><a
							class="dropdown-toggle" data-toggle="dropdown"
							aria-expanded="true">Produtos <i class="fa fa-caret-down"></i></a>
							<ul class="custom-menu">
								<li><a href="Produtos?operacao=CONSULTAR">Visualizar
										produtos</a></li>
								<li><a href="DadosProduto?operacao=CONSULTAR&editar=0">Cadastrar
										produtos</a></li>
							</ul></li>
						<li class="dropdown default-dropdown"><a
							class="dropdown-toggle" data-toggle="dropdown"
							aria-expanded="true">Pedidos <i class="fa fa-caret-down"></i></a>
							<ul class="custom-menu">
								<li><a href="Pedidos?operacao=CONSULTAR-ADMIN">Visualizar
										todos os pedidos</a></li>
								<li><a
									href="Pedidos?status=abertos&operacao=CONSULTAR-ADMIN">Visualizar
										pedidos em aberto</a></li>
							</ul></li>
						<li class="dropdown default-dropdown"><a
							class="dropdown-toggle" data-toggle="dropdown"
							aria-expanded="true">Dashboard <i class="fa fa-caret-down"></i></a>
							<ul class="custom-menu">
								<li><a href="Graficos?operacao=DASHBOARD">Gráficos
										analíticos</a></li>
							</ul></li>
					</ul>
				</div>
				<!-- menu nav -->
			</div>
		</div>
		<!-- /container -->
	</div>
	<!-- /NAVIGATION -->
	<!-- section -->
	<!-- container -->
	<div class="container" style="text-align: center">
		<div class="table-wrapper">
			<div class="table-title">
				<div class="row">
					<div class="col-sm-3">
						<h2>Dashboard Analytics</h2>
					</div>
				</div>
			</div>
			<!-- dashboard admin -->
			<div style="display: flex; justify-content: space-around">
				<div style="width: 1400px">
					<canvas id="grafico"></canvas>
				</div>
				<div style="padding-top: 100px; width: 200px">
					<form
						style="border-style: solid; border-width: 0.7px; border-radius: 5px;"
						action="Graficos" method="POST">
						<span><strong>Filtros</strong></span><br>
						<span>Data de Inicio</span> 
						<input type="text" name="ano-cat"
							placeholder="Ex:AAAA-MM-DD" class="col-sm-3 form-control" 
							required oninvalid="this.setCustomValidity('O campo é obrigatorio!')"
							oninput="setCustomValidity('')" /> 
						<br> 
						<span>Data limite</span>
						<input type="text" name="anof-cat" 
							placeholder="Ex:AAAA-MM-DD" class="col-sm-3 form-control" 
							required oninvalid="this.setCustomValidity('O campo é obrigatorio!')"
							oninput="setCustomValidity('')" /> 
						<br> 
						<button class="btn btn-primary" type="submit" value="FILTRAR"
							name="operacao">Filtrar</button>
						<p></p>
						<a class="btn btn-success" href="Graficos?operacao=DASHBOARD">Resetar</a>
						<br>
					</form>
				</div>
			</div>
			<br>
			<hr style="border-color: black">
			<br>
			<div style="display: flex; justify-content: space-around">
				<div style="width: 1400px">
					<canvas id="grafico2"></canvas>
				</div>
				<div style="padding-top: 100px; width: 200px">
					<form
						style="border-style: solid; border-width: 0.7px; border-radius: 5px;"
						action="Graficos" method="POST">
						<span><strong>Filtros</strong></span><br>
						<span>Data de Inicio</span> <input type="text" name="ano-prd"
							placeholder="Ex:AAAA-MM-DD" class="col-sm-3 form-control" required
							oninvalid="this.setCustomValidity('O campo é obrigatorio!')"
							oninput="setCustomValidity('')" /> <br>
						<span>Data Limite</span>
						<input type="text" name="anof-prd" placeholder="Ex:AAAA-MM-DD"
							class="col-sm-3 form-control" required
							oninvalid="this.setCustomValidity('O campo é obrigatorio!')"
							oninput="setCustomValidity('')" /> <br> 
						<button class="btn btn-primary" type="submit" value="FILTRAR"
							name="operacao">Filtrar</button>
						<p></p>
						<a class="btn btn-success" href="Graficos?operacao=DASHBOARD">Resetar</a>
						<br>
					</form>
				</div>
			</div>
			<script>
			//document.getElementById('grafico').html();
			//document.getElementById('grafico2').html();
			 var ctx = document.getElementById('grafico').getContext('2d');
			 var ctx2 = document.getElementById('grafico2').getContext('2d');
			 ctx.canvas.height = 120;
			 ctx2.canvas.height = 120;
			 
			 Chart.plugins.register({
					afterDraw: function(chart) {
				  	if (chart.data.datasets.length === 0) {
				    	// No data is present
				      var ctx = chart.chart.ctx;
				      var width = chart.chart.width;
				      var height = chart.chart.height
				      chart.clear();
				      
				      ctx.save();
				      ctx.textAlign = 'center';
				      ctx.textBaseline = 'middle';
				      ctx.font = "16px normal 'Helvetica Nueue'";
				      ctx.fillText('Não existem registros para o filtro escolhido!', width / 2, height / 2);
				      ctx.restore();
				    }
				  }
				});
			 
			 
			 var Grafico = new Chart(ctx, {
				 type: 'line',	
				 data: {
					 labels:[
						 <% 
						 	for(String prd : listaMesAno) {
						 		out.print("'");
						 		out.print(prd);
						 		out.print("', ");
						 	}
						 %>
					],
					 datasets: [
						<% 
							for(Map.Entry<String, LinkedHashMap<String, List<Integer>>> key : dadosPorMes.entrySet())  {
								 for(Map.Entry<String, List<Integer>> pair : key.getValue().entrySet()) {
									out.print("{");
									out.print("label: '" + pair.getKey() + " vendidos',");
									out.print("data:" + pair.getValue() + ",");
									out.print("borderWidth: 3,");
									Random randomGenerator = new Random();
									int R = randomGenerator.nextInt(255);
									int G = randomGenerator.nextInt(255);
									int B = randomGenerator.nextInt(255);
									out.print("borderColor: 'rgb(" + R + ", " + G + ", " + B + ")',");
									out.print("fill: false,");
									out.print("},");
									
								 }
							 }
					    %>
					 ]
				 },
				 options: {
					 	tooltips:{
					 		intersect: false,
					 	},
					 	hover:{
					 		mode:'nearest',
					 		intersect:true,
					 	},
					    scales: {
					      yAxes: [{
					        ticks: {
					          beginAtZero: true,
					          callback: function(value) {if (value % 1 === 0) {return value;}}
					        }
					      }]
					    },
				 		title:{
				 			display:true,
				 			text:"Quantidade de vendas por categoria",
				 			fontSize:18
				 		}
					  }
				 
			 });
			 
			 var Grafico2 = new Chart(ctx2, {
				 type: 'line',	
				 data: {
					 labels:[
						 <% 
						 	for(String prd2 : listaMesAno2) {
						 		out.print("'");
						 		out.print(prd2);
						 		out.print("', ");
						 	}
						 %>
					],
					 datasets: [
						<% 
							for(Map.Entry<String, LinkedHashMap<String, List<Integer>>> key2 : produtosPorMes.entrySet())  {
								 for(Map.Entry<String, List<Integer>> pair2 : key2.getValue().entrySet()) {
									out.print("{");
									out.print("label: '" + pair2.getKey() + " vendidos',");
									out.print("data:" + pair2.getValue() + ",");
									out.print("borderWidth: 3,");
									Random randomGenerator = new Random();
									int R = randomGenerator.nextInt(255);
									int G = randomGenerator.nextInt(255);
									int B = randomGenerator.nextInt(255);
									out.print("borderColor: 'rgb(" + R + ", " + G + ", " + B + ")',");
									out.print("fill: false,");
									out.print("},");
								
								 }
							 }
					    %>
					 ]
				 },
				 options: {
					 	tooltips:{
					 		intersect: false,
					 	},
					 	hover:{
					 		mode:'nearest',
					 		intersect:true,
					 	},
					    scales: {
					      yAxes: [{
					        ticks: {
					          beginAtZero: true,
					          callback: function(value) {if (value % 1 === 0) {return value;}}
					        }
					      }]
					    },
				 		title:{
				 			display:true,
				 			text:"Produtos mais vendidos",
				 			fontSize:18
				 		}
					  }
				 
			 });
			 
			 Grafico.update();
			 Grafico2.update();
			 </script>
			<!-- dashboard admin -->
			<!-- /row -->

		</div>
		<div class="loader-wrapper">
			<span class="loader"><span class="loader-inner"></span></span>
		</div>
	</div>
	<!-- /container -->
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

</body>

</html>