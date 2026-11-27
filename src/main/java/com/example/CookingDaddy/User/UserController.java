package com.example.CookingDaddy.User;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;

@Controller
public class UserController {
	@Autowired
	private UserService userService;

	@GetMapping("/register")
	public String registerView() {
		return "register.html";
	}

	@GetMapping("/login")
	public String loginView() {
		return "login.html";
	}

	@PostMapping("/register")
	public String register(@Valid @ModelAttribute("registrationForm") RegistrationForm form, BindingResult bindingResult) {
		if (bindingResult.hasErrors()) {
			return "register";
		}

		if (!form.getPassword().equals(form.getConfirmpassword())) {
			bindingResult.rejectValue(
					"confirmpassword",
					"PasswordMismatch",
					"Passwords do not match");

			return "register";
		}

		if (!userService.register(form)) {
			bindingResult.rejectValue(
					"username",
					"DuplicateUsername",
					"Username already exists");
			return "register";
		}
		return "redirect:/results";
	}

	@PostMapping("/login")
	public String login(Model model, @RequestParam String username, @RequestParam String password,
			HttpSession session) {
		if (userService.login(username, password) != null) {
			session.setAttribute("username", username);
			return "redirect:/dashboard";
		}

		return "login";
	}
}
