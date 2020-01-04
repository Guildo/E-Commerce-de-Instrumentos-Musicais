package controle.web.vh.impl;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import controle.web.vh.IViewHelper;
import core.aplicacao.Resultado;
import dominio.*;

public class ProdutoViewHelper implements IViewHelper{

	@Override
	public EntidadeDominio getEntidade(HttpServletRequest request) {
		// TODO Auto-generated method stub
		String operacao = request.getParameter("operacao");
		System.out.println("entrou na viewhelper" + operacao);
		Produto produto = new Produto();
		Categoria categoria = new Categoria();
		
		try {
			if(produto.getId() == null) {
				produto.setId(Integer.parseInt(request.getParameter("id-produto")));
			}
		} catch(Exception e) {	
		}
		
		try {
			produto.setId(Integer.parseInt(request.getParameter("idprd")));
		} catch(Exception e) {
			
		}
		
		try {
			produto.setModeloProduto(request.getParameter("modelo-produto"));
		}catch(Exception e) {
			
		}
		
		try {
			produto.setMarcaProduto(request.getParameter("marca-produto"));
		}catch(Exception e) {
			
		}
		
		try {
			produto.setCorProduto(request.getParameter("cor-produto"));
		}catch(Exception e) {
			
		}
		
		try {
			produto.setPrecoUnitario(Double.parseDouble(request.getParameter("valor-produto")));
		}catch(Exception e) {
			
		}
		
		try {
			categoria.setId(Integer.parseInt(request.getParameter("categoria-produto")));
		}catch(Exception e) {
			
		}
		
		try {
			produto.setImagemProduto(request.getParameter("img-produto"));
		}catch(Exception e) {
			
		}
		
		try {
			produto.setMotivoDesativacao(request.getParameter("motivo-desativacao-produto"));
			System.out.println("ProdutoVH - motivo desativação: " + produto.getMotivoDesativacao());
		}catch(Exception e) {
			
		}
		
		try {
			produto.setMotivoAtivacao(request.getParameter("motivo-ativacao-produto"));
		}catch(Exception e) {
			
		}
		
		try {
			produto.setQtd_estoque(Integer.parseInt(request.getParameter("qtd-estoque")));
		} catch(Exception e) {
			
		}
		
		try {
			produto.setCategoria(categoria);
		}catch(Exception e) {
			
		}
		return produto;
	}

	@Override
	public void setView(Resultado resultado, HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		RequestDispatcher d = null;
		String operacao = request.getParameter("operacao");
		System.out.println(operacao);
		// salvar
		if(resultado.getMsg() == null && operacao.equals("SALVAR")) {						
			request.getSession().setAttribute("produto", resultado);
			d = request.getRequestDispatcher("produto-cadastrado.jsp");
		}
		
		if(resultado.getMsg() != null && operacao.equals("SALVAR")) {						
			request.getSession().setAttribute("produto", resultado);
			d = request.getRequestDispatcher("Dadosproduto?operacao=CONSULTAR&editar=0");
		}
				
		// excluir
		if(resultado.getMsg() == null && operacao.equals("EXCLUIR")) {
			request.getSession().setAttribute("produto", resultado);
			d = request.getRequestDispatcher("produto-desativado.jsp");
		}
		
		if(resultado.getMsg() != null && operacao.equals("EXCLUIR")) {
			request.getSession().setAttribute("produto", resultado);
			d = request.getRequestDispatcher("produto?operacao=CONSULTAR");
		}
		
		//ativar
		if(resultado.getMsg() == null && operacao.equals("ATIVAR")) {
			request.getSession().setAttribute("produto", resultado);
			d = request.getRequestDispatcher("produto-ativado.jsp");
		}
		
		if(resultado.getMsg() != null && operacao.equals("ATIVAR")) {
			request.getSession().setAttribute("produto", resultado);
			d = request.getRequestDispatcher("produto?operacao=CONSULTAR");
		}
		
		//alterar
		if(resultado.getMsg() == null && operacao.equals("ALTERAR")) {
			request.getSession().setAttribute("produto", resultado);
			d = request.getRequestDispatcher("produto-alterado.jsp");
		}
		
		if(resultado.getMsg() != null && operacao.equals("ALTERAR")) {
			System.out.println("Entro no setView ALTERAR");
			request.getSession().setAttribute("mensagem", resultado);
			String id = resultado.getMsg();
			String erro = resultado.getMsg();
			System.out.println(id + " / " + erro);
			id = id.replaceAll("\\D+", "");
			erro = erro.replaceAll("[^A-Za-z]", " ");
			System.out.println(id + " / " + erro);
			resultado.setMsg(erro);
			
			d = request.getRequestDispatcher("Dadosproduto?idCap="+id+"&operacao=CONSULTAR&editar=1");
		}
		
		if(resultado.getMsg() == null && operacao.equals("INDEX")) {
			System.out.println("Entrou na setview");
			request.getSession().setAttribute("produtos", resultado);
			
			d = request.getRequestDispatcher("pag-inicial-clienteLogado.jsp");
		}
		
		// consultar
		if(resultado.getMsg() == null && operacao.equals("CONSULTAR")) {
			System.out.println("Entrou no setView CONSULTAR");
			request.getSession().setAttribute("produto", resultado);
			d = request.getRequestDispatcher("admin-visualizar-produto.jsp");
		}
		
		// visualizar
		if(resultado.getMsg() == null && operacao.equals("VISUALIZAR")) {
			System.out.println("Entrou no setView VISUALIZAR");
			request.getSession().setAttribute("visualizar", resultado);
			d = request.getRequestDispatcher("produto.jsp");
		}
		d.forward(request, response);
	}

}
