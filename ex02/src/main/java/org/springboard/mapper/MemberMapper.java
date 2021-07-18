package org.springboard.mapper;

import org.springboard.domain.MemberVO;
import org.springboard.domain.RegistCheckVO;
import org.springboard.domain.RegistDTO;

public interface MemberMapper {
	
	public MemberVO read(String userid);
	
	public int regist(RegistDTO vo);
	
	public int registAuth(RegistDTO vo);
	
	public String checkRegist(RegistCheckVO vo);

}
