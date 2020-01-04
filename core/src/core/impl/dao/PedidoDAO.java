package core.impl.dao;

import java.sql.PreparedStatement;
import java.sql.Statement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import dominio.*;

public class PedidoDAO extends AbstractJdbcDAO {

	public PedidoDAO() {
		super ("pedidos", "id_pedido");
	}
	
	@Override
	public void salvar(EntidadeDominio entidade) throws SQLException {
		openConnection();                                      // abre a conexão com o Banco
        PreparedStatement pst = null;
		Pedido objPedido = (Pedido) entidade;
		Pedido ped = new Pedido();
		//CupomPromocional cpP = new CupomPromocional();
		//ArrayList<CupomTroca> cpT = new ArrayList<CupomTroca>();
		//double ValorDesconto=0;
		double total=0;
		boolean flg=false;
		//CupomTroca cp;
		ResultSet rs;
		StringBuilder sql;

		if(objPedido != null) {
			if(!objPedido.isStatus_troca_pedido()) {
			try {
				sql = new StringBuilder();
				connection.setAutoCommit(false);
				java.util.Date dt = new java.util.Date();
				//java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

				System.out.println("VALOR TOTAL PEDIDO: "+objPedido.getValor_total());
				System.out.println("ID USER: "+objPedido.getCliente().getId());
				System.out.println("CEP ENTREGA: "+objPedido.getEndEntrega().getCEP());
				System.out.println("CEP Cobranca: "+objPedido.getEndCobranca().getCEP());
				System.out.println("Num ENTREGA: "+objPedido.getEndEntrega().getNumero());
				System.out.println("Num Cobranca: "+objPedido.getEndCobranca().getNumero());
				//String currentTime = sdf.format(dt);
				
				sql.append("INSERT INTO pedidos "
						+ "(valor_pedido, "
						+ "status_troca_pedido, "
						+ "id_usuario_pedido, "
						+ "rota_entrega_pedido, "
						+ "cep_endereco_entrega, "
						+ "cep_endereco_cobranca, "
						+ "num_endereco_cobranca, "
						+ "num_endereco_entrega, "
						+ "data_pedido) "
						+ "VALUES (?, ?, ?, ?, ?, ?, ?, ?, sysdate())");
				
				pst = connection.prepareStatement(sql.toString(), Statement.RETURN_GENERATED_KEYS);
				
				pst.setDouble(1, objPedido.getValor_total());
				pst.setBoolean(2, false);
				pst.setInt(3, objPedido.getCliente().getId());
				pst.setString(4, "Em processamento");
				pst.setString(5, objPedido.getEndEntrega().getCEP());
				pst.setString(6, objPedido.getEndCobranca().getCEP());
				pst.setString(7, objPedido.getEndCobranca().getNumero());
				pst.setString(8, objPedido.getEndEntrega().getNumero());
				//pst.setString(9, currentTime);
				
				System.out.println(pst);
				
				pst.executeUpdate();
				
				rs = pst.getGeneratedKeys();
				int num = 0;
				if(rs.next()) {
					num = rs.getInt(1);
					objPedido.setId(num);
				}				
				connection.commit(); 
				
				for(Produto prod:objPedido.getProdutos()) {
					System.out.println("Entrou salvar pedidos_produtos");
					connection.setAutoCommit(false);
					try {
					sql = new StringBuilder();
					sql.append("INSERT INTO pedido_produtos (id_pedido_usuario, id_produto, id_qtd_produto, subtotal) "
							+ "VALUES (?, ?, ?, ?)");
					pst = connection.prepareStatement(sql.toString());
					pst.setInt(1, objPedido.getId());
					pst.setInt(2, prod.getId());
					pst.setInt(3, prod.getQtdtotal());
					pst.setDouble(4, prod.getSubtotal());
					
					pst.executeUpdate();
					connection.commit(); 
					} catch(SQLException e) {
						e.printStackTrace();
					}
				}
				
				for(Cartao cart:objPedido.getCartoes()) {	
					try {
						System.out.println("Entrou salvar pagamento_pedidos");
						connection.setAutoCommit(false);
						sql = new StringBuilder();
						sql.append("INSERT INTO pagamento_pedidos (id_pedido, num_cartao, valor_pagamento, bandeira_cartao, tipo_pagamento) "
								+ "VALUES(?, ?, ?, ?, ?) ");
						pst = connection.prepareStatement(sql.toString());
						pst.setInt(1, objPedido.getId());
						pst.setString(2, cart.getNumero_cartao());
						pst.setDouble(3, cart.getValor_pago());
						pst.setInt(4, cart.getId_bandeira_cartao());
						pst.setString(5, "cartao");
												
						System.out.println(pst);
						pst.executeUpdate();
						connection.commit();
					} catch (SQLException e) {
						e.printStackTrace();
					}
					
				}
				
				if(!objPedido.getCuponsTroca().isEmpty()) {
					for(CupomTroca cupom:objPedido.getCuponsTroca()) {
						System.out.println("Entrou salvar Cupons");
						try {
							connection.setAutoCommit(false);
							sql = new StringBuilder();
							sql.append("INSERT INTO pagamento_pedidos (id_pedido, num_cartao, valor_pagamento, tipo_pagamento, bandeira_cartao) "
									+ "VALUES(?, ?, ?, ?, 7)");
							pst = connection.prepareStatement(sql.toString());
							pst.setInt(1, objPedido.getId());
							pst.setInt(2, cupom.getId());
							pst.setDouble(3, cupom.getValor());
							pst.setString(4, "cupom");
							
							System.out.println(pst);
							pst.executeUpdate();
							connection.commit();
						} catch (SQLException e) {
							e.printStackTrace();
						}
						//deixar cupom inativo
						try {
							connection.setAutoCommit(false);
							sql = new StringBuilder();
							sql.append("UPDATE cupons_troca SET status_cupom=? WHERE id_cupom = ?");
							pst = connection.prepareStatement(sql.toString());
							pst.setBoolean(1, false);
							pst.setInt(2, cupom.getId());
							
							System.out.println(pst);
							pst.executeUpdate();
							connection.commit();
						} catch (SQLException e) {
							e.printStackTrace();
						}						
					}
				}				
			} catch (SQLException e) {
					try {
						connection.rollback();
					} catch (SQLException el) {
						el.printStackTrace();
					}
				e.printStackTrace();
				} finally {
					try {
						pst.close();
						connection.close();
					} catch (SQLException e) {
						e.printStackTrace();
					}
				}
			}
		}		
	}
	
	@Override
	public void alterar(EntidadeDominio entidade) throws SQLException {
		openConnection();                                       // abre a conexão com o Banco
        PreparedStatement pst = null;
        PreparedStatement pst2 = null;
        Pedido objPedido = (Pedido) entidade;
        StringBuilder sql = new StringBuilder();
        ResultSet rs = null;
        double total = 0;
        double subTotalTroca = 0;
        double totalTroca = 0;
        System.out.println("PedidoDAO - ALTERAR");
        if(objPedido != null) {
        	System.out.println("PedidoDAO - ALTERAR - if(objPedido != null)");
        	if(objPedido.isStatus_troca_pedido()) {
        		System.out.println("Status_troca_pedido == TRUE");
        		System.out.println("Status == " + objPedido.getStatus());
        		try {
        			if(objPedido.getStatus().equals("Entregue")) {
            			System.out.println("Entrou solicitar troca dentro pedido entregue");
            			System.out.println("total de produtos: "+objPedido.getQtd_produtos());
            			System.out.println("total para troca: "+objPedido.getQtd_troca());
            			if(objPedido.getQtd_produtos()==objPedido.getQtd_troca()) {
        	        		connection.setAutoCommit(false);
        	    			sql.append("UPDATE pedidos SET rota_entrega_pedido=?, motivo_troca=?, status_troca_pedido=? ");
        	    			sql.append("WHERE id_pedido=?");
        	    			
        	    			pst = connection.prepareStatement(sql.toString());
        	    			pst.setString(1, "Troca solicitada");
        	    			pst.setString(2, objPedido.getMotivoTroca());
        	    			pst.setBoolean(3, true);
        	    			pst.setInt(4, objPedido.getId());
        	    			
        	    			pst.executeUpdate();
        	    			connection.commit();
            			}else {            
            				
            				for(Produto prod:objPedido.getProdutos()) {
            					connection.setAutoCommit(false);
                				sql = new StringBuilder();
                				sql.append("SELECT * FROM pedido_produtos WHERE id_pedido_usuario=? AND id_produto=?");
                				pst = connection.prepareStatement(sql.toString());
                				pst.setInt(1, objPedido.getId());
                				pst.setInt(2, prod.getId());
                				rs = pst.executeQuery();
                				for (int i=0; rs.next();i++) {
                					connection.setAutoCommit(false);
                					sql = new StringBuilder();
                					
            						if(prod.getQtd_pedido()==rs.getInt("id_qtd_produto")) {
            							total = prod.getPrecoUnitario()*prod.getQtd_pedido();
            							sql.append("DELETE FROM pedido_produtos WHERE id_produto=? AND id_pedido_usuario=?");
            							pst2 = connection.prepareStatement(sql.toString());
            							pst2.setInt(1, prod.getId());
    	            					pst2.setInt(2, objPedido.getId());
    	            					System.out.println(pst2.toString());
    	            					
            						}else {
            							total = prod.getPrecoUnitario()*prod.getQtd_pedido();
            							subTotalTroca = prod.getPrecoUnitario()*(rs.getInt("id_qtd_produto")-prod.getQtd_pedido());
	            						sql.append("UPDATE pedido_produtos SET id_qtd_produto=?, subtotal=? "
	            								+ "WHERE id_produto=? AND id_pedido_usuario=?");
		            					pst2 = connection.prepareStatement(sql.toString());
		            					pst2.setInt(1, rs.getInt("id_qtd_produto")-prod.getQtd_pedido());
		            					pst2.setDouble(2, subTotalTroca);
		            					pst2.setInt(3, prod.getId());
		            					pst2.setInt(4, objPedido.getId());
		            					System.out.println(pst2.toString());		            					
	            	    			}
            						
            						totalTroca = totalTroca + total;
            						System.out.println("ANTES DO EXECUTEUPDATE");
            						pst2.executeUpdate();
	            	    			connection.commit();
                				}
            				}
            				double valoratual = 0;
            				connection.setAutoCommit(false);
            				sql = new StringBuilder(); 
            				sql.append("SELECT valor_pedido FROM pedidos where id_pedido=?");
            				pst = connection.prepareStatement(sql.toString());
            				pst.setInt(1, objPedido.getId());
            				rs = pst.executeQuery();
            				while(rs.next()) {
            					valoratual = rs.getDouble("valor_pedido");
            				}
            				System.out.println("atual: "+valoratual);
            				valoratual = valoratual - totalTroca;
            				System.out.println("total retirado: "+totalTroca);
            				System.out.println("atual agora: "+valoratual);
            				System.out.println("PASSOU");
            				connection.setAutoCommit(false);
            				sql = new StringBuilder(); 
            				sql.append("UPDATE pedidos SET valor_pedido=? WHERE id_pedido=?");
            				pst = connection.prepareStatement(sql.toString());
            				pst.setDouble(1, valoratual);
            				pst.setInt(2, objPedido.getId());
            				System.out.println(pst.toString());
            				pst.executeUpdate();
        	    			connection.commit();
        	    			total = 0;
        	    			for(Produto prod:objPedido.getProdutos()) {
        	    				total = total + (prod.getQtd_pedido()*prod.getPrecoUnitario());
        	    			}
        	    			
        	    			connection.setAutoCommit(false);
            				sql = new StringBuilder();
            				sql.append("SELECT * FROM pedidos WHERE id_pedido=?");
            				pst = connection.prepareStatement(sql.toString());
            				pst.setInt(1, objPedido.getId());
            				rs = pst.executeQuery();
            				int num = 0;
            				while(rs.next()) {
	        	    			//java.util.Date dt = new java.util.Date();
	        					//java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	
	        					//String currentTime = sdf.format(dt);
	        					sql = new StringBuilder();
	        					sql.append("INSERT INTO pedidos "
	        							+ "(valor_pedido, "
	        							+ "status_troca_pedido, "
	        							+ "id_usuario_pedido, "
	        							+ "rota_entrega_pedido, "
	        							+ "cep_endereco_entrega, "
	        							+ "cep_endereco_cobranca, "
	        							+ "num_endereco_cobranca, "
	        							+ "num_endereco_entrega, "
	        							+ "data_pedido, "
	        							+ "id_pedido_troca, "
	        							+ "motivo_troca) "
	        							+ "VALUES (?, ?, ?, ?, ?, ?, ?, ?, sysdate(), ?, ?)");
	        					
	        					pst = connection.prepareStatement(sql.toString(), Statement.RETURN_GENERATED_KEYS);
	        					
	        					pst.setDouble(1, total);
	        					pst.setBoolean(2, true);
	        					pst.setInt(3, objPedido.getCliente().getId());
	        					pst.setString(4, "Troca solicitada");
	        					pst.setString(5, rs.getString("cep_endereco_entrega"));
	        					pst.setString(6, rs.getString("cep_endereco_cobranca"));
	        					pst.setString(7, rs.getString("num_endereco_cobranca"));
	        					pst.setString(8, rs.getString("num_endereco_entrega"));
	        					pst.setInt(9, objPedido.getId());
	        					pst.setString(10, objPedido.getMotivoTroca());
	        					System.out.println(pst.toString());
	        					pst.executeUpdate();
	        					
	        					rs = pst.getGeneratedKeys();
	        					
	        					if(rs.next()) {
	        						num = rs.getInt(1);
	        					}
            				}
        					
        					for(Produto prod:objPedido.getProdutos()) {
        						connection.setAutoCommit(false);
        						try {
        						sql = new StringBuilder();
        						sql.append("INSERT INTO pedido_produtos (id_pedido_usuario, id_produto, id_qtd_produto, subtotal) "
        								+ "VALUES (?, ?, ?, ?)");
        						pst = connection.prepareStatement(sql.toString());
        						pst.setInt(1, num);
        						pst.setInt(2, prod.getId());
        						pst.setInt(3, prod.getQtd_pedido());
        						pst.setDouble(4, prod.getQtd_pedido()*prod.getPrecoUnitario());
        						
        						pst.executeUpdate();
        						connection.commit();
        						} catch(SQLException e) {
        							e.printStackTrace();
        						}
        					}
        					connection.setAutoCommit(false);
        					sql = new StringBuilder();
        					sql.append("INSERT INTO pagamento_pedidos (id_pedido, num_cartao, valor_pagamento, tipo_pagamento, bandeira_cartao) "
        							+ "VALUES(?, ?, ?, ?, ?)");
        					pst = connection.prepareStatement(sql.toString());
        					pst.setInt(1, num);
        					pst.setString(2, "Troca de produtos");
        					pst.setDouble(3, total);
        					pst.setString(4, "troca");
        					pst.setInt(5, 7);
        					
        					System.out.println(pst);
        					pst.executeUpdate();
        					connection.commit();
            			}
        			}else if(objPedido.getStatus().equals("Troca solicitada")) {
        				connection.setAutoCommit(false);
        				System.out.println("ENTROU PRA AUTORIZAR");
        				for(Produto prod:objPedido.getProdutos()) {
        					connection.setAutoCommit(false);
        					
        					sql=new StringBuilder();
        					sql.append("SELECT qtd_estoque_produto FROM produto WHERE id_produto=?");
        					pst = connection.prepareStatement(sql.toString());
        					pst.setInt(1, prod.getId());
        					int qtd = 0;
        					rs = pst.executeQuery();
        					if(rs.next()) {
        						qtd = rs.getInt("qtd_estoque_produto");
        					}
		        			
        					connection.commit();
        					
        					connection.setAutoCommit(false);
		        			
		        			sql = new StringBuilder();
		        			sql.append("UPDATE produto set qtd_estoque_produto=?");
		        			sql.append(" WHERE id_produto=?");
		        			
		        			pst = connection.prepareStatement(sql.toString());
		        			
		        			qtd = qtd + (prod.getQtd_pedido());
		        			
		        			pst.setInt(1, qtd);
		        			pst.setInt(2, prod.getId());
		        			
		        			
		        			pst.executeUpdate();
		        			connection.commit();
        				}
        				System.out.println("PASSOU DOS PROD");
        				connection.setAutoCommit(false);
        				sql=new StringBuilder();
        				sql.append("UPDATE pedidos set rota_entrega_pedido=? ");
    	    			sql.append("WHERE id_pedido=?");
    	    			
    	    			pst = connection.prepareStatement(sql.toString());
    	    			
    	    			pst.setString(1, "Troca autorizada");
    	    			pst.setInt(2, objPedido.getId());
    	    			
    	    			pst.executeUpdate();
    	    			connection.commit();
    	    			
    	    			
    	    			connection.setAutoCommit(false);
        				/*java.util.Date dt = new java.util.Date();
        				java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

        					String currentTime = sdf.format(dt);
            			*/
            			sql = new StringBuilder();
            			sql.append("INSERT INTO cupons_troca (valor_cupom, id_pedido_cupom, id_usuario_cupom, status_cupom, datacriacao_cupom, ativar) ");
            			sql.append("VALUES (?, ?, ?, ?, sysdate(), ?)");
            			
            			pst = connection.prepareStatement(sql.toString());
            			
            			pst.setDouble(1, objPedido.getValor_total());
            			pst.setInt(2, objPedido.getId());
            			pst.setInt(3, objPedido.getCliente().getId());
            			pst.setBoolean(4, true);
            			pst.setBoolean(5, false);
            			
            			pst.executeUpdate();
            			connection.commit();
        			}
        		} catch (SQLException e) {
	        			try {
							connection.rollback();
						}catch (SQLException e1) {
							e1.printStackTrace();
						}
						e.printStackTrace();
					}  finally {
						try {
							pst.close();
							connection.close();
						} catch (SQLException e) {
							e.printStackTrace();
						}
					}
        		}
        	else if(objPedido.getStatus()!=null) {
        		System.out.println("status nao e nulo!: "+objPedido.getStatus());
        		if(objPedido.getStatus().equals("Em processamento")) {
	        		try {
		        		connection.setAutoCommit(false);
		    			sql.append("UPDATE pedidos set rota_entrega_pedido=? ");
		    			sql.append("WHERE id_pedido=?");
		    			
		    			pst = connection.prepareStatement(sql.toString());
		    			pst.setString(1, "Em trânsito");
		    			pst.setInt(2, objPedido.getId());
		    			
		    			pst.executeUpdate();
		    			connection.commit();
	        		}catch (SQLException e) {
	        			try {
							connection.rollback();
						}catch (SQLException e1) {
							e1.printStackTrace();
						}
						e.printStackTrace();
					}  finally {
						try {
							pst.close();
							connection.close();
						} catch (SQLException e) {
							e.printStackTrace();
						}
					}
        		}else if(objPedido.getStatus().equals("Pedido negado")) {
        			System.out.println("Entrou negar pedido");
        			try {
    	        		connection.setAutoCommit(false);
    	    			sql.append("UPDATE pedidos set rota_entrega_pedido=? ");
    	    			sql.append("WHERE id_pedido=?");
    	    			
    	    			pst = connection.prepareStatement(sql.toString());
    	    			pst.setString(1, "Pedido negado");
    	    			pst.setInt(2, objPedido.getId());
    	    			
    	    			pst.executeUpdate();
    	    			connection.commit();
	        		}catch (SQLException e) {
	        			try {
							connection.rollback();
						}catch (SQLException e1) {
							e1.printStackTrace();
						}
						e.printStackTrace();
					}  finally {
						try {
							pst.close();
							connection.close();
						} catch (SQLException e) {
							e.printStackTrace();
						}
					}
        		}else if(objPedido.getStatus().equals("Em trânsito")) {
        			System.out.println("Entrou confirmar entrega");
        			try {
    	        		connection.setAutoCommit(false);
    	    			sql.append("UPDATE pedidos set rota_entrega_pedido=? ");
    	    			sql.append("WHERE id_pedido=?");
    	    			
    	    			pst = connection.prepareStatement(sql.toString());
    	    			pst.setString(1, "Entregue");
    	    			pst.setInt(2, objPedido.getId());
    	    			
    	    			pst.executeUpdate();
    	    			connection.commit();
	        		}catch (SQLException e) {
	        			try {
							connection.rollback();
						}catch (SQLException e1) {
							e1.printStackTrace();
						}
						e.printStackTrace();
					}  finally {
						try {
							pst.close();
							connection.close();
						} catch (SQLException e) {
							e.printStackTrace();
						}
					}
        		}
        	} else {
        		try {
        			System.out.println("ENTROU DENTRO DA DAO");
        			for(Produto prod:objPedido.getProdutos()) {
        				System.out.println("entrou for");
        				if(prod.getId()==objPedido.getId_item_atual()) {
	        				if(prod.isRemover()) {
	        					System.out.println("entrou remover");
	        					connection.setAutoCommit(false);
	        					
	        					sql=new StringBuilder();
	        					sql.append("SELECT qtd_estoque_produto FROM produto WHERE id_produto=?");
	        					pst = connection.prepareStatement(sql.toString());
	        					pst.setInt(1, prod.getId());
	        					int qtd = 0;
	        					ResultSet rs2 = pst.executeQuery();
	        					if(rs2.next()) {
	        						qtd = rs2.getInt("qtd_estoque_produto");
	        					}
			        			
	        					connection.commit();
	        					
	        					connection.setAutoCommit(false);
			        			
			        			sql = new StringBuilder();
			        			sql.append("UPDATE produto set qtd_estoque_produto=?");
			        			sql.append(" WHERE id_produto=?");
			        			
			        			pst = connection.prepareStatement(sql.toString());
			        			
			        			qtd = qtd + (prod.getQtdremover());
			        			
			        			pst.setInt(1, qtd);
			        			pst.setInt(2, prod.getId());
			        			
			        			
			        			pst.executeUpdate();
			        			connection.commit();
			        			
	        				} else {	        					
	        					connection.setAutoCommit(false);
	        					
	        					sql=new StringBuilder();
	        					sql.append("SELECT qtd_estoque_produto FROM produto WHERE id_produto=?");
	        					pst = connection.prepareStatement(sql.toString());
	        					pst.setInt(1, prod.getId());
	        					int qtd = 0;
	        					ResultSet rs3 = pst.executeQuery();
	        					if(rs3.next()) {
	        						qtd = rs3.getInt("qtd_estoque_produto");
	        					}
			        			
	        					connection.commit();
	        					connection.setAutoCommit(false);
	        					
			        			sql = new StringBuilder();
			        			sql.append("UPDATE produto set qtd_estoque_produto=?");
			        			sql.append(" WHERE id_produto=?");
			        			
			        			pst = connection.prepareStatement(sql.toString());
			        			System.out.println("QUANTIDADE: "+qtd);
			        			System.out.println("QTD PRODUTO: "+prod.getQtd_pedido());
			        			
			        			qtd = qtd - (prod.getQtd_pedido());
			        			System.out.println("QTD FINAL: "+qtd);
			        			pst.setInt(1, qtd);
			        			pst.setInt(2, prod.getId());			        			
			        			
			        			pst.executeUpdate();
			        			connection.commit();
	        				}
        				}
        			}
        			
        		} catch (SQLException e) {
        			try {
						connection.rollback();
					}catch (SQLException e1) {
						e1.printStackTrace();
					}
					e.printStackTrace();
				}  finally {
					try {
						pst.close();
						connection.close();
					} catch (SQLException e) {
						e.printStackTrace();
					}
        		}
        	}        		
        }
    }
	
	@Override
	public List<EntidadeDominio> consultar(EntidadeDominio entidade){
		System.out.println("ENTROU CONSULTAR");
		PreparedStatement pst = null;
		PreparedStatement pst2 = null;
		PreparedStatement pst3 = null;
		ResultSet rs2;
		ResultSet rs3;
		Pedido objPedido = (Pedido) entidade;
		StringBuilder sql = new StringBuilder();
		List<EntidadeDominio> pedidos = new ArrayList<EntidadeDominio>();
		
		System.out.println("entidade: "+objPedido);
		System.out.println("user: "+objPedido.getCliente());
		System.out.println("id: "+objPedido.getCliente().getId());
		
		sql.append("SELECT * FROM pedidos AS pedido ");
		sql.append("INNER JOIN pedido_produtos AS produtos ");
		sql.append("ON pedido.id_pedido = produtos.id_pedido_usuario ");
		sql.append("INNER JOIN pagamento_pedidos AS pagamentos ");
		sql.append("ON pedido.id_pedido = pagamentos.id_pedido ");
		sql.append("WHERE 1=1 ");
		
		System.out.println("PASSOU ate aqui");
		if(objPedido.getCliente().getId()!=null) {
			if(objPedido.getCliente().getId()>0) {
				//System.out.println("Entrou no if - PedidoDAO linha 465");
				sql.append(" AND id_usuario_pedido = "+objPedido.getCliente().getId());
			}
		}
		if(objPedido.getStatus()!=null) {
			if(objPedido.getStatus().equals("trocas")) {
				sql.append(" AND status_troca_pedido != 0");
			}
			else if(objPedido.getStatus().equals("abertos")) { // abertos: pedidos que o cliente não pediu para trocar
				sql.append(" AND status_troca_pedido = 0");
			}
		}
		sql.append(" GROUP BY pedido.id_pedido");
		System.out.println("ANTES DO RS NEXT - PedidoDAO - Consultar");
		
		try {
			openConnection();
			pst = connection.prepareStatement(sql.toString());
			ResultSet rs = pst.executeQuery();
			while(rs.next()) {
				//System.out.println("Entrou no rs.next do PedidoDAO CONSULTAR!");
				Pedido ped = new Pedido();				
				ped.setProdutos(new ArrayList<Produto>());
				ped.setCliente(new Cliente());
				ped.setEndEntrega(new Endereco());
				ped.setEndCobranca(new Endereco());
				ped.setId(rs.getInt("id_pedido"));
				ped.setValor_total(rs.getDouble("valor_pedido"));
				ped.setDataPedido(rs.getTimestamp("data_pedido"));
				ped.setStatus_troca_pedido(rs.getBoolean("status_troca_pedido"));
				ped.getCliente().setId(rs.getInt("id_usuario_pedido"));
				ped.setStatus(rs.getString("rota_entrega_pedido"));
				ped.getEndEntrega().setCEP(rs.getString("cep_endereco_entrega"));
				ped.getEndEntrega().setNumero(rs.getString("num_endereco_entrega"));
				ped.getEndCobranca().setCEP(rs.getString("cep_endereco_cobranca"));
				ped.getEndCobranca().setNumero(rs.getString("num_endereco_cobranca"));
				ped.setMotivoTroca(rs.getString("motivo_troca"));
			
				sql = new StringBuilder();
				sql.append("SELECT * FROM pedido_produtos as ped");
				sql.append(" INNER JOIN produto ");
				sql.append(" ON ped.id_produto = produto.id_produto");
				sql.append(" WHERE ped.id_pedido_usuario = ?");
				
				pst2 = connection.prepareStatement(sql.toString());
				pst2.setInt(1, ped.getId());
				rs2 = pst2.executeQuery();
				int i = 0;
				
				for(i = 0; rs2.next(); i++) {
    				if(ped.getId() == rs2.getInt("id_pedido_usuario")) {
    					ped.getProdutos().add(new Produto());
    					ped.getProdutos().get(i).setModeloProduto(rs2.getString("modelo_produto"));
    					ped.getProdutos().get(i).setQtd_pedido(rs2.getInt("id_qtd_produto"));
    					ped.getProdutos().get(i).setPrecoUnitario(rs2.getDouble("preco_unitario_produto"));
    					ped.getProdutos().get(i).setId(rs2.getInt("id_produto"));
    					ped.getProdutos().get(i).setPedido(ped.getId());
    					ped.getProdutos().get(i).setSubtotal(rs2.getDouble("subtotal"));
    					ped.setQtd_produtos(ped.getQtd_produtos()+rs2.getInt("id_qtd_produto"));
    				}
    			}
				
				sql = new StringBuilder();
				sql.append("SELECT * FROM pagamento_pedidos ");
				sql.append("WHERE id_pedido = ?");
				
				pst3 = connection.prepareStatement(sql.toString());
				pst3.setInt(1, ped.getId());
				rs3 = pst3.executeQuery();
				
				for(i = 0; rs3.next(); i++) {
					if(ped.getId() == rs3.getInt("id_pedido")) {
						if(rs3.getString("tipo_pagamento").equals("cartao")||rs3.getString("tipo_pagamento").equals("troca")) {
							ped.getCartoes().add(new Cartao());
							ped.getCartoes().get(i).setNumero_cartao(rs3.getString("num_cartao"));
							ped.getCartoes().get(i).setPedido(ped.getId());
							ped.getCartoes().get(i).setId_bandeira_cartao(rs3.getInt("bandeira_cartao"));
						}else {
							CupomTroca cupom = new CupomTroca();
							cupom.setValor(rs3.getDouble("valor_pagamento"));
							cupom.setId_pedido_cupom(rs3.getInt("id_pedido"));
							ped.getCuponsTroca().add(cupom);
						}
					}	
				}
				pedidos.add(ped);
			}
		} catch(SQLException e) {
				e.printStackTrace();
		}
		System.out.println(pedidos.size());
		return pedidos;
	}
	
}