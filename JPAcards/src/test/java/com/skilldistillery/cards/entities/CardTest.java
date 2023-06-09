package com.skilldistillery.cards.entities;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertTrue;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

class CardTest {
	
	private static EntityManagerFactory emf;
	private EntityManager em;
	private Card card;
	
	@BeforeAll
	static void setUpBeforeClass() throws Exception {
		emf = Persistence.createEntityManagerFactory("JPAcards");
	}

	@AfterAll
	static void tearDownAfterClass() throws Exception {
		emf.close();
	}

	@BeforeEach
	void setUp() throws Exception {
		em = emf.createEntityManager();
		card = em.find(Card.class, 1);
	}

	@AfterEach
	void tearDown() throws Exception {
		em.close();
		card = null;
		
	}

	@Test
	void test_Card_Mapping() {
		assertNotNull(card);
		assertEquals("Armored Scrapgorger", card.getName());
	}	
	@Test
	void test_Card_InventoryItem_OneToMany_Mapping() {
		assertNotNull(card);
		assertTrue(card.getInventoryItems().size()>0);
	}
	@Test
	void test_Card_User_ManyToMany_Mapping() {
		assertNotNull(card);
		assertTrue(card.getUsers().size()>0);
	}

}
