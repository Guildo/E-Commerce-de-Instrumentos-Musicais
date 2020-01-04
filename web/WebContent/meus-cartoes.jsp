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
	//recebendo dados de endereços
	Resultado cartao = (Resultado)session.getAttribute("dadosCartao");	
	if(session.getAttribute("dadosCartao")==null){
		pageContext.forward("User?operacao=CONSULTAR");
	}
	
	try{
		Resultado resultProdutos = (Resultado)session.getAttribute("erro");
		erro = resultProdutos.getMsg().trim();
		session.removeAttribute("erro");
	} catch (Exception e){
		
	}
	
	List<EntidadeDominio> cartoes = cartao.getEntidades();
	Cartao card;
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
	if(error==0){
		List<EntidadeDominio> user = login.getEntidades();
		Cliente us = (Cliente)user.get(0);
		nomeUser = us.getNomeCliente();
		id = us.getId();
	}
	StringBuilder sb = new StringBuilder();
	
	try{
		Cartao card2 = (Cartao)cartoes.get(0);
	} catch (Exception e){
		cartoes = null;
	}	
	
	int id2 = 0;
	int idcard1 = 0;
	int idcard2 = 0;
	String mes1 = null;
	String mes2 = null;
	/* sb = new StringBuilder();
	sb.append(us.getNome_usuario());
	sb.append(us.getEnderecos().get(0).getRua());
out.print(sb.toString()); */
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
				<p><strong>PARA EFETUAR COMPRAS EM NOSSO SITE, VOCE DEVE TER NO MINIMO 1 CARTAO DE CREDITO CADASTRADO</strong></p>
				<a href="Cliente?operacao=CONSULTAR" class="primary-btn">Voltar</a>
					</div>
					<%
					if(cartoes!=null){
						for(EntidadeDominio e: cartoes){
						card = (Cartao)e;
						
						out.print("<div class='col-md-4 col-md-offset-1' style='width: 38%' >");//1
						out.print("<div class='billing-details'>");//2
								out.print("<div class='section-title'>");//3
								if(id2==0){
									idcard1 = card.getId();
									mes1 = card.getMes_cartao();
									out.print("<h3 class='title'>Cartão 1</h3>");
									out.print("</div>");//3
									out.print("<form id='cartao1' action='Cartoes' method='POST'>");
								} else {
									idcard2 = card.getId();
									mes2 = card.getMes_cartao();
									out.print("<h3 class='title'>Cartão 2</h3>");
									out.print("<form id='cartao2' action='Cartoes' method='POST'>");
									out.print("</div>");//3
								}
								out.print("<div class='form-group'>");//4
									out.print("<input type='hidden' name='id-usuario' value='"+id+"'/>");
									out.print("<input type='hidden' value='"+card.getId()+"' name='id-cartao'/>");
								out.print("</div>");//4
								
								out.print("<p><strong>Nome impresso no cartão:</strong><input id='nome' value='"+card.getNome_cartao()+"' name='nome-cartao' class='input' type='text' /></p>");
							        out.print("<p><strong>Número do cartão:</strong></p>");
									out.print("<div style='display:flex; justify-content:space-between'>");//5
									out.print("<input style='width:250px' id='numero' value='"+card.getNumero_cartao()+"' name='numero-cartao' maxlength='16' onkeyup='Carta1(this.value, "+id2+")' onkeydown='Carta1(this.value, "+id2+")' class='input' type=text />");
									if(card.getId_bandeira_cartao()==1){
										out.print("<i id='icone-cartao"+id2+"' class='fab fa-cc-mastercard fa-3x'></i>");
									} else if(card.getId_bandeira_cartao()==2){
										out.print("<i id='icone-cartao"+id2+"' class='fab fa-cc-visa fa-3x'></i>");
									} else if(card.getId_bandeira_cartao()==3){
										out.print("<i id='icone-cartao"+id2+"' class='fab fa-cc-diners-club fa-3x'></i>");
									} else if(card.getId_bandeira_cartao()==4){
										out.print("<i id='icone-cartao"+id2+"' class='fab fa-cc-jcb fa-3x'></i>");
									} else if(card.getId_bandeira_cartao()==5){
										out.print("<i id='icone-cartao"+id2+"' class='fab fa-cc-discover fa-3x'></i>");
									} else if(card.getId_bandeira_cartao()==6){
										out.print("<i id='icone-cartao"+id2+"' class='fab fa-cc-amex fa-3x'></i>");
									}
									out.print("<input type='hidden' id='bandeira"+id2+"' name='id-bandeira' value='"+card.getId_bandeira_cartao()+"' />");
									out.print("</div>");//5
									out.print("<br>");
									out.print("<p><strong>Data de validade</strong></p>");
									out.print("<div style='display:flex; justify-content:space-between'>");//6
									out.print("<p><strong>Mes: </strong>");
									out.print("<select style='width:80px' name='mes-validade' id='mes"+card.getId()+"' placeholder='"+card.getMes_cartao()+"' class='input' required oninvalid='this.setCustomValidity('O campo é obrigatório!')' oninput='setCustomValidity('')'>");
									out.print("<option value=''>Mes</option>");
									out.print("<option value='01'>01</option>");
									out.print("<option value='02'>02</option>");
									out.print("<option value='03'>03</option>");
									out.print("<option value='04'>04</option>");
									out.print("<option value='05'>05</option>");
									out.print("<option value='06'>06</option>");
									out.print("<option value='07'>07</option>");
									out.print("<option value='08'>08</option>");
									out.print("<option value='09'>09</option>");
									out.print("<option value='10'>10</option>");
									out.print("<option value='11'>11</option>");
									out.print("<option value='12'>12</option>");
									out.print("</select></p>");
									out.print("<p><strong>Ano: </strong>");
									out.print("<input style='width:120px' id='ano' maxlength='4' value='"+card.getAno_cartao()+"' placeholder='Ex: 2022' name='ano-validade' class='input' type='text' /></p>");
									out.print("</div>");//6
									out.print("<div style='display:flex; justify-content:space-around'>");//7
									out.print("<p style='padding-right:20px' ><strong>CVV: </strong>");
									out.print("<input style='width:80px' id='cvv' value='"+card.getCvv_cartao()+"' name='cvv-cartao' class='input' type='text' /></p>");
									out.print("</div><br>");//7
	                                
						out.print("<div style='display:flex; justify-content:space-around'>");//8
						out.print("<div style='text-align:center' class='form-group'>");//9
							out.print("<button class='primary-btn' type='submit' name='operacao' value='ALTERAR'>Alterar dados</button>");
							out.print("</div>");//9
						out.print("</div>");//8
						out.print("</form>");
					out.print("</div>");//2
					out.print("<div style='text-align:center' class='form-group'>");//10
					out.print("<button name='exc' style='background-color:red' class='primary-btn' data-toggle='modal' data-target='#Excluir"+id2+"'>Excluir Cartão</button>");
					out.print("</div>");//10
					out.print("</div>");//1
			id2++;
					}
				} else {
					out.print("<div class='col-md-4 col-md-offset-4'>");
					out.print("<div class='billing-details'>");
							out.print("<div class='section-title'>");
								out.print("<h3 class='title'>Cadastrar cartões</h3>");
								out.print("</div>");
								out.print("<div style='display:flex; justify-content:space-around'>");
								out.print("<p><strong>Você ainda não tem nenhum cartão cadastrado!</strong></p>");
								out.print("</div>");
								out.print("<form id='CadCard' action='Cartoes' method='POST'>");
						        out.print("<p>Caso queira cadastrar um agora, confirme os dados abaixo!</p>");
						        out.print("<input type='hidden' name='id-usuario' value='"+id+"'/>");
						        out.print("<p><strong>Nome impresso no cartão:</strong><input id='nome' name='nome-cartao' class='input' type='text' /></p>");
						        out.print("<p><strong>Número do cartão:</strong></p>");
								out.print("<div style='display:flex; justify-content:space-between'>");
								out.print("<input style='width:250px' id='numero' name='numero-cartao' maxlength='16' onkeyup='Carta1(this.value, 3)' onkeydown='Carta1(this.value, 3)' class='input' type=text /><i id='icone-cartao3' class='fas fa-credit-card fa-3x'></i>");
								out.print("<input type='hidden' id='bandeira3' name='id-bandeira' value='0' />");
								out.print("</div>");
								out.print("<br>");
								out.print("<p><strong>Data de validade</strong></p>");
								out.print("<div style='display:flex; justify-content:space-between'>");
								out.print("<p><strong>Mes: </strong>");
								out.print("<select style='width:80px' name='mes-validade' id='mes' class='input' required oninvalid='this.setCustomValidity('O campo é obrigatório!')' oninput='setCustomValidity('')'>");
								out.print("<option value=''>Mes</option>");
								out.print("<option value='01'>01</option>");
								out.print("<option value='02'>02</option>");
								out.print("<option value='03'>03</option>");
								out.print("<option value='04'>04</option>");
								out.print("<option value='05'>05</option>");
								out.print("<option value='06'>06</option>");
								out.print("<option value='07'>07</option>");
								out.print("<option value='08'>08</option>");
								out.print("<option value='09'>09</option>");
								out.print("<option value='10'>10</option>");
								out.print("<option value='11'>11</option>");
								out.print("<option value='12'>12</option>");
								out.print("</select></p>");
								out.print("<p><strong>Ano: </strong>");
								out.print("<input style='width:120px' id='ano' maxlength='4' placeholder='Ex: 2022' name='ano-validade' class='input' type='text' /></p>");
								out.print("</div>");
								out.print("<div style='display:flex; justify-content:space-around'>");
								out.print("<p style='padding-right:20px' ><strong>CVV: </strong>");
								out.print("<input style='width:80px' id='cvv' name='cvv-cartao' class='input' type='text' /></p>");
								out.print("</div><br>");
						        	out.print("<div style='text-align:center' class='form-group'>");
						       			out.print("<button id='cad1' type='submit' name='operacao' value='SALVAR' class='primary-btn'>Cadastrar</button>");
						       		 out.print("</div>");
						       out.print("</form>");
								out.print("</div>");
							out.print("</div>");
							out.print("</div>");
				}
					if(id2==1){
						out.print("<div class='col-md-4 col-md-offset-1' style='width: 38%'>");
						out.print("<div class='billing-details'>");
								out.print("<div class='section-title'>");
									out.print("<h3 class='title'>Cadastrar Cartão</h3>");
									out.print("</div><br><br>");
									out.print("<div style='display:flex; justify-content:space-around'>");
									out.print("<p><strong>Você ainda pode cadastrar um segundo cartão!</strong></p>");
									out.print("</div>");
									out.print("<div style='display:flex; justify-content:space-around'>");
									out.print("<button id='maisum' name='cad' class='primary-btn' data-toggle='modal' data-target='#Cadastrar'>Cadastrar mais um cartão</button>");
									out.print("</div>");
									out.print("</div>");
								out.print("</div>");
								out.print("</div>");
					}
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
			
	<div class="modal fade" id="Cadastrar" role="dialog">
    <div class="modal-dialog">
    
      <!-- Modal content-->
     <div style="background-color:white" class="col-md-7 col-md-offset-2">
		<div class="billing-details">
			<div class="section-title">
			<h3 class="title">Cadastrar cartão</h3>
        </div>
        <form id="CadCard" action="Cartoes" method="POST">
          <p>Confirme os dados do cartão</p>
          <input type="hidden" name="id-usuario" value="<%out.print(id);%>"/>
         	 <p><strong>Nome impresso no cartão:</strong><input id="nome-modal" name="nome-cartao" class="input" type="text" /></p>
           	<p><strong>Número do cartão:</strong></p>
			<div style="display:flex; justify-content:space-between">
			<input style="width:250px" id="numero-modal" maxlength="16" onkeyup="Carta1(this.value, 4)" onkeydown="Carta1(this.value, 4)" name="numero-cartao" class="input" type=text /><i id="icone-cartao4" class="fas fa-credit-card fa-3x"></i>
			<input type="hidden" id="bandeira4" name="id-bandeira" value="0" />
			</div>
			<br>
			<p><strong>Data de validade</strong></p>
			<div style="display:flex; justify-content:space-between">
			<p><strong>Mes:</strong>
			<select style="width:80px" name="mes-validade" id="mes-modal" class="input" required oninvalid="this.setCustomValidity('O campo é obrigatório!')" oninput="setCustomValidity('')">
				<option value=''>Mes</option>
				<option value='01'>01</option>
				<option value='02'>02</option>
				<option value='03'>03</option>
				<option value='04'>04</option>
				<option value='05'>05</option>
				<option value='06'>06</option>
				<option value='07'>07</option>
				<option value='08'>08</option>
				<option value='09'>09</option>
				<option value='10'>10</option>
				<option value='11'>11</option>
				<option value='12'>12</option>
			</select>
			</p>
			<p><strong>Ano:</strong>
			<input style="width:120px" id="ano-modal" maxlength="4" name="ano-validade" class="input" type="text" /></p>
			</div>
			<div style="display:flex; justify-content:space-around">
			<p style="padding-right:20px" ><strong>CVV</strong>
			<input style="width:80px" id="cvv-modal" name="cvv-cartao" class="input" type="text" /></p>
			</div>
        	<div class="form-group">
       			<button id="cad2" type="submit" name="operacao" value="SALVAR" class="primary-btn">Cadastrar</button>
         		<button style="background-color:gray" type="button" class="primary-btn" data-dismiss="modal">Fechar</button>
       		 </div>
        </form>
        </div>
      </div>
    </div>
  </div>
  
  <div class="modal fade" id="Excluir0" role="dialog">
    <div class="modal-dialog">
    
      <!-- Modal content-->
      <div style="background-color:white" class="col-md-6 col-md-offset-3">
		<div class="billing-details">
			<div class="section-title">
			<h3 class="title">Confirmar exclusão</h3>
       		</div>
          <p>Deseja mesmo excluir esse cartão?</p>
           <p>Após a exclusão, a única forma de voltar a usar este cartão é cadastrando novamente...</p>
           <br>
        <div class="form-group">
       		<a name="exclu1" href="Cartoes?id-cartao=<%out.print(idcard1);%>&operacao=EXCLUIR" class="primary-btn">Sim, quero excluir</a>
          <button style="background-color:gray" type="button" class="primary-btn" data-dismiss="modal">Fechar</button>
        </div>
      </div>
      </div>
    </div>
  </div>
  
  <div class="modal fade" id="Excluir1" role="dialog">
    <div class="modal-dialog">
    
      <!-- Modal content-->
      <div style="background-color:white" class="col-md-6 col-md-offset-3">
		<div class="billing-details">
			<div class="section-title">
			<h3 class="title">Confirmar exclusão</h3>
       		</div>
          <p>Deseja mesmo excluir esse cartão?</p>
           <p>Após a exclusão, a única forma de voltar a usar este cartão é cadastrando novamente...</p>
           <br>
        <div class="form-group">
       		<a name="exclu12" href="Cartoes?id-cartao=<%out.print(idcard2);%>&operacao=EXCLUIR" class="primary-btn">Sim, quero excluir</a>
          <button style="background-color:gray" type="button" class="primary-btn" data-dismiss="modal">Fechar</button>
        </div>
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
	
<script type="text/javascript">
function Carta1(number, number2)
{
    // visa
    var re = new RegExp("^4");
    if (number.match(re) != null){
    	document.getElementById("icone-cartao"+number2).className = "fab fa-cc-visa fa-3x";
    	document.getElementById("bandeira"+number2).value = "2";
    }
    // Mastercard 
    // Updated for Mastercard 2017 BINs expansion
    re = new RegExp("^5[1-5]");
     if (number.match(re)!= null){
    	 document.getElementById("icone-cartao"+number2).className = "fab fa-cc-mastercard fa-3x";
    	 document.getElementById("bandeira"+number2).value = "1";
     }
    // AMEX
    re = new RegExp("^3[47]");
    if (number.match(re) != null){
    	document.getElementById("icone-cartao"+number2).className = "fab fa-cc-amex fa-3x";
    	document.getElementById("bandeira"+number2).value = "6";
    }
    // Discover
    re = new RegExp("^(6011|622(12[6-9]|1[3-9][0-9]|[2-8][0-9]{2}|9[0-1][0-9]|92[0-5]|64[4-9])|65)");
    if (number.match(re) != null){
    	document.getElementById("icone-cartao"+number2).className = "fab fa-cc-discover fa-3x";
    	document.getElementById("bandeira"+number2).value = "5";
    }
    
    // Diners
    re = new RegExp("^36");
    if (number.match(re) != null){
    	document.getElementById("icone-cartao"+number2).className = "fab fa-cc-diners-club fa-3x";
    	document.getElementById("bandeira"+number2).value = "3";
    }
    // JCB
    re = new RegExp("^35(2[89]|[3-8][0-9])");
    if (number.match(re) != null){
    	document.getElementById("icone-cartao"+number2).className = "fab fa-cc-jcb fa-3x";
    	document.getElementById("bandeira"+number2).value = "4";
    }
   
    re = new RegExp("\b[1-9]\b");
    if(number === "" || number.match(re)){
    	document.getElementById("icone-cartao"+number2).className = "fas fa-credit-card fa-3x";
    	document.getElementById("bandeira"+number2).value = "0";
    }
    
    return "";
}
</script>

<script type="text/javascript">
$(document).ready(function(){
	var id1 = "<%=idcard1%>";
	var id2 = "<%=idcard2%>";
	var est1 = "<%=mes1%>";
	var est2 = "<%=mes2%>";
	if(id1 != 0 || est1 != null){
		if(est1>9){
			document.getElementById("mes"+id1).value = est1;
		}else{
			document.getElementById("mes"+id1).value = "0"+est1;
		}
		}
	if(id2 != 0 && est2 != null){
		if(est2>9){
			document.getElementById("mes"+id2).value = est2;
		}else{
			document.getElementById("mes"+id2).value = "0"+est2;	
		}
	}
});
</script>
</body>
</html>