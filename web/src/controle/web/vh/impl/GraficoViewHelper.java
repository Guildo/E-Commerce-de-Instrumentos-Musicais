package controle.web.vh.impl;

import java.io.IOException;
import java.sql.Date;
import java.text.SimpleDateFormat;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import dominio.*;
import controle.web.vh.IViewHelper;
import core.aplicacao.Resultado;

public class GraficoViewHelper implements IViewHelper{

	@Override
	public EntidadeDominio getEntidade(HttpServletRequest request) {
		String operacao = request.getParameter("operacao");
		Grafico grafico = new Grafico();
		
		try {
			if(request.getParameter("ano-cat")!= null) {
				if(!request.getParameter("ano-cat").equals("")) {
					grafico.setAno_cat(request.getParameter("ano-cat"));
				}
			}
		}catch(Exception e) {
			
		}
		
		try {
			if(request.getParameter("mes-prd")!= null) {
					grafico.setMes_prd(request.getParameter("mes-prd"));
				}
		}catch(Exception e) {
			
		}
		
		try {
			if(request.getParameter("ano-prd")!= null) {
				if(!request.getParameter("ano-prd").equals("")) {
					grafico.setAno_prd(request.getParameter("ano-prd"));
				}
			}
		}catch(Exception e) {
			
		}
		
		try {
			if(request.getParameter("mes-cat")!= null) {
					grafico.setMes_cat(request.getParameter("mes-cat"));
				}
		}catch(Exception e) {
			
		}
		
		try {
			if(request.getParameter("qtd-prd")!=null) {
				grafico.setQtd_prd(request.getParameter("qtd-prd"));
			}
		}catch(Exception e) {
			
		}
		
		try {
			if(request.getParameter("qtd-cat")!=null) {
				grafico.setQtd_cat(request.getParameter("qtd-cat"));
			}
		}catch(Exception e) {
			
		}
		
		try {
			if(request.getParameter("mesf-cat")!=null) {
				grafico.setMesf_cat(request.getParameter("mesf-cat"));
			}
		}catch(Exception e) {
			
		}
		
		try {
			if(request.getParameter("mesf-prd")!=null) {
				grafico.setMesf_prd(request.getParameter("mesf-prd"));
			}
		}catch(Exception e) {
			
		}
		
		try {
			if(request.getParameter("anof-cat")!=null) {
				grafico.setAnof_cat(request.getParameter("anof-cat"));
			}
		}catch(Exception e) {
			
		}
		
		try {
			if(request.getParameter("anof-prd")!=null) {
				grafico.setAnof_prd(request.getParameter("anof-prd"));
			}
		}catch(Exception e) {
			
		}
		
		System.out.println(grafico.getQtd_prd());
		return grafico;

	}

	@Override
	public void setView(Resultado resultado, HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		RequestDispatcher d = null;
		String operacao = request.getParameter("operacao");
		
		if(resultado.getMsg() == null && operacao.equals("DASHBOARD")) {
			
			request.getSession().setAttribute("grafico", resultado);
			d = request.getRequestDispatcher("dashboard-admin.jsp");
			
			}
		
		if(resultado.getMsg() == null && operacao.equals("FILTRAR")) {
			
			request.getSession().setAttribute("grafico", resultado);
			d = request.getRequestDispatcher("dashboard-admin.jsp");
			
			}
		
		d.forward(request, response);
	}
}