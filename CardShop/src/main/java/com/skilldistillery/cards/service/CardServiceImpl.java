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
	public List<Card> indexByUserId(Integer userId) {
		List<Card> usersCards = cardRepo.findByUsers_Id(userId);
		if(usersCards.size()>0) {
		return usersCards;
		} else {
			return null;
		}
	}

	@Override
	public Card showCard(int id) {
		Card managedCard = cardRepo.findById(id);
		if (managedCard != null) {
			return managedCard;
		} else {
			return null;
		}

	}

	@Override
	public Card createCard(Card newCard) {
		Card managedCard = cardRepo.saveAndFlush(newCard);
		return managedCard;
		
	}

	@Override
	public Card updateCard(int cardId, Card card) {
		Card managedCard = cardRepo.findById(cardId);
		managedCard.setName(card.getName());
		managedCard.setType(card.getType());
		managedCard.setCost(card.getCost());
		managedCard.setRarity(card.getRarity());
		managedCard.setImageURL(card.getImageURL());
		cardRepo.saveAndFlush(managedCard);
		return managedCard;

	}

	@Override
	public boolean delete(int cardId) {
		Card managedCard = cardRepo.findById(cardId);
		if (managedCard != null) {
		cardRepo.delete(managedCard);
		return true;
		} else {
			return false;
		}

	}
}
