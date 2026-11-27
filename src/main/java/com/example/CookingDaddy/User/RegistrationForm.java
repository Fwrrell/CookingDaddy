package com.example.CookingDaddy.User;

import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import lombok.AllArgsConstructor;
import lombok.Data;

/**
 * RegistrationForm
 */
@Data
@AllArgsConstructor 
public class RegistrationForm {
	@NotNull
	@Size(min=4, max=20)
    private String username;

	@NotNull
	@Size(min=4, max=30)
    private String email;

	@NotNull
	@Size(min=4, max=40)
    private String fullname;

	@NotNull
	@Size(min=4, max=20)
    private String password;

	@NotNull
	@Size(min=4, max=20)
    private String confirmpassword;
}
