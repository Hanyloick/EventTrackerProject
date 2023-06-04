package com.skilldistillery.cards.entities;

import static org.junit.jupiter.api.Assertions.*;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

class PurchaseTest {
	private static EntityManagerFactory emf;
	private EntityManager em;
	private Purchase purchase;
	
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
		purchase = em.find(Purchase.class, 1);
	}

	@AfterEach
	void tearDown() throws Exception {
		em.close();
		purchase = null;
		
	}
	
	@Test
	void test_Purchase_Entity_mapping() {
		assertNotNull(purchase);
		assertEquals(2.06, purchase.getAmount());
	}
	@Test
	void test_Purchase_User_ManyToOne_mapping() {
		assertNotNull(purchase);
		assertEquals(1, purchase.getUser().getId());
	}
}
