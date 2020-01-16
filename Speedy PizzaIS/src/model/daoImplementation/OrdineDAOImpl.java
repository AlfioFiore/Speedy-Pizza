package model.daoImplementation;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Collection;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.Map;
import java.util.Set;

import model.DriverManagerConnectionPool;
import model.beans.Carrello;
import model.beans.Carta;
import model.beans.Categoria;
import model.beans.Cliente;
import model.beans.Indirizzo;
import model.beans.Ordine;
import model.beans.Pizzeria;
import model.beans.Prodotto;
import model.beans.Recensione;
import model.beans.Utente;
import model.daoInterface.OrdineDAO;

public class OrdineDAOImpl implements OrdineDAO {
	private static final String INSERT_ORDINE="insert into ordine values(null,?,?,?,?,?,?,?,?,null,?,null,null,null)";
	private static final String INSERT_CONTENUTO_ORDINE="insert into contenuto_ordine values(?,?,?,?,?)";

	private static final String UPDATE="update ordine set stato = ? where id = ?";
	private static final String GET_BY_CLIENTE="select * from ordine where id_cliente = ?";
	private static final String GET_BY_PIZZERIA="select * from ordine where id_pizzeria = ?";
	private static final String GET_BY_TRACKER="select * from ordine where tracker = ?";
	private static final String GET_BY_FATTORINO="select * from ordine where id_fattorino =? ";
	/*query per prendere i dati complessi di un ordine*/
	private static final String GET_CARTA ="select * from carta where numero_carta = ?";
	private static final String GET_RECENSIONE ="select recensione.id,recensione.starring,recensione.recensione,recensione.date,recensione.id_ordine from ordine inner join recensione where ordine.id= ?";
	private static final String GET_INDIRIZZO ="select indirizzo.* from indirizzo inner join ordine where ordine.id_indirizzo= ?";
	private static final String GET_CLIENTE ="select nome,cognome from utente where email = ?";
	private static final String GET_FATTORINO ="select nome,cognome from utente where email = ?";
	private static final String GET_PIZZERIA ="select nome from pizzeria where partita_iva= ?";
	private static final String GET_PRODOTTI ="SELECT * FROM contenuto_ordine inner join prodotto on contenuto_ordine.id_pizzeria = prodotto.id_pizzeria and  contenuto_ordine.id_prodotto=prodotto.nome "
			+ "inner join categoria on categoria.nome = prodotto.id_categoria where id_ordine  = ?";

	@Override
	public Collection<Ordine> getOrdiniByFattorino(String idFattorino){
		ResultSet result=null;
		Connection connection =null;
		Set<Ordine> set = null;
		try {				
			connection = DriverManagerConnectionPool.getConnection();
			PreparedStatement preparedStatement = connection.prepareStatement(OrdineDAOImpl.GET_BY_FATTORINO);
			preparedStatement.setString(1, idFattorino);
			
			result = preparedStatement.executeQuery();
			
				set = new HashSet<Ordine>();
				while(result.next()) {
					Ordine o = new Ordine();
					o.setId(result.getInt(1));
					o.setTipoPagamento(result.getInt(2));
					o.setStato(result.getString(3));
					o.setTotale(result.getFloat(4));
					o.setCliente(OrdineDAOImpl.getCliente(result.getString(5)));
					o.setTipoOrdine(result.getInt(6));
					o.setData(result.getDate(7));
					
					o.setIndirizzo(OrdineDAOImpl.getIndirizzo(result.getInt(9)));
					o.setTracking(result.getString(10));
					o.setNumeroOrdine(result.getInt(11));
					
					
					o.setCarrello(OrdineDAOImpl.getProdotti(result.getInt(1)));
					set.add(o);
					

				}
			
		}catch (Exception e) {
			System.out.println("Errore durante la connessione." + e.getMessage());

			return null;
		}finally {
			try {
				DriverManagerConnectionPool.releaseConnection(connection);
			} catch (SQLException e) {
				System.out.println("Errore durante la connessione." + e.getMessage());
				return null;
			}
		}
		System.out.println(set);
		return set;
	}
	

	@Override
	public synchronized Ordine inserisciOrdine(Ordine ordine) {
		System.out.println("nel metodo");
		Connection connection = null;
		
		boolean flag1=false;
		try {
			System.out.println("dopo try");
			connection = DriverManagerConnectionPool.getConnection();
			System.out.println("dopo connection");
			PreparedStatement statement = connection.prepareStatement(OrdineDAOImpl.INSERT_ORDINE);
			statement.execute("SET FOREIGN_KEY_CHECKS=0");
			System.out.println("dopo statement");
			statement.setInt(1, ordine.getTipoPagamento());
			statement.setString(2, ordine.getStato());
			statement.setFloat(3, ordine.getTotale());
			statement.setString(4, ordine.getCliente().getEmail());
			statement.setInt(5, ordine.getTipoOrdine());
			statement.setDate(6, ordine.getData());
			statement.setString(7, ordine.getPizzeria().getIban());
			statement.setInt(8, ordine.getIndirizzo().getIdIndirizzo());
			statement.setString(9, ordine.getCarta().getNumeroCarta());
			System.out.println("prima");
			flag1 = (statement.executeUpdate()>0) ? true:false;
			System.out.println(flag1);
			Carrello c = ordine.getCarrello();
			
			PreparedStatement statement2= connection.prepareStatement(OrdineDAOImpl.INSERT_CONTENUTO_ORDINE);
			Iterator<Map.Entry<Prodotto, Integer>> itr = c.getProdotti().entrySet().iterator();
			int cont=0;
			while(itr.hasNext()) {
				Map.Entry<Prodotto, Integer> entry = itr.next();
				statement2.setInt(1, ordine.getId());
				statement2.setString(2,ordine.getPizzeria().getIban());
				statement2.setString(3,entry.getKey().getNome());
				statement2.setFloat(4, entry.getKey().getPrezzo());
				statement2.setInt(5,entry.getValue());
				cont = (statement2.executeUpdate()>0) ? +1:0;
			}
				
			if ((cont == c.getProdotti().size()) && flag1) {
				return ordine;
			}
			
			
		}catch (Exception e) {
			System.out.println("Errore durante la connessionee." + e.getMessage());

			return null;
		} finally {
			try {
				DriverManagerConnectionPool.releaseConnection(connection);
			} catch (SQLException e) {
				System.out.println("Errore durante la connession." + e.getMessage());
			}
		}
		return null;
	}

	@Override
	public boolean updateOrdine(int idOrdine, String stato) {
		Connection connection = null;
		try {
			connection = DriverManagerConnectionPool.getConnection();
			PreparedStatement statement = connection.prepareStatement(OrdineDAOImpl.UPDATE);
			statement.setString(1, stato);
			statement.setInt(2, idOrdine);
			return (statement.executeUpdate()>0) ? true:false;

			
		}catch (SQLException e) {
			System.out.println("Errore durante la connessione." + e.getMessage());
			return false;
		}finally {
			try {
				DriverManagerConnectionPool.releaseConnection(connection);
			} catch (SQLException e) {
				System.out.println("Errore durante la connessione." + e.getMessage());
			}
		}
	}
	@Override
	public Set<Ordine> getOrdiniByCliente(String idCliente) {
		ResultSet result=null;
		Connection connection =null;
		Set<Ordine> set = null;
		try {				
			connection = DriverManagerConnectionPool.getConnection();
			PreparedStatement preparedStatement = connection.prepareStatement(OrdineDAOImpl.GET_BY_CLIENTE);
			preparedStatement.setString(1, idCliente);
			
			result = preparedStatement.executeQuery();
			
				set = new HashSet<Ordine>();
				while(result.next()) {
					Ordine o = new Ordine();
					o.setId(result.getInt(1));
					o.setTipoPagamento(result.getInt(2));
					o.setStato(result.getString(3));
					o.setTotale(result.getFloat(4));
					o.setCliente(OrdineDAOImpl.getCliente(result.getString(5)));
					o.setTipoOrdine(result.getInt(6));
					o.setData(result.getDate(7));
					o.setPizzeria(OrdineDAOImpl.getPizzeria(result.getString(8)));
					o.setIndirizzo(OrdineDAOImpl.getIndirizzo(result.getInt(9)));
					o.setTracking(result.getString(10));
					o.setNumeroOrdine(result.getInt(11));
					if(o.getTipoOrdine() == 0) {
					o.setFattorino(OrdineDAOImpl.getFattorino(result.getString(12)));}
					if(o.getTipoPagamento() == 0) {
					o.setCarta(OrdineDAOImpl.getCarta(result.getString(13)));}
					o.setCarrello(OrdineDAOImpl.getProdotti(result.getInt(1)));
				}
			
		}catch (Exception e) {
			System.out.println("Errore durante la connessione." + e.getMessage());

			return null;
		}finally {
			try {
				DriverManagerConnectionPool.releaseConnection(connection);
			} catch (SQLException e) {
				System.out.println("Errore durante la connessione." + e.getMessage());
				return null;
			}
		}
		return set;
	}

	@Override
	public Set<Ordine> getOrdiniByPizzeria(String idPizzeria) {
		ResultSet result=null;
		Connection connection =null;
		Set<Ordine> set = null;
		try {				
			connection = DriverManagerConnectionPool.getConnection();
			PreparedStatement preparedStatement = connection.prepareStatement(OrdineDAOImpl.GET_BY_PIZZERIA);
			preparedStatement.setString(1, idPizzeria);
			
			result = preparedStatement.executeQuery();
			
				set = new HashSet<Ordine>();
				while(result.next()) {
					Ordine o = new Ordine();
					o.setId(result.getInt(1));
					o.setTipoPagamento(result.getInt(2));
					o.setStato(result.getString(3));
					o.setTotale(result.getFloat(4));
					o.setCliente(OrdineDAOImpl.getCliente(result.getString(5)));
					o.setTipoOrdine(result.getInt(6));
					o.setData(result.getDate(7));
					o.setPizzeria(OrdineDAOImpl.getPizzeria(result.getString(8)));
					o.setIndirizzo(OrdineDAOImpl.getIndirizzo(result.getInt(9)));
					o.setTracking(result.getString(10));
					o.setNumeroOrdine(result.getInt(11));
					o.setFattorino(OrdineDAOImpl.getFattorino(result.getString(12)));
					o.setCarta(OrdineDAOImpl.getCarta(result.getString(13)));
					o.setCarrello(OrdineDAOImpl.getProdotti(result.getInt(1)));
					set.add(o);
					

				}
			
		}catch (Exception e) {
			System.out.println("Errore durante la connessione." + e.getMessage());

			return null;
		}finally {
			try {
				DriverManagerConnectionPool.releaseConnection(connection);
			} catch (SQLException e) {
				System.out.println("Errore durante la connessione." + e.getMessage());
				return null;
			}
		}
		
		return set;
	}

	@Override
	public Ordine getOrdineByTracker(String tracker) {
		ResultSet result=null;
		Connection connection =null;
		Ordine o= null;
		try {				
			connection = DriverManagerConnectionPool.getConnection();
			PreparedStatement preparedStatement = connection.prepareStatement(OrdineDAOImpl.GET_BY_TRACKER);
			preparedStatement.setString(1, tracker);
			
			result = preparedStatement.executeQuery();
			while(result.next()) {
					o=new Ordine();
					o.setId(result.getInt(1));
					o.setTipoPagamento(result.getInt(2));
					o.setStato(result.getString(3));
					o.setTotale(result.getFloat(4));
					o.setCliente(OrdineDAOImpl.getCliente(result.getString(5)));
					o.setTipoOrdine(result.getInt(6));
					o.setData(result.getDate(7));
					o.setPizzeria(OrdineDAOImpl.getPizzeria(result.getString(8)));
					o.setIndirizzo(OrdineDAOImpl.getIndirizzo(result.getInt(9)));
					o.setTracking(result.getString(10));
					o.setNumeroOrdine(result.getInt(11));
					o.setFattorino(OrdineDAOImpl.getFattorino(result.getString(12)));
					o.setCarta(OrdineDAOImpl.getCarta(result.getString(13)));
					o.setCarrello(OrdineDAOImpl.getProdotti(result.getInt(1)));
				}
			
		}catch (Exception e) {
			System.out.println("Errore durante la connessione." + e.getMessage());

			return null;
		}finally {
			try {
				DriverManagerConnectionPool.releaseConnection(connection);
			} catch (SQLException e) {
				System.out.println("Errore durante la connessione." + e.getMessage());
				return null;
			}
		}
		return o;
	}
	private static Indirizzo getIndirizzo(int idIndirizzo) {
		ResultSet result=null;
		Connection connection =null;
		Indirizzo indirizzo = null;
		try {				
			connection = DriverManagerConnectionPool.getConnection();
			PreparedStatement preparedStatement = connection.prepareStatement(OrdineDAOImpl.GET_INDIRIZZO);
			preparedStatement.setInt(1, idIndirizzo);
			
			result = preparedStatement.executeQuery();
			while(result.next()) {
				indirizzo = new Indirizzo(result.getInt(5),result.getInt(1),result.getString(2),result.getString(4),result.getString(3),result.getString(6));
					
			}
			
		}catch (Exception e) {
			System.out.println("Errore durante la connessione." + e.getMessage());

			return null;
		}finally {
			try {
				DriverManagerConnectionPool.releaseConnection(connection);
			} catch (SQLException e) {
				System.out.println("Errore durante la connessione." + e.getMessage());
				return null;
			}
		}
		return indirizzo;
		
	}
	private static Carta  getCarta(String idCarta) {
		ResultSet result=null;
		Connection connection =null;
		Carta carta= null;
		try {				
			connection = DriverManagerConnectionPool.getConnection();
			PreparedStatement preparedStatement = connection.prepareStatement(OrdineDAOImpl.GET_CARTA);
			preparedStatement.setString(1, idCarta);
			
			result = preparedStatement.executeQuery();
			while(result.next()) {
				carta = new Carta();
				carta.setNumeroCarta(result.getString(1));
				carta.setScadenza(result.getString(2));
				carta.setCvc(result.getString(3));
				carta.setIntestatario(result.getString(4));
			}
			
		}catch (Exception e) {
			System.out.println("Errore durante la connessione." + e.getMessage());

			return null;
		}finally {
			try {
				DriverManagerConnectionPool.releaseConnection(connection);
			} catch (SQLException e) {
				System.out.println("Errore durante la connessione." + e.getMessage());
				return null;
			}
		}
		return carta;
		
	}
	private static Recensione getRecensione(int idOrdine) {
		ResultSet result=null;
		Connection connection =null;
		Recensione recensione= null;
		try {				
			connection = DriverManagerConnectionPool.getConnection();
			PreparedStatement preparedStatement = connection.prepareStatement(OrdineDAOImpl.GET_RECENSIONE);
			preparedStatement.setInt(1, idOrdine);
			
			result = preparedStatement.executeQuery();
			while(result.next()) {
				recensione=new Recensione(result.getString(3), result.getInt(2), result.getInt(5),result.getDate(4));
			}
			
		}catch (Exception e) {
			System.out.println("Errore durante la connessione." + e.getMessage());

			return null;
		}finally {
			try {
				DriverManagerConnectionPool.releaseConnection(connection);
			} catch (SQLException e) {
				System.out.println("Errore durante la connessione." + e.getMessage());
				return null;
			}
		}
		return recensione;
		
	}
	private static Cliente getCliente(String idCliente) {
		ResultSet result=null;
		Connection connection =null;
		Cliente cliente= null;
		try {				
			connection = DriverManagerConnectionPool.getConnection();
			PreparedStatement preparedStatement = connection.prepareStatement(OrdineDAOImpl.GET_CLIENTE);
			preparedStatement.setString(1,idCliente);
			
			result = preparedStatement.executeQuery();
			while(result.next()) {
				cliente=new Cliente();
				cliente.setNome(result.getString(1));
				cliente.setCognome(result.getString(2));
			}
			
		}catch (Exception e) {
			System.out.println("Errore durante la connessione." + e.getMessage());

			return null;
		}finally {
			try {
				DriverManagerConnectionPool.releaseConnection(connection);
			} catch (SQLException e) {
				System.out.println("Errore durante la connessione." + e.getMessage());
				return null;
			}
		}
		return cliente;
		
	}
	private static Utente getFattorino (String idFattorino) {
		ResultSet result=null;
		Connection connection =null;
		Utente utente= null;
		try {				
			connection = DriverManagerConnectionPool.getConnection();
			PreparedStatement preparedStatement = connection.prepareStatement(OrdineDAOImpl.GET_FATTORINO);
			preparedStatement.setString(1,idFattorino);
			
			result = preparedStatement.executeQuery();
			while(result.next()) {
				utente=new Utente();
				utente.setNome(result.getString(1));
				utente.setCognome(result.getString(2));
			}
			
		}catch (Exception e) {
			System.out.println("Errore durante la connessione." + e.getMessage());

			return null;
		}finally {
			try {
				DriverManagerConnectionPool.releaseConnection(connection);
			} catch (SQLException e) {
				System.out.println("Errore durante la connessione." + e.getMessage());
				return null;
			}
		}
		return utente;
	}
	private static Pizzeria getPizzeria (String idPizzeria) {
		ResultSet result=null;
		Connection connection =null;
		Pizzeria pizzeria= null;
		try {				
			connection = DriverManagerConnectionPool.getConnection();
			PreparedStatement preparedStatement = connection.prepareStatement(OrdineDAOImpl.GET_PIZZERIA);
			preparedStatement.setString(1,idPizzeria);
			
			result = preparedStatement.executeQuery();
			while(result.next()) {
				pizzeria = new Pizzeria();
				pizzeria.setNome(result.getString(1));
			}
			
		}catch (Exception e) {
			System.out.println("Errore durante la connessione." + e.getMessage());

			return null;
		}finally {
			try {
				DriverManagerConnectionPool.releaseConnection(connection);
			} catch (SQLException e) {
				System.out.println("Errore durante la connessione." + e.getMessage());
				return null;
			}
		}
		return pizzeria;
	}
	private static Carrello getProdotti (int idOrdine) {
		ResultSet result=null;
		Connection connection =null;
		Carrello carrello= null;
		HashMap<Prodotto,Integer> prodotti= null;
		try {				
			connection = DriverManagerConnectionPool.getConnection();
			PreparedStatement preparedStatement = connection.prepareStatement(OrdineDAOImpl.GET_PRODOTTI);
			preparedStatement.setInt(1,idOrdine);
			
			result = preparedStatement.executeQuery();
			
				carrello = new Carrello();
				prodotti = new HashMap<Prodotto,Integer>();
				while(result.next()) {
					Prodotto p = new Prodotto();
					p.setCategoria(new Categoria(result.getString(12),result.getInt(13)));
					p.setNome(result.getString(3));
					p.setPrezzo(result.getFloat(4));
					prodotti.put(p, result.getInt(5));
				}
			
			carrello.setProdotti(prodotti);
			
		}catch (Exception e) {
			System.out.println("Errore durante la connessione." + e.getMessage());

			return null;
		}finally {
			try {
				DriverManagerConnectionPool.releaseConnection(connection);
			} catch (SQLException e) {
				System.out.println("Errore durante la connessione." + e.getMessage());
				return null;
			}
		}
		return carrello;
	}
}
