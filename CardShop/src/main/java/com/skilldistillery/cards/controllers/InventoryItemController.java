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

import com.skilldistillery.cards.entities.InventoryItem;
import com.skilldistillery.cards.service.InventoryItemService;

@RestController
@RequestMapping("api")
public class InventoryItemController {

	@Autowired
	private InventoryItemService inventoryItemService;

	@GetMapping("inventoryItems")
	public List<InventoryItem> index() {
		return inventoryItemService.index();
	}

	@GetMapping("inventoryItems/{id}")
	public InventoryItem show(@PathVariable Integer id, HttpServletResponse res) {
		InventoryItem managedItem = inventoryItemService.show(id);
		if (managedItem == null) {
			res.setStatus(404);
		}
		return managedItem;
	}

	@PostMapping("inventoryItems")
	public InventoryItem create(@RequestBody InventoryItem inventoryItem, HttpServletRequest req,
			HttpServletResponse res) {
		if (inventoryItem.getCard() == null) {
			res.setStatus(400);
			inventoryItem = null;
			return inventoryItem;
		}
		try {
			inventoryItem = inventoryItemService.create(inventoryItem);
			res.setStatus(201);
			StringBuffer url = req.getRequestURL();
			url.append("/").append(inventoryItem.getId());
			res.setHeader("Location", url.toString());
		} catch (Exception e) {
			e.printStackTrace();
			res.setStatus(400);
			inventoryItem = null;
		}
		return inventoryItem;
	}

	@PutMapping("inventoryItems/{id}")
	public InventoryItem update(@PathVariable Integer id, @RequestBody InventoryItem inventoryItem,
			HttpServletResponse res) {
		if (inventoryItem.getCard() == null) {
			res.setStatus(400);
			inventoryItem = null;
			return inventoryItem;
		}
		try {
			inventoryItem = inventoryItemService.update(id, inventoryItem);
		} catch (Exception e) {
			e.printStackTrace();
			res.setStatus(400);
			inventoryItem = null;
		}
		return inventoryItem;
	}
	
	@DeleteMapping("inventoryItems/{id}")
	public void delete(@PathVariable Integer id, HttpServletResponse res) {
		if (inventoryItemService.delete(id)) {
			res.setStatus(204);
		} else {
			res.setStatus(404);
		}
	}

}
