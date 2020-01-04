package controle.web.command.impl;

import core.aplicacao.Resultado;
import dominio.EntidadeDominio;

public class ConsultarCommand extends AbstractCommand{
	public Resultado execute(EntidadeDominio entidade) {
		return fachada.consultar(entidade);
	}
}