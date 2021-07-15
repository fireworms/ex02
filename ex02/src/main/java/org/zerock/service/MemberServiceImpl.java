package org.zerock.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.zerock.domain.RegistCheckVO;
import org.zerock.domain.RegistDTO;
import org.zerock.mapper.MemberMapper;

import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
@AllArgsConstructor
public class MemberServiceImpl implements MemberService{
	
	@Setter(onMethod_ = @Autowired)
	private MemberMapper mapper;
	
	@Setter(onMethod_ = @Autowired)
	private PasswordEncoder pwencoder;
	
	@Transactional
	@Override
	public int registUser(RegistDTO vo) {
		
		log.info("insert member");
		
		vo.setUserpw(pwencoder.encode(vo.getUserpw()));
		
		int insertResult = mapper.regist(vo);
		
		mapper.registAuth(vo);
		
		return insertResult;
	}

	@Override
	public String checkRegist(RegistCheckVO vo) {

		log.info("check id or email and ? : " + vo);
		
		return mapper.checkRegist(vo) == null ? "true" : "false";
	}
	
	
	
}
