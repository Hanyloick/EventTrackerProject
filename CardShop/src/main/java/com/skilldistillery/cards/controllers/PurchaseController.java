package com.skilldistillery.cards.controllers;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.skilldistillery.cards.entities.Purchase;
import com.skilldistillery.cards.service.PurchaseService;

@RestController
@RequestMapping("api")
public class PurchaseController {

	@Autowired
	private PurchaseService purchaseService;

	@GetMapping("purchases")
	public List<Purchase> index() {
		return purchaseService.index();
	}

	@GetMapping("purchases/{id}")
	public Purchase show(@PathVariable Integer id, HttpServletResponse res) {
		Purchase purchase = purchaseService.show(id);
		if (purchase != null) {
			return purchase;
		} else {
			res.setStatus(404);
			return null;
		}
	}

	@PostMapping("purchases")
	public Purchase create(@RequestBody Purchase purchase, HttpServletRequest req, HttpServletResponse res) {
		if (purchase.getAmount() < 0 || purchase.getUser() == null) {
			res.setStatus(400);
			purchase = null;
			return purchase;
		}
		try {
			purchase = purchaseService.create(purchase);
			res.setStatus(201);
			StringBuffer url = req.getRequestURL();
			url.append("/").append(purchase.getId());
			res.setHeader("Location", url.toString());
		} catch (Exception e) {
			e.printStackTrace();
			res.setStatus(400);
			purchase = null;
		}
		return purchase;
	}

	@PutMapping("purchases/{id}")
	public Purchase update(@PathVariable Integer id, @RequestBody Purchase purchase, HttpServletResponse res) {
		if (purchase.getAmount() < 0 || purchase.getUser() == null) {
			res.setStatus(400);
			purchase = null;
			return purchase;
		}
		try {
			purchase = purchaseService.update(id, purchase);
		} catch (Exception e) {
			e.printStackTrace();
			res.setStatus(400);
			purchase = null;
		}
		return purchase;
	}

	@DeleteMapping("purchases/{id}")
	public void delete(@PathVariable Integer id, HttpServletResponse res) {
		if (purchaseService.delete(id)) {
			res.setStatus(204);
		} else {
			res.setStatus(404);
		}
	}

}
