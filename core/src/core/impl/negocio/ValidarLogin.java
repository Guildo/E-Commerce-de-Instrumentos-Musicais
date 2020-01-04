package core.impl.negocio;

import java.util.ArrayList;
import java.util.List;

import core.IStrategy;
import core.impl.dao.ClienteDAO;
import dominio.EntidadeDominio;
import dominio.Cliente;

public class ValidarLogin implements IStrategy{

	@Override
	public String processar(EntidadeDominio entidade) {
		if(entidade instanceof Cliente) {
			Cliente objCliente = (Cliente)entidade; // Usuário Logando
			
			ClienteDAO objClienteDao = new ClienteDAO();
			Cliente Cliente = new Cliente();
			List<EntidadeDominio> dadosCliente = objClienteDao.consultar(entidade);
				if(dadosCliente!=null) {
					for(EntidadeDominio p:dadosCliente) {
						Cliente = (Cliente)p; // Informações do Usuário pegas no banco de Dados
						System.out.println("Cliente digitado: "+objCliente.getEmailCliente());
						System.out.println("Cliente do banco: "+Cliente.getEmailCliente());
						System.out.println("senha digitado: "+objCliente.getSenhaCliente());
						System.out.println("senha do banco: "+Cliente.getSenhaCliente());
						if(Cliente.getEmailCliente().equals(objCliente.getEmailCliente()) &&
								Cliente.getSenhaCliente().equals(objCliente.getSenhaCliente())){
							if(!Cliente.getFlgAtivo()) {
								return "Sua conta foi previamente excluida! Ative-a novamente para fazer login!";
							}else {
								System.out.println("Entrou aqui");
								if(Cliente.getIsAdmin()) {
									objCliente.setNomeCliente(Cliente.getNomeCliente());
									objCliente.setId(Cliente.getId());
									objCliente.setIsAdmin(Cliente.getIsAdmin());
								}else {
									objCliente.setNomeCliente(Cliente.getNomeCliente());
									objCliente.setId(Cliente.getId());
									objCliente.setEnderecos(Cliente.getEnderecos());
									objCliente.setCartoes(Cliente.getCartoes());	
									objCliente.setCupons(Cliente.getCupons());
									objCliente.setFrete(Cliente.getFrete());
								}
								return null;
							}
						}
					}
					return "E-mail ou senha invalidos!";
				}
				else {
					return "Erro no login";
				}
			}
		System.out.println("Passa pelo ultimo return");
		return "Erro no login";
	}
	
}