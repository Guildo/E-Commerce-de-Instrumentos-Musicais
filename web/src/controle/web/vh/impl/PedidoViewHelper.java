package controle.web.vh.impl;

import java.io.IOException;
import java.sql.Date;
import java.text.SimpleDateFormat;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.swing.plaf.synth.SynthSeparatorUI;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import dominio.*;
import controle.web.vh.IViewHelper;
import core.aplicacao.Resultado;

public class PedidoViewHelper implements IViewHelper{

	@Override
	public EntidadeDominio getEntidade(HttpServletRequest request) {
		System.out.println("Entrou na VIEWHELPER de PEDIDOS");
		String operacao = request.getParameter("operacao");
		Pedido pedido = new Pedido();
		
		//CupomTroca = new CupomTroca();
		Resultado resultado = (Resultado) request.getSession().getAttribute("login");
		/*if(request.getSession().getAttribute("login")!=null) {
			List<EntidadeDominio> us = resultado.getEntidades();
		}else {
			System.out.println("ViewHelper Pedidos - pedido.setStatus(\"Erro\");");
			pedido.setStatus("Erro");
			return pedido;
		}*/
		List<EntidadeDominio> us = resultado.getEntidades();		
		Cliente cliente = (Cliente)us.get(0);
		ArrayList<Produto> produtos;
		double total = 0;
		int qtd = 0;
		double subtotal = 0;
		
		
		
		if(operacao.equals("CONSULTAR")) {
			
			Pedido ped = new Pedido();
			
			try {
				ped.getCliente().setId(Integer.parseInt(request.getParameter("idusr")));
				System.out.println(ped.getCliente().getId());
			} catch (Exception e){				
			}
			
			try {
				ped.setStatus(request.getParameter("status"));
			}catch(Exception e) {				
			}
			
			return ped;			
		}
		
		if(operacao.equals("CONSULTAR-TROCAS") || operacao.equals("CONSULTAR-ADMIN")) {
			
			Pedido ped = new Pedido();
			
			try {
				ped.setStatus(request.getParameter("status"));
			} catch (Exception e){
					
			}
			return ped;			
		}
		
		if(operacao.equals("CONSULTAR-CUPONS")) {
			
			Pedido ped = new Pedido();
			
			try {
				ped.getCliente().setId(Integer.parseInt(request.getParameter("idusr")));
				System.out.println(ped.getCliente().getId());
			} catch (Exception e){
					
			}
			
			return ped;			
		}
		
		
		if(operacao.equals("VISUALIZAR")) {
			
			Pedido ped = new Pedido();
			
			try {
				ped.setId(Integer.parseInt(request.getParameter("id-pedido")));
			} catch (Exception e){
					
			}
			return ped;			
		}
		
		
		if(operacao.equals("CONFIRMAR-PEDIDO")) {
			Pedido ped = new Pedido();
			try {
				ped.setId(Integer.parseInt(request.getParameter("id-pedido")));
			} catch (Exception e){
					
			}
			try {
				ped.setStatus(request.getParameter("status-pedido"));
			}catch(Exception e) {
				
			}
			
			try {
				ped.setStatus_troca_pedido(false);
			}catch(Exception e) {
				
			}		
			return ped;			
		}
		
		if(operacao.equals("NEGAR-PEDIDO")) {
			Pedido ped = new Pedido();
			try {
				ped.setId(Integer.parseInt(request.getParameter("id-pedido")));
			} catch (Exception e){
					
					}
			try {
				ped.setStatus("Pedido negado");
			}catch(Exception e) {
				
			}
			
			try {
				ped.setStatus_troca_pedido(false);
			}catch(Exception e) {
				
			}		
			return ped;			
		}
		
		if(operacao.equals("FAZER-PEDIDO")) {
			pedido = (Pedido) request.getSession().getAttribute("carrinho");
			
			Cartao card1 = new Cartao();
			Cartao card2 = new Cartao();
			ArrayList<Cartao> cartoes = new ArrayList<Cartao>();
			Endereco endCobranca = new Endereco();
			Endereco endEntrega = new Endereco();
			ArrayList<CupomTroca> cupons = new ArrayList<CupomTroca>();
			
			if(cliente.getEnderecos().size()==1) {
				System.out.println("ENTROU ENDERECO UNICOOOOOO");
				endCobranca.setCEP(cliente.getEnderecos().get(0).getCEP());
				endCobranca.setNumero(cliente.getEnderecos().get(0).getNumero());
				pedido.setEndEntrega(endCobranca);
				pedido.setEndCobranca(endCobranca);
			} else {
				endCobranca.setCEP(cliente.getEnderecos().get(0).getCEP());
				endCobranca.setNumero(cliente.getEnderecos().get(0).getNumero());
				pedido.setEndCobranca(endCobranca);
				System.out.println("CEP cobranca: "+pedido.getEndCobranca().getCEP());
				System.out.println("Numero cobranca: "+pedido.getEndCobranca().getNumero());
				
				endEntrega.setCEP(cliente.getEnderecos().get(1).getCEP());
				endEntrega.setNumero(cliente.getEnderecos().get(1).getNumero());
				pedido.setEndEntrega(endEntrega);
				System.out.println("CEP entrega: "+pedido.getEndEntrega().getCEP());
				System.out.println("Numero Entrega: "+pedido.getEndEntrega().getNumero());
			}
			String usarcartao1 = "";
			String usarcartao2 = "";
			double valorpago2 = 0;
			double valorpago1 = 0;
	
			usarcartao1 = request.getParameter("usarcartao1");
			
			usarcartao2 = request.getParameter("usarcartao2");
			
			try {
				if(request.getParameter("valor-cartao2")!=null) {
					if(request.getParameter("valor-cartao2")!="") {
						System.out.println("entrou aqui"+request.getParameter("valor-cartao2"));
						valorpago2 = Double.parseDouble(request.getParameter("valor-cartao2"));
					}
				}
				if(request.getParameter("valor-cartao1")!=null) {
					if(request.getParameter("valor-cartao1")!="") {
						valorpago1 = Double.parseDouble(request.getParameter("valor-cartao1"));
					}
				}
			}catch(Exception e) {				
			}
			
			System.out.println("ENTROU CARTOES 1");
			if(usarcartao1!=null) {
				if(usarcartao1.equals("sim")) {
					card1.setNumero_cartao(cliente.getCartoes().get(0).getNumero_cartao());
					card1.setId_bandeira_cartao(cliente.getCartoes().get(0).getId_bandeira_cartao());
					card1.setValor_pago(valorpago1);
					cartoes.add(card1);
					System.out.println(card1.getNumero_cartao());
					System.out.println(card1.getValor_pago());
				}
			}
			if(usarcartao2!=null) {
				if(usarcartao2.equals("sim")) {
					System.out.println("ENTROU CARTOES 2");
					card2.setNumero_cartao(cliente.getCartoes().get(1).getNumero_cartao());
					card2.setId_bandeira_cartao(cliente.getCartoes().get(1).getId_bandeira_cartao());
					card2.setValor_pago(valorpago2);
					cartoes.add(card2);
					System.out.println(card2.getNumero_cartao());
					System.out.println(card2.getValor_pago());
				}
			}				
		
			pedido.setCartoes(cartoes);
			
			//tratativa para pagamento com cupom
			//cupons estao presentes na session login e estamos recebendo a opção de inserção dele na compra pelo input com name usarcupom
			//primeiro passo: declarar as variaveis que irao receber os valores se o cupom foi inserido na compra
			String usarcupom="";
			int countercupom = 1;
			//segundo passo: verificar sessao de login para saber se existe um cupom do cliente
			//try {
				if(!cliente.getCupons().isEmpty()) {
					System.out.println("ENTROU CUPONS");
					//varrer a session de login e verificar os cupons encontrados
					for(CupomTroca cupom: cliente.getCupons()) {
						//verificar se o cupom está ativo
						System.out.println("STATUS CUPOM: "+cupom.getStatus_cupom());
						if(cupom.getStatus_cupom() && cupom.isHabilitar()) {
							//verificar se o cupom foi inserido na compra
							//receber a variavel do formulario usarcupom
							usarcupom = request.getParameter("usarcupom"+countercupom);
							System.out.println("Usar cupom?: "+usarcupom);
							if(usarcupom.equals("sim")) {
								//cupom inserido na compra
								CupomTroca cup = new CupomTroca();
								cup.setId(cupom.getId());
								cup.setValor(cupom.getValor());
								cupons.add(cup);
							}							
							countercupom++;
						}
					}
					pedido.setCuponsTroca(cupons);
				}
			/*} catch (Exception e){
				
			}*/
			pedido.setStatus_troca_pedido(false);
			return pedido;
		}
		
		if(operacao.equals("REMOVECARRINHO")) {
			pedido = (Pedido) request.getSession().getAttribute("carrinho");
			produtos = pedido.getProdutos();
				for(Produto produto:produtos) {
					if(produto.getId() == Integer.parseInt(request.getParameter("id-produto"))) {
						produto.setRemover(true);
						produto.setQtd_estoque(1);
						produto.setQtdremover(Integer.parseInt(request.getParameter("qtd")));
						pedido.setId_item_atual(Integer.parseInt(request.getParameter("id-produto")));
					}
				}
				pedido.setProdutos(produtos);
				
				return pedido;
			}
		
		if(operacao.equals("ADDCARRINHO")) {			
			if(request.getSession().getAttribute("carrinho") != null) {
				System.out.println("PedidoVH EntidadeDomínio - operação ADDCARRINHO - part1");
				pedido = (Pedido) request.getSession().getAttribute("carrinho");
				produtos = pedido.getProdutos();
				Produto produto = new Produto();
				produtos = pedido.getProdutos();
				for(Produto prod:pedido.getProdutos()) {
					if(prod.getId() == Integer.parseInt(request.getParameter("id-produto"))) { // add produto que já tinha
						System.out.println("----------------");
						
						if(request.getParameter("qtd-estoque")!=""){
							if(request.getParameter("qtd-estoque")!=null) {
							prod.setQtd_estoque(Integer.parseInt(request.getParameter("qtd-estoque")));
							prod.setQtd_pedido(Integer.parseInt(request.getParameter("qtd")));
							System.out.println("QTD Estoque: " + prod.getQtd_estoque());
							System.out.println("QTD Pedido: " + prod.getQtd_pedido());
								if(prod.getQtd_pedido()>prod.getQtd_estoque()) {
									prod.setId(Integer.parseInt(request.getParameter("id-produto")));
									produtos.add(produto);
									pedido.setProdutos(produtos);
									System.out.println("ADDCARRINHO - saiu no if(prod.getQtd_pedido()>prod.getQtd_estoque())");
									return pedido;
								}
							}
						}
						prod.setQtd_pedido(Integer.parseInt(request.getParameter("qtd")));
						produto.setQtd_estoque(0);
						prod.setQtdtotal(prod.getQtdtotal()+Integer.parseInt(request.getParameter("qtd")));
						prod.setQtd_pedido_anterior(prod.getQtd_pedido());
						System.out.println("VALOR ATUAL DO PEDIDO: "+pedido.getValor_total());
						qtd = Integer.parseInt(request.getParameter("qtd")) + (prod.getQtd_pedido()-prod.getQtd_pedido_anterior());
						System.out.println("QUANTIDADE DO PEDIDO ATUAL:"+prod.getQtd_pedido());
						
						System.out.println("QUANTIDADE ANTERIOR: "+prod.getQtd_pedido_anterior());
						System.out.println("----------------");
						
						pedido.setId_item_atual(Integer.parseInt(request.getParameter("id-produto")));
						subtotal = qtd * prod.getPrecoUnitario();
						System.out.println("SUBTOTAL = "+qtd+" * "+prod.getPrecoUnitario()+" = "+ subtotal);
						total = pedido.getValor_total();
						System.out.println("TOTAL pedido: "+ total);
						total += subtotal;
						System.out.println("TOTAL + SUB: "+total);
						prod.setSubtotal(prod.getPrecoUnitario()*prod.getQtdtotal());
						prod.setQtd_pedido(qtd);
						produto.setQtdremover(0);
						prod.setRemover(false);
						pedido.setValor_total(total);
						return pedido;
					}
				} // for
			
				if(request.getParameter("qtd-estoque")!=""){
					if(request.getParameter("qtd-estoque")!=null) {
					produto.setQtd_estoque(Integer.parseInt(request.getParameter("qtd-estoque")));
					produto.setQtd_pedido(Integer.parseInt(request.getParameter("qtd")));
					System.out.println("2-QTD Estoque: " + produto.getQtd_estoque());
					System.out.println("2-QTD Pedido: " + produto.getQtd_pedido());
						if(produto.getQtd_pedido()>produto.getQtd_estoque()) {
							produto.setId(Integer.parseInt(request.getParameter("id-produto")));
							produtos.add(produto);
							pedido.setProdutos(produtos);
							return pedido;
						}
					}
				}
				
				produto.setQtd_pedido(Integer.parseInt(request.getParameter("qtd")));
				produto.setQtd_estoque(Integer.parseInt(request.getParameter("qtd-estoque")));
				produto.setQtd_pedido_anterior(0);
				pedido.setId_item_atual(Integer.parseInt(request.getParameter("id-produto")));
				produto.setId(Integer.parseInt(request.getParameter("id-produto")));
				produto.setModeloProduto(request.getParameter("modelo-produto"));
				produto.setPrecoUnitario(Double.parseDouble(request.getParameter("valor-produto")));
				produto.setQtdtotal(produto.getQtd_pedido());
				produto.setQtdremover(0);
				produto.setSubtotal(produto.getPrecoUnitario()*produto.getQtd_pedido());
				total = pedido.getValor_total() + produto.getSubtotal();
				produto.setRemover(false);
				pedido.setValor_total(total);
				produtos.add(produto);
				pedido.setProdutos(produtos);
				
				System.out.println("ID: " + produto.getId());
				System.out.println("MODELO: " + produto.getModeloProduto());
				
				return pedido;
			} else { //if carrinho == NULL
				System.out.println("PedidoVH EntidadeDomínio - operação ADDCARRINHO - part2");
				Pedido ped = new Pedido();
				ped.setCliente(new Cliente());
				
				produtos = new ArrayList<Produto>();
				Produto produto = new Produto();
				
				if(request.getParameter("qtd-estoque")!=""){
					if(request.getParameter("qtd-estoque")!=null) {
					produto.setQtd_estoque(Integer.parseInt(request.getParameter("qtd-estoque")));
					produto.setQtd_pedido(Integer.parseInt(request.getParameter("qtd")));
					System.out.println("3-QTD Estoque: " + produto.getQtd_estoque());
					System.out.println("3-QTD Pedido: " + produto.getQtd_pedido());
						if(produto.getQtd_pedido()>produto.getQtd_estoque()) {
							produto.setId(Integer.parseInt(request.getParameter("id-produto")));
							produtos.add(produto);
							ped.setProdutos(produtos);
							return ped;
						}
					}
				}
				
				produto.setQtd_pedido(Integer.parseInt(request.getParameter("qtd")));
				produto.setQtd_estoque(Integer.parseInt(request.getParameter("qtd-estoque")));
				ped.getCliente().setNomeCliente(cliente.getNomeCliente());
				ped.getCliente().setId(cliente.getId());
				ped.setId_item_atual(Integer.parseInt(request.getParameter("id-produto")));
				produto.setId(Integer.parseInt(request.getParameter("id-produto")));
				produto.setModeloProduto(request.getParameter("modelo-produto"));
				produto.setPrecoUnitario(Double.parseDouble(request.getParameter("valor-produto")));
				produto.setQtd_pedido_anterior(0);
				produto.setQtdremover(0);
				produto.setQtd_pedido(Integer.parseInt(request.getParameter("qtd")));
				produto.setQtdtotal(produto.getQtd_pedido());
				produto.setSubtotal(produto.getQtd_pedido()*Double.parseDouble(request.getParameter("valor-produto")));
				produto.setRemover(false);
				
				produtos.add(produto);
				ped.setProdutos(produtos);
				ped.setValor_total(produto.getSubtotal());
				System.out.println("ID: " + produto.getId());
				System.out.println("MODELO: " + produto.getModeloProduto());
				return ped;
			}
		}
		
		if(operacao.equals("SOLICITAR-TROCA")) {
			Pedido ped = new Pedido();
			Resultado result = (Resultado) request.getSession().getAttribute("dadosPedido");
			List<EntidadeDominio> pedidos = result.getEntidades();
			
			System.out.println("Entrou solicitar toca");
			try {
				ped.setId(Integer.parseInt(request.getParameter("id-pedido")));
			} catch (Exception e){}
			
			try {
				ped.setStatus(request.getParameter("status-pedido"));
				System.out.println("VH Pedido - SOLICITAR-TROCA - status: " + ped.getStatus());
			}catch (Exception e){}
			
			try {
				ped.setMotivoTroca(request.getParameter("motivo-troca"));
				System.out.println("VH Pedido - SOLICITAR-TROCA - motivo troca: " + ped.getMotivoTroca());
			}catch (Exception e){}
			
			try {
				ped.getCliente().setId(Integer.parseInt(request.getParameter("idusr")));
			}catch (Exception e){}
			
			try {
				ped.setStatus_troca_pedido(true);
			}catch (Exception e){}
			
			String trocar="";
			int countProdutos = 1;
			int qtdProd = 0;
			for(EntidadeDominio ent:pedidos) {
				pedido = (Pedido)ent;
				if(ped.getId()==pedido.getId()) {
					ped.setQtd_produtos(pedido.getQtd_produtos());
					ped.setValor_total(pedido.getValor_total());
					for(Produto prod:pedido.getProdutos()) {
						Produto produtoTroca = new Produto();
						
						trocar = request.getParameter("trocar"+countProdutos);
						qtdProd = Integer.parseInt(request.getParameter("qtd-troca"+countProdutos));
							
						System.out.println("QUANTIDADE PARA TROCA: "+qtdProd);
						
						if(pedido.getProdutos().size()==1) { // troca de 1 produdo
							produtoTroca.setQtd_pedido(qtdProd);
							produtoTroca.setId(prod.getId());
							produtoTroca.setPrecoUnitario(prod.getPrecoUnitario());
							ped.getProdutos().add(produtoTroca);
							ped.setQtd_troca(ped.getQtd_troca()+qtdProd);
							ped.setValor_total(ped.getValor_total()+prod.getQtd_pedido()*prod.getPrecoUnitario());
						}
						else if(pedido.getProdutos().size()>1) { // troca de MAIS de 1 produto
							if(trocar!=null) {
								produtoTroca.setQtd_pedido(qtdProd);
								produtoTroca.setId(prod.getId());
								produtoTroca.setPrecoUnitario(prod.getPrecoUnitario());
								ped.getProdutos().add(produtoTroca);
								ped.setQtd_troca(ped.getQtd_troca()+qtdProd);
								ped.setValor_total(ped.getValor_total()+prod.getQtd_pedido()*prod.getPrecoUnitario());
							}
						}
						countProdutos++;
						qtdProd=0;
					}
				}
			}			
			return ped;			
		}
		
		if(operacao.equals("AUTORIZAR-TROCA")) {
			Pedido ped = new Pedido();
			Produto produtinho = new Produto();
			Resultado result = (Resultado) request.getSession().getAttribute("dadosPedido");
			List<EntidadeDominio> pedidos = result.getEntidades();
			ArrayList<Produto>prds = new ArrayList<Produto>();
			try {
				ped.setId(Integer.parseInt(request.getParameter("id-pedido")));
			} catch (Exception e){
					
			}
			
			try {
				ped.setValor_total(Double.parseDouble(request.getParameter("valor-pedido")));
			} catch (Exception e){
					
			}
			
			try {
				ped.setStatus(request.getParameter("status-pedido"));
			}catch(Exception e) {
				
			}
			
			try {
				ped.getCliente().setId(Integer.parseInt(request.getParameter("idusr")));
			}catch(Exception e) {
				
			}
			
			try {
				ped.setStatus_troca_pedido(true);
			}catch(Exception e) {
				
			}
			
			for(EntidadeDominio ent:pedidos) {
				Pedido pedi = (Pedido)ent;
				if(pedi.getId() == ped.getId()) {
					
					for(Produto prod:pedi.getProdutos()) {
						produtinho.setId(prod.getId());
						produtinho.setQtd_pedido(prod.getQtd_pedido());
						prds.add(produtinho);
					}
				}
			}
			ped.setProdutos(prds);
			return ped;		
		}
		
		if(operacao.equals("NEGAR-TROCA")) {
			Pedido ped = new Pedido();
			try {
				ped.setId(Integer.parseInt(request.getParameter("id-pedido")));
			} catch (Exception e){
					
			}
			
			try {
				ped.setStatus("Troca negada");
			}catch(Exception e) {
				
			}
			
			ped.setStatus_troca_pedido(true);		
					
			return ped;			
		}
		
		if(operacao.equals("CONFIRMAR-ENTREGA")) {
			Pedido ped = new Pedido();
			try {
				ped.setId(Integer.parseInt(request.getParameter("id-pedido")));
			} catch (Exception e){
					
					}
			try {
				ped.setStatus(request.getParameter("status-pedido"));
			}catch(Exception e) {
				
			}
			
			try {
				ped.setStatus_troca_pedido(false);
			}catch(Exception e) {
				
			}		
			return ped;			
		}
		
		return pedido;
	}

	@Override
	public void setView(Resultado resultado, HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		RequestDispatcher d = null;
		String operacao = request.getParameter("operacao");
		
		if(resultado.getMsg() == null && operacao.equals("ADDCARRINHO")) {
			/*Pedido pedido = (Pedido) resultado.getEntidades().get(0);
			for(Produto prod:pedido.getProdutos()) {
				if(prod.isRemover()) {
					prod.setRemover(false);	
					break;
				}
			}
			resultado.getEntidades().remove(0);
			resultado.getEntidades().add(pedido);*/
			request.getSession().setAttribute("carrinho", resultado.getEntidades().get(0));
			
			d = request.getRequestDispatcher("adicionado-carrinho.jsp");
		}
		
		if(resultado.getMsg() != null && operacao.equals("ADDCARRINHO")) {
			String id = resultado.getMsg().substring(0, 2);
			String msg = resultado.getMsg().substring(2);
			id = id.trim();
			System.out.println("id-produto: "+id);
			resultado.setMsg(msg);
			request.getSession().setAttribute("erro", resultado);
			d = request.getRequestDispatcher("Produtos?id-produto="+id+"&operacao=VISUALIZAR");
		}
		
		
		if(resultado.getMsg() == null && operacao.equals("REMOVECARRINHO")) {
			Pedido pedido = (Pedido) resultado.getEntidades().get(0);
			for(Produto prod:pedido.getProdutos()) {
				if(prod.isRemover()) {
					prod.setQtdtotal(prod.getQtdtotal()-prod.getQtdremover());
					pedido.setValor_total(pedido.getValor_total()-(prod.getPrecoUnitario()*prod.getQtdremover()));
					prod.setSubtotal(prod.getPrecoUnitario()*prod.getQtdtotal());
					if(prod.getQtdtotal()==0) {
						pedido.getProdutos().remove(prod);
						break;
					}
					
				}
			}
			resultado.getEntidades().remove(0);
			resultado.getEntidades().add(pedido);
			request.getSession().setAttribute("carrinho", resultado.getEntidades().get(0));
			
			d = request.getRequestDispatcher("removido-carrinho.jsp");
		}
		
		if(resultado.getMsg() != null && operacao.equals("REMOVECARRINHO")) {
			
			request.getSession().setAttribute("erro", resultado);			
			d = request.getRequestDispatcher("meu-carrinho.jsp");
		}
		
		if(resultado.getMsg() == null && operacao.equals("VER-CARRINHO")) {
			
			request.getSession().setAttribute("visualizar", resultado);
			d = request.getRequestDispatcher("meu-carrinho.jsp");
		}
		
		if(resultado.getMsg() == null && operacao.equals("FINALIZAR-COMPRA")) {
			
			request.getSession().setAttribute("visualizar", resultado);
			d = request.getRequestDispatcher("finalizar-compra.jsp");
		}
		
		if(resultado.getMsg() == null && operacao.equals("FAZER-PEDIDO")) {
			
			request.getSession().setAttribute("pedidook", resultado);
			d = request.getRequestDispatcher("refresh.jsp");
		}
		
		if(resultado.getMsg() != null && operacao.equals("FAZER-PEDIDO")) {
			
			request.getSession().setAttribute("erro", resultado);
			d = request.getRequestDispatcher("finalizar-compra.jsp");
		}

		if(resultado.getMsg() == null && operacao.equals("CONSULTAR")) { 
		
			request.getSession().setAttribute("dadosPedido", resultado);
			d = request.getRequestDispatcher("meus-pedidos.jsp");
		}
		
		if(resultado.getMsg() == null && operacao.equals("CONSULTAR-CUPONS")) { 
			
			request.getSession().setAttribute("dadosCupom", resultado);
			d = request.getRequestDispatcher("meus-cupons.jsp");
		}
		
		if(resultado.getMsg() == null && operacao.equals("CONSULTAR-ADMIN")) {
			
			request.getSession().setAttribute("dadosPedido", resultado);
			d = request.getRequestDispatcher("admin-visualizar-pedidos.jsp");
		}
		
		if(resultado.getMsg() == null && operacao.equals("CONSULTAR-TROCAS")) {
			
			request.getSession().setAttribute("dadosPedido", resultado);
			d = request.getRequestDispatcher("admin-visualizar-trocas.jsp");
		}
		
		if(resultado.getMsg() == null && operacao.equals("VISUALIZAR")) {
			
			request.getSession().setAttribute("resultado", resultado);
			d = request.getRequestDispatcher("pedido.jsp");
			
		}
		
		if(resultado.getMsg() == null && operacao.equals("CONFIRMAR-PEDIDO")) {
			
			request.getSession().setAttribute("pedidoConfirmado", resultado);
			d = request.getRequestDispatcher("pedido-atualizado.jsp"); 
			
		}
		
		if(resultado.getMsg() == null && operacao.equals("NEGAR-PEDIDO")) {
			
			request.getSession().setAttribute("pedidoNegado", resultado);
			d = request.getRequestDispatcher("pedido-atualizado.jsp");
			
		}
		
		if(resultado.getMsg() == null && operacao.equals("SOLICITAR-TROCA")) {
			
			request.getSession().setAttribute("trocaSolicitada", resultado);
			d = request.getRequestDispatcher("troca-solicitada.jsp"); 
			
		}
		
		if(resultado.getMsg() == null && operacao.equals("AUTORIZAR-TROCA")) {
			
			request.getSession().setAttribute("trocaAutorizada", resultado);
			d = request.getRequestDispatcher("pedido-atualizado.jsp?status=trocas");
			
		}
		
		if(resultado.getMsg() == null && operacao.equals("NEGAR-TROCA")) {
			
			request.getSession().setAttribute("trocaNegada", resultado);
			d = request.getRequestDispatcher("Pedidos?operacao=CONSULTAR-ADMIN");
			
		}
		
		if(resultado.getMsg() == null && operacao.equals("CONFIRMAR-ENTREGA")) {
			
			request.getSession().setAttribute("pedidoEntregue", resultado);
			d = request.getRequestDispatcher("pedido-atualizado.jsp");
			
		}
				
		d.forward(request, response);
	}

}
