package org.zerock.mapper;

import org.zerock.domain.MemberVO;
import org.zerock.domain.RegistDTO;

public interface MemberMapper {
	
	public MemberVO read(String userid);
	
	public int regist(RegistDTO vo);
	
	public int registAuth(RegistDTO vo);

}
