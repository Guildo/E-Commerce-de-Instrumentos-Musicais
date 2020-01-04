package core.impl.negocio;

import core.IStrategy;
import dominio.Cartao;
import dominio.CupomTroca;
import dominio.EntidadeDominio;
import dominio.Pedido;

public class ValidarPagamento implements IStrategy {

	public String processar(EntidadeDominio entidade) {
		System.out.println("ENTROU REGRA");
		double total = 0;
		int i = 0;
		String cupons = "";
		if(entidade instanceof Pedido) {
			Pedido objPedido = (Pedido)entidade;
			for(Cartao cardi:objPedido.getCartoes()) {
				if(cardi.getValor_pago()==0) {
					return "Voce deve inserir apenas o valor, em numeros!";
				}
			}
			if(!objPedido.getCuponsTroca().isEmpty()) {
				for(CupomTroca cupom:objPedido.getCuponsTroca()) {
					total = total + cupom.getValor();
					i++;					
				}
				cupons = "com mais "+i+" cupons: ";
			}else {
				if(objPedido.getCartoes().isEmpty()) {
					return "Você precisa selecionar ao menos 1 forma de pagamento!";
				}
			}
			if(objPedido.getCartoes().size() == 1) {
				//tem apenas um cartao
				System.out.println("APENAS 1 CARTAO");
				for(Cartao card:objPedido.getCartoes()) {
					total = total + card.getValor_pago();
					System.out.println("VALOR pago cartao: "+card.getValor_pago());
					System.out.println("VALOR TOTAL: "+total);
					if(total < objPedido.getValor_total()) {
						return "O pedido tem valor total de "+objPedido.getValor_total()+"! Valor no cartao "+cupons+total;
					}else if(total > objPedido.getValor_total()) {
						return "O pedido tem valor total de "+objPedido.getValor_total()+" Valor no cartao "+cupons+total;
					}
				}
			}else{				
				for(Cartao card:objPedido.getCartoes()) {
					total = total+ card.getValor_pago();
				} 
				if(total < objPedido.getValor_total()) {
					return "O valor total do pedido é de "+objPedido.getValor_total()+" e somando os 2 cartoes "+cupons+total;
				}else if(total > objPedido.getValor_total()) {
					return "Voce digitou um valor maior que do pedido! Pedido:"+objPedido.getValor_total()+" e somando os 2 cartoes "+cupons+total;
				}
			}
			System.out.println("TUDO OK");
			return null;
		}
		return "Erro no processamento do pedido";
	}	
}