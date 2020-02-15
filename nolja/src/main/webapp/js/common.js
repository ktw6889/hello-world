var nvlString = function(str) {
	var returnStr = "";
	str = $.trim(str);
	if(str != null && str != undefined) {
		returnStr = str;
	}
	return returnStr;
};

var replaceEnterToBr = function(str) {
	str = nvlString(str);
	var regex = /\r/g;
	str = str.replace(regex,"");
	regex = /\n/g;
	return str.replace(regex,"<br/>");
};

var comma = function(str) {
    str = String(str);
    return str.replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,');
}

function dateMask(obj) {
	if(event.keyCode != 16 && event.keyCode != 17 && event.keyCode != 18 && event.keyCode != 37 && event.keyCode != 38 && event.keyCode != 39 && event.keyCode != 40) {
		var text = $(obj).val();
		var textlength = text.length;
		if (textlength == 4) {
			$(obj).val(text+'-');
		} else if (textlength == 7) {
			$(obj).val(text+'-');
		} else if (textlength > 9) {
			$(obj).val(text.substr(0,10));
		}
	}
}

function numberMask(obj, costFlag) {
	var text = $(obj).val();
	var regex = /^[0-9-.]*$/;
	if(!regex.test(text)) {
		$(obj).val(text.replace(/\D/g,''))
	}
	if(costFlag) {
		$(obj).val(comma($(obj).val()));
		if(page.controller.onChangeItem) {
			page.controller.onChangeItem(obj)
		}
	}
}


// var rsa = new RSAKey();
page.setPublic = function(modulus, exponent) {
	// rsa.setPublic(modulus, exponent);
};


Map = function() {
	this.map = new Object();
};
Map.prototype = {
	put : function(key, value) {
		this.map[key] = value;
	},
	get : function(key) {
		return this.map[key];
	},
	containsKey : function(key) {
		return key in this.map;
	},
	containsValue : function(value) {
		for ( var prop in this.map) {
			if (this.map[prop] == value)
				return true;
		}
		return false;
	},
	isEmpty : function(key) {
		return (this.size() == 0);
	},
	clear : function() {
		for ( var prop in this.map) {
			delete this.map[prop];
		}
	},
	remove : function(key) {
		delete this.map[key];
	},
	keys : function() {
		var keys = new Array();
		for ( var prop in this.map) {
			keys.push(prop);
		}
		return keys;
	},
	values : function() {
		var values = new Array();
		for ( var prop in this.map) {
			values.push(this.map[prop]);
		}
		return values;
	},
	size : function() {
		var count = 0;
		for ( var prop in this.map) {
			count++;
		}
		return count;
	}
};

var common = {};
common.initPaging = function() {
	$('input[name="totalRecord"]').val(parent.$('input[name="totalRecord"]').val());
	$('input[name="pagePerBlock"]').val(parent.$('input[name="pagePerBlock"]').val());
	$('input[name="currPageNum"]').val(parent.$('input[name="currPageNum"]').val());
	$('select[name="numPerPage"]').val(parent.$('input[name="numPerPage"]').val());
	if(parent.$('input[name="searchType"]').val() != '') {
		$('select[name="searchType"]').val(parent.$('input[name="searchType"]').val());	
	}
	$('input[name="searchVal"]').val(parent.$('input[name="searchVal"]').val());
	$('input[name="prevPageName"]').val(parent.$('input[name="prevPageName"]').val());
};

common.savePaging = function() {
	parent.$('input[name="totalRecord"]').val($('input[name="totalRecord"]').val());
	parent.$('input[name="pagePerBlock"]').val($('input[name="pagePerBlock"]').val());
	parent.$('input[name="currPageNum"]').val($('input[name="currPageNum"]').val());
	parent.$('input[name="numPerPage"]').val($('select[name="numPerPage"]').val());
	parent.$('input[name="searchType"]').val($('select[name="searchType"]').val());	
	parent.$('input[name="searchVal"]').val($('input[name="searchVal"]').val());
	parent.$('input[name="prevPageName"]').val($('input[name="prevPageName"]').val());
};

common.makePaging = function(obj) {
	var endCnt = parseInt(obj.currPageNum)*parseInt(obj.numPerPage);
	if(endCnt > obj.totalRecord) {
		endCnt = obj.totalRecord;
	}
	obj.pagingTable.find("._total").html(((obj.currPageNum-1)*obj.numPerPage+1) + " - " + endCnt + " of " + obj.totalRecord);
	
	var currBlock = (parseInt(obj.currPageNum)-1)/parseInt(obj.pagePerBlock);
	var totalPage = parseInt(((parseInt(obj.totalRecord)-1)/parseInt(obj.numPerPage))+1);
	var prevPage = parseInt(currBlock)*parseInt(obj.pagePerBlock);
	var nextPage = parseInt(currBlock)*parseInt(obj.pagePerBlock)+parseInt(obj.pagePerBlock)+1;

	var pageHtml = "";
	if(prevPage > 0) {
		pageHtml += '<img src="images/button/btn_prev02.gif" class="paging_show" onclick="page.controller.goPage(1);"/>&nbsp;&nbsp;';
		pageHtml += '<img src="images/button/btn_prev01.gif" class="paging_show" onclick="page.controller.goPage('+prevPage+');"/>&nbsp;&nbsp;';
	} else {
		pageHtml += '<img src="images/button/btn_prev02.gif" class="paging_none"/>&nbsp;&nbsp;';
		pageHtml += '<img src="images/button/btn_prev01.gif" class="paging_none"/>&nbsp;&nbsp;';
	}
	
	for(var page=1; page<=obj.pagePerBlock; page++) {
		var currNum = parseInt(currBlock)*parseInt(obj.pagePerBlock)+page;
		if(currNum <= totalPage) {
			if(currNum == obj.currPageNum) {
				pageHtml += '<span style="vertical-align:bottom;"><b>'+currNum+'</b></span>&nbsp;&nbsp;';
			} else {
				pageHtml += '<span class="paging_num" onclick="page.controller.goPage('+currNum+');">'+currNum+'</span>&nbsp;&nbsp;';
			}
		}
	}
	
	if(nextPage <= totalPage) {
		pageHtml += '<img src="images/button/btn_next01.gif" class="paging_show" onclick="page.controller.goPage('+nextPage+');"/>&nbsp;&nbsp;';
		pageHtml += '<img src="images/button/btn_next02.gif" class="paging_show" onclick="page.controller.goPage('+totalPage+');"/>';
	} else {
		pageHtml += '<img src="images/button/btn_next01.gif" class="paging_none"/>&nbsp;&nbsp;';
		pageHtml += '<img src="images/button/btn_next02.gif" class="paging_none"/>';
	}
	obj.pagingTable.find("._paging").html(pageHtml);
};

common.checkvalidation = function(obj) {
	var checkFlag = true;
	$(obj).find('.required').each(function(i) {
		if(nvlString($(this).val()) == '' && checkFlag) {
			$(this).focus();
			alert('필수항목을 입력하세요.');
			checkFlag = false;
		}
	});
	if(checkFlag) {
		$(obj).find('._checkDate').each(function(i) {
			var text = $(this).val();
			if(text != '' && checkFlag) {
				var validformat = /^\d{4}\-\d{2}\-\d{2}$/; 
				if (!validformat.test(text)) {
					$(this).focus();
					alert("날짜 형식이 올바르지 않습니다. YYYY-MM-DD");
					checkFlag = false;
				} else { 
					var yearfield = text.split("-")[0];
					var monthfield = text.split("-")[1];
					var dayfield = text.split("-")[2];
					var dayobj = new Date(yearfield, monthfield - 1, dayfield);
					
					if ((dayobj.getMonth() + 1 != monthfield) || (dayobj.getDate() != dayfield) || (dayobj.getFullYear() != yearfield)) {
						$(this).focus();
						alert("날짜 형식이 올바르지 않습니다. YYYY-MM-DD");
						checkFlag = false;
					}
				}
			}
		});
	}
	
	if(checkFlag) {
		$(obj).find('._checkNumber').each(function(i) {
			var text = $(this).val();
			if(text != '' && checkFlag) {
				var validformat = /^[0-9-.]*$/;
				if (!validformat.test(text)) {
					$(this).focus();
					alert("숫자 형식이 올바르지 않습니다.");
					checkFlag = false;
				}
			}
		});
		
		$(obj).find('._checkCost').each(function(i) {
			var text = $(this).val();
			if(text != '' && checkFlag) {
				var validformat = /^[+-]?[\d,]*(\.?\d*)$/;
				if (!validformat.test(text)) {
					$(this).focus();
					alert("금액 형식이 올바르지 않습니다.");
					checkFlag = false;
				}
			}
		});
		
		
	}
	return checkFlag;
};

common.CheckEnter = function(focusId) {
	var keycode = event.keyCode;
	if(keycode == 13) {
		$('input[name="'+focusId+'"]').focus();
	}
};

common.checkInitFrame = function(url) {
	if(!parent.page.controller.goContent) {
		$(location).attr('href',url);
		return true;
	} else {
		return false;
	}
}

common.goParentContent = function(contentSrc, param) {
	if(param == null) {
		parent.page.controller.goContent(contentSrc);
	} else {
		parent.page.controller.goContent(contentSrc+'?'+param);
	}
};

common.goParentContentPop = function(contentSrc, param) {
	if(param == null) {
		parent.page.controller.goContentPop(contentSrc);
	} else {
		parent.page.controller.goContentPop(contentSrc+'?'+param);
	}
};

common.goParentClosePop = function(targetPage, param1, param2) {
	parent.page.controller.goClosePop(targetPage, param1, param2);
};

common.goParentMapClosePop = function(targetPage, param1, param2) {
	parent.page.controller.goMapClosePop(targetPage, param1,param2);
};

common.goParentLogout = function() {
	parent.page.controller.goLogout();
};

common.goReload = function() {
	parent.page.controller.goReload();
};

common.goBack = function() {
	parent.page.controller.goBack();
	//window.history.back();
};

common.callPhone = function(phoneNumber) {
	if(phoneNumber != null && phoneNumber != '') {
		parent.page.plugin.callPhone(phoneNumber);
	}
};


common.goGameTabContent = function(status, tabName, param) {
	if(status == '수락') {
		if(tabName == 'gameAcceptView' || tabName == 'gameAttendanceView') {
			common.goParentContent(tabName+'.do', param);
		}
	} else if(status == '당일') {
		if(tabName == 'gameAcceptView' || tabName == 'gameAttendanceView' || tabName == 'gameAttendanceView' || tabName == 'gameAttendView') {
			common.goParentContent(tabName+'.do', param);
		}
	} else if(status == '참석') {
		if(tabName == 'gameAcceptView' || tabName == 'gameAttendanceView' || tabName == 'gameAttendView' || tabName == 'gamePositionView') {
			common.goParentContent(tabName+'.do', param);
		}
	} else if(status == '확정' || status == '종료') {
		common.goParentContent(tabName+'.do', param);
	}
};

common.loading = function(flag) {
	parent.page.loading(flag);
};

common.isMobile = function() {
	return parent.page.isMobile;
};
