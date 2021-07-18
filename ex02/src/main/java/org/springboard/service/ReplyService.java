package org.springboard.service;

import java.util.List;

import org.springboard.domain.Criteria;
import org.springboard.domain.ReplyPageDTO;
import org.springboard.domain.ReplyVO;

public interface ReplyService {

	public int register(ReplyVO vo);
	public ReplyVO get(Long rno);
	public int modify(ReplyVO vo);
	public int remove(Long rno);
	public List<ReplyVO> getList(Criteria cri, Long bno);
	public ReplyPageDTO getListPage(Criteria cri, Long bno);
	//public int removeAll(Long bno);
}
