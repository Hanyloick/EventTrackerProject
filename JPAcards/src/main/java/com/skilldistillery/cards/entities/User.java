package com.skilldistillery.cards.entities;

import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.ManyToMany;
import javax.persistence.OneToMany;

import com.fasterxml.jackson.annotation.JsonIgnore;

@Entity
public class User {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	@Column(name = "first_name")
	private String firstName;
	@Column(name = "last_name")
	private String lastName;
	private String username;
	private String password;
	private String email;
	@Column(name = "image_url")
	private String imageURL;
	private Double balance;

	@JsonIgnore
	@OneToMany(mappedBy = "user")
	private List<Purchase> purchases;
	@ManyToMany(mappedBy = "users")
	private List<Card> deckBuilder;

	public User() {
		super();
	}

	public User(int id, String firstName, String lastName, String username, String password, String email,
			String imageURL, Double balance, List<Purchase> purchases, List<Card> deckBuilder) {
		super();
		this.id = id;
		this.firstName = firstName;
		this.lastName = lastName;
		this.username = username;
		this.password = password;
		this.email = email;
		this.imageURL = imageURL;
		this.balance = balance;
		this.purchases = purchases;
		this.deckBuilder = deckBuilder;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getFirstName() {
		return firstName;
	}

	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}

	public String getLastName() {
		return lastName;
	}

	public void setLastName(String lastName) {
		this.lastName = lastName;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getImageURL() {
		return imageURL;
	}

	public void setImageURL(String imageURL) {
		this.imageURL = imageURL;
	}

	public Double getBalance() {
		return balance;
	}

	public void setBalance(Double balance) {
		this.balance = balance;
	}

	public List<Purchase> getPurchases() {
		return purchases;
	}

	public void setPurchases(List<Purchase> purchases) {
		this.purchases = purchases;
	}

	public List<Card> getDeckBuilder() {
		return deckBuilder;
	}

	public void setDeckBuilder(List<Card> deckBuilder) {
		this.deckBuilder = deckBuilder;
	}

	public void addCard(Card card) {
		if (deckBuilder == null) {
			deckBuilder = new ArrayList<>();
		}
		if (!deckBuilder.contains(card)) {
			deckBuilder.add(card);
			card.addUser(this);
		}
	}

	public void removeCard(Card card) {
		if (deckBuilder != null && deckBuilder.contains(card)) {
			deckBuilder.remove(card);
			card.removeUser(this);
		}
	}

	public void addPurchase(Purchase purchase) {
		if (purchases == null) {
			purchases = new ArrayList<>();
		}
		if (!purchases.contains(purchase)) {
			purchases.add(purchase);
			if (purchase.getUser() != null) {
				purchase.getUser().removePurchase(purchase);

			} else {
				purchase.setUser(this);
			}
		}
	}

	public void removePurchase(Purchase purchase) {
		if (purchases != null && purchases.contains(purchase)) {
			purchases.remove(purchase);
			purchase.setUser(null);
		}
	}

	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder();
		builder.append("User [id=");
		builder.append(id);
		builder.append(", firstName=");
		builder.append(firstName);
		builder.append(", lastName=");
		builder.append(lastName);
		builder.append(", username=");
		builder.append(username);
		builder.append(", password=");
		builder.append(password);
		builder.append(", email=");
		builder.append(email);
		builder.append(", imageURL=");
		builder.append(imageURL);
		builder.append(", balance=");
		builder.append(balance);
		builder.append("]");
		return builder.toString();
	}

	@Override
	public int hashCode() {
		return Objects.hash(id);
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		User other = (User) obj;
		return id == other.id;
	}

}
