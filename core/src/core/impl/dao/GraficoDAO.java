package core.impl.dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import auxiliar.ItemsGrafico;
import dominio.Categoria;
import dominio.EntidadeDominio;
import dominio.Grafico;
import dominio.Pedido;
import dominio.Produto;
import dominio.Cliente;

public class GraficoDAO extends AbstractJdbcDAO {

	public GraficoDAO() {
		super ("pedidos", "id_pedido");
	}
	
	@Override
	public void salvar(EntidadeDominio entidade) {
		
	}
	
	@Override
	public void alterar(EntidadeDominio entidade) {
	
	}
	
	@Override
	public void excluir(EntidadeDominio entidade) {
		
	}
	
	@Override
	public List<EntidadeDominio> consultar(EntidadeDominio entidade){
		PreparedStatement pst = null;
		PreparedStatement pst2 = null;
		Grafico objGrafico = (Grafico) entidade;
		ItemsGrafico items = new ItemsGrafico();
		Pedido pedido = new Pedido();
		
		Cliente user = new Cliente();		
		
		List<EntidadeDominio> graficos = new ArrayList<EntidadeDominio>();
		ArrayList<ItemsGrafico> dados = new ArrayList<ItemsGrafico>();
		ArrayList<Produto> produtos = new ArrayList<Produto>();
		ArrayList<Produto> produtos2 = new ArrayList<Produto>();
		/*
		 * if(objGrafico.getTipografico().equals("pedidos")) { //query para grafico de
		 * pedidos }
		 * 
		 * if(objGrafico.getTipografico().equals("users")) { //query para grafico de
		 * users }
		 * 
		 * if(objGrafico.getTipografico().equals("produtos")) { //query para grafico de
		 * produtos }
		 */
		openConnection();
		
		StringBuilder sql = new StringBuilder();
		
		sql.append("SELECT YEAR(pedido.data_pedido) AS year, MONTH(pedido.data_pedido) AS date, ");
		sql.append("SUM(pp.id_qtd_produto) AS total, ");
		sql.append("c.nome_categoria AS nome_cat ");
		sql.append("FROM pedidos AS pedido ");
		sql.append("INNER JOIN pedido_produtos pp ON pp.id_pedido_usuario = id_pedido ");
		sql.append("INNER JOIN produto p ON p.id_produto = pp.id_produto ");
		sql.append("INNER JOIN categoria c ON c.id_categoria = p.categoria_id ");
			
		/*if(objGrafico.getMes_cat()!=null && objGrafico.getMesf_cat()!=null && objGrafico.getAno_cat()!=null && objGrafico.getAnof_cat()!=null) {
			sql.append("WHERE YEAR(pedido.data_pedido) BETWEEN "+objGrafico.getAno_cat()+ " AND " + objGrafico.getAnof_cat() +
					" AND MONTH(pedido.data_pedido) BETWEEN "+objGrafico.getMes_cat()+" AND "+objGrafico.getMesf_cat());
		}else if(objGrafico.getAno_cat()!=null && objGrafico.getMes_cat()!=null) {
			sql.append("WHERE YEAR(pedido.data_pedido) = "+objGrafico.getAno_cat()+" AND MONTH(pedido.data_pedido) = "+objGrafico.getMes_cat());
		}*/ if(objGrafico.getAno_cat()!=null && objGrafico.getAnof_cat() != null) {
			sql.append("WHERE pedido.data_pedido BETWEEN '"+ objGrafico.getAno_cat()+ "' AND '" + objGrafico.getAnof_cat() + "'");
		}else if(objGrafico.getAno_cat()!=null) {
			sql.append("WHERE YEAR(pedido.data_pedido) = "+objGrafico.getAno_cat());
		}
		//sql.append("WHERE YEAR(pedido.data_pedido) = 2019 and MONTH(pedido.data_pedido) = 5 ");
		sql.append(" GROUP BY date, nome_cat ");
		sql.append("order by year, date asc");
		if(objGrafico.getQtd_cat()!=null && !objGrafico.getQtd_cat().equals("")) {
			sql.append(" LIMIT "+objGrafico.getQtd_cat());
		}
		sql.append(";");
		try {
			connection.setAutoCommit(false);
			pst = connection.prepareStatement(sql.toString());
			System.out.println("Query1: "+ pst);
			ResultSet rs = pst.executeQuery();
			while(rs.next()) {
				Produto produto = new Produto();
				Categoria categoria = new Categoria();
				categoria.setNomeCategoria(rs.getString("nome_cat"));
				produto.setCategoria(categoria);
				produto.setQtdtotal(rs.getInt("total"));
				produto.setGraficoMes(rs.getInt("date"));
				produto.setGraficoAno(rs.getInt("year"));
				produtos.add(produto);
			}
		
			sql = new StringBuilder();
			sql.append("SELECT YEAR(pedido.data_pedido) AS year2, MONTH(pedido.data_pedido) AS date2, ");
			sql.append("SUM(pp.id_qtd_produto) AS total, ");
			sql.append("p.modelo_produto AS nome, ");
			sql.append("p.marca_produto AS nome_marca ");
			sql.append("FROM pedidos AS pedido ");
			sql.append("INNER JOIN pedido_produtos pp ON pp.id_pedido_usuario = id_pedido ");
			sql.append("INNER JOIN produto p ON p.id_produto = pp.id_produto ");
			//sql.append("INNER JOIN marcas m ON m.id_marca = p.id_marca_produto ");
			
			/*if(objGrafico.getMes_prd()!=null && objGrafico.getMesf_prd()!=null && objGrafico.getAno_prd()!=null && objGrafico.getAnof_prd()!=null) {
				sql.append("WHERE YEAR(pedido.data_pedido) BETWEEN "+ objGrafico.getAno_prd()+ " AND " + objGrafico.getAnof_prd() +
						" AND MONTH(pedido.data_pedido) BETWEEN "+ objGrafico.getMes_prd()+ " AND " + objGrafico.getMesf_prd());
			}else if(objGrafico.getAno_prd()!=null && objGrafico.getMes_prd()!=null) {
				sql.append("WHERE YEAR(pedido.data_pedido) = "+objGrafico.getAno_prd()+" AND MONTH(pedido.data_pedido) = "+objGrafico.getMes_prd());
			}else*/ if(objGrafico.getAno_prd() != null && objGrafico.getAnof_prd() != null) {
				sql.append("WHERE pedido.data_pedido BETWEEN '"+ objGrafico.getAno_prd()+ "' AND '" + objGrafico.getAnof_prd() + "'");
			}else if(objGrafico.getAno_prd() != null) {
				sql.append("WHERE YEAR(pedido.data_pedido) = "+objGrafico.getAno_prd());
			}
			//sql.append("where YEAR(pedido.data_pedido) = 2019 and MONTH(pedido.data_pedido) = 5 ");
			sql.append(" group by date2, p.modelo_produto ");
			sql.append("order by year2, date2 asc ");
			if(objGrafico.getQtd_prd()!=null && !objGrafico.getQtd_prd().equals("")) {
				sql.append(" LIMIT "+objGrafico.getQtd_prd());
			}
			sql.append(";");
			connection.setAutoCommit(false);
			pst2 = connection.prepareStatement(sql.toString());
			System.out.println("Query2: "+ pst2);
			rs = pst2.executeQuery();
			while(rs.next()) {
				Produto produto = new Produto();
				produto.setModeloProduto(rs.getString("nome"));
				produto.setMarcaProduto(rs.getString("nome_marca"));
				produto.setQtdtotal(rs.getInt("total"));
				produto.setGraficoMes(rs.getInt("date2"));
				produto.setGraficoAno(rs.getInt("year2"));
				produtos2.add(produto);
			}
		
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			try {
			pst.close();
			pst2.close();
			connection.close();
			}catch(SQLException e) {
				
			}
		}
		items.setProdutos2(produtos2);
		items.setProdutos(produtos);
		dados.add(items);
		objGrafico.setItems(dados);
		graficos.add(objGrafico);
		
		return graficos;
	}	
}