package core.impl.negocio;

import java.util.List;

import core.IStrategy;
import core.impl.dao.ClienteDAO;
import dominio.EntidadeDominio;
import dominio.Cliente;

public class AddSession implements IStrategy{

	@Override
	public String processar(EntidadeDominio entidade) {
		// TODO Auto-generated method stub
		if(entidade instanceof Cliente) {
			Cliente objCliente = (Cliente)entidade;
			ClienteDAO objClienteDao = new ClienteDAO();
			System.out.println(objClienteDao + "Addsession XP");
			Cliente Cliente = new Cliente();
			System.out.println(Cliente + " AddSession");
			List<EntidadeDominio> dadosCliente = objClienteDao.consultar(entidade);
			System.out.println("CRIOU LISTA DE DADOS");
			System.out.println(dadosCliente);
			System.out.println("id: "+ objCliente.getId());
			for(EntidadeDominio p:dadosCliente) {
				Cliente = (Cliente)p;
				System.out.println("Entrou for");
				System.out.println(Cliente);
				if(Cliente.getId() == objCliente.getId()){
					objCliente.setNomeCliente(Cliente.getNomeCliente());
					objCliente.setId(Cliente.getId());
					objCliente.setIsAdmin(Cliente.getIsAdmin());
					objCliente.setEnderecos(Cliente.getEnderecos());
					objCliente.setCartoes(Cliente.getCartoes());
					objCliente.setCupons(Cliente.getCupons());
					objCliente.setFrete(Cliente.getFrete());
					System.out.println("ADICIONOU A SESSAO");
					return null;
				}
			}
		}
		System.out.println("CAIU ERRO AddSession");
		return "Erro";
	}

}
