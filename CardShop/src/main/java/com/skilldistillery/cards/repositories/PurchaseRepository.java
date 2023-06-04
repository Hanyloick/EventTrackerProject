package com.skilldistillery.cards.repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.cards.entities.Purchase;

public interface PurchaseRepository extends JpaRepository<Purchase, Integer> {
	
	Purchase findById(int id);
}
