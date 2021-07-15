package org.zerock.service;

import org.zerock.domain.RegistCheckVO;
import org.zerock.domain.RegistDTO;

public interface MemberService {

	public int registUser(RegistDTO vo);
	
	public String checkRegist(RegistCheckVO vo);
	
}
