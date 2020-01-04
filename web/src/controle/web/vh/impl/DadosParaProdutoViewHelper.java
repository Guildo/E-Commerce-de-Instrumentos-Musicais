package controle.web.vh.impl;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import controle.web.vh.IViewHelper;
import core.aplicacao.Resultado;
import auxiliar.DadosDeCadastro;
import dominio.EntidadeDominio;

public class DadosParaProdutoViewHelper implements IViewHelper{

	@Override
	public EntidadeDominio getEntidade(HttpServletRequest request) {
		// TODO Auto-generated method stub
		DadosDeCadastro dadosProduto = new DadosDeCadastro();
		return dadosProduto;
	} 

	@Override
	public void setView(Resultado resultado, HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		RequestDispatcher d = null;
		DadosDeCadastro dt = new DadosDeCadastro();
		String operacao = request.getParameter("editar");
		if(operacao.equals("1")) {
			request.getSession().setAttribute("dados", resultado);
			dt = (DadosDeCadastro)resultado.getEntidades().get(0);
			d = request.getRequestDispatcher("alterar-produto-admin.jsp");
		}
		else {
			request.getSession().setAttribute("dados", resultado);
			dt = (DadosDeCadastro)resultado.getEntidades().get(0);
			d = request.getRequestDispatcher("cadastrar-produto.jsp");
		}
		d.forward(request, response);	
	}
}