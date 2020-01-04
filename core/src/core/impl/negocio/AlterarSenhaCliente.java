package core.impl.negocio;

import java.util.List;

import core.IStrategy;
import dominio.Cliente;
import dominio.EntidadeDominio;
import core.impl.dao.ClienteDAO;

public class AlterarSenhaCliente implements IStrategy{
	@Override
	public String processar(EntidadeDominio entidade) {
		// TODO Auto-generated method stub
		if(entidade instanceof Cliente) {
			Cliente objCliente = (Cliente)entidade;
			ClienteDAO objClienteDAO = new ClienteDAO();
			Cliente Cliente = new Cliente();
			System.out.println(objCliente.getSenhaCliente());
			List<EntidadeDominio> dadosCliente = objClienteDAO.consultar(entidade);
			if(objCliente.getSenhaCliente()!=null) {
				for(EntidadeDominio p:dadosCliente) {
					Cliente = (Cliente)p;
					if(Cliente.getId()==objCliente.getId()) {
						if(Cliente.getSenhaCliente().equals(objCliente.getSenhaCliente())){
							System.out.println("aaaa");
							System.out.println(objCliente.getNovaSenhaCliente());
							System.out.println(objCliente.getNovaSenhaCliente().length());
							if(objCliente.getNovaSenhaCliente().length()>=3) {
								return null;
							}
							else {
								return "A nova senha deve conter 3 ou mais caracteres!";
							}
						}
					}
				}
				return "A senha inserida não confere com sua senha atual!";
			}
			else {
			if(objCliente.getNomeCliente()==null || objCliente.getNomeCliente().equals("")||
					objCliente.getEmailCliente()==null || objCliente.getEmailCliente().equals("") ||
						objCliente.getTelefoneCliente()==null || objCliente.getTelefoneCliente().equals("")) {
				return "Para alterar seu cadastro, todos os dados devem ser preenchidos!";
			} else if (objCliente.getNomeCliente()!=null || objCliente.getEmailCliente()!=null 
					|| objCliente.getTelefoneCliente()!=null){
						for(EntidadeDominio p:dadosCliente) {
							Cliente = (Cliente)p;
							if(objCliente.getEmailCliente().equals(Cliente.getEmailCliente()) && objCliente.getId()!=Cliente.getId()) {
								return "E-mail colocado não está disponivel para uso";
							} 
						}
					return null;
					}
				}
			}
		return "Erro na alteração";
	}
}
