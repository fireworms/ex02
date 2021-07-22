package org.springboard.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springboard.domain.BoardVO;
import org.springboard.domain.Criteria;

public interface BoardMapper {

	public List<BoardVO> getListWithPaging(Criteria cri);
	
	public void insert(BoardVO board);
	
	public void insertSelectKey(BoardVO board);
	
	public BoardVO read(Long bno);
	
	public int delete(Long bno);
	
	public int update(BoardVO board);
	
	public int getTotalCount(Criteria cri);
	
	public void updateReplyCnt(@Param("bno") Long bno, @Param("amount") int amount);
}
