package controle.web.command.impl;

import core.aplicacao.Resultado;
import dominio.EntidadeDominio;

public class SalvarCommand extends AbstractCommand {

	public Resultado execute(EntidadeDominio entidade) {
		return fachada.salvar(entidade);
	}
}