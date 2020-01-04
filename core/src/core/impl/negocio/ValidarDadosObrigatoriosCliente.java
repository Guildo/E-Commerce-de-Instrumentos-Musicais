package core.impl.negocio;

import java.sql.Date;

import core.IStrategy;
import dominio.Cartao;
import dominio.Cliente;
import dominio.Endereco;
import dominio.EntidadeDominio;

public class ValidarDadosObrigatoriosCliente implements IStrategy {

	@Override
	public String processar(EntidadeDominio entidade) {
		// TODO Auto-generated method stub
		if(entidade instanceof Cliente) {
			Cliente cliente = (Cliente)entidade;
			
			String Nome = null;
            String email = null;
            Endereco endereco = null;
            String senha = null;
            String telefone = null;
            
            try {
            	Nome = cliente.getNomeCliente();
	            email = cliente.getEmailCliente();
	            endereco = cliente.getEnderecos().get(0);
	            senha = cliente.getSenhaCliente();
	            telefone = cliente.getTelefoneCliente();
            } catch(Exception e) {            	
            }
            
            if((Nome == null || email == null || telefone == null   || senha == null) && endereco.getCEP() != null)
                return null;
            
            if(Nome == null || email == null || telefone == null   || senha == null)
                return "Todos os dados cadastrais de um cliente são obrigatórios! 1";
            
             if(Nome.trim().equals("") || email.trim().equals("") || telefone.trim().equals("") || 
                    senha.trim().equals("") )
                return "Todos os dados cadastrais de um cliente são obrigatórios! 2";
            
		} else {
			return "Um cliente deve ser registrado!";
		}
		return null;
	}

}
