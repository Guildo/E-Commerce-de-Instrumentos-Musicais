package core;

import core.aplicacao.Resultado;
import dominio.EntidadeDominio;


public interface IFachada {
	public Resultado salvar(EntidadeDominio entidade);
	public Resultado excluir(EntidadeDominio entidade);
	public Resultado ativar(EntidadeDominio entidade);
	public Resultado alterar(EntidadeDominio entidade);
	public Resultado consultar(EntidadeDominio entidade);
	public Resultado visualizar(EntidadeDominio entidade);
	public Resultado login(EntidadeDominio entidade);
	public Resultado session(EntidadeDominio entidade);
}
