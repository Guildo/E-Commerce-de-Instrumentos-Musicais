package core.impl.negocio;

import core.IStrategy;
import dominio.Cliente;
import dominio.EntidadeDominio;

public class ConfirmarSenhaCliente implements IStrategy{

	@Override
	public String processar(EntidadeDominio entidade) {
		// TODO Auto-generated method stub
		System.out.println("Entrou na regra de negócio CONFIRMAR SENHA");
		if(entidade instanceof Cliente) {			
			Cliente cliente = (Cliente)entidade;
			String senha1 = "";
			String senha2 = "";
			
			try {
				if(cliente.getSenhaCliente() != null) {
	            	senha1 = cliente.getSenhaCliente();
	            	senha2 = cliente.getSenha2Cliente();
				}
            } catch(Exception e) {            	
            }
			System.out.println("Senha 1: " + senha1 + " / Senha 2: " + senha2);
			if(!senha1.equals(senha2)) {				
				return "Não é a MESMA SENHA!";
			} 
		} else {
			return "Um cliente deve ser registrado!";
		}
		return null;
	}

}
