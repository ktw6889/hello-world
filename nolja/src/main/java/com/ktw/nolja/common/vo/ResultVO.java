package com.ktw.nolja.common.vo;

import java.util.List;

import com.ktw.nolja.common.constant.CommonConstant;

public class ResultVO {
	private int status;
	private String infos;
	private List<?> result;
	
	private List<?> gameResult;
	private List<?> recordResult;
	
	private int totalRecord;
	private Object resultObj;
	
	public ResultVO() {
		this.status = CommonConstant.FAIL;
	}
	
	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
	}
	public List<?> getResult() {
		return result;
	}
	public void setResult(List<?> result) {
		this.result = result;
	}
	public String getInfos() {
		return infos;
	}
	public void setInfos(String infos) {
		this.infos = infos;
	}
	public Object getResultObj() {
		return resultObj;
	}
	public void setResultObj(Object resultObj) {
		this.resultObj = resultObj;
	}
	public int getTotalRecord() {
		return totalRecord;
	}
	public void setTotalRecord(int totalRecord) {
		this.totalRecord = totalRecord;
	}

	public List<?> getGameResult() {
		return gameResult;
	}

	public void setGameResult(List<?> gameResult) {
		this.gameResult = gameResult;
	}

	public List<?> getRecordResult() {
		return recordResult;
	}

	public void setRecordResult(List<?> recordResult) {
		this.recordResult = recordResult;
	}
}