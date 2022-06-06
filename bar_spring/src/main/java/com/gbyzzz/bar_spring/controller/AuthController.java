package com.gbyzzz.bar_spring.controller;


import com.gbyzzz.bar_spring.controller.payload.request.LoginRequest;
import com.gbyzzz.bar_spring.controller.payload.request.SignupRequest;
import com.gbyzzz.bar_spring.controller.payload.response.JwtResponse;
import com.gbyzzz.bar_spring.controller.payload.response.MessageResponse;
import com.gbyzzz.bar_spring.entity.User;
import com.gbyzzz.bar_spring.security.jwt.JwtUtils;
import com.gbyzzz.bar_spring.security.services.UserDetailsImpl;
import com.gbyzzz.bar_spring.service.UserService;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.sql.Date;
import java.util.List;
import java.util.stream.Collectors;

@CrossOrigin(origins = "http://localhost:4200", maxAge = 3600)
@RestController
public class AuthController {

	AuthenticationManager authenticationManager;

	private UserService userService;

	PasswordEncoder encoder;

	JwtUtils jwtUtils;

	public AuthController(AuthenticationManager authenticationManager, UserService userService,
						  PasswordEncoder encoder, JwtUtils jwtUtils) {
		this.authenticationManager = authenticationManager;
		this.userService = userService;
		this.encoder = encoder;
		this.jwtUtils = jwtUtils;
	}

	@PostMapping("/signin")
	public ResponseEntity<?> authenticateUser(@Valid @RequestBody LoginRequest loginRequest) {

		Authentication authentication = authenticationManager.authenticate(
				new UsernamePasswordAuthenticationToken(loginRequest.getUsername(), loginRequest.getPassword()));

		SecurityContextHolder.getContext().setAuthentication(authentication);
		String jwt = jwtUtils.generateJwtToken(authentication);
		
		UserDetailsImpl userDetails = (UserDetailsImpl) authentication.getPrincipal();
		List<String> roles = userDetails.getAuthorities().stream()
				.map(item -> item.getAuthority())
				.collect(Collectors.toList());
		User.Role role = User.Role.valueOf(roles.get(0));

		return ResponseEntity.ok(new JwtResponse(jwt,
												 userDetails.getId(), 
												 userDetails.getUsername(), 
												 userDetails.getEmail(), 
												 role));
	}

	@PostMapping("/signup")
	public ResponseEntity<?> registerUser(@Valid @RequestBody SignupRequest signUpRequest) {
		if (userService.existsByUsername(signUpRequest.getUsername())) {
			return ResponseEntity
					.badRequest()
					.body(new MessageResponse("Error: Username is already taken!"));
		}

		if (userService.existsByEmail(signUpRequest.getEmail())) {
			return ResponseEntity
					.badRequest()
					.body(new MessageResponse("Error: Email is already in use!"));
		}

		User user = new User(null, signUpRequest.getUsername(), encoder.encode(signUpRequest.getPassword()), null,
				null, null, signUpRequest.getEmail(), null, User.Role.ROLE_USER, true,
				new Date(new java.util.Date().getTime()));


		userService.updateUser(user);

		return ResponseEntity.ok(new MessageResponse("User registered successfully!"));
	}
}
