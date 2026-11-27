package com.example.CookingDaddy.User;

import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

@Service
public class UserService {
    @Autowired
    private UserRepository userRepository;

	@Autowired
	private PasswordEncoder passwordEncoder;

    public boolean register(RegistrationForm form) {
		User user = new User(
			form.getUsername(),
			form.getEmail(),
			form.getFullname(),
			passwordEncoder.encode(form.getPassword()),
			Role.user
		);

		try {
			userRepository.store(user);
			return true;
		} catch (Exception e) {
			return false;
		}
    }

    public Optional<User> login(String username, String password) {
		Optional<User> user = userRepository.findByUsername(username);

		if (user.isPresent() && passwordEncoder.matches(password, user.get().getPassword())) {
			return user;
		}

		return Optional.empty();
    }
}
