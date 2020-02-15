package com.ktw.nolja.common.vo;

public class PageVO {
	private int totalRecord;
	private int numPerPage;
	private int pagePerBlock;
	private int currPageNum;
	
	private int startIdx;
	
	private String searchType;
	private String searchAreaType;
	private String searchVal;
	private String isFirst;
	private String prevPageName;
	
	public int getStartIdx() {
		startIdx = (currPageNum-1)*numPerPage;
		return startIdx;
	}
	public void setStartIdx(int startIdx) {
		this.startIdx = startIdx;
	}
	
	public int getTotalRecord() {
		return totalRecord;
	}
	public void setTotalRecord(int totalRecord) {
		this.totalRecord = totalRecord;
	}
	public int getNumPerPage() {
		return numPerPage;
	}
	public void setNumPerPage(int numPerPage) {
		this.numPerPage = numPerPage;
	}
	public int getPagePerBlock() {
		return pagePerBlock;
	}
	public void setPagePerBlock(int pagePerBlock) {
		this.pagePerBlock = pagePerBlock;
	}
	public int getCurrPageNum() {
		return currPageNum;
	}
	public void setCurrPageNum(int currPageNum) {
		this.currPageNum = currPageNum;
	}
	public String getSearchType() {
		return searchType;
	}
	public void setSearchType(String searchType) {
		this.searchType = searchType;
	}
	public String getSearchVal() {
		return searchVal;
	}
	public void setSearchVal(String searchVal) {
		this.searchVal = searchVal;
	}
	public String getPrevPageName() {
		return prevPageName;
	}
	public void setPrevPageName(String prevPageName) {
		this.prevPageName = prevPageName;
	}
	public String getSearchAreaType() {
		return searchAreaType;
	}
	public void setSearchAreaType(String searchAreaType) {
		this.searchAreaType = searchAreaType;
	}
	public String getIsFirst() {
		return isFirst;
	}
	public void setIsFirst(String isFirst) {
		this.isFirst = isFirst;
	}
}