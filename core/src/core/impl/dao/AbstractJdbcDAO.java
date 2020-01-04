package core.impl.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLClientInfoException;
import java.sql.SQLException;
import java.util.List;

import core.IDAO;
import core.util.Conexao;
import dominio.EntidadeDominio;

public class AbstractJdbcDAO implements IDAO{
	protected Connection connection;
	protected String table;
	protected String idTable;
	protected boolean ctrlTransaction = true;
	
	public AbstractJdbcDAO(Connection connection, String table, String idTable) {
		this.table = table;
		this.idTable = idTable;
		this.connection = connection;
	}
	
	protected AbstractJdbcDAO( String table, String idTable) {
		this.table = table;
		this.idTable = idTable;
	}
	
	protected void openConnection() {
		try {
			if(connection == null || connection.isClosed())
				connection = Conexao.getConnection();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	@Override
	public void salvar(EntidadeDominio entidade) throws SQLException {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void alterar(EntidadeDominio entidade) throws SQLException {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void excluir(EntidadeDominio entidade) throws SQLException {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void ativar(EntidadeDominio entidade) throws SQLException {
		// TODO Auto-generated method stub
		
	}

	@Override
	public List<EntidadeDominio> consultar(EntidadeDominio entidade) throws SQLException {
		// TODO Auto-generated method stub
		return null;
	}
}
