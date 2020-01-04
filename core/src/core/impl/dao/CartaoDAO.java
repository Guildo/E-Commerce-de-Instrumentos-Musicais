package core.impl.dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import dominio.Cartao;
import dominio.EntidadeDominio;

public class CartaoDAO extends AbstractJdbcDAO {

	public CartaoDAO() {
		super ("cartoes_credito", "id_cartao");
	}
	
	@Override
	public void salvar(EntidadeDominio entidade) {
		openConnection();
		PreparedStatement pst = null;
		Cartao objCartao = (Cartao)entidade;
		try {
			connection.setAutoCommit(false);
			
			StringBuilder sql = new StringBuilder();
					
			sql = new StringBuilder();
			
			sql.append("INSERT INTO cartoes_credito "
					+ "(numero_cartao, "					
					+ "mes_validade_cartao, "
					+ "ano_validade_cartao, "
					+ "validade_cartao, "
					+ "cvv_cartao, "
					+ "nome_cartao, "
					+ "id_usuario_cartao, "
					+ "id_bandeira_cartao, "
					+ "status_cartao) "
					+ "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)");
			pst = connection.prepareStatement(sql.toString());
			
			pst.setString(1, objCartao.getNumero_cartao());
			pst.setString(2, objCartao.getMes_cartao());
			pst.setString(3, objCartao.getAno_cartao());
			pst.setString(4, objCartao.getMes_cartao() + objCartao.getAno_cartao());
			pst.setString(5, objCartao.getCvv_cartao());
			pst.setString(6, objCartao.getNome_cartao());
			pst.setInt(7, objCartao.getId_usuario_cartao());
			pst.setInt(8, objCartao.getId_bandeira_cartao());
			pst.setBoolean(9, true);
			
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
		System.out.println("ENTROU NA DAO cartao");		
		openConnection();
		PreparedStatement pst = null;
		Cartao objCartao = (Cartao)entidade;
		StringBuilder sql = new StringBuilder();
		
			try {
				connection.setAutoCommit(false);
				sql.append("UPDATE cartoes_credito SET numero_cartao=?, ");
				sql.append("mes_validade_cartao=?, ano_validade_cartao=?, ");
				sql.append("validade_cartao=?, cvv_cartao=?, ");
				sql.append("nome_cartao=?, id_bandeira_cartao=? ");
				sql.append("WHERE id_cartao="+objCartao.getId()+" AND id_usuario_cartao="+objCartao.getId_usuario_cartao());
				
				pst = connection.prepareStatement(sql.toString());
			
				pst.setString(1, objCartao.getNumero_cartao());
				pst.setString(2, objCartao.getMes_cartao());
				pst.setString(3, objCartao.getAno_cartao());
				pst.setString(4, objCartao.getMes_cartao() + objCartao.getAno_cartao());
				pst.setString(5, objCartao.getCvv_cartao());
				pst.setString(6, objCartao.getNome_cartao());
				pst.setInt(7, objCartao.getId_bandeira_cartao());
				
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
				} catch (SQLException e){
					e.printStackTrace();
				}
			}
		}
	
	@Override
	public void excluir(EntidadeDominio entidade) {
		System.out.println("entrou na dao excluir");
		openConnection();
		PreparedStatement pst = null;
		Cartao objCartao = (Cartao)entidade;
		
		try {
			connection.setAutoCommit(false);
			StringBuilder sql = new StringBuilder();
			sql.append("DELETE FROM cartoes_credito ");
			sql.append("WHERE id_cartao=?");
			
			pst = connection.prepareStatement(sql.toString());
			
			pst.setInt(1, objCartao.getId());
			
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
		Cartao objCartao = (Cartao)entidade;
		StringBuilder sql = new StringBuilder();
		List<EntidadeDominio> cartoes = new ArrayList<EntidadeDominio>();
		
		System.out.println("ENTROU CONSULTAR cartoes");
		sql.append("SELECT * FROM cartoes_credito ");
		sql.append("WHERE 1=1");
		
		if(objCartao.getId_usuario_cartao()>0) {
			sql.append(" AND id_usuario_cartao="+objCartao.getId_usuario_cartao());
		}
		
		try {
			openConnection();
			pst = connection.prepareStatement(sql.toString());
			ResultSet rs = pst.executeQuery();
			Calendar cal = Calendar.getInstance();
			while(rs.next()) {
				Cartao card = new Cartao();
				card.setId(rs.getInt("id_cartao"));
				card.setNumero_cartao(rs.getString("numero_cartao"));				
				card.setAno_cartao(rs.getString("ano_validade_cartao"));
				card.setMes_cartao(rs.getString("mes_validade_cartao"));
				card.setCvv_cartao(rs.getString("cvv_cartao"));
				card.setNome_cartao(rs.getString("nome_cartao"));
				card.setId_usuario_cartao(rs.getInt("id_usuario_cartao"));
				card.setId_bandeira_cartao(rs.getInt("id_bandeira_cartao"));
				card.setStatus_cartao(rs.getBoolean("status_cartao"));
				cartoes.add(card);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return cartoes;
	}
	
}