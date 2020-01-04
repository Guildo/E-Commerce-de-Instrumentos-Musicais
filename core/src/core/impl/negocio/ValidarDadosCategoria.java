package core.impl.negocio;

import core.IStrategy;
import dominio.EntidadeDominio;
import dominio.Categoria;

public class ValidarDadosCategoria implements IStrategy{
	@Override
	public String processar(EntidadeDominio entidade) {
		if(entidade instanceof Categoria) {
			Categoria categoria = (Categoria)entidade;
			String nome_categoria = null;
			
			try {
				nome_categoria = categoria.getNomeCategoria();
			} catch (Exception e) {
				
			}
			
			if(nome_categoria == null) {
				return "Para realizar o cadastro de um TIPO � preciso preencher todos os campos obrigat�rios!";
			}
			if(nome_categoria.trim().equals("")) {
				return "Para cadastrar um PRODUTO � preciso preencer todos os campos obrigat�rios";
			}
		}
		else {
			return "O cadastro de um TIPO � necess�rio!";
		}
		return null;
	} 
}
