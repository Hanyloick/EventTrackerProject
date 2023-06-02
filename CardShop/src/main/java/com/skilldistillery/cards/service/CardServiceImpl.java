package com.skilldistillery.cards.service;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.cards.entities.Card;
import com.skilldistillery.cards.repositories.CardRepository;

@Service
@Transactional
public class CardServiceImpl implements CardService {

	@Autowired
	private CardRepository cardRepo;

	@Override
	public List<Card> index() {
		return cardRepo.findAll();

	}

	@Override
	public Card getCard(int id) {
		Card managedCard = cardRepo.findById(id);
		if (managedCard != null) {
		return managedCard;
		} else {
			return null;
		}

	}

	@Override
	public Card createCard(Card newCard) {
		return newCard;

	}

	@Override
	public Card updateCard(int cardI, Card card) {
		return card;

	}

	@Override
	public Boolean delete(int cardId) {
		return null;

	}
}
