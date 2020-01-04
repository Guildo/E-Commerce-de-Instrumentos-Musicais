package controle.web.command.impl;

import core.aplicacao.Resultado;
import dominio.EntidadeDominio;

public class LoginCommand extends AbstractCommand {

	@Override
	public Resultado execute(EntidadeDominio entidade) {
		// TODO Auto-generated method stub
		return fachada.login(entidade);
	}

}
