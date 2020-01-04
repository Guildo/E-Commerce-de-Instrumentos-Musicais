package dominio;

public class Cartao extends EntidadeDominio {
	
	private int id_usuario_cartao;
	private int id_bandeira_cartao;
	private String numero_cartao;
	private String ano_cartao;
	private String mes_cartao;
	private String cvv_cartao;
	private String nome_cartao;
	private boolean status_cartao;
	private double valor_pago;
	private int pedido;
	
	public int getPedido() {
		return pedido;
	}
	public void setPedido(int pedido) {
		this.pedido = pedido;
	}
	public double getValor_pago() {
		return valor_pago;
	}
	public void setValor_pago(double valor_pago) {
		this.valor_pago = valor_pago;
	}
	public String getNumero_cartao() {
		return numero_cartao;
	}
	public void setNumero_cartao(String numero_cartao) {
		this.numero_cartao = numero_cartao;
	}
	
	public String getAno_cartao() {
		return ano_cartao;
	}
	public void setAno_cartao(String ano_cartao) {
		this.ano_cartao = ano_cartao;
	}
	public String getMes_cartao() {
		return mes_cartao;
	}
	public void setMes_cartao(String mes_cartao) {
		this.mes_cartao = mes_cartao;
	}
	
	public String getCvv_cartao() {
		return cvv_cartao;
	}
	public void setCvv_cartao(String cvv_cartao) {
		this.cvv_cartao = cvv_cartao;
	}
	
	public String getNome_cartao() {
		return nome_cartao;
	}
	public void setNome_cartao(String nome_cartao) {
		this.nome_cartao = nome_cartao;
	}
	
	public int getId_usuario_cartao() {
		return id_usuario_cartao;
	}
	public void setId_usuario_cartao(int id_usuario_cartao) {
		this.id_usuario_cartao = id_usuario_cartao;
	}
	
	public int getId_bandeira_cartao() {
		return id_bandeira_cartao;
	}
	public void setId_bandeira_cartao(int id_bandeira_cartao) {
		this.id_bandeira_cartao = id_bandeira_cartao;
	}
	
	public boolean isStatus_cartao() {
		return status_cartao;
	}
	public void setStatus_cartao(boolean status_cartao) {
		this.status_cartao = status_cartao;
	}
	
}
