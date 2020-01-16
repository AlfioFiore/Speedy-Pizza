package controller.GestoreOrdini;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.beans.Carta;
import model.beans.Indirizzo;
import model.daoFactory.CartaDAOFactory;
import model.daoFactory.IndirizzoDAOFactory;
import model.daoFactory.OrdineDAOFactory;

/**
 * Servlet implementation class OrdineServlet
 */
@WebServlet("/OrdineServlet")
public class OrdineServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public OrdineServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	if (request.getParameter("method") != null && request.getParameter("method").equals("aggiornaStato")) {
		String stato = request.getParameter("stato");
		int idOrdine = Integer.parseInt(request.getParameter("idOrdine"));
		if(OrdineDAOFactory.getOrdineDAO().updateOrdine(idOrdine, stato)) {
			response.setStatus(HttpServletResponse.SC_OK);
		}
		
	}else if(request.getParameter("method") != null && request.getParameter("method").equals("setAddress")) {
		int id = Integer.parseInt((String)request.getAttribute("ind"));
		System.out.println(id);
		/*Indirizzo indirizzo = IndirizzoDAOFactory.getIndirizzoDAO().getIndirizzoById(idIndirizzo);
		request.getSession().setAttribute("indirizzoScelto", indirizzo);
		response.setStatus(HttpServletResponse.SC_OK);*/
	}else if(request.getParameter("method") != null && request.getParameter("method").equals("setPaymentMethod")) {
		String numeroCarta= (String) request.getAttribute("carta");
		System.out.println(numeroCarta);
		Carta carta = CartaDAOFactory.getCartaDAO().getCartaByNumero(numeroCarta);
		request.getSession().setAttribute("cartaScelta", carta);
		response.setStatus(HttpServletResponse.SC_OK);
	}else {
		response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
	}
	}
}
