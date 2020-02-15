var page = {};
$(document).ready(function() {
	logger.info('document.ready()', '/lib/common.js');
	if(page.ready) {
		page.ready();	
	}
});

$(window).load(function() {
	logger.info('window.load()', '/lib/common.js');
	if(page.load) {
		page.load();	
	}
	if(page.controller && page.controller.init) {
		page.controller.init();	
	}
});

$(window).on('beforeunload', function() {
	logger.info('window.beforeunload()', '/lib/common.js');
	if(page.beforeunload) {
		page.beforeunload();	
	}
});

$(window).on('unload', function() {
	logger.info('window.unload()', '/lib/common.js');
	if(page.unload) {
		page.unload();	
	}
});

var debugFlag = true;
var infoFlag = false;
var logger = {};
logger.debug = function(message, id) {
	if(debugFlag) {
		if(id) {
			console.log('['+id+'] '+message);
		} else {
			console.log(message);
		}
	}
};

logger.info = function(message, id) {
	if(infoFlag) {
		if(id) {
			console.log('['+id+'] '+message);
		} else {
			console.log(message);
		}
	}
};
