package com.ktw.nolja.common.service;

import org.apache.ibatis.session.SqlSession;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service("CommonService")
public class CommonService  {
	public Logger logger = Logger.getLogger(this.getClass());

	@Autowired
	private SqlSession sqlSession;
	
	public String getInfos() throws Exception {
		logger.info("start");
		
		return sqlSession.selectOne("common.getInfos");
	}

}