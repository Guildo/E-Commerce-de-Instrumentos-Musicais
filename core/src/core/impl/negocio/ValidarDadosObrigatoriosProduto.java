package core.impl.negocio;

import core.IStrategy;
import dominio.EntidadeDominio;
import dominio.Categoria;
import dominio.Produto;

public class ValidarDadosObrigatoriosProduto implements IStrategy{

	@Override
	public String processar(EntidadeDominio entidade) {
		if(entidade instanceof Produto) {
			Produto produto = (Produto)entidade;
			int id_produto = 0;
			String modelo_produto = null;
			String marca_produto = null;
			Categoria cate = null;
			double preco = 0;
			
			try {
				id_produto = produto.getId();
				modelo_produto = produto.getModeloProduto();
				marca_produto = produto.getMarcaProduto();
				cate = produto.getCategoria();
				preco = produto.getPrecoUnitario();
				System.out.println(id_produto + " / " + modelo_produto + " / " + marca_produto +  " / " + preco + " / " + cate);
			} catch(Exception e) {
				
			}
			
			if(modelo_produto == null || marca_produto == null ||  preco < 0 || cate == null)
				return "Todos os dados cadastrais de uma produto são obritatórios!";
			
		} else {
			return "Um produto deve ser registrado!";
		}
		return null;
	}
}
