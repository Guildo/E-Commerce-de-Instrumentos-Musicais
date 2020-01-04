package controle.web.vh.impl;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import controle.web.vh.IViewHelper;
import core.aplicacao.Resultado;
import dominio.*;

public class ClienteViewHelper implements IViewHelper{

	@Override
	public EntidadeDominio getEntidade(HttpServletRequest request) {
		// TODO Auto-generated method stub
		String operacao = request.getParameter("operacao");
		Cliente cliente = new Cliente();
		Endereco endereco = new Endereco();
		
		System.out.println(operacao + " 2 ");
		
		try {
			cliente.setId(Integer.parseInt(request.getParameter("idusr")));
		} catch (Exception e) {
			
		}
		
		try {
			if(cliente.getId() == null) {
				cliente.setId(Integer.parseInt(request.getParameter("id_cliente")));
			}
		} catch(Exception e) {	
		}
		
		try {
			cliente.setNomeCliente(request.getParameter("nome_cliente"));
		} catch (Exception e) {
			
		}
		
		try {
			cliente.setEmailCliente(request.getParameter("email_cliente"));
		} catch (Exception e) {
			
		}
		
		try {
			cliente.setSenhaCliente(request.getParameter("senha_cliente"));
		} catch (Exception e) {
			
		}
		
		try {
			cliente.setSenha2Cliente(request.getParameter("conf_senha_cliente"));
		} catch (Exception e) {
			
		}
		
		try {
			cliente.setNovaSenhaCliente(request.getParameter("nova_senha_cliente"));
		} catch (Exception e) {
			
		}
		
		try {
			cliente.setTelefoneCliente(request.getParameter("telefone_cliente"));
		} catch (Exception e) {
			
		}
		
		try {
			cliente.setIsAdmin(Boolean.parseBoolean(request.getParameter("admin_cliente")));
		} catch (Exception e) {
			
		}
		
			cliente.setFlgAtivo(true);
		
		try {
			endereco.setId(Integer.parseInt(request.getParameter("id_endereco")));
		} catch (Exception e) {
			
		}
		
		try {
			endereco.setId(Integer.parseInt(request.getParameter("idEnd")));
		} catch (Exception e) {
			
		}
		
		try {
			endereco.setTipoResidencia(request.getParameter("tipo_residencia"));
		} catch (Exception e) {
			
		}
		
		try {
			endereco.setTipoLogradouro(request.getParameter("tipo_logradouro"));
		} catch (Exception e) {
			
		}
		
		try {
			endereco.setLogradouro(request.getParameter("logradouro"));
		} catch (Exception e) {
			
		}
		
		try {
			endereco.setNumero(request.getParameter("numero"));
		} catch (Exception e) {
			
		}
		
		try {
			endereco.setCidade(request.getParameter("cidade"));
		} catch (Exception e) {
			
		}
		
		try {
			endereco.setBairro(request.getParameter("bairro"));
		} catch (Exception e) {
			
		}
		
		try {
			endereco.setCEP(request.getParameter("cep"));
		} catch (Exception e) {
			
		}
		
		try {
			endereco.setEstado(request.getParameter("estado"));
		} catch (Exception e) {
			
		}
		
		try {
			endereco.setComplemento(request.getParameter("complemento"));
		} catch (Exception e) {
			
		}
		
		try {
			cliente.setEnderecos(new ArrayList<Endereco>());
			cliente.getEnderecos().add(endereco);
		} catch (Exception e) {
			
		}
		
		try {
			CupomTroca cupom = new CupomTroca();
			cliente.setCupons(new ArrayList<CupomTroca>());
			cupom.setId(Integer.parseInt(request.getParameter("id-cup")));
			cliente.getCupons().add(cupom);
		} catch (Exception e){
				
		}
		
		return cliente;
	}

	@Override
	public void setView(Resultado resultado, HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		// TODO Auto-generated method stub
		RequestDispatcher d = null;
		String target = "";
		String operacao = request.getParameter("operacao");
		System.out.println(operacao + " 3 ");
		//SALVAR
		if(resultado.getMsg() == null && operacao.equals("SALVAR")) {
			request.getSession().setAttribute("login", resultado);
			List<EntidadeDominio> ent = resultado.getEntidades();
			Cliente cli = (Cliente)ent.get(0);
			System.out.println(cli.getId() + "Tchuflak!!!");
			if(cli.getNomeCliente() == null)
				d = request.getRequestDispatcher("Cliente?idCli="+ cli.getId() +"&operacao=CONSULTAR");
			else
				d = request.getRequestDispatcher("Produtos?operacao=INDEX");
		}
		if(resultado.getMsg() != null && operacao.equals("SALVAR")) {
			request.getSession().setAttribute("cliente", resultado);
			d = request.getRequestDispatcher("cadastrar-cliente.jsp");
		}
		
		//LOGIN
		if(resultado.getMsg() == null && operacao.equals("LOGIN")) {
			request.getSession().setAttribute("login", resultado);
			List<EntidadeDominio> ent = resultado.getEntidades();
			Cliente cli = (Cliente)ent.get(0);
			System.out.println("VH Cliente - LOGIN - cartão: " + cli.getCartoes());
			System.out.println("VH Cliente - LOGIN - cupom: " + cli.getCupons());
			System.out.println("Frete: " + cli.getFrete());
			if(cli.getIsAdmin())
				d = request.getRequestDispatcher("Produtos?operacao=CONSULTAR");
			else
				d = request.getRequestDispatcher("Produtos?operacao=INDEX");
		}
		/*
		if(resultado.getMsg().equals("Cliente NÃO ATIVO!") && operacao.equals("LOGIN")) {
			request.getSession().setAttribute("cliente", resultado);
			d = request.getRequestDispatcher("ativar-cliente.jsp");
		}
		*/
		
		//ALTERAR
		if(resultado.getMsg() == null && operacao.equals("ALTERAR")) {
			request.getSession().setAttribute("resultado", resultado);
			d = request.getRequestDispatcher("usersession.jsp");
		}
		
		if(resultado.getMsg() != null && operacao.equals("ALTERAR")) {
			request.getSession().setAttribute("erro", resultado);
			d = request.getRequestDispatcher("cliente?operacao=CONSULTAR");
		}
		
		if(resultado.getMsg() == null && operacao.equals("ALTERAR-SENHA")) {
			request.getSession().setAttribute("resultado", resultado);
			d = request.getRequestDispatcher("senha-alterada.jsp");
		}
		
		if(resultado.getMsg() != null && operacao.equals("ALTERAR-SENHA")) {
			request.getSession().setAttribute("erro", resultado);
			d = request.getRequestDispatcher("User?operacao=CONSULTAR");
		}
		
		//CONSULTAR -> mostrar dados do cliente 
		if(resultado.getMsg() == null && operacao.equals("CONSULTAR")) {
			request.getSession().setAttribute("dadosUser", resultado);
			d = request.getRequestDispatcher("meus-dados.jsp");
		}
		if(resultado.getMsg() != null && operacao.equals("CONSULTAR")) {
			request.getSession().setAttribute("erro", resultado);
			d = request.getRequestDispatcher("erro.jsp");
		}
		
		//CONSULTAR-ENDERECO -> mostrar todos os endereços do cliente 
		/*if(resultado.getMsg() == null && operacao.equals("CONSULTAR-ENDERECO")) {
			request.getSession().setAttribute("cliente", resultado);
			d = request.getRequestDispatcher("visualizar-enderecos.jsp");
		}*/
		
		
		//VISUALIZAR -> tem a mesma função do CONSULTAR, porém é usado pra mostrar os dados na tela de alteração
		if(resultado.getMsg() == null && operacao.equals("VISUALIZAR")) {
			request.getSession().setAttribute("visualizar", resultado.getEntidades().get(0));
			try {
				target = request.getParameter("target");
				System.out.println(target);
			}catch (Exception e) {
				
			}
			
			if(target != null) {
				d = request.getRequestDispatcher(target);
			}else {
				d = request.getRequestDispatcher("alterar-endereco.jsp");
			}
		}
		
		if(resultado.getMsg() == null && operacao.equals("VISUALIZAR-ENDERECO")) {
			request.getSession().setAttribute("cliente", resultado);
			d = request.getRequestDispatcher("alterar-endereco.jsp");
		}
		
		if(resultado.getMsg() == null && operacao.equals("VISUALIZAR-SENHA")) {
			request.getSession().setAttribute("cliente", resultado);
			d = request.getRequestDispatcher("alterar-senha.jsp");
		}
		
		if(resultado.getMsg() == null && operacao.equals("EXCLUIR")) {
			request.getSession().setAttribute("userDesativado", resultado);
			d = request.getRequestDispatcher("conta-desativada.jsp");
		}
		
		if(resultado.getMsg() == null && operacao.equals("REFRESH")) {
			request.getSession().setAttribute("login", resultado);
			d = request.getRequestDispatcher("pedido-realizado.jsp");
		}
		
		if(resultado.getMsg() == null && operacao.equals("ENDSESSION")) {
			request.getSession().setAttribute("login", resultado);
			d = request.getRequestDispatcher("endereco-alterado.jsp");
		}
		
		if(resultado.getMsg() == null && operacao.equals("CARDSESSION")) {
			request.getSession().setAttribute("login", resultado);
			d = request.getRequestDispatcher("cartao-alterado.jsp");
		}
		
		if(resultado.getMsg() == null && operacao.equals("ATIVAR-CUPOM")) {
			request.getSession().setAttribute("resultado", resultado);
			d = request.getRequestDispatcher("cupsession.jsp");
		}
		
		if(resultado.getMsg() == null && operacao.equals("CUPSESSION")) {
			
			request.getSession().setAttribute("login", resultado);
			d = request.getRequestDispatcher("cupom-ativado.jsp");
		}
		
		if(resultado.getMsg() == null && operacao.equals("CONSULTAR-CUPONS")) {
			request.getSession().setAttribute("dadosUser", resultado);
			d = request.getRequestDispatcher("meus-cupons.jsp");
		}
		

		if(resultado.getMsg() == null && operacao.equals("USERSESSION")) {
			request.getSession().setAttribute("login", resultado);
			d = request.getRequestDispatcher("dados-user-alterados.jsp");
		}
		
		d.forward(request, response);
	}

}
