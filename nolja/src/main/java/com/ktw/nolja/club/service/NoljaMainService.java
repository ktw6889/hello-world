package com.ktw.nolja.club.service;

import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ktw.nolja.club.vo.NoljaMemberInfoVO;
import com.ktw.nolja.common.util.CommonUtil;
import com.ktw.nolja.common.vo.MemberInfoVO;

@Service("NoljaMainService")
public class NoljaMainService {
	public Logger logger = Logger.getLogger(this.getClass());

	@Autowired
	private SqlSession sqlSession;
	
	public MemberInfoVO selectMemberInfo(String email, String password, String infos, String phone) throws Exception {
		logger.info("start");
		
		Map<String, String> map = new HashMap<String, String>();
		map.put("email", email);
		map.put("password", password);
		map.put("infos", infos);
		map.put("phone", phone);
		return sqlSession.selectOne("nolja.main.selectMemberInfo", map);
	}
	
	public NoljaMemberInfoVO selectMemberInfoDetail(String infos) throws Exception {
		logger.info("start");
		
		Map<String, String> map = new HashMap<String, String>();
		map.put("infos", infos);
		return sqlSession.selectOne("nolja.main.selectMemberInfo.detail", map);
	}
	
	public NoljaMemberInfoVO selectMemberInfoFind(String memberName, String phone) throws Exception {
		logger.info("start");
		
		Map<String, String> map = new HashMap<String, String>();
		map.put("memberName", memberName);
		map.put("phone", phone);
		return sqlSession.selectOne("nolja.main.selectMemberInfoFind", map);
	}
	
	public String checkMemberInfo(String infos, String email) throws Exception {
		logger.info("start");
		
		Map<String, String> map = new HashMap<String, String>();
		map.put("infos", infos);
		map.put("email", email);
		return sqlSession.selectOne("nolja.main.checkMemberInfo", map);
	}
	
	public String insertMemberInfo(NoljaMemberInfoVO memberInfoVO) throws Exception {
		logger.info("start");
		
		Map<String, String> map = new HashMap<String, String>();
		map.put("email", memberInfoVO.getEmail());
		String checkInfos = sqlSession.selectOne("nolja.main.checkMemberInfo", map);
		if(CommonUtil.isNotNullString(checkInfos)) {
			return "duplication";
		} else {
			if(CommonUtil.isNullString(memberInfoVO.getInfos())) {
				memberInfoVO.setInfos((String)sqlSession.selectOne("common.getInfos"));
			}
			sqlSession.insert("nolja.main.insertMemberInfo", memberInfoVO);
		}
		return memberInfoVO.getInfos();
	}
	
	public String updateMemberInfo(NoljaMemberInfoVO memberInfoVO) throws Exception {
		logger.info("start");
		
		sqlSession.update("nolja.main.updateMemberInfo", memberInfoVO);
		return memberInfoVO.getInfos();
	}
	
	public String updateMemberInfoPassword(String infos, String password) throws Exception {
		logger.info("start");
		
		Map<String, String> map = new HashMap<String, String>();
		map.put("infos", infos);
		map.put("password", password);
		sqlSession.update("nolja.main.updateMemberInfoPassword", map);
		return infos;
	}
	
	public String deleteMemberInfo(String infos) throws Exception {
		logger.info("start");
		
		Map<String, String> map = new HashMap<String, String>();
		map.put("infos", infos);
		sqlSession.update("nolja.main.deleteMemberInfo", map);
		return infos;
	}
	
	public String updateMemberInfoClubInfos(String infos, String clubInfos) throws Exception {
		logger.info("start");
		
		Map<String, String> map = new HashMap<String, String>();
		map.put("infos", infos);
		map.put("clubInfos", clubInfos);
		sqlSession.update("nolja.main.updateMemberInfoClubInfos", map);
		return infos;
	}
	
	
	public String updateMemberImage(NoljaMemberInfoVO memberInfoVO) throws Exception {
		logger.info("start");
		
		sqlSession.update("nolja.main.updateMemberImage", memberInfoVO);
		return memberInfoVO.getInfos();
	}
	/*
	 * 
	
	
	public void insertSysLog(String memberInfos, String clubInfos, String gameInfos, String pageUrl) throws Exception {
		logger.info("start");
		
		Map<String, String> map = new HashMap<String, String>();
		map.put("memberInfos", memberInfos);
		map.put("clubInfos", clubInfos);
		map.put("gameInfos", gameInfos);
		map.put("pageUrl", pageUrl);
		sqlSession.insert("nolja.main.insertSysLog", map);
	}
	
	public String updateTeamImage(ScTeamInfoVO scTeamInfoVO) throws Exception {
		logger.info("start");
		
		sqlSession.update("nolja.main.updateTeamImage", scTeamInfoVO);
		return scTeamInfoVO.getInfos();
	}
	
	public String updateNoticeImage(ScTeamBoardVO scTeamBoardVO) throws Exception {
		logger.info("start");
		
		sqlSession.update("nolja.main.updateNoticeImage", scTeamBoardVO);
		return scTeamBoardVO.getInfos();
	}
	*/
	public String updateMemberInfoGcmId(String memberInfos, String token) throws Exception {
		logger.info("start");
		
		Map<String, String> map = new HashMap<String, String>();
		map.put("memberInfos", memberInfos);
		map.put("token", token);
		sqlSession.update("nolja.main.updateMemberInfoGcmId", map);
		return memberInfos;
	}
	
}