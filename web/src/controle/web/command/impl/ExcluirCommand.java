package controle.web.command.impl;

import core.aplicacao.Resultado;
import dominio.EntidadeDominio;

public class ExcluirCommand extends AbstractCommand{
	
	public Resultado execute(EntidadeDominio entidade) {
		return fachada.excluir(entidade);
	}
}