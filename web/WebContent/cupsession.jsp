<%@page import="core.aplicacao.Resultado"%>
<%@page import="dominio.Cliente"%>
<%@page import="dominio.EntidadeDominio"%>
<%@page import="java.util.*"%>
<!DOCTYPE html>
<html lang="en">

<head>
<%
int erro = 0;
Resultado login = (Resultado) session.getAttribute("login");
	try{
		List<EntidadeDominio> user = login.getEntidades();
	} catch (Exception e){
		erro = 1;
	}
	
	int id = 0;
	String nomeUser = "";
	if(erro==0){
		List<EntidadeDominio> user = login.getEntidades();
		Cliente us = (Cliente)user.get(0);
		nomeUser = us.getNomeCliente();
		id = us.getId();
	}
	
%>

<body onload="refresh()">
	

	

</body>
<script type="text/javascript">
	function refresh(){
		var value = "<%=id%>";
			window.location.href = "Cliente?idusr="+value+"&operacao=CUPSESSION";
	}
	</script>

</html>