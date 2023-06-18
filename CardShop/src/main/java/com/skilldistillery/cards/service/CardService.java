package com.skilldistillery.cards.service;

import java.util.List;

import com.skilldistillery.cards.entities.Card;

public interface CardService {

	List<Card> index();


	Card createCard(Card newCard);

	Card updateCard(int cardI, Card card);

	boolean delete(int cardId);

	Card showCard(int id);


	List<Card> indexByUserId(Integer userId);

}
