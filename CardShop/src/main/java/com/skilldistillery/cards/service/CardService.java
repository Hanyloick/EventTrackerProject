package com.skilldistillery.cards.service;

import java.util.List;

import com.skilldistillery.cards.entities.Card;

public interface CardService {

	List<Card> index();

	Card getCard(int id);

	Card createCard(Card newCard);

	Card updateCard(int cardI, Card card);

	Boolean delete(int cardId);

}
