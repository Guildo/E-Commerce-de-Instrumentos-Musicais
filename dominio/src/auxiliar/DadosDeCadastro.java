package auxiliar;

import java.util.ArrayList;

import dominio.EntidadeDominio;
import dominio.Categoria;

public class DadosDeCadastro extends EntidadeDominio{
	private ArrayList<Categoria> categorias = new ArrayList<>();

	public ArrayList<Categoria> getCategorias() {
		return categorias;
	}

	public void setCategorias(ArrayList<Categoria> categorias) {
		this.categorias = categorias;
	}
}
