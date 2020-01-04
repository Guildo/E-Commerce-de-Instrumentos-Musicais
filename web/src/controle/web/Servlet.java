package controle.web;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Map;
import java.util.HashMap;

import controle.web.command.ICommand;
import controle.web.command.impl.AlterarCommand;
import controle.web.command.impl.AtivarCommand;
import controle.web.command.impl.SalvarCommand;
import controle.web.command.impl.VisualizarCommand;
import controle.web.command.impl.ConsultarCommand;
import controle.web.command.impl.ExcluirCommand;
import controle.web.command.impl.LoginCommand;
import controle.web.command.impl.AddSessionCommand;
import controle.web.vh.IViewHelper;
import controle.web.vh.impl.ProdutoViewHelper;
import controle.web.vh.impl.CartaoViewHelper;
import controle.web.vh.impl.ClienteViewHelper;
import controle.web.vh.impl.DadosParaProdutoViewHelper;
import controle.web.vh.impl.EnderecoViewHelper;
import controle.web.vh.impl.PedidoViewHelper;
import controle.web.vh.impl.GraficoViewHelper;
import core.aplicacao.Resultado;
import dominio.EntidadeDominio;

/**
 * Servlet implementation class Servlet
 */
public class Servlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	private static Map<String, ICommand> commands;
	private static Map<String, IViewHelper> vhs;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Servlet() {
        super();
        commands = new HashMap<String, ICommand>();
        vhs = new HashMap<String, IViewHelper>();
        
        commands.put("SALVAR", new SalvarCommand());
		commands.put("ALTERAR", new AlterarCommand());
		commands.put("ALTERAR-SENHA", new AlterarCommand());
		commands.put("EXCLUIR", new ExcluirCommand());
		commands.put("CONSULTAR", new ConsultarCommand());
		commands.put("INDEX", new ConsultarCommand());
		commands.put("VISUALIZAR", new VisualizarCommand());
		commands.put("ATIVAR", new AtivarCommand());
		commands.put("ATIVAR-CUPOM", new AtivarCommand());
		commands.put("LOGIN", new LoginCommand());
		commands.put("CARDSESSION", new AddSessionCommand());
		commands.put("ENDSESSION", new AddSessionCommand());
		commands.put("USERSESSION", new AddSessionCommand());
		commands.put("CUPSESSION", new AddSessionCommand());
		commands.put("REFRESH", new AddSessionCommand());
		commands.put("ADDCARRINHO", new AlterarCommand());
		commands.put("VER-CARRINHO", new VisualizarCommand());
		commands.put("REMOVECARRINHO", new AlterarCommand());
		commands.put("FINALIZAR-COMPRA", new VisualizarCommand());
		commands.put("FAZER-PEDIDO", new SalvarCommand());
		commands.put("CONSULTAR-ADMIN", new ConsultarCommand());
		commands.put("CONSULTAR-TROCAS", new ConsultarCommand());
		commands.put("CONSULTAR-CUPONS", new ConsultarCommand());
		commands.put("CONFIRMAR-PEDIDO", new AlterarCommand());
		commands.put("NEGAR-PEDIDO", new AlterarCommand());
		commands.put("SOLICITAR-TROCA", new AlterarCommand());
		commands.put("AUTORIZAR-TROCA", new AlterarCommand());
		commands.put("CONFIRMAR-ENTREGA", new AlterarCommand());
		commands.put("NEGAR-TROCA", new AlterarCommand());
		commands.put("DASHBOARD", new ConsultarCommand());
		commands.put("FILTRAR", new ConsultarCommand());

        
        vhs.put("/web/Produtos", new ProdutoViewHelper());        
        vhs.put("/web/DadosProduto", new DadosParaProdutoViewHelper());
        vhs.put("/web/Cliente", new ClienteViewHelper());
        vhs.put("/web/Enderecos", new EnderecoViewHelper());
        vhs.put("/web/Cartoes", new CartaoViewHelper());
        vhs.put("/web/Pedidos", new PedidoViewHelper());
        vhs.put("/web/Graficos", new GraficoViewHelper());
    }

    /**
     * TODO Descrição do Método
     * @param req
     * @param resp
     * @throws ServletException
     * @throws IOException
     * @see javax.servlet.http.HttpServlet#doGet(javax.servlet.http.HttpServletRequest, javax.servlet.http.HttpServletResponse)
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException,
    		IOException {
    	System.out.println("doGet");
    	doProcessRequest(request, response);
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("doPost");
		doProcessRequest(request, response);
		
	}
	
	protected void doProcessRequest(HttpServletRequest request, 
			HttpServletResponse response) throws ServletException, IOException {
		//Obtêm a uri que invocou esta servlet (O que foi definido no methdo do form html)
		String uri = request.getRequestURI();
		System.out.println("Servlet - URI: " + uri);
		
		//Obtêm a operação executada
		String operacao = request.getParameter("operacao");
		System.out.println("Servlet - Operação: " + operacao + " 1 ");
		
		//Obtêm um viewhelper indexado pela uri que invocou esta servlet
		IViewHelper vh = vhs.get(uri);
		System.out.println(vh.getClass().getName());
		System.out.println("Servlet - Achou!");
		
		//O viewhelper retorna a entidade especifica para a tela que chamou esta servlet
		EntidadeDominio entidade =  vh.getEntidade(request);
		System.out.println("Servlet - Entidade" + entidade);
		
		//Obtêm o command para executar a respectiva operação
		ICommand command = commands.get(operacao);
		/*Executa o command que chamará a fachada para executar a operação requisitada
		 * o retorno é uma instância da classe resultado que pode conter mensagens derro 
		 * ou entidades de retorno
		 */
		System.out.println("Command: " + command.getClass().getName());
		Resultado resultado = new Resultado();
		try {
			resultado = command.execute(entidade);
			
		}catch (Exception e) {
		}
		/*
		 * Executa o método setView do view helper específico para definir como deverá ser apresentado 
		 * o resultado para o usuário
		 */
		vh.setView(resultado, request, response);
	
	}
}
