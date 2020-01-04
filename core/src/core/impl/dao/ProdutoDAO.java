package core.impl.dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import dominio.EntidadeDominio;
import dominio.Categoria;
import dominio.Produto;

public class ProdutoDAO  extends AbstractJdbcDAO {
	public ProdutoDAO() {
		super("produto", "id_produto");
	}
	
	
	public void salvar(EntidadeDominio entidade) {
		openConnection();
		PreparedStatement pst = null;
		Produto produto = (Produto)entidade;
		
		try {
				connection.setAutoCommit(false);
				
				StringBuilder sql = new StringBuilder();
				sql.append("INSERT INTO produto (modelo_produto, marca_produto, cor_produto, "
						+ "preco_unitario_produto, categoria_id, isAtivo, imagem_produto, qtd_estoque_produto)");
				sql.append(" VALUES (?,?,?,?,?,?,?,?)");
				
				pst = connection.prepareStatement(sql.toString(), Statement.RETURN_GENERATED_KEYS);
				
				pst.setString(1, produto.getModeloProduto());
				pst.setString(2, produto.getMarcaProduto());
				pst.setString(3, produto.getCorProduto());
				pst.setDouble(4, produto.getPrecoUnitario());
				pst.setInt(5, produto.getCategoria().getId());
				pst.setBoolean(6, true);
				pst.setString(7, produto.getImagemProduto());
				pst.setInt(8, produto.getQtd_estoque());
				
				pst.executeUpdate();
				
				ResultSet rs = pst.getGeneratedKeys();
				
				connection.commit();
							
		} catch (SQLException e) {
			try {
				connection.rollback();
			} catch (SQLException e1) {
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
	
	public void alterar(EntidadeDominio entidade) {
		openConnection();
		PreparedStatement pst = null;
		Produto produto = (Produto)entidade;
		
		if(produto.getModeloProduto() != null) {
			try {
				System.out.println("Entrou na DAO ALTERAR");
				connection.setAutoCommit(false);
				
				StringBuilder sql = new StringBuilder();
				sql.append("UPDATE produto SET modelo_produto=?, marca_produto=?, cor_produto=?, preco_unitario_produto=?, "
						+ "categoria_id=?, descricao_produto=?, imagem_produto=?, qtd_estoque_produto=? ");
				sql.append("WHERE id_produto=?");
				
				pst = connection.prepareStatement(sql.toString());
				System.out.println(pst.toString() + "GUILDO");
				
				pst.setString(1, produto.getModeloProduto());
				pst.setString(2, produto.getMarcaProduto());
				pst.setString(3, produto.getCorProduto());
				pst.setDouble(4, produto.getPrecoUnitario());
				pst.setInt(5, produto.getCategoria().getId());
				pst.setString(6, produto.getDescricaoProduto());
				pst.setString(7, produto.getImagemProduto());
				pst.setInt(8, produto.getId());
				pst.setInt(9, produto.getQtd_estoque());
				
				System.out.println(produto.getModeloProduto() + " / " + produto.getMarcaProduto() + " / " + produto.getModeloProduto() + " / " + produto.getPrecoUnitario() + " / " + produto.getCategoria().getId()+ " / " + produto.getId());
				
				pst.executeUpdate();
				connection.commit();
				
				System.out.println("Passou pela DAO ALTERAR");
			} catch (SQLException e) {
				try {
					connection.rollback();
				} catch (SQLException e1) {
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
	
	public void excluir(EntidadeDominio entidade) {
		openConnection();
		PreparedStatement pst = null;
		Produto produto = (Produto)entidade;
		
		try {
			connection.setAutoCommit(false);
			
			System.out.println("ProdutoDAO excluir - motivo desativação: " + produto.getMotivoDesativacao());
			System.out.println("ID: " + produto.getId());
			
			StringBuilder sql = new StringBuilder();
			sql.append("UPDATE produto SET isAtivo=?, motivo_desativacao=? ");
			sql.append("WHERE id_produto=? ");
			
			pst = connection.prepareStatement(sql.toString());
			
			pst.setBoolean(1, false);
			pst.setString(2, produto.getMotivoDesativacao());
			pst.setInt(3, produto.getId());
			
			pst.executeUpdate();
			
			connection.commit();
			
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
	
	public void ativar (EntidadeDominio entidade) {
		openConnection();
		PreparedStatement pst = null;
		Produto produto = (Produto)entidade;
		
		try {
			connection.setAutoCommit(false);
			
			StringBuilder sql = new StringBuilder();
			sql.append("UPDATE produto SET isAtivo=?, motivo_ativacao=? ");
			sql.append("WHERE id_produto=?");
			
			pst = connection.prepareStatement(sql.toString());
			
			pst.setBoolean(1, true);
			pst.setString(2, produto.getMotivoAtivacao());
			pst.setInt(3, produto.getId());
			
			pst.executeUpdate();
			
			connection.commit();
			
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
	
	public List<EntidadeDominio> consultar (EntidadeDominio entidade){
		PreparedStatement pst = null;
		Produto produto = (Produto)entidade;
		
		List<EntidadeDominio> produtos = new ArrayList<EntidadeDominio>();
		StringBuilder sql = new StringBuilder();
		
		sql.append("SELECT produto.id_produto, produto.modelo_produto, ");
		sql.append("produto.marca_produto, produto.cor_produto, ");
		sql.append("categoria.nome_categoria, produto.preco_unitario_produto, ");
		sql.append("produto.descricao_produto ,produto.imagem_produto, produto.isAtivo, ");
		sql.append("produto.qtd_estoque_produto, produto.motivo_desativacao ");
		sql.append("FROM produto ");
		sql.append("INNER JOIN categoria ");
		sql.append("ON produto.categoria_id = categoria.id_categoria ");
		sql.append("WHERE 1=1 ");
		/*		
		if(produto.getQtdEstoque() == 1) 
			sql.append(" AND quantidade > 0");
		
		try {
			System.out.println(produto.isAtivo());
			if(produto.isAtivo()) {
				sql.append(" AND isAtivo= " + produto.isAtivo());
			} else if(!produto.isAtivo()) {
				sql.append(" AND isAtivo= " + produto.isAtivo());
			}
		} catch (Exception e) {
			
		}*/
		
		try {
			openConnection();
			pst = connection.prepareStatement(sql.toString());
			System.out.println(pst.toString() + "LOL");
			ResultSet rs = pst.executeQuery();
			while(rs.next()) {
				Produto prod = new Produto();
				prod.setCategoria(new Categoria());
				prod.setId(rs.getInt("id_produto"));
				prod.setModeloProduto(rs.getString("modelo_produto"));
				prod.setMarcaProduto(rs.getString("marca_produto"));
				prod.setCorProduto(rs.getString("cor_produto"));
				prod.getCategoria().setNomeCategoria(rs.getString("nome_categoria"));;
				prod.setPrecoUnitario(rs.getDouble("preco_unitario_produto"));
				prod.setDescricaoProduto(rs.getString("descricao_produto"));
				prod.setImagemProduto(rs.getString("imagem_produto"));
				//prod.setDtCadastro(rs.getDate("dataCadastro"));
				prod.setAtivo(rs.getBoolean("isAtivo"));
				prod.setQtd_estoque(rs.getInt("qtd_estoque_produto"));
				prod.setMotivoDesativacao(rs.getString("motivo_desativacao"));
				produtos.add(prod);
			}
			System.out.println("LOL FIM");
		} catch (SQLException e) {
			e.printStackTrace();
		}
		System.out.println(produtos.get(0).getId() + " getID");
		return produtos;		
		
	}
}
