<%@page import="core.aplicacao.Resultado"%>
<%@page import="dominio.*"%>
<%@page import="auxiliar.DadosDeCadastro"%>
<%@page import="java.util.*"%>
<html>
<head>
<link rel="stylesheet" href="css/bootstrap.min.css" />
<link href="https://fonts.googleapis.com/css?family=Hind:400,700" rel="stylesheet">
<!-- Font Awesome Icon -->
	<link rel="stylesheet" href="css/font-awesome.min.css">

	<!-- Custom stlylesheet -->
	<link type="text/css" rel="stylesheet" href="css/style.css" />
</head>
<body>		
			<div style="text-align:center; padding-top:10px">
            <h1 class="title_text">Login</h1>                
                <form id="login" action="Cliente" class="form-horizontal form-signin" method="post">

              	<div class="form-group" style="padding-left:200px">
				<label class="col-sm-3 control-label">Email<span class="required">*</span></label>
				<div class="col-sm-4">
					<input style="background-color:white" type="text" name="email_cliente" class="input" placeholder="Ex:abc@gmail.com" required oninvalid="this.setCustomValidity('O campo é obrigatório!')" oninput="setCustomValidity('')"/>
				</div>
				</div>
			
				<div class="form-group" style="padding-left:200px">
				<label class="col-sm-3 control-label">Senha<span class="required">*</span></label>
				<div class="col-sm-4">
					<input style="background-color:white" type="password" name="senha_cliente" placeholder="Digite sua senha..." class="input" required oninvalid="this.setCustomValidity('O campo é obrigatório!')" oninput="setCustomValidity('')"/>
				</div>
				</div>
				
				<div class="form-group"><br>
					<div>
						<button  type="submit" name="operacao" value="LOGIN" class="primary-btn">Entrar</button>
						<a style="color:white" class="primary-btn" href="pag-inicial-cliente.jsp">Cancelar</a>
					</div>
				</div>                
					</form>
					<div><span>Não possui uma conta? Cadastre-se!</span>
					<div><a style="color:white" class="primary-btn" href="cadastrar-cliente.jsp">Cadastrar!</a></div>
					</div>
        </div>
 <script type="text/javascript">
</script>
</body>
</html>