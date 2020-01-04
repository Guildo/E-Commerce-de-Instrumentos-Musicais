package dominio;

import java.util.Date;

public class EntidadeDominio implements IEntidade{
	private int id;
	private Date dtCadastro;
	
	public Date getDtCadastro() {
		return dtCadastro;
	}
	
	public void setDtCadastro(Date dtCadastro) {
		this.dtCadastro = dtCadastro;
	}

	@Override
	public Integer getId() {
		// TODO Auto-generated method stub
		return id;
	}

	@Override
	public void setId(Integer id) {
		this.id = id;
		
	}
}
