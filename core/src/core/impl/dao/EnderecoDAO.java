package core.impl.dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import dominio.Endereco;
import dominio.EntidadeDominio;

public class EnderecoDAO extends AbstractJdbcDAO {

	public EnderecoDAO() {
		super ("enderecos", "id_endereco");
	}
	
	@Override
	public void salvar(EntidadeDominio entidade) {
		openConnection();
		PreparedStatement pst = null;
		Endereco objEndereco = (Endereco)entidade;
		try {
			connection.setAutoCommit(false);
			
			StringBuilder sql = new StringBuilder();
			
			sql = new StringBuilder();
			
			sql.append("INSERT INTO enderecos(estado, cidade, bairro, complemento, cep, ende_clienteID, "
					+ "tipo_residencia, tipo_logradouro, logradouro, numero) ");
			sql.append("VALUES (?,?,?,?,?,?,?,?,?,?)");
			
			pst = connection.prepareStatement(sql.toString());
			
			pst.setString(1, objEndereco.getEstado());
			pst.setString(2, objEndereco.getCidade());
			pst.setString(3, objEndereco.getBairro());
			pst.setString(4, objEndereco.getComplemento());
			pst.setString(5, objEndereco.getCEP());
			pst.setInt(6, objEndereco.getIdCliente());
			pst.setString(7, objEndereco.getTipoResidencia());
			pst.setString(8, objEndereco.getTipoLogradouro());
			pst.setString(9, objEndereco.getLogradouro());
			pst.setString(10, objEndereco.getNumero());
			
			pst.executeUpdate();
			connection.commit();
			
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
	
	@Override
	public void alterar(EntidadeDominio entidade) {
		System.out.println("ENTROU NA DAO alterar endereco");		
		openConnection();
		PreparedStatement pst = null;
		Endereco objEndereco = (Endereco)entidade;
		System.out.println(objEndereco.getId());
		System.out.println(objEndereco.getIdCliente());
		StringBuilder sql = new StringBuilder();
		
			try {
				connection.setAutoCommit(false);
				sql.append("UPDATE enderecos SET bairro=?, cep=?, cidade=?, estado=?, complemento=?, "
						+ "tipo_residencia=?, tipo_logradouro=?, logradouro=?, numero=? ");
                sql.append("WHERE enderecoID=?");

                pst = connection.prepareStatement(sql.toString());               
                	            
                pst.setString(1, objEndereco.getBairro());
                pst.setString(2, objEndereco.getCEP());
                pst.setString(3, objEndereco.getCidade());
                pst.setString(4, objEndereco.getEstado());
                pst.setString(5, objEndereco.getComplemento());
                pst.setString(6, objEndereco.getTipoResidencia());
    			pst.setString(7, objEndereco.getTipoLogradouro());
    			pst.setString(8, objEndereco.getLogradouro());
    			pst.setString(9, objEndereco.getNumero());
    			pst.setInt(10, objEndereco.getId());
				
				pst.executeUpdate();
				connection.commit();
				
			} catch (SQLException e) {
				try {
					System.out.println("Singaro 0.1");
					connection.rollback();
				} catch (SQLException el) {
					System.out.println("Singaro 0.2");
					el.printStackTrace();
				}
				e.printStackTrace();
			} finally {
				try {
					System.out.println("Singaro 0.3");
					pst.close();
					connection.close();
				} catch (SQLException e){
					System.out.println("Singaro 0.4");
					e.printStackTrace();
				}
			}
		}
	
	@Override
	public void excluir(EntidadeDominio entidade) {
		System.out.println("entrou na dao excluir");
		openConnection();
		PreparedStatement pst = null;
		Endereco objEndereco = (Endereco)entidade;
		System.out.println("ID do endereço excluído: " + objEndereco.getId());
		try {
			connection.setAutoCommit(false);
			StringBuilder sql = new StringBuilder();
			sql.append("DELETE FROM enderecos ");
			sql.append(" WHERE enderecoID=?");
			
			pst = connection.prepareStatement(sql.toString());
			
			pst.setInt(1, objEndereco.getId());
			
			pst.executeUpdate();
			connection.commit();
			
		} catch(SQLException e) {
			try {
				connection.rollback();
			} catch(SQLException el) {
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

	
	
	@Override
	public List<EntidadeDominio> consultar(EntidadeDominio entidade){
		PreparedStatement pst = null;
		Endereco objEndereco = (Endereco)entidade;
		StringBuilder sql = new StringBuilder();
		List<EntidadeDominio> enderecos = new ArrayList<EntidadeDominio>();
		System.out.println("ENTROU CONSULTAR ENDERECOS");
		sql.append("SELECT * FROM enderecos ");
		sql.append("WHERE 1=1");
		
		if(objEndereco.getIdCliente()>0) {
			sql.append(" AND ende_clienteID="+objEndereco.getIdCliente());
		}
		
		try {
			openConnection();
			pst = connection.prepareStatement(sql.toString());
			ResultSet rs = pst.executeQuery();
			while(rs.next()) {
				Endereco end = new Endereco();
				end.setId(rs.getInt("enderecoID"));
				end.setLogradouro(rs.getString("logradouro"));
				end.setTipoLogradouro(rs.getString("tipo_logradouro"));
				end.setTipoResidencia(rs.getString("tipo_residencia"));
				end.setNumero(rs.getString("numero"));
				end.setBairro(rs.getString("bairro"));
				end.setCidade(rs.getString("cidade"));
				end.setEstado(rs.getString("estado"));
				end.setCEP(rs.getString("cep"));
				end.setComplemento(rs.getString("complemento"));
				end.setIdCliente(rs.getInt("ende_clienteID"));

				enderecos.add(end);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return enderecos;
	}
	
}
