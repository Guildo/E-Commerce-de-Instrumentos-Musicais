package auxiliar;

import java.util.ArrayList;

import dominio.EntidadeDominio;
import dominio.Pedido;
import dominio.Produto;
import dominio.Cliente;

public class ItemsGrafico extends EntidadeDominio{

	private ArrayList<Produto> produtos = new ArrayList<Produto>();
	private ArrayList<Pedido> pedidos = new ArrayList<Pedido>();
	private ArrayList<Cliente> users = new ArrayList<Cliente>();
	private ArrayList<Produto> produtos2 = new ArrayList<Produto>();
	
	
	public ArrayList<Produto> getProdutos2() {
		return produtos2;
	}

	public void setProdutos2(ArrayList<Produto> produtos2) {
		this.produtos2 = produtos2;
	}

	public ArrayList<Cliente> getUsers() {
		return users;
	}

	public void setUsers(ArrayList<Cliente> users) {
		this.users = users;
	}

	public ArrayList<Produto> getProdutos() {
		return produtos;
	}

	public void setProdutos(ArrayList<Produto> produtos) {
		this.produtos = produtos;
	}

	public ArrayList<Pedido> getPedidos() {
		return pedidos;
	}

	public void setPedidos(ArrayList<Pedido> pedidos) {
		this.pedidos = pedidos;
	}
	
}
