package org.zerock.controller;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.zerock.domain.RegistCheckVO;
import org.zerock.domain.RegistDTO;
import org.zerock.service.MemberService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@AllArgsConstructor
public class UserController {
	
	private MemberService service; 

	@GetMapping("/registUser")
	public void registGet() {
		
		log.info("regist user page");
	}
	
	@PostMapping("/registUser")
	public String registPost(RegistDTO regist) {
		
		log.info("regist user" + regist);
		
		service.registUser(regist);
		
		return "redirect:/board/list";
		
	}
	
	@PostMapping("/checkRegist")
	public ResponseEntity<String> emailCheck(RegistCheckVO vo) {
		
		log.info("checkRegist : " + vo);
		
		return new ResponseEntity<>(service.checkRegist(vo), HttpStatus.OK);
	}
	
}
