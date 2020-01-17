package test.DaoImplementation;

import static org.junit.Assert.*;

import java.util.Collection;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;

import model.beans.Indirizzo;
import model.daoImplementation.IndirizzoDAOImpl;

public class TestIndirizzo {
	Collection<String> collection;
	IndirizzoDAOImpl manager ;

	@Before
	public void setUp() throws Exception {
		manager = new IndirizzoDAOImpl();
	}

	@After
	public void tearDown() throws Exception {
	}

	@Test
	public void testGetCitta() {
		collection = manager.getCitta();
		assertNotNull(collection);
	}

	@Test
	public void testUpdateIndirizzo() {
		boolean result = manager.updateIndirizzo(new Indirizzo(26, 1, "via di napoli", "81000","Napoli", null));
		assertFalse(result);
		result = manager.updateIndirizzo(new Indirizzo(26, 1, "via di napoli", "81000","Napoli", null));
		assertFalse(result);
		result = manager.updateIndirizzo(new Indirizzo(26, 1, "via di napoli", "81000","Napoli", null));
		assertFalse(result);
		result = manager.updateIndirizzo(new Indirizzo(26, 1, "via di napoli", "81000","Napoli", null));
		assertFalse(result);
		result = manager.updateIndirizzo(new Indirizzo(26, 1, "via di napoli", "81000","Napoli", null));
		assertFalse(result);
		result = manager.updateIndirizzo(new Indirizzo(26, 1, "via di napoli", "81000","Napoli", null));
		assertFalse(result);
		result = manager.updateIndirizzo(new Indirizzo(26, 1, "via di napoli", "81000","Napoli", null));
		assertFalse(result);
	}

	@Test
	public void testInserisciIndirizzo() {
		fail("Not yet implemented");
	}

	@Test
	public void testEliminaIndirizzo() {
		fail("Not yet implemented");
	}

	@Test
	public void testGetIndirizziByCliente() {
		fail("Not yet implemented");
	}

	@Test
	public void testGetIndirizziByPizzeria() {
		fail("Not yet implemented");
	}

	@Test
	public void testGetIndirizzoById() {
		fail("Not yet implemented");
	}

}
