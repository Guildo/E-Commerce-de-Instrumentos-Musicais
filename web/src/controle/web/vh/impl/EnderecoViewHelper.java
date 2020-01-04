package controle.web.vh.impl;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import controle.web.vh.IViewHelper;
import core.aplicacao.Resultado;
import dominio.Endereco;
import dominio.EntidadeDominio;

public class EnderecoViewHelper implements IViewHelper {

	public EntidadeDominio getEntidade(HttpServletRequest request) {
		Endereco endereco = new Endereco();
		String operacao = request.getParameter("operacao");
		System.out.println("ENTROU NA VH endereco");
		try {
			endereco.setIdCliente(Integer.parseInt(request.getParameter("idusr")));
		} catch (Exception e){
				
				}
		
		try {
			//endereco.setEndereco_cobranca(Boolean.parseBoolean(request.getParameter("end-cobranca")));
		} catch (Exception e){
				
		}
		
		try {
			endereco.setIdCliente(Integer.parseInt(request.getParameter("id-usuario")));
		} catch (Exception e){
				
		}
		
		try {
			endereco.setId(Integer.parseInt(request.getParameter("id-endereco")));
		} catch (Exception e){
				
		}	
		
		try {
			endereco.setTipoResidencia(request.getParameter("tipo_residencia"));
		} catch (Exception e){
				
		}
		
		try {
			endereco.setTipoLogradouro(request.getParameter("tipo_logradouro"));
		} catch (Exception e){
				
		}
		
		try {
			endereco.setLogradouro(request.getParameter("logradouro"));
		} catch (Exception e){
				
		}
		
		try {
			endereco.setCEP(request.getParameter("cep"));
		} catch (Exception e){
				
		}
		try {
			endereco.setBairro(request.getParameter("bairro"));
		} catch (Exception e){
				
		}
		try {
			endereco.setCidade(request.getParameter("cidade"));
		} catch (Exception e){
				
		}
		try {
			endereco.setEstado(request.getParameter("uf"));
		} catch (Exception e){
				
		}
		try {
			endereco.setNumero(request.getParameter("numero"));
		} catch (Exception e){
				
		}
		try {
			endereco.setComplemento(request.getParameter("complemento"));
		} catch (Exception e){
				
		}
		
		try {
			endereco.setPagina(request.getParameter("pagina"));
			System.out.println("Página: " + endereco.getPagina());
		} catch (Exception e){
				
		}
		
		
		System.out.println(endereco.getNumero());
	return endereco;
}

	@Override
	public void setView(Resultado resultado, HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		RequestDispatcher rdisp = null;

		String operacao = request.getParameter("operacao");
		
		//consultar
		if(resultado.getMsg() == null && operacao.equals("CONSULTAR")) {
			request.getSession().setAttribute("dadosEndereco", resultado);
			rdisp = request.getRequestDispatcher("meus-enderecos.jsp");
		}
		
		//alterar
		if(resultado.getMsg() == null && operacao.equals("ALTERAR")) {
			request.getSession().setAttribute("resultado", resultado);
			rdisp = request.getRequestDispatcher("endsession.jsp");
		}
		//alterar
		if(resultado.getMsg() != null && operacao.equals("ALTERAR")) {
			request.getSession().setAttribute("erro", resultado);
			rdisp = request.getRequestDispatcher("Enderecos?operacao=CONSULTAR");
		}
		
		//excluir
		if(resultado.getMsg() == null && operacao.equals("EXCLUIR")) {
			request.getSession().setAttribute("resultado", resultado);
			rdisp = request.getRequestDispatcher("endsession.jsp");
		}
				
		//salvar
		if(resultado.getMsg() == null && operacao.equals("SALVAR")) {
			request.getSession().setAttribute("resultado", resultado);
			rdisp = request.getRequestDispatcher("endsession.jsp");
		}
		//salvar
		if(resultado.getMsg() != null && operacao.equals("SALVAR")) {
			request.getSession().setAttribute("erro", resultado);
			rdisp = request.getRequestDispatcher("Enderecos?operacao=CONSULTAR");
		}
		
		rdisp.forward(request, response);
	}
}