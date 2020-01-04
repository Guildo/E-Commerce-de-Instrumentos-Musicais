package dominio;

import java.util.ArrayList;
import java.util.Date;

public class Pedido extends EntidadeDominio {

	
	private ArrayList<Produto> Produtos = new ArrayList<Produto>();
	private Cliente cliente = new Cliente();
	private ArrayList<Cartao> Cartoes = new ArrayList<Cartao>();
	private int id_cliente_pedido;
	private int id_endereco_entrega;
	private int id_item_atual;
	private double Frete;
	private double valor_total;
	private boolean status_troca_pedido = false;
	private String Status;
	private Date dataPedido;
	private Endereco endEntrega = new Endereco();
	private Endereco endCobranca = new Endereco();	
	private ArrayList<CupomTroca> cuponsTroca = new ArrayList<CupomTroca>();
	private String motivoTroca;
	private int qtd_produtos;
	private int qtd_troca;
	private boolean frete_add = false;

	public Date getDataPedido() {
		return dataPedido;
	}
	public void setDataPedido(Date dataPedido) {
		this.dataPedido = dataPedido;
	}
	public ArrayList<Produto> getProdutos() {
		return Produtos;
	}
	public void setProdutos(ArrayList<Produto> produtos) {
		Produtos = produtos;
	}
	
	public ArrayList<Cartao> getCartoes() {
		return Cartoes;
	}
	public void setCartoes(ArrayList<Cartao> cartao) {
		Cartoes = cartao;
	}
	public int getId_endereco_entrega() {
		return id_endereco_entrega;
	}
	public void setId_endereco_entrega(int id_endereco_entrega) {
		this.id_endereco_entrega = id_endereco_entrega;
	}
	public double getFrete() {
		return Frete;
	}
	public void setFrete(double frete) {
		Frete = frete;
	}
	public double getValor_total() {
		return valor_total;
	}
	public void setValor_total(double valor_total) {
		this.valor_total = valor_total;
	}
	/*public String getRota_entrega_pedido() {
		return rota_entrega_pedido;
	}
	public void setRota_entrega_pedido(String rota_entrega_pedido) {
		this.rota_entrega_pedido = rota_entrega_pedido;
	}*/
	public boolean isStatus_troca_pedido() {
		return status_troca_pedido;
	}
	public void setStatus_troca_pedido(boolean status_troca_pedido) {
		this.status_troca_pedido = status_troca_pedido;
	}
	
	public int getId_item_atual() {
		return id_item_atual;
	}
	public void setId_item_atual(int id_item_atual) {
		this.id_item_atual = id_item_atual;
	}
	
	public String getStatus() {
		return Status;
	}
	public void setStatus(String status) {
		Status = status;
	}	
	
	public Endereco getEndEntrega() {
		return endEntrega;
	}
	public void setEndEntrega(Endereco endEntrega) {
		this.endEntrega = endEntrega;
	}
	public Endereco getEndCobranca() {
		return endCobranca;
	}
	public void setEndCobranca(Endereco endCobranca) {
		this.endCobranca = endCobranca;
	}
	public Cliente getCliente() {
		return cliente;
	}
	public void setCliente(Cliente cliente) {
		this.cliente = cliente;
	}
	public ArrayList<CupomTroca> getCuponsTroca() {
		return cuponsTroca;
	}
	public void setCuponsTroca(ArrayList<CupomTroca> cuponsTroca) {
		this.cuponsTroca = cuponsTroca;
	}
	public int getId_cliente_pedido() {
		return id_cliente_pedido;
	}
	public void setId_cliente_pedido(int id_cliente_pedido) {
		this.id_cliente_pedido = id_cliente_pedido;
	}
	public String getMotivoTroca() {
		return motivoTroca;
	}
	public void setMotivoTroca(String motivoTroca) {
		this.motivoTroca = motivoTroca;
	}
	public int getQtd_produtos() {
		return qtd_produtos;
	}
	public void setQtd_produtos(int qtd_produtos) {
		this.qtd_produtos = qtd_produtos;
	}
	public int getQtd_troca() {
		return qtd_troca;
	}
	public void setQtd_troca(int qtd_troca) {
		this.qtd_troca = qtd_troca;
	}
	public boolean isFrete_add() {
		return frete_add;
	}
	public void setFrete_add(boolean frete_add) {
		this.frete_add = frete_add;
	}
	
}