package com.skilldistillery.cards.entities;

import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonIgnore;

@Entity
@Table(name="card_condition")
public class Condition {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;

	private String grade;

	@JsonIgnore
	@OneToMany(mappedBy = "condition")
	private List<InventoryItem> inventoryItems;

	public Condition() {
		super();
	}

	public Condition(int id, String grade, List<InventoryItem> inventoryItems) {
		super();
		this.id = id;
		this.grade = grade;
		this.inventoryItems = inventoryItems;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getGrade() {
		return grade;
	}

	public void setGrade(String grade) {
		this.grade = grade;
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
			if (inventoryItem.getCondition() != null) {
				inventoryItem.getCondition().removeInventoryItem(inventoryItem);

			} else {
				inventoryItem.setCondition(this);
			}
		}
	}

	public void removeInventoryItem(InventoryItem inventoryItem) {
		if (inventoryItems != null && inventoryItems.contains(inventoryItem)) {
			inventoryItems.remove(inventoryItem);
			inventoryItem.setCondition(null);
		}
	}

	

	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder();
		builder.append("Condition [id=");
		builder.append(id);
		builder.append(", grade=");
		builder.append(grade);
		builder.append(", inventoryItems=");
		builder.append(inventoryItems);
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
		Condition other = (Condition) obj;
		return id == other.id;
	}

}
