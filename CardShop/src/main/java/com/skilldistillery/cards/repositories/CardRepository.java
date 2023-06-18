package com.skilldistillery.cards.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.cards.entities.Card;

public interface CardRepository extends JpaRepository<Card, Integer> {
	
	Card findById(int id);
	List<Card> findByUsers_Id(int id);
}
