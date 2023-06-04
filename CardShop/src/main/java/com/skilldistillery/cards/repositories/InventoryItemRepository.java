package com.skilldistillery.cards.repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.cards.entities.InventoryItem;

public interface InventoryItemRepository extends JpaRepository<InventoryItem, Integer> {

	InventoryItem findById(int id);
}
