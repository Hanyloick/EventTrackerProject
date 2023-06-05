package com.skilldistillery.cards.controllers;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.skilldistillery.cards.entities.User;
import com.skilldistillery.cards.service.UserService;

@RestController
@RequestMapping("api")
public class UserController {

	@Autowired
	private UserService userService;

	@GetMapping("users")
	public List<User> index() {
		return userService.index();
	}

	@GetMapping("users/{id}")
	public User show(@PathVariable Integer id, HttpServletResponse res) {
		User managedUser = userService.show(id);
		if (managedUser == null) {
			res.setStatus(404);
		}
		return managedUser;
	}

	@PostMapping("users")
	public User create(@RequestBody User user, HttpServletRequest req, HttpServletResponse res) {
		if (user.getFirstName().isEmpty() || user.getLastName().isEmpty() || user.getUsername().isEmpty()
				|| user.getPassword().isEmpty()) {
			res.setStatus(400);
			user = null;
			return user;
		}
		try {
			user = userService.create(user);
			res.setStatus(201);
			StringBuffer url = req.getRequestURL();
			url.append("/").append(user.getId());
			res.setHeader("Location", url.toString());
		} catch (Exception e) {
			e.printStackTrace();
			res.setStatus(400);
			user = null;
		}
		return user;
	}

	@PutMapping("users/{id}")
	public User update(@PathVariable Integer id, @RequestBody User user, HttpServletResponse res) {
		if (user.getFirstName().isEmpty() || user.getLastName().isEmpty() || user.getUsername().isEmpty()
				|| user.getPassword().isEmpty()) {
			res.setStatus(400);
			user = null;
			return user;
		}
		try {
			user = userService.update(id, user);
		} catch (Exception e) {
			e.printStackTrace();
			res.setStatus(400);
			user = null;
		}
		return user;
	}
	
	@DeleteMapping("users/{id}")
	public void delete(@PathVariable Integer id, HttpServletResponse res) {
		if (userService.delete(id)) {
			res.setStatus(204);
		} else {
			res.setStatus(404);
		}
	}

}
