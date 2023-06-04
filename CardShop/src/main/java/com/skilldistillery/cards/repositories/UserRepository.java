package com.skilldistillery.cards.repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.cards.entities.User;

public interface UserRepository extends JpaRepository<User, Integer> {
	
	User findById(int id);

}
