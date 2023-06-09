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

class UserTest {

	private static EntityManagerFactory emf;
	private EntityManager em;
	private User user;

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
		user = em.find(User.class, 1);
	}

	@AfterEach
	void tearDown() throws Exception {
		em.close();
		user = null;

	}

	@Test
	void test_User_entity_mapping() {
		assertNotNull(user);
		assertEquals("Firsticus", user.getFirstName());
	}

	@Test
	void test_User_Purchase_OneToMany_mapping() {
		assertNotNull(user);
		assertTrue(user.getPurchases().size() > 0);
	}
	
	@Test
	void test_User_Card_ManyToMany_Mapping() {
		assertNotNull(user);
		assertTrue(user.getDeckBuilder().size()>0);
	}

}
