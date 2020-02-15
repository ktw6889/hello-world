package com.ktw.nolja.club.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ktw.nolja.club.vo.NoljaClubBoardVO;
import com.ktw.nolja.club.vo.NoljaClubInfoVO;
import com.ktw.nolja.club.vo.NoljaClubMessageVO;
import com.ktw.nolja.club.vo.NoljaMemberInfoVO;
import com.ktw.nolja.club.vo.NoljaVO;
import com.ktw.nolja.common.util.CommonUtil;

@Service("NoljaClubService")
public class NoljaClubService {
	public Logger logger = Logger.getLogger(this.getClass());

	@Autowired
	private SqlSession sqlSession;
	
	public NoljaClubInfoVO selectClubInfo(String memberInfos, String clubInfos) throws Exception {
		logger.info("start");
		
		Map<String, String> map = new HashMap<String, String>();
		map.put("memberInfos", memberInfos);
		map.put("clubInfos", clubInfos);
		return sqlSession.selectOne("nolja.club.selectClubInfo", map);
	}
	
	public NoljaClubInfoVO selectClubInfoDetail(String infos) throws Exception {
		logger.info("start");
		
		Map<String, String> map = new HashMap<String, String>();
		map.put("infos", infos);
		return sqlSession.selectOne("nolja.club.selectClubInfo.detail", map);
	}
	
	public String checkClubInfo(String infos, String clubName) throws Exception {
		logger.info("start");
		
		Map<String, String> map = new HashMap<String, String>();
		map.put("infos", infos);
		map.put("clubName", clubName);
		return sqlSession.selectOne("nolja.club.checkClubInfo", map);
	}
	
	public String insertClubInfo(NoljaClubInfoVO clubInfoVO) throws Exception {
		logger.info("start");
		
		Map<String, String> map = new HashMap<String, String>();
		map.put("clubName", clubInfoVO.getClubName());
		String checkInfos = sqlSession.selectOne("nolja.club.checkClubInfo", map);
		if(CommonUtil.isNotNullString(checkInfos)) {
			return "duplication";
		} else {
			if(CommonUtil.isNullString(clubInfoVO.getInfos())) {
				clubInfoVO.setInfos((String)sqlSession.selectOne("common.getInfos"));
			}
			clubInfoVO.setClubInfos(clubInfoVO.getInfos());
			sqlSession.insert("nolja.club.insertClubInfo", clubInfoVO);
			sqlSession.insert("nolja.club.insertClubMemberLink", clubInfoVO);
		}
		return clubInfoVO.getInfos();
	}
	
	public String insertClubMemberLink(NoljaClubInfoVO clubInfoVO) throws Exception {
		logger.info("start");
		
		Map<String, String> map = new HashMap<String, String>();
		map.put("memberInfos", clubInfoVO.getCreateInfos());
		map.put("clubInfos", clubInfoVO.getClubInfos());
		NoljaClubInfoVO teamVO = sqlSession.selectOne("nolja.club.selectClubMemberLink", map);
		if(teamVO != null) {
			return "duplication";
		} else {
			sqlSession.insert("nolja.club.insertClubMemberLink", clubInfoVO);
			//insertTeamMemberBadge(clubInfoVO.getClubInfos(), clubInfoVO.getCreateInfos());
		}
		return clubInfoVO.getCreateInfos();
	}
	
	public String updateClubMemberLink(NoljaMemberInfoVO memberInfoVO) throws Exception {
		logger.info("start");
		
		sqlSession.update("nolja.club.updateClubMemberLink", memberInfoVO);
		//insertTeamMemberBadge(memberInfoVO.getClubInfos(), memberInfoVO.getInfos());
		//updateTeamMemberBadge(memberInfoVO.getClubInfos(), memberInfoVO.getInfos());
		return memberInfoVO.getInfos();
	}
	
	public String updateClubInfo(NoljaClubInfoVO clubInfoVO) throws Exception {
		logger.info("start");
		
		sqlSession.update("nolja.club.updateClubInfo", clubInfoVO);
		return clubInfoVO.getInfos();
	}
	
	public String deleteClubInfo(String infos) throws Exception {
		logger.info("start");
		
		Map<String, String> map = new HashMap<String, String>();
		map.put("infos", infos);
		sqlSession.update("nolja.club.deleteClubInfo", map);
		return infos;
	}
	
	public List<NoljaMemberInfoVO> selectClubMemberList(NoljaVO NoljaVO) throws Exception {
		logger.info("start");
		
		return sqlSession.selectList("nolja.club.selectClubMemberList", NoljaVO);
	}
	
	public List<NoljaClubBoardVO> selectClubBoardList(NoljaVO noljaVO) throws Exception {
		logger.info("start");
		
		return sqlSession.selectList("nolja.club.selectClubBoardList", noljaVO);
	}
	
	public int countClubBoardList(NoljaVO noljaVO) throws Exception {
		logger.info("start");
		
		return sqlSession.selectOne("nolja.club.countClubBoardList", noljaVO);
	}
	

	public NoljaClubBoardVO selectClubBoard(String infos) throws Exception {
		logger.info("start");
		
		Map<String, String> map = new HashMap<String, String>();
		map.put("infos", infos);
		return sqlSession.selectOne("nolja.club.selectClubBoard", map);
	}
	
	public String insertClubBoard(NoljaClubBoardVO clubBoardVO) throws Exception {
		logger.info("start");
		
		if(CommonUtil.isNullString(clubBoardVO.getInfos())) {
			clubBoardVO.setInfos((String)sqlSession.selectOne("common.getInfos"));
		}
		sqlSession.insert("nolja.club.insertClubBoard", clubBoardVO);
		return clubBoardVO.getInfos();
	}
	
	public String updateClubBoard(NoljaClubBoardVO clubBoardVO) throws Exception {
		logger.info("start");
		
		sqlSession.update("nolja.club.updateClubBoard", clubBoardVO);
		return clubBoardVO.getInfos();
	}
	
	public String deleteClubBoard(String infos) throws Exception {
		logger.info("start");
		
		Map<String, String> map = new HashMap<String, String>();
		map.put("infos", infos);
		sqlSession.update("nolja.club.deleteClubBoard", map);
		return infos;
	}
	
	public List<NoljaClubMessageVO> selectClubMessageList(NoljaVO noljaVO) throws Exception {
		logger.info("start");
		
		return sqlSession.selectList("nolja.club.selectClubMessageList", noljaVO);
	}
	
	public List<NoljaClubMessageVO> selectClubMessageListEnd(NoljaVO noljaVO) throws Exception {
		logger.info("start");
		
		return sqlSession.selectList("nolja.club.selectClubMessageListEnd", noljaVO);
	}
	
	public int countClubMessageList(NoljaVO noljaVO) throws Exception {
		logger.info("start");
		
		return sqlSession.selectOne("nolja.club.countClubMessageList", noljaVO);
	}
	
	public String insertClubMessage(String messageType, String message,String clubInfos, String memberInfos, String createInfos) throws Exception {
		logger.info("start");
		
		NoljaClubMessageVO teamMessageVO = new NoljaClubMessageVO();
		teamMessageVO.setCreateInfos(createInfos);
		teamMessageVO.setClubInfos(clubInfos);
		teamMessageVO.setMemberInfos(memberInfos);
		teamMessageVO.setMessageType(messageType);
		teamMessageVO.setMessage(message);
		return insertClubMessage(teamMessageVO);
	}
	
	public String insertClubMessage(NoljaClubMessageVO teamMessageVO) throws Exception {
		logger.info("start");
		
		teamMessageVO.setInfos((String)sqlSession.selectOne("common.getInfos"));
		sqlSession.insert("nolja.club.insertClubMessage", teamMessageVO);
		//insertClubMessageBadge(teamMessageVO.getInfos(), teamMessageVO.getTeamInfos(), teamMessageVO.getMemberInfos());
		return teamMessageVO.getInfos();
	}
	
}