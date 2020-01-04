package core.impl.negocio;

import core.IStrategy;
import dominio.Cliente;
import dominio.Endereco;
import dominio.EntidadeDominio;

public class ValidarDadosObrigatoriosEndereco implements IStrategy {

	@Override
	public String processar(EntidadeDominio entidade) {
		// TODO Auto-generated method stub
		if(entidade instanceof Cliente) {
			Cliente cliente = (Cliente)entidade;
			
			Endereco endereco = null;
			
			try {            	
	            endereco = cliente.getEnderecos().get(0);	            
            } catch(Exception e) {            	
            }
			
			if(endereco.getCidade() == null || endereco.getBairro() == null   ||  
                    endereco.getCEP() == null || endereco.getEstado() == null)
				return "Preencher todos os dados obrigatórios de um endereço! 1";
			
			if(endereco.getCidade().trim().equals("") || endereco.getBairro().trim().equals("") ||  
                    endereco.getCEP().trim().equals("") || endereco.getEstado().trim().equals(""))
				return "Preencher todos os dados obrigatórios de um endereço! 2";
		} else {
			return "Um endereço deve ser cadastrado!";
		}
		return null;
	}

}
