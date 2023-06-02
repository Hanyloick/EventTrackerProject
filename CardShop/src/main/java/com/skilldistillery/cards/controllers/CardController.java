package com.skilldistillery.cards.controllers;

import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
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
	
	@GetMapping("cards/{cardId}")
	public Card findById(HttpServletResponse res, @PathVariable Integer cardId) {
		Card card = cardService.getCard(cardId);
		if (card != null) {
		return card;
		} else {
			res.setStatus(404);
			return null;
		}
	}
	

}
