package core.impl.negocio;

import core.IStrategy;
import core.impl.dao.ProdutoDAO;
import dominio.EntidadeDominio;
import dominio.Produto;
import java.util.List;


public class ProdutoMesmoNome implements IStrategy{

	@Override
	public String processar(EntidadeDominio entidade) {
		System.out.println("Chegou na regra de negócio PRODUTO MESMO NOME");
		if(entidade instanceof Produto) {
			Produto objProd = (Produto)entidade;
			if(objProd.getModeloProduto() == null) {
				return null;
			}else {
				ProdutoDAO prodDAO = new ProdutoDAO();
				Produto prod = new Produto();
				List<EntidadeDominio> dadosCapinha = prodDAO.consultar(entidade);
				if(dadosCapinha != null) {
					for(EntidadeDominio c:dadosCapinha) {
						prod = (Produto)c;
						if(prod.getModeloProduto().equals(objProd.getModeloProduto())) {
							return objProd.getId() + "Produto com este NOME já cadastrado!";
						}
					}
				}
			} 
		}
		return null;
	}

}
