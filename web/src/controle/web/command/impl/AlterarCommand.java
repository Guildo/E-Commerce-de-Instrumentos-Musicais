package controle.web.command.impl;

import core.aplicacao.Resultado;
import dominio.EntidadeDominio;

public class AlterarCommand extends AbstractCommand {
	public Resultado execute(EntidadeDominio entidade) {
		return fachada.alterar(entidade);
	}
}
