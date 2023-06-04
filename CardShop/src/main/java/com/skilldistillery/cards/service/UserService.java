package com.skilldistillery.cards.service;

import java.util.List;

import com.skilldistillery.cards.entities.User;

public interface UserService {

	List<User> index();

	User show(int id);

	User create(User user);
	
	User update(int id, User user);
	
	boolean delete(int id);

}
