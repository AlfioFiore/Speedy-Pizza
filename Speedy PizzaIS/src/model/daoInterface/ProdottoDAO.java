package model.daoInterface;

import java.util.Collection;
import java.util.Set;

import model.beans.Pizzeria;
import model.beans.Prodotto;

public interface ProdottoDAO {
	public Prodotto inserisciProdotto(Prodotto prodotto);
	public boolean eliminaProdotto(Prodotto prodotto,Pizzeria pizzeria);
	public Prodotto modificaProdotto(Prodotto prodotto,String nome);
	public Prodotto getProdotto(String idPizzeria,String nomeProdotto);
	public Collection<Prodotto> getProdotti(String idPizzeria);
	public Collection<Prodotto> getProdottiByCategoria(String idPizzeria,String idCategoria);
}
