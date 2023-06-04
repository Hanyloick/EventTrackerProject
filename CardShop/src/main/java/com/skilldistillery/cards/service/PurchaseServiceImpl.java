package com.skilldistillery.cards.service;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.cards.entities.Purchase;
import com.skilldistillery.cards.repositories.PurchaseRepository;

@Transactional
@Service
public class PurchaseServiceImpl implements PurchaseService {

	@Autowired
	private PurchaseRepository purchaseRepo;

	@Override
	public List<Purchase> index() {
		return purchaseRepo.findAll();
	}

	@Override
	public Purchase show(int id) {
		Purchase managedPurchase = purchaseRepo.findById(id);
		if (managedPurchase != null) {
			return managedPurchase;
		} else {
			return null;
		}
	}

	@Override
	public Purchase create(Purchase purchase) {
		if (purchase != null) {
			Purchase managedPurchase = purchaseRepo.saveAndFlush(purchase);
			return managedPurchase;
		} else {
			return null;
		}
	}

	@Override
	public Purchase update(int id, Purchase purchase) {
		if (purchase != null) {
			Purchase managedPurchase = purchaseRepo.findById(id);
			managedPurchase.setAmount(purchase.getAmount());
			managedPurchase.setUser(purchase.getUser());
			return managedPurchase;
		} else {
			return null;
		}
	}

	@Override
	public boolean delete(int id) {
		Purchase managedPurchase = purchaseRepo.findById(id);
		if (managedPurchase != null) {
			purchaseRepo.delete(managedPurchase);
			return true;
		} else {
			return false;
		}
	}
}
