package com.skilldistillery.cards.service;

import java.util.List;

import javax.persistence.criteria.CriteriaBuilder.In;
import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.cards.entities.InventoryItem;
import com.skilldistillery.cards.repositories.InventoryItemRepository;

@Service
@Transactional
public class InventoryItemServiceImpl implements InventoryItemService {

	@Autowired
	private InventoryItemRepository inventoryItemRepo;

	@Override
	public List<InventoryItem> index() {
		List<InventoryItem> managedItems = inventoryItemRepo.findAll();
		if (managedItems != null) {
			return managedItems;
		} else {
			return null;
		}
	}

	@Override
	public InventoryItem show(int id) {
		InventoryItem managedItem = inventoryItemRepo.findById(id);
		if (managedItem != null) {
			return managedItem;
		} else {
			return null;
		}
	}

	@Override
	public InventoryItem create(InventoryItem inventoryItem) {
		if (inventoryItem != null) {
			InventoryItem managedItem = inventoryItemRepo.saveAndFlush(inventoryItem);
			return managedItem;
		} else {
			return null;
		}
	}

	@Override
	public boolean delete(int id) {
		InventoryItem managedItem = inventoryItemRepo.findById(id);
		if (managedItem != null) {
			inventoryItemRepo.delete(managedItem);
			return true;
		} else {
			return false;
		}
	}

	@Override
	public InventoryItem update(int id, InventoryItem inventoryItem) {
		if (inventoryItem != null) {
			InventoryItem managedItem = inventoryItemRepo.findById(id);
			managedItem.setCard(inventoryItem.getCard());
			managedItem.setCondition(inventoryItem.getCondition());
			managedItem.setPrice(inventoryItem.getPrice());
			managedItem.setPurchase(inventoryItem.getPurchase());
			inventoryItemRepo.saveAndFlush(managedItem);
			return managedItem;
		} else {
			return null;
		}
	}
}
