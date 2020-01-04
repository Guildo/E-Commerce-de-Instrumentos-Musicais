package dominio;

import java.util.ArrayList;

public class Cliente extends EntidadeDominio{
	private String nomeCliente;
	private String emailCliente;
	private String senhaCliente;
	private String senha2Cliente;
	private String novaSenhaCliente;
	private String telefoneCliente;
	private ArrayList<Endereco> enderecos = new ArrayList<Endereco>();
	private ArrayList<Cartao> cartoes = new ArrayList<Cartao>(); 
	private ArrayList<CupomTroca> cupons = new ArrayList<CupomTroca>();
	private Boolean isAdmin;
	private Boolean flgAtivo;
	private double frete;
	private boolean com_frete;
	
	public String getNomeCliente() {
		return nomeCliente;
	}
	public void setNomeCliente(String nomeCliente) {
		this.nomeCliente = nomeCliente;
	}
	public String getEmailCliente() {
		return emailCliente;
	}
	public void setEmailCliente(String emailCliente) {
		this.emailCliente = emailCliente;
	}
	public String getSenhaCliente() {
		return senhaCliente;
	}
	public void setSenhaCliente(String senhaCliente) {
		this.senhaCliente = senhaCliente;
	}
	public String getNovaSenhaCliente() {
		return novaSenhaCliente;
	}
	public void setNovaSenhaCliente(String novaSenhaCliente) {
		this.novaSenhaCliente = novaSenhaCliente;
	}
	public String getTelefoneCliente() {
		return telefoneCliente;
	}
	public void setTelefoneCliente(String telefoneCliente) {
		this.telefoneCliente = telefoneCliente;
	}
	public ArrayList<Endereco> getEnderecos() {
		return enderecos;
	}
	public void setEnderecos(ArrayList<Endereco> enderecos) {
		this.enderecos = enderecos;
	}
	public ArrayList<Cartao> getCartoes() {
		return cartoes;
	}
	public void setCartoes(ArrayList<Cartao> cartoes) {
		this.cartoes = cartoes;
	}
	public ArrayList<CupomTroca> getCupons() {
		return cupons;
	}
	public void setCupons(ArrayList<CupomTroca> cupons) {
		this.cupons = cupons;
	}
	public Boolean getIsAdmin() {
		return isAdmin;
	}
	public void setIsAdmin(Boolean isAdmin) {
		this.isAdmin = isAdmin;
	}
	public Boolean getFlgAtivo() {
		return flgAtivo;
	}
	public void setFlgAtivo(Boolean flgAtivo) {
		this.flgAtivo = flgAtivo;
	}
	public String getSenha2Cliente() {
		return senha2Cliente;
	}
	public void setSenha2Cliente(String senha2Cliente) {
		this.senha2Cliente = senha2Cliente;
	}
	public double getFrete() {
		return frete;
	}
	public void setFrete(double frete) {
		this.frete = frete;
	}
	public boolean isCom_frete() {
		return com_frete;
	}
	public void setCom_frete(boolean com_frete) {
		this.com_frete = com_frete;
	}
	
}
