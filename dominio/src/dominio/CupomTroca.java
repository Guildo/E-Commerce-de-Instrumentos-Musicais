package dominio;

import java.util.Date;

public class CupomTroca extends EntidadeDominio{
	private Double Valor;
	private boolean FlgUsado = false;
	private int id_pedido_cupom;
	private int id_usuario_cupom;
	private boolean status_cupom;
	private Date data_cupom;
	private int pedidoAtual;
	private boolean habilitar;

	public Double getValor() {
		return Valor;
	}

	public void setValor(Double valor) {
		Valor = valor;
	}

	public boolean isFlgUsado() {
		return FlgUsado;
	}

	public void setFlgUsado(boolean flgUsado) {
		FlgUsado = flgUsado;
	}

	public int getId_pedido_cupom() {
		return id_pedido_cupom;
	}

	public void setId_pedido_cupom(int id_pedido_cupom) {
		this.id_pedido_cupom = id_pedido_cupom;
	}

	public int getId_usuario_cupom() {
		return id_usuario_cupom;
	}

	public void setId_usuario_cupom(int id_usuario_cupom) {
		this.id_usuario_cupom = id_usuario_cupom;
	}

	public boolean getStatus_cupom() {
		return status_cupom;
	}

	public void setStatus_cupom(boolean status_cupom) {
		this.status_cupom = status_cupom;
	}

	public Date getData_cupom() {
		return data_cupom;
	}

	public void setData_cupom(Date data_cupom) {
		this.data_cupom = data_cupom;
	}

	public int getPedidoAtual() {
		return pedidoAtual;
	}

	public void setPedidoAtual(int pedidoAtual) {
		this.pedidoAtual = pedidoAtual;
	}

	public boolean isHabilitar() {
		return habilitar;
	}

	public void setHabilitar(boolean habilitar) {
		this.habilitar = habilitar;
	}
}
