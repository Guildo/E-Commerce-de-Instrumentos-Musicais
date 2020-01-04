<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="core.aplicacao.Resultado"%>
<%@page import="dominio.*"%>
<%@page import="java.util.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Cadastro Cartão de Crédito</title>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="description" content="OneTech shop project">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link type="text/css" rel="stylesheet" href="css/bootstrap.min.css" />
<link rel="stylesheet" type="text/css" href="styles/bootstrap4/bootstrap.min.css">
<link href="plugins/fontawesome-free-5.0.1/css/fontawesome-all.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" type="text/css" href="plugins/OwlCarousel2-2.2.1/owl.carousel.css">
<link rel="stylesheet" type="text/css" href="plugins/OwlCarousel2-2.2.1/owl.theme.default.css">
<link rel="stylesheet" type="text/css" href="plugins/OwlCarousel2-2.2.1/animate.css">
<link rel="stylesheet" type="text/css" href="plugins/slick-1.8.0/slick.css">
<link rel="stylesheet" type="text/css" href="styles/main_styles.css">
<link rel="stylesheet" type="text/css" href="styles/responsive.css">
</head>
<body>
	<%
			Resultado resultado = (Resultado) session.getAttribute("login");
			List<EntidadeDominio> Cli = resultado.getEntidades();
			
			Cliente cliente = (Cliente)Cli.get(0);

			StringBuilder sb;
			
	%>
	<div class="section">
		<!-- container -->
		<div class="container" style="text-align: center">
			<!-- row -->
			<!-- dashboard admin -->
			<div style="text-align: center">
				<form id="form" action="Cliente" method="post" class="form-horizontal">
					<section class="panel">
						<header class="panel-heading" style="padding-right:200px">
							<h2 class="panel-title">Digite os dados de seu Cartão de crédito</h2>							
						</header>
							<div class="form-group">
								<div class="col-sm-6">
									<%
									sb = new StringBuilder();
									sb.append("<input id='id' type='hidden' name='idCli' value='"+cliente.getId()+"'/>");
									out.print(sb.toString());
									%>
								</div>
							</div>
						<div class="panel-body">												
							<!-- Estado -->
							<div class="form-group">
								<label class="col-sm-3 control-label">Nome impresso no cartão <span class="required">*</span></label>
								<div class="col-sm-4">
									<input type="text" id="nomeCart" name="nome_cartao" class="col-sm-10 form-control" required oninvalid="this.setCustomValidity('O campo valor é obrigatorio!')" oninput="setCustomValidity('')"/>
								</div>
							</div>
							<!-- Cidade -->
							<div class="form-group">
								<label class="col-sm-3 control-label">Número do cartão <span class="required">*</span></label>
								<div class="col-sm-4">
									<input type="text" id="numeroCart" name="numero_cartao" class="col-sm-10 form-control" required oninvalid="this.setCustomValidity('O campo valor é obrigatorio!')" oninput="setCustomValidity('')"/>
								</div>
							</div>
						
							<!-- Bairro -->
							<div class="form-group">
								<label class="col-sm-3 control-label">Bandeira do cartão <span class="required">*</span></label>
								<div class="col-sm-4">
									<input type="text" id="bandeiraCart" name="bandeira_cartao" class="col-sm-10 form-control" required oninvalid="this.setCustomValidity('O campo valor é obrigatorio!')" oninput="setCustomValidity('')"/>
								</div>
							</div>
							<!-- CEP -->
							<div class="form-group">
								<label class="col-sm-3 control-label">Data de validade <span class="required">*</span></label>
								<div class="col-sm-4">
									<input type="text" id="validadeCart" name="validade_cartao" class="col-sm-10 form-control" maxlength='10' placeholder="Ex: 01/01/2019" required oninvalid="this.setCustomValidity('O campo valor é obrigatorio!')" oninput="setCustomValidity('')"/>
								</div>
							</div>
							<!-- Complemento -->
							<div class="form-group">
								<label class="col-sm-3 control-label">CVV </label>
								<div class="col-sm-4">
									<input type="text" id="cvv" name="cvv_cartao" class="col-sm-10 form-control" oninput="setCustomValidity('')"/>
								</div>
							</div>
								
						</div>
						<footer class="panel-footer">
							<div class="row" style="padding-left:100px">
								<div class="col-sm-9 col-sm-offset-3">
									<button type="submit" name="operacao" value="SALVAR" class="btn btn-primary">Cadastrar Novo cartão de crédito</button>
									<button style="background-color:grey; color:white" type="reset" class="btn btn-default">Resetar campos</button>
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
</body>
</html>