package com.skilldistillery.cards.controllers;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.skilldistillery.cards.entities.Card;
import com.skilldistillery.cards.entities.User;
import com.skilldistillery.cards.service.UserService;

@CrossOrigin({"*", "http://localhost/"})
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
	
	@GetMapping("users/{username}/{password}")
	public User login(@PathVariable String username, @PathVariable String password, HttpServletResponse res) {
		User managedUser = userService.validate(username,password);
		if (managedUser == null) {
			res.setStatus(404);
		}
		return managedUser;
	}
	
	@PutMapping("users/{userId}/{cardId}")
    public User addCardToUser(@PathVariable Integer userId,
    		@PathVariable Integer cardId, HttpServletResponse res) {
		User updatingUser = null;
        try {
            updatingUser = userService.addCardToUser(userId, cardId);
            return updatingUser;
        } catch (Exception e) {
        	e.printStackTrace();
        	res.setStatus(400);
    }
		return updatingUser;
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
