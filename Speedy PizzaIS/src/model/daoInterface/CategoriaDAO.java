package model.daoInterface;

import java.util.Collection;

import model.beans.Categoria;

public interface CategoriaDAO {
	public Collection<Categoria> getCategorie();
	public Categoria getCategoria(String nome);
	
}
