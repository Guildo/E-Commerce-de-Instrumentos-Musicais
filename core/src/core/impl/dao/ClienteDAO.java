package core.impl.dao;

import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.util.Calendar;
import java.util.Collection;

import com.sun.corba.se.spi.orb.ParserData;

import dominio.Cartao;
import dominio.Cliente;
import dominio.CupomTroca;
import dominio.Endereco;
import dominio.EntidadeDominio;

public class ClienteDAO extends AbstractJdbcDAO {

	public ClienteDAO() {
		super("clientes", "clienteID");
		// TODO Auto-generated constructor stub		
	}
	
	@SuppressWarnings("resource")
	@Override
	public void salvar(EntidadeDominio entidade) {
		// TODO Auto-generated method stub
		openConnection();                                       // abre a conexão com o Banco
        PreparedStatement pst = null;
        Cliente objCliente = (Cliente)entidade;
        //System.out.println(obCliente.getCartoes().get(0).getsNumCartao());
        System.out.println(objCliente.getNomeCliente() + " / " + objCliente.getEmailCliente() + 
        		" / " + objCliente.getSenhaCliente() + " / " + objCliente.getTelefoneCliente() + 
        		" / " + objCliente.getId() + 
        		" / " + objCliente.getEnderecos().get(0).getCEP() + 
        		" / " + objCliente.getEnderecos().get(0).getCidade() + 
        		" / " + objCliente.getEnderecos().get(0).getEstado() + 
        		" / " + objCliente.getEnderecos().get(0).getBairro() + 
        		" / " + objCliente.getEnderecos().get(0).getComplemento());
        StringBuilder sql;
        
        try {
			if(objCliente.getId() == 0) {		// novo cliente
				System.out.println("DAO - Cadastrando o cliente... ");
				connection.setAutoCommit(false);
				
				sql = new StringBuilder();
				sql.append("INSERT INTO clientes(nomeCliente, email, senha, telefone, isAdmin, isAtivo, dataCadastro) ");
				sql.append("VALUES (?,?,?,?,?,?,sysdate())");
				
				pst = connection.prepareStatement(sql.toString(), Statement.RETURN_GENERATED_KEYS);
				
				pst.setString(1, objCliente.getNomeCliente());
				pst.setString(2, objCliente.getEmailCliente());
				pst.setString(3, objCliente.getSenhaCliente());
				pst.setString(4, objCliente.getTelefoneCliente());
				pst.setBoolean(5, false);
				pst.setBoolean(6, true);
				
				pst.executeUpdate();
				
				ResultSet rs = pst.getGeneratedKeys();
                int id = 0;
                
    			if(rs.next()) {
    				id = rs.getInt(1);
        			objCliente.setId(id);
    			}
    			    			 
    			connection.commit();    			
    			
    			connection.setAutoCommit(false);
    			
    			sql = new StringBuilder();
    			sql.append("INSERT INTO enderecos(estado, cidade, bairro, complemento, cep, ende_clienteID, "
    					+ "tipo_residencia, tipo_logradouro, logradouro, numero) ");
    			sql.append("VALUES (?,?,?,?,?,?,?,?,?,?)");
    			
    			pst = connection.prepareStatement(sql.toString());
    			
    			pst.setString(1, objCliente.getEnderecos().get(0).getEstado());
    			pst.setString(2, objCliente.getEnderecos().get(0).getCidade());
    			pst.setString(3, objCliente.getEnderecos().get(0).getBairro());
    			pst.setString(4, objCliente.getEnderecos().get(0).getComplemento());
    			pst.setString(5, objCliente.getEnderecos().get(0).getCEP());
    			pst.setInt(6, objCliente.getId());
    			pst.setString(7, objCliente.getEnderecos().get(0).getTipoResidencia());
    			pst.setString(8, objCliente.getEnderecos().get(0).getTipoLogradouro());
    			pst.setString(9, objCliente.getEnderecos().get(0).getLogradouro());
    			pst.setString(10, objCliente.getEnderecos().get(0).getNumero());
    			
    			pst.executeUpdate();
    			
    			connection.commit();
			}
	
		} catch (SQLException e) {
            try {
            	System.out.println("Olá 1");
                connection.rollback();
                
            } catch (Exception e1) {                
                System.out.println("Olá 2");
                e1.printStackTrace();
            }
            e.printStackTrace();
        } finally {
            try {
            	System.out.println("Olá 3");
                pst.close();
                connection.close();
             } catch (SQLException e) {
            	 System.out.println("Olá 4");
                 e.printStackTrace();
             }
        }
	}

	@Override
	public void alterar(EntidadeDominio entidade) {
		// TODO Auto-generated method stub
        openConnection();
        PreparedStatement pst = null;
        Cliente objCliente = (Cliente) entidade;
        StringBuilder sql = new StringBuilder();
        
        if(objCliente.getNovaSenhaCliente() != null) {
        	try {
        		System.out.println("Alterando SENHA do cliente");
	        	connection.setAutoCommit(false);
	
	            sql = new StringBuilder();
	            sql.append("UPDATE clientes SET senha=? ");
	            sql.append("WHERE clienteID=?");
	
	            pst = connection.prepareStatement(sql.toString());
	
	            pst.setString(1, objCliente.getNovaSenhaCliente());
	            pst.setInt(2, objCliente.getId());
	            
	            pst.executeUpdate();
	            connection.commit();
        	}catch (SQLException e) {
	            try {
	                connection.rollback();
	            } catch (Exception e1) {
	                e1.printStackTrace();
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
        	
        } else {
            try {
            	System.out.println("Alterando DADOS do cliente");
                connection.setAutoCommit(false);

                sql = new StringBuilder();
                sql.append("UPDATE clientes SET nomeCliente=?, email=?, telefone=?");
                sql.append("WHERE clienteID=?");

                pst = connection.prepareStatement(sql.toString());

                pst.setString(1, objCliente.getNomeCliente());
                pst.setString(2, objCliente.getEmailCliente());
                pst.setString(3, objCliente.getTelefoneCliente());
                pst.setInt(4, objCliente.getId());

                System.out.println(pst.toString());
                System.out.println(sql.toString());
                pst.executeUpdate();
                connection.commit();
            }catch (SQLException e) {
            	try {
    	                connection.rollback();
    	            } catch (Exception e1) {
    	                e1.printStackTrace();
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

	@Override
	public void excluir(EntidadeDominio entidade) {
		// TODO Auto-generated method stub
		openConnection();
		PreparedStatement pst = null;
		StringBuilder sql;
		Cliente cliente = (Cliente) entidade;
		//System.out.println(cliente.getEnderecos().get(0).getCEP());
		//System.out.println(cliente.getCartoes().get(0).getsNumCartao());
		if (cliente.getId() != null && cliente.getEnderecos().get(0).getCEP() == null 
				&& cliente.getCartoes().get(0).getNumero_cartao() == null) {
			try {
				connection.setAutoCommit(false);
				System.out.println("DAO - desativar usuário");
				sql = new StringBuilder();
				sql.append("UPDATE clientes SET isAtivo=? ");
				sql.append("WHERE clienteID=?");
				
				pst = connection.prepareStatement(sql.toString());
				
				pst.setBoolean(1, false);
				pst.setInt(2, cliente.getId());
				
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
		}else if (cliente.getId() != null && cliente.getEnderecos().get(0).getCEP() != null 
				&& cliente.getCartoes().get(0).getNumero_cartao() == null){
			try {
				for (Endereco endereco : cliente.getEnderecos()) {
					
					connection.setAutoCommit(false);
					sql = new StringBuilder();
					sql.append("DELETE FROM enderecos ");
					sql.append("WHERE ende_clienteID=? AND cep=? ");
					
					pst = connection.prepareStatement(sql.toString());
					
					pst.setInt(1, cliente.getId());
					pst.setString(2, endereco.getCEP()); 
									
					System.out.println(pst.toString());
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
			
		} else if (cliente.getId() != null && cliente.getEnderecos().get(0).getCEP() == null 
				&& cliente.getCartoes().get(0).getNumero_cartao() != null){
			try {
				for (Cartao cartao : cliente.getCartoes()) {
					
					connection.setAutoCommit(false);
					sql = new StringBuilder();
					sql.append("DELETE FROM cartaocredito ");
					sql.append("WHERE cart_clienteID=? AND numeroCartao=?");
					
					pst = connection.prepareStatement(sql.toString());
					
					pst.setInt(1, cliente.getId());
					pst.setString(2, cartao.getNumero_cartao());
					
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
	}

	@Override
	public void ativar(EntidadeDominio entidade) {
		// TODO Auto-generated method stub
		openConnection();
		PreparedStatement pst = null;
		StringBuilder sql;
		
		Cliente cliente = (Cliente)entidade;
		
		try {	
			if(cliente.getCupons().size()>0) {
				System.out.println("ClienteDAO - Entrou ativar cupom");
				System.out.println("ID Cupom: " + cliente.getCupons().get(0).getId());
				connection.setAutoCommit(false);
				sql = new StringBuilder();
				sql.append("UPDATE cupons_troca SET ativar=? ");
				sql.append("WHERE id_cupom=?");
				pst = connection.prepareStatement(sql.toString());
				pst.setBoolean(1, true);
				pst.setInt(2, cliente.getCupons().get(0).getId());
				pst.executeUpdate();
				connection.commit();
			}else {
				connection.setAutoCommit(false);
				
				sql = new StringBuilder();
				sql.append("UPDATE clientes SET isAtivo=? ");
				sql.append("WHERE clienteID=?");
				
				pst = connection.prepareStatement(sql.toString());
				
				pst.setBoolean(1, true);
				pst.setInt(2, cliente.getId());
				
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

	@Override
	public List<EntidadeDominio> consultar(EntidadeDominio entidade) {
		// TODO Auto-generated method stub
		PreparedStatement pst = null;
    	PreparedStatement pst2 = null;
    	PreparedStatement pst3 = null;
    	PreparedStatement pst4 = null;
    	PreparedStatement pst5 = null;
    	System.out.println("CliendeDAO consultar 1");
    	
    	Cliente cliente = (Cliente) entidade;
    	List<EntidadeDominio> clientes = new ArrayList<EntidadeDominio>();
    	StringBuilder sql = new StringBuilder();
    	
    	sql.append("SELECT * FROM clientes ");							// Consulta de dados do cliente
    	/*sql.append("WHERE 1=1 ");
    	
    	try {
    	    sql.append(" AND isAdmin= '" + (cliente.getIsAdmin() ? 1 : 0) + "'");
    	}catch (Exception e) {
    	    
    	}
    	
    	try {
    	    sql.append(" AND isAtivo= '" + (cliente.getFlgAtivo() ? 1 : 0) + "'");
    	} catch (Exception e) {
    	    
    	}
    	
    	sql.append(" GROUP BY clienteID");
    	*/
    	try {
    		openConnection();
    		pst = connection.prepareStatement(sql.toString());
    		System.out.println(sql.toString());
    		ResultSet rs = pst.executeQuery();
    		ResultSet rs2;
    		ResultSet rs3;
    		ResultSet rs4;
    		ResultSet rs5;
    		Calendar cal = Calendar.getInstance();
    		while(rs.next()) {
    			Cliente cli = new Cliente();
    			cli.setId(rs.getInt("clienteID")); 
    			cli.setNomeCliente(rs.getString("nomeCliente"));    		
    			cli.setEmailCliente(rs.getString("email"));
    			cli.setSenhaCliente(rs.getString("senha"));
    			cli.setTelefoneCliente(rs.getString("telefone"));
    			cli.setCartoes(new ArrayList<Cartao>());
    			cli.setEnderecos(new ArrayList<Endereco>());
    			cli.setIsAdmin(rs.getBoolean("isAdmin"));
    			cli.setFlgAtivo(rs.getBoolean("isAtivo"));
    			
    			System.out.println(cli.getNomeCliente() + "  LaLALa");
    			
    			if(!cli.getIsAdmin())  {						// usuário NÃO é administrador
    				// consulta de entereços do cliente
    				System.out.println("ClienteDAO consultar endereços");
    				sql = new StringBuilder();
	    			sql.append(" SELECT * FROM enderecos WHERE ende_clienteID = ?");				
	    			 
	    			pst2 = connection.prepareStatement(sql.toString());
	    			pst2.setInt(1, cli.getId());
	    			rs2 = pst2.executeQuery();
	    			
	    			for(int i = 0; rs2.next(); i++) {
	    				if(cli.getId() == rs2.getInt("ende_clienteID")) {
	    					cli.getEnderecos().add(new Endereco());
	    					cli.getEnderecos().get(i).setId(rs2.getInt("enderecoID"));
	    					cli.getEnderecos().get(i).setIdCliente(rs2.getInt("ende_clienteID"));
	    					cli.getEnderecos().get(i).setLogradouro(rs2.getString("logradouro"));
	    					cli.getEnderecos().get(i).setNumero(rs2.getString("numero"));
	    					cli.getEnderecos().get(i).setBairro(rs2.getString("bairro"));
	    					cli.getEnderecos().get(i).setCEP(rs2.getString("cep"));
	    					cli.getEnderecos().get(i).setCidade(rs2.getString("cidade"));
	    					cli.getEnderecos().get(i).setEstado(rs2.getString("estado"));
	    					cli.getEnderecos().get(i).setComplemento(rs2.getString("complemento"));
	    					cli.getEnderecos().get(i).setTipoResidencia(rs2.getString("tipo_residencia"));
	    					cli.getEnderecos().get(i).setTipoLogradouro(rs2.getString("tipo_logradouro"));
	    				} /*else {
	    					break;
	    				}*/
	    			}
	    			
	    			// consulta de cartões do cliente
	    			System.out.println("ClienteDAO consultar cartões");
	    			sql = new StringBuilder();
					sql.append("SELECT * FROM cartoes_credito WHERE id_usuario_cartao = ?");
					pst3 = connection.prepareStatement(sql.toString());
					pst3.setInt(1, cli.getId());
					rs3 = pst3.executeQuery();
					int n;
					for(n = 0; rs3.next(); n++) {
						if(cli.getId() == rs3.getInt("id_usuario_cartao")) {
							cli.getCartoes().add(new Cartao());
							cli.getCartoes().get(n).setNumero_cartao(rs3.getString("numero_cartao"));
							cal.setTime(rs3.getDate("validade_cartao"));
							int mes = cal.get(Calendar.MONTH);
							
							System.out.println(cal.get(Calendar.MONTH));
							mes = mes + 1;
							cli.getCartoes().get(n).setMes_cartao(String.valueOf(mes));
							cli.getCartoes().get(n).setAno_cartao(String.valueOf(cal.get(Calendar.YEAR)));
							cli.getCartoes().get(n).setCvv_cartao(rs3.getString("cvv_cartao"));
							cli.getCartoes().get(n).setNome_cartao(rs3.getString("nome_cartao"));
							cli.getCartoes().get(n).setId_usuario_cartao(rs3.getInt("id_usuario_cartao"));
							cli.getCartoes().get(n).setId_bandeira_cartao(rs3.getInt("id_bandeira_cartao"));						
						}
					}
					
					System.out.println("ClienteDAO consultar Cupons");
	    			sql = new StringBuilder();
					sql.append("SELECT * FROM cupons_troca WHERE id_usuario_cupom = ?");
					pst4 = connection.prepareStatement(sql.toString());
					pst4.setInt(1, cli.getId());
					rs4 = pst4.executeQuery();
					int j;
					for(j = 0; rs4.next(); j++) {
						if(cli.getId() == rs4.getInt("id_usuario_cupom")) {
							System.out.println("O cliente tem copum de troca");
							cli.getCupons().add(new CupomTroca());
							cli.getCupons().get(j).setId(rs4.getInt("id_cupom"));
							cli.getCupons().get(j).setValor(rs4.getDouble("valor_cupom"));
							cli.getCupons().get(j).setId_pedido_cupom(rs4.getInt("id_pedido_cupom"));	
							cli.getCupons().get(j).setId_usuario_cupom(rs4.getInt("id_usuario_cupom"));
							cli.getCupons().get(j).setStatus_cupom(rs4.getBoolean("status_cupom"));
							cli.getCupons().get(j).setData_cupom(rs4.getDate("datacriacao_cupom"));
							cli.getCupons().get(j).setHabilitar(rs4.getBoolean("ativar"));
						}
						System.out.println("ID Cupom: " + cli.getCupons().get(j).getId());
						System.out.println("Valor Cupom: " + cli.getCupons().get(j).getValor());
					}
					
					System.out.println("ClienteDAO consultar FRETE");
					sql = new StringBuilder();
					sql.append("SELECT * FROM frete WHERE estado_frete=?");
					pst5 = connection.prepareStatement(sql.toString());
					pst5.setString(1, cli.getEnderecos().get(0).getEstado());
					rs5 = pst5.executeQuery();
					int x;
					for(x = 0; rs5.next(); x++) {
						if(cli.getEnderecos().get(0).getEstado().equals(rs5.getString("estado_frete"))) {
							cli.setFrete(rs5.getDouble("preco_frete"));
							System.out.println("Valor do Frete: " + cli.getFrete());
						}
					}
    			}
    			clientes.add(cli);
    		}
    	}catch (Exception e) {
			e.printStackTrace();
		}
		
		return clientes;
	}

}
