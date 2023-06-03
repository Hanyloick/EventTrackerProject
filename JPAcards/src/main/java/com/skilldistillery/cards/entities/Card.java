package com.skilldistillery.cards.entities;

import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;

import com.fasterxml.jackson.annotation.JsonIgnore;

@Entity
public class Card {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;

	private String name;
	private String type;
	private String cost;
	private String rarity;
	private double price;
	@Column(name = "image_url")
	private String imageURL;
	@OneToMany(mappedBy="card")
	@JsonIgnore
	private List<InventoryItem> inventoryItems;

	public Card() {
		super();
	}

	public Card(int id, String name, String type, String cost, String rarity, double price, String imageURL) {
		super();
		this.id = id;
		this.name = name;
		this.type = type;
		this.cost = cost;
		this.rarity = rarity;
		this.price = price;
		this.imageURL = imageURL;
	}
	
	

	public Card(int id, String name, String type, String cost, String rarity, double price, String imageURL,
			List<InventoryItem> inventoryItems) {
		super();
		this.id = id;
		this.name = name;
		this.type = type;
		this.cost = cost;
		this.rarity = rarity;
		this.price = price;
		this.imageURL = imageURL;
		this.inventoryItems = inventoryItems;
	}

	

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getCost() {
		return cost;
	}

	public void setCost(String cost) {
		this.cost = cost;
	}

	public String getRarity() {
		return rarity;
	}

	public void setRarity(String rarity) {
		this.rarity = rarity;
	}

	public double getPrice() {
		return price;
	}

	public void setPrice(double price) {
		this.price = price;
	}

	public String getImageURL() {
		return imageURL;
	}

	public void setImageURL(String imageURL) {
		this.imageURL = imageURL;
	}

	public List<InventoryItem> getInventoryItems() {
		return inventoryItems;
	}

	public void setInventoryItems(List<InventoryItem> inventoryItems) {
		this.inventoryItems = inventoryItems;
	}
	
	public void addInventoryItem(InventoryItem inventoryItem) {
		if (inventoryItems == null) {
			inventoryItems = new ArrayList<>();
		}
		if (!inventoryItems.contains(inventoryItem)) {
			inventoryItems.add(inventoryItem);
			if (inventoryItem.getCard() != null) {
				inventoryItem.getCard().removeInventoryItem(inventoryItem);

			} else {
				inventoryItem.setCard(this);
			}
		}
	}

	public void removeInventoryItem(InventoryItem inventoryItem) {
		if (inventoryItems != null && inventoryItems.contains(inventoryItem)) {
			inventoryItems.remove(inventoryItem);
			inventoryItem.setCard(null);
		}
	}
	

	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder();
		builder.append("Card [id=");
		builder.append(id);
		builder.append(", name=");
		builder.append(name);
		builder.append(", type=");
		builder.append(type);
		builder.append(", cost=");
		builder.append(cost);
		builder.append(", rarity=");
		builder.append(rarity);
		builder.append(", price=");
		builder.append(price);
		builder.append(", imageURL=");
		builder.append(imageURL);
		builder.append(", inventoryItems=");
		builder.append(inventoryItems.size());
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
		Card other = (Card) obj;
		return id == other.id;
	}

}
