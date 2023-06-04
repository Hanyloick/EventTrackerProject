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

class InventoryItemTest {

	private static EntityManagerFactory emf;
	private EntityManager em;
	private InventoryItem inventoryItem;
	
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
		inventoryItem = em.find(InventoryItem.class, 1);
	}

	@AfterEach
	void tearDown() throws Exception {
		em.close();
		inventoryItem = null;
		
	}
	
	@Test
	void test_InventoryItem_Condition_ManyToOne_mapping() {
		assertNotNull(inventoryItem);
		assertEquals(9, inventoryItem.getCondition().getId());
	}

	@Test
	void test_InventoryItem_Purchase_ManyToOne_mapping() {
		assertNotNull(inventoryItem);
		assertEquals(1, inventoryItem.getPurchase().getId());
	}
	
	@Test
	void test_InventoryItem_Card_ManyToOne_Mapping() {
		assertNotNull(inventoryItem);
		assertEquals("Armored Scrapgorger", inventoryItem.getCard().getName());
	}

}
