package org.springboard.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@AllArgsConstructor
public class CommonController {
	
	@GetMapping("/accessError")
	public void accessDenied(Authentication auth, Model model) {
		
		log.info("access Denied : " + auth);
		
		model.addAttribute("msg", "Access Denied");
	}
	
	@GetMapping("/customLogin")
	public String loginInput(HttpServletRequest request) {
		
		String referrer = request.getHeader("Referer");
		
		log.info(referrer);
		
		if(!referrer.equals("http://localhost:8090/customLogin")) {
			
			request.getSession().setAttribute("prevPage", referrer);
			
		}
	    
	    return "customLogin";
	}
	
	@GetMapping("/customLogout")
	public void logoutGet() {
		
		log.info("custom logout");
	}
	}
