package core.impl.controle;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import auxiliar.DadosDeCadastro;
import core.IFachada;
import core.IDAO;
import core.IStrategy;

import core.aplicacao.Resultado;

import core.impl.dao.ProdutoDAO;
import core.impl.dao.DadosDeCadastroDAO;
import core.impl.dao.EnderecoDAO;
import core.impl.dao.ClienteDAO;
import core.impl.dao.CartaoDAO;
import core.impl.dao.PedidoDAO;
import core.impl.dao.GraficoDAO;
import core.impl.negocio.AddSession;
import core.impl.negocio.ValidarDadosCategoria;
import core.impl.negocio.ValidarDadosObrigatoriosProduto;
import core.impl.negocio.ValidarDadosObrigatoriosCliente;
import core.impl.negocio.ValidarDadosObrigatoriosEndereco;
import core.impl.negocio.ConfirmarSenhaCliente;
import core.impl.negocio.AddSession;
import core.impl.negocio.AlterarSenhaCliente;
import core.impl.negocio.ProdutoMesmoNome;
import core.impl.negocio.ValidarLogin;
import core.impl.negocio.ValidarPagamento;
import dominio.*;

public class Fachada implements IFachada{
	private Map<String, IDAO> daos;
	private Map<String, Map<String, List<IStrategy>>> rns;
	private Resultado resultado;
	
	public Fachada() {
		daos = new HashMap<String, IDAO>();
		rns = new HashMap<String, Map<String, List<IStrategy>>>();
		
		ProdutoDAO produtoDAO = new ProdutoDAO();
		DadosDeCadastroDAO dadosProdutoDAO = new DadosDeCadastroDAO();
		ClienteDAO clienteDAO = new ClienteDAO();
		EnderecoDAO enderecoDAO = new EnderecoDAO();
		CartaoDAO cartaoDAO = new CartaoDAO();
		PedidoDAO pedidoDAO = new PedidoDAO();
		GraficoDAO graficoDAO = new GraficoDAO();
		
		daos.put(Produto.class.getName(), produtoDAO);
		daos.put(DadosDeCadastro.class.getName(), dadosProdutoDAO);
		daos.put(Cliente.class.getName(), clienteDAO);
		daos.put(Endereco.class.getName(), enderecoDAO);
		daos.put(Cartao.class.getName(), cartaoDAO);
		daos.put(Pedido.class.getName(), pedidoDAO);
		daos.put(Grafico.class.getName(), graficoDAO);
		
		ValidarDadosObrigatoriosCliente vDadosObrigatoriosCliente = new ValidarDadosObrigatoriosCliente();
		ValidarDadosObrigatoriosEndereco vDadosObrigatoriosEndereco = new ValidarDadosObrigatoriosEndereco();
		ValidarLogin VaLogin = new ValidarLogin();
		ConfirmarSenhaCliente vConfirmarSenhaCliente = new ConfirmarSenhaCliente();
		AlterarSenhaCliente vAlterarSenhaCliente = new AlterarSenhaCliente();
		ValidarDadosObrigatoriosProduto vDadosObrigatoriosProduto = new ValidarDadosObrigatoriosProduto();
		ValidarDadosCategoria vDadosTipo = new ValidarDadosCategoria();
		ProdutoMesmoNome vProdutoMesmoNome = new ProdutoMesmoNome();
		ValidarPagamento objPagamento = new ValidarPagamento();
		AddSession objAddSession = new AddSession();
		
		List<IStrategy> rnsSalvarCapinha = new ArrayList<IStrategy>();		
		rnsSalvarCapinha.add(vDadosObrigatoriosProduto);
		//rnsSalvarCapinha.add(vProdutoMesmoNome);			
		
		List<IStrategy> rnsSalvarTipo = new ArrayList<IStrategy>();
		rnsSalvarTipo.add(vDadosTipo);
		
		
		List<IStrategy> rnsSalvarCliente = new ArrayList<IStrategy>();
		rnsSalvarCliente.add(vDadosObrigatoriosCliente);		
		rnsSalvarCliente.add(vConfirmarSenhaCliente);
		
		List<IStrategy>rnsAddSession = new ArrayList<IStrategy>();
		rnsAddSession.add(objAddSession);
		
		List<IStrategy> rnsSalvarEndereco = new ArrayList<IStrategy>();
		rnsSalvarCliente.add(vDadosObrigatoriosEndereco);
		
		List<IStrategy> Login = new ArrayList<IStrategy>();		
		Login.add(VaLogin);
		
		List<IStrategy> rnsAlterarSenha = new ArrayList<IStrategy>();		
		rnsAlterarSenha.add(vAlterarSenhaCliente);
		
		List<IStrategy>rnsPagamento = new ArrayList<IStrategy>();
		rnsPagamento.add(objPagamento);
		
		Map<String, List<IStrategy>> rnsProduto = new HashMap<String, List<IStrategy>>();	
		Map<String, List<IStrategy>> rnsTipo = new HashMap<String, List<IStrategy>>();
		Map<String, List<IStrategy>> rnsCliente = new HashMap<String, List<IStrategy>>();
		Map<String, List<IStrategy>> rnsPedido = new HashMap<String, List<IStrategy>>();

		rnsCliente.put("SALVAR", rnsSalvarCliente);
		rnsCliente.put("LOGIN", Login);
		//rnsCliente.put("ALTERAR", rnsAlterarSenha);
		//rnsCliente.put("SALVAR-ENDERECO", rnsSalvarEndereco);
		rnsCliente.put("SESSION", rnsAddSession);
		
		rnsProduto.put("SALVAR", rnsSalvarCapinha);
		rnsProduto.put("ALTERAR", rnsSalvarCapinha);
		
		rnsTipo.put("SALVAR", rnsSalvarTipo);
		rnsTipo.put("ALTERAR", rnsSalvarTipo);	
		
		rnsPedido.put("SALVAR", rnsPagamento);
		
		rns.put(Cliente.class.getName(), rnsCliente);
		rns.put(Produto.class.getName(), rnsProduto);
		rns.put(Categoria.class.getName(), rnsTipo);
		rns.put(Pedido.class.getName(), rnsPedido);
	}
	
	private String executarRegras(EntidadeDominio entidade, String operacao) {
		String nomeClasse = entidade.getClass().getName();
		StringBuilder msg = new StringBuilder();
		
		Map<String, List<IStrategy>> regrasOperacao = rns.get(nomeClasse);
		
		if(regrasOperacao != null) {
			List<IStrategy> regras = regrasOperacao.get(operacao);
			
			if(regras != null) {
				for(IStrategy s:regras) {
					String m = s.processar(entidade);
					System.out.println("Executar regras -> " + m);
					if(m != null) {
						msg.append(m);
						msg.append("\n");
					}
				}
			}
		}		
		if(msg.length()>0)
			return msg.toString();
		else
			return null;
	}

	@Override
	public Resultado salvar(EntidadeDominio entidade) {
		// TODO Auto-generated method stub
		System.out.println("FACHADA SALVAR");
		resultado = new Resultado();
		String nomeClasse = entidade.getClass().getName();
		String msg = executarRegras(entidade, "SALVAR");
		System.out.println("antes da dao");
		if(msg == null) {
			IDAO dao = daos.get(nomeClasse);
			try {
				System.out.println("O Miranha " + dao);
				dao.salvar(entidade);
				System.out.println("Passou pela DAO SALVAR XD");
				List<EntidadeDominio> entidades = new ArrayList<EntidadeDominio>();
				entidades.add(entidade);
				resultado.setEntidades(entidades);
			} catch (SQLException e) {
				e.printStackTrace();
				resultado.setMsg("Não foi possível realizar o registro!");
			}
		} else {
			System.out.println(msg);
			resultado.setMsg(msg);
		}
		return resultado;
	}

	@Override
	public Resultado excluir(EntidadeDominio entidade) {
		// TODO Auto-generated method stub
		resultado = new Resultado();
		String nomeClasse = entidade.getClass().getName();
		
		String msg = executarRegras(entidade, "EXCLUIR");
		
		if(msg == null) {
			IDAO dao = daos.get(nomeClasse);
			try {
				dao.excluir(entidade);
				List<EntidadeDominio> entidades = new ArrayList<EntidadeDominio>();
				entidades.add(entidade);
				System.out.println(entidades.get(0).getClass().getName());
				resultado.setEntidades(entidades);
			} catch (SQLException e) {
				e.printStackTrace();
				resultado.setMsg("Não foi possivel realizar a exclusão!");
			}
		} else {
			resultado.setMsg(msg);
		}
		return resultado;
	}

	@Override
	public Resultado ativar(EntidadeDominio entidade) {
		// TODO Auto-generated method stub
		resultado = new Resultado();
		String nomeClasse = entidade.getClass().getName();
		
		String msg = executarRegras(entidade, "ATIVAR");
		if(msg == null) {
			IDAO dao = daos.get(nomeClasse);
			try {
				dao.ativar(entidade);
				List<EntidadeDominio> entidades = new ArrayList<EntidadeDominio>();
				entidades.add(entidade);
				resultado.setEntidades(entidades);
			} catch (SQLException e) {
				e.printStackTrace();
				resultado.setMsg("Não foi possivel realizar a ativação!");
			}
		} else {
			resultado.setMsg(msg);
		}
		return resultado;
	}

	@Override
	public Resultado alterar(EntidadeDominio entidade) {
		// TODO Auto-generated method stub
		resultado = new Resultado();
		String nomeClasse = entidade.getClass().getName();
		String msg = executarRegras(entidade, "ALTERAR");
		System.out.println("Mensagem do ALTERAR: " + msg);
		if(msg == null) {
			System.out.println("Antes da DAO ALTERAR");
			IDAO dao = daos.get(nomeClasse);
			try {
				dao.alterar(entidade);
				List<EntidadeDominio> entidades = new ArrayList<EntidadeDominio>();
				entidades.add(entidade);
				resultado.setEntidades(entidades);
			} catch (SQLException e) {
				e.printStackTrace();
				resultado.setMsg("Não foi possivel realizar a alteração!");
			}
		} else {
			resultado.setMsg(msg);
		}
		return resultado;
	}

	@Override
	public Resultado consultar(EntidadeDominio entidade) {
		// TODO Auto-generated method stub
		System.out.println("Que entidade é essa? " + entidade);
		resultado = new Resultado();
		String nomeClasse = entidade.getClass().getName();
		System.out.println("Nome Classe: " + nomeClasse);
		String msg = executarRegras(entidade, "CONSULTAR");
		
		if(msg == null) {
			IDAO dao = daos.get(nomeClasse);
			System.out.println("CHAMOU A DAO: " + dao);
			try {
				resultado.setEntidades(dao.consultar(entidade));
			} catch (SQLException e) {
				e.printStackTrace();
				resultado.setMsg("Não foi possivel realizar a consulta!");
			}
		} else {
			resultado.setMsg(msg);
			System.out.println("Olha a mensagem: " + msg);
		}
		System.out.println("RETORNOU!");
		return resultado;
	}

	@Override
	public Resultado visualizar(EntidadeDominio entidade) {
		// TODO Auto-generated method stub
		resultado = new Resultado();
		resultado.setEntidades(new ArrayList<EntidadeDominio>(1));
		resultado.getEntidades().add(entidade);
		return resultado;
	}

	@Override
	public Resultado login(EntidadeDominio entidade) {
		// TODO Auto-generated method stub
		resultado = new Resultado();
		String msg = executarRegras(entidade, "LOGIN");
		if(msg == null || msg.equals("Cliente NÃO ATIVO!")) {
			List<EntidadeDominio> entidades = new ArrayList<EntidadeDominio>();
			entidades.add(entidade);
			resultado.setEntidades(entidades);
		} else {
			resultado.setMsg(msg);
		}
		return resultado;
	}

	@Override
	public Resultado session(EntidadeDominio entidade) {
		// TODO Auto-generated method stub
		resultado = new Resultado();
		String msg = executarRegras(entidade, "SESSION");
		if(msg == null) {
			List<EntidadeDominio> entidades = new ArrayList<EntidadeDominio>();
			entidades.add(entidade);
			resultado.setEntidades(entidades);
		} else {
			resultado.setMsg(msg);
		}
		return resultado;
	}

}
