package com.skilldistillery.cards.service;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.cards.entities.Card;
import com.skilldistillery.cards.entities.Purchase;
import com.skilldistillery.cards.entities.User;
import com.skilldistillery.cards.repositories.CardRepository;
import com.skilldistillery.cards.repositories.UserRepository;

@Service
@Transactional
public class UserServiceImpl implements UserService {

	@Autowired
	private UserRepository userRepo;
	@Autowired
	private CardRepository cardRepo;

	@Override
	public List<User> index() {
		return userRepo.findAll();
	}
	
	@Override
	public User validate(String username, String password) {
		User managedUser = userRepo.findByUsernameAndPassword(username, password);
		if(managedUser != null) {
			return managedUser;
		}
		return null;
	}
	
	@Override
	public User addCardToUser(int userId, int cardId) {
		User managedUser = userRepo.findById(userId);
		Card managedCard = cardRepo.findById(cardId);
		if(managedUser!=null && managedCard!=null) {
			managedUser.addCard(managedCard);
			managedCard.addUser(managedUser);
			cardRepo.saveAndFlush(managedCard);
			userRepo.saveAndFlush(managedUser);
			return managedUser;
		}
		return null;
		
	}

	@Override
	public User show(int id) {
		User managedUser = userRepo.findById(id);
		if (managedUser != null) {
			return managedUser;
		} else {
			return null;
		}
	}

	@Override
	public User create(User user) {
		if (user.getFirstName().isEmpty() || user.getLastName().isEmpty() || user.getPassword().isEmpty()
				|| user.getUsername().isEmpty()) {
			return null;
		} else {
			User managedUser = userRepo.saveAndFlush(user);
			return managedUser;
		}
	}

	@Override
	public User update(int id, User user) {
		if (user.getFirstName().isEmpty() || user.getLastName().isEmpty() || user.getPassword().isEmpty()
				|| user.getUsername().isEmpty()) {
			return null;
		} else {
			User managedUser = userRepo.findById(id);
			managedUser.setFirstName(user.getFirstName());
			managedUser.setLastName(user.getLastName());
			managedUser.setUsername(user.getUsername());
			managedUser.setPassword(user.getPassword());
			managedUser.setImageURL(user.getImageURL());
			if (!user.getDeckBuilder().isEmpty()) {
				for (Card card : user.getDeckBuilder()) {
					managedUser.getDeckBuilder().add(card);
				}
			}

			return managedUser;
		}
	}

	@Override
	public boolean delete(int id) {
		User managedUser = userRepo.findById(id);
		if (managedUser != null) {
			for (Card card : managedUser.getDeckBuilder()) {
				card.removeUser(managedUser);
				managedUser.removeCard(card);
			}
			for (Purchase purchase : managedUser.getPurchases()) {
				managedUser.removePurchase(purchase);
			}
			userRepo.delete(managedUser);
			return true;
		} else {

			return false;
		}
	}
}
