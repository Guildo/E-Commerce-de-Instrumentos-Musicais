package dominio;

public class Produto extends EntidadeDominio{
	private String modeloProduto;
	private String marcaProduto;
	private String corProduto;
	private String descricaoProduto;
	private double precoUnitario;
	private String imagemProduto;
	private boolean isAtivo;
	private int qtd_estoque;
	private int qtd_pedido;
	private int qtd_pedido_anterior;
	private boolean remover;
	private double subtotal;
	private int qtdtotal;
	private int qtdremover;
	private int pedido;
	private Categoria categoria = new Categoria();
	private String motivoDesativacao;
	private String motivoAtivacao;
	private int graficoAno;
	private int graficoAno2;
	private int graficoMes;
	private int graficoMes2;
	
	public String getModeloProduto() {
		return modeloProduto;
	}
	public void setModeloProduto(String modeloProduto) {
		this.modeloProduto = modeloProduto;
	}
	
	public String getMarcaProduto() {
		return marcaProduto;
	}
	public void setMarcaProduto(String marcaProduto) {
		this.marcaProduto = marcaProduto;
	}
	
	public String getCorProduto() {
		return corProduto;
	}
	public void setCorProduto(String corProduto) {
		this.corProduto = corProduto;
	}
	
	public String getDescricaoProduto() {
		return descricaoProduto;
	}
	public void setDescricaoProduto(String descricaoProduto) {
		this.descricaoProduto = descricaoProduto;
	}
	
	public double getPrecoUnitario() {
		return precoUnitario;
	}
	public void setPrecoUnitario(double precoUnitario) {
		this.precoUnitario = precoUnitario;
	}
	
	public String getImagemProduto() {
		return imagemProduto;
	}
	public void setImagemProduto(String imagemProduto) {
		this.imagemProduto = imagemProduto;
	}
	
	public boolean isAtivo() {
		return isAtivo;
	}
	public void setAtivo(boolean isAtivo) {
		this.isAtivo = isAtivo;
	}
	
	public Categoria getCategoria() {
		return categoria;
	}
	public void setCategoria(Categoria categoria) {
		this.categoria = categoria;
	}
	
	public String getMotivoDesativacao() {
		return motivoDesativacao;
	}
	public void setMotivoDesativacao(String motivoDesativacao) {
		this.motivoDesativacao = motivoDesativacao;
	}
	
	public String getMotivoAtivacao() {
		return motivoAtivacao;
	}
	public void setMotivoAtivacao(String motivoAtivacao) {
		this.motivoAtivacao = motivoAtivacao;
	}
	public int getQtd_estoque() {
		return qtd_estoque;
	}
	public void setQtd_estoque(int qtd_estoque) {
		this.qtd_estoque = qtd_estoque;
	}
	public int getQtd_pedido() {
		return qtd_pedido;
	}
	public void setQtd_pedido(int qtd_pedido) {
		this.qtd_pedido = qtd_pedido;
	}
	public int getQtd_pedido_anterior() {
		return qtd_pedido_anterior;
	}
	public void setQtd_pedido_anterior(int qtd_pedido_anterior) {
		this.qtd_pedido_anterior = qtd_pedido_anterior;
	}
	public boolean isRemover() {
		return remover;
	}
	public void setRemover(boolean remover) {
		this.remover = remover;
	}
	public double getSubtotal() {
		return subtotal;
	}
	public void setSubtotal(double subtotal) {
		this.subtotal = subtotal;
	}
	public int getQtdtotal() {
		return qtdtotal;
	}
	public void setQtdtotal(int qtdtotal) {
		this.qtdtotal = qtdtotal;
	}
	public int getQtdremover() {
		return qtdremover;
	}
	public void setQtdremover(int qtdremover) {
		this.qtdremover = qtdremover;
	}
	public int getPedido() {
		return pedido;
	}
	public void setPedido(int pedido) {
		this.pedido = pedido;
	}
	public int getGraficoAno() {
		return graficoAno;
	}
	public void setGraficoAno(int graficoAno) {
		this.graficoAno = graficoAno;
	}
	public int getGraficoAno2() {
		return graficoAno2;
	}
	public void setGraficoAno2(int graficoAno2) {
		this.graficoAno2 = graficoAno2;
	}
	public int getGraficoMes() {
		return graficoMes;
	}
	public void setGraficoMes(int graficoMes) {
		this.graficoMes = graficoMes;
	}
	public int getGraficoMes2() {
		return graficoMes2;
	}
	public void setGraficoMes2(int graficoMes2) {
		this.graficoMes2 = graficoMes2;
	}
	
}
