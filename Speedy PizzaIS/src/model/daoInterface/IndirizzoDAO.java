package model.daoInterface;

import java.util.Collection;

import model.beans.Indirizzo;


public interface IndirizzoDAO {
	public Indirizzo inserisciIndirizzo(Indirizzo indirizzo);
	public boolean eliminaIndirizzo(Indirizzo indirizzo);
	public Collection<Indirizzo> getIndirizziByCliente(String idCliente);
	public Indirizzo getIndirizziByPizzeria(String idCliente);

	public boolean updateIndirizzo(Indirizzo indirizzo);
	
}
