package com.skilldistillery.cards.service;

import java.util.List;

import com.skilldistillery.cards.entities.Purchase;

public interface PurchaseService {

	List<Purchase> index();

	Purchase show(int id);
	Purchase create(Purchase purchase);
	Purchase update(int id, Purchase purchase);
	boolean delete(int id);

}
