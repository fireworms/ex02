package org.springboard.service;

import org.springboard.domain.RegistCheckVO;
import org.springboard.domain.RegistDTO;

public interface MemberService {

	public int registUser(RegistDTO vo);
	
	public String checkRegist(RegistCheckVO vo);
	
}
