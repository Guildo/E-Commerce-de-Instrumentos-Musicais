package core.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class Conexao {
	public static Connection getConnection()
		throws ClassNotFoundException, 
		SQLException{
		String driver = "com.mysql.jdbc.Driver";
		String url = "jdbc:mysql://localhost:3306/projeto2?useTimezone=true&serverTimezone=UTC";
		String user = "root";
		String paswd = "";
		Class.forName( driver );
		Connection conn = DriverManager.getConnection(url, user, paswd);
		
		return conn;
	}
}