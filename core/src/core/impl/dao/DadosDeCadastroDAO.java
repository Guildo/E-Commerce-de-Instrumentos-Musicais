package core.impl.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import auxiliar.DadosDeCadastro;
import dominio.Categoria;
import dominio.EntidadeDominio;

public class DadosDeCadastroDAO extends AbstractJdbcDAO{

	public DadosDeCadastroDAO() {
		super("categoria", "id-categoria");
		// TODO Auto-generated constructor stub
	}

	@Override
	public List<EntidadeDominio> consultar(EntidadeDominio entidade) throws SQLException {
		// TODO Auto-generated method stub
		openConnection();
		PreparedStatement pst = null;
		StringBuilder sql = new StringBuilder();
		DadosDeCadastro dados = new DadosDeCadastro();
		Categoria categoria = new Categoria();
		
		dados.setCategorias(new ArrayList<Categoria>());
		
	try {			
			sql = new StringBuilder();
			sql.append("SELECT * FROM categoria ");
			pst = connection.prepareStatement(sql.toString());
			ResultSet rs = pst.executeQuery();
			
			while(rs.next()) {
				categoria = new Categoria();
				categoria.setNomeCategoria(rs.getString("nome_categoria"));
				categoria.setId(rs.getInt("id_categoria"));
				dados.getCategorias().add(categoria);
				System.out.println(categoria.getNomeCategoria());
			}
			ArrayList<EntidadeDominio> utility = new ArrayList<EntidadeDominio>();
			utility.add(dados);
			return utility;
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
	return null;
	}
}