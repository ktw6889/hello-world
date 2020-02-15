package com.ktw.nolja.club.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ktw.nolja.club.vo.NoljaClubInfoVO;
import com.ktw.nolja.club.vo.NoljaVO;

@Service("NoljaMenuService")
public class NoljaMenuService {
	public Logger logger = Logger.getLogger(this.getClass());

	@Autowired
	private SqlSession sqlSession;
	
	public List<NoljaClubInfoVO> selectMyClubInfoList(NoljaVO ClubVO) throws Exception {
		logger.info("start");
		
		return sqlSession.selectList("nolja.menu.selectMyClubInfoList", ClubVO);
	}
	
	public List<NoljaClubInfoVO> searchClubInfoList(NoljaVO ClubVO) throws Exception {
		logger.info("start");
		
		return sqlSession.selectList("nolja.menu.searchClubInfoList", ClubVO);
	}
	
	
	/*
	
	public int countSearchTeamInfoList(ClubVO ClubVO) throws Exception {
		logger.info("start");
		
		return sqlSession.selectOne("soccer.menu.countSearchTeamInfoList", ClubVO);
	}
	
	public List<ScGameInfoVO> searchTeamScheduleList(ClubVO ClubVO) throws Exception {
		logger.info("start");
		
		return sqlSession.selectList("soccer.menu.searchTeamScheduleList", ClubVO);
	}
	
	public int countSearchTeamScheduleList(ClubVO ClubVO) throws Exception {
		logger.info("start");
		
		return sqlSession.selectOne("soccer.menu.countSearchTeamScheduleList", ClubVO);
	}
	
	public List<ClubInfoVO> searchTeamRankingList(ClubVO ClubVO) throws Exception {
		logger.info("start");
		
		return sqlSession.selectList("soccer.menu.searchTeamRankingList", ClubVO);
	}
	
	public int countSearchTeamRankIngList(ClubVO ClubVO) throws Exception {
		logger.info("start");
		
		return sqlSession.selectOne("soccer.menu.countSearchTeamRankingList", ClubVO);
	}
	
	public String updateMemberInfoPushFlag(String memberInfos, String pushFlag) throws Exception {
		logger.info("start");
		
		Map<String, String> map = new HashMap<String, String>();
		map.put("memberInfos", memberInfos);
		map.put("pushFlag", pushFlag);
		sqlSession.update("soccer.menu.updateMemberInfoPushFlag", map);
		return memberInfos;
	}
	*/
}