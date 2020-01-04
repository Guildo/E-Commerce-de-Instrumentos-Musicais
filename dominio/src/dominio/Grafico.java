package dominio;

import java.util.ArrayList;

import auxiliar.ItemsGrafico;

public class Grafico extends EntidadeDominio{

	private ArrayList<ItemsGrafico> items = new ArrayList<ItemsGrafico>();
	private String ano_cat;
	private String mes_cat;
	private String ano_prd;
	private String mes_prd;
	private String qtd_prd;
	private String qtd_cat;
	private String mesf_cat;
	private String mesf_prd;
	private String anof_cat;
	private String anof_prd;
	
	public String getMesf_prd() {
		return mesf_prd;
	}
	public void setMesf_prd(String mesf_prd) {
		this.mesf_prd = mesf_prd;
	}
	public String getMesf_cat() {
		return mesf_cat;
	}
	public void setMesf_cat(String mesf_cat) {
		this.mesf_cat = mesf_cat;
	}
	public String getQtd_cat() {
		return qtd_cat;
	}
	public void setQtd_cat(String qtd_cat) {
		this.qtd_cat = qtd_cat;
	}
	public String getQtd_prd() {
		return qtd_prd;
	}
	public void setQtd_prd(String qtd) {
		this.qtd_prd = qtd;
	}
	public String getAno_cat() {
		return ano_cat;
	}
	public void setAno_cat(String ano_cat) {
		this.ano_cat = ano_cat;
	}
	public String getMes_cat() {
		return mes_cat;
	}
	public void setMes_cat(String mes_cat) {
		this.mes_cat = mes_cat;
	}
	public String getAno_prd() {
		return ano_prd;
	}
	public void setAno_prd(String ano_prd) {
		this.ano_prd = ano_prd;
	}
	public String getMes_prd() {
		return mes_prd;
	}
	public void setMes_prd(String mes_prd) {
		this.mes_prd = mes_prd;
	}
	
	public String getAno() {
		return ano_cat;
	}
	public void setAno(String ano) {
		ano_cat = ano;
	}
	public String getMes() {
		return mes_cat;
	}
	public void setMes(String mes) {
		mes_cat = mes;
	}
	
	public String getAnof_cat() {
		return anof_cat;
	}
	public void setAnof_cat(String anof_cat) {
		this.anof_cat = anof_cat;
	}
	public String getAnof_prd() {
		return anof_prd;
	}
	public void setAnof_prd(String anof_prd) {
		this.anof_prd = anof_prd;
	}
	
	public ArrayList<ItemsGrafico> getItems() {
		return items;
	}
	public void setItems(ArrayList<ItemsGrafico> items) {
		this.items = items;
	}
}
