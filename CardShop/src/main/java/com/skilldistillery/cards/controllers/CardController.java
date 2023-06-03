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

import com.skilldistillery.cards.entities.Card;
import com.skilldistillery.cards.service.CardService;

@RestController
@RequestMapping("api")
public class CardController {

	@Autowired
	private CardService cardService;

	@GetMapping("cards")
	public List<Card> listAllCards() {
		return cardService.index();

	}
	
	@DeleteMapping("cards/{cardId}")
	public void deleteCard(HttpServletResponse res, @PathVariable Integer cardId) {
		if (cardService.delete(cardId)) {
			res.setStatus(204);
		} else {
			res.setStatus(404);
		}
	}

	@GetMapping("cards/{cardId}")
	public Card findById(HttpServletResponse res, @PathVariable Integer cardId) {
		Card card = cardService.showCard(cardId);
		if (card != null) {
			return card;
		} else {
			res.setStatus(404);
			return null;
		}
	}

	@PostMapping("cards")
	public Card addNewCard(HttpServletResponse res, HttpServletRequest req, @RequestBody Card card) {
		try {
			card = cardService.createCard(card);
			res.setStatus(201);
			StringBuffer url = req.getRequestURL();
			url.append("/").append(card.getId());
			res.setHeader("Location", url.toString());
		} catch (Exception e) {
			e.printStackTrace();
			res.setStatus(400);
			card = null;
		}
		return card;
	}

	@PutMapping("cards/{cardId}")
	public Card updateCard(HttpServletResponse res, @PathVariable Integer cardId, @RequestBody Card card) {
		try {
			card = cardService.updateCard(cardId, card);
			if (card == null) {
				res.setStatus(404);
			}
		} catch (Exception e) {
			e.printStackTrace();
			res.setStatus(400);
			card = null;
		}
		return card;
	}

}
