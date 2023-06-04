package com.skilldistillery.cards.service;

import java.util.List;

import com.skilldistillery.cards.entities.InventoryItem;

public interface InventoryItemService {

	List<InventoryItem> index();
	InventoryItem show(int id);
	InventoryItem create(InventoryItem inventoryItem);
	boolean delete(int id);
	InventoryItem update(int id, InventoryItem inventoryItem);
}
