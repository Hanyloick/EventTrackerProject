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

class ConditionTest {

	private static EntityManagerFactory emf;
	private EntityManager em;
	private Condition condition;
	
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
		condition = em.find(Condition.class, 1);
	}

	@AfterEach
	void tearDown() throws Exception {
		em.close();
		condition = null;
		
	}
	
	@Test
	void test_Condition_Entity_Mapping() {
		assertNotNull(condition);
		assertEquals("PSA 1", condition.getGrade());
		
	}

	@Test
	void test_InventoryItem_Condition_ManyToOne_Mapping() {
		assertNotNull(condition);
		assertTrue(condition.getInventoryItems().size()>0);
	}

}
