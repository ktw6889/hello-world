(function() {
	var results = location.href.substr(location.href.indexOf("http://")+7).match(/\//g);

	var cnt = 1;
	var hrefStr = '';
	if(results != null) {
		cnt = results.length;
	}
	/*
	if(cnt == 1) {
		hrefStr = "";
	} else if(cnt == 2) {
		hrefStr = "../";
	} else if(cnt == 3) {
		hrefStr = "../../";
	}
	*/
	hrefStr = "";
	
	
	document.write('<link rel="stylesheet" type="text/css" href="'+hrefStr+'css/common.css"/>');
	document.write('<script type="text/javascript" src="'+hrefStr+'lib/jquery/jquery-1.10.2.min.js"></script>');
	document.write('<script type="text/javascript" src="'+hrefStr+'lib/jqueryui/jquery-ui.min.js"></script>');
	document.write('<link rel="stylesheet" type="text/css" href="'+hrefStr+'lib/jqueryui/jquery-ui.min.css"/>');
	/*
	document.write('<script type="text/javascript" src="'+hrefStr+'lib/rsa/jsbn.js"></script>');
	document.write('<script type="text/javascript" src="'+hrefStr+'lib/rsa/rsa.js"></script>');
	document.write('<script type="text/javascript" src="'+hrefStr+'lib/rsa/prng4.js"></script>');
	document.write('<script type="text/javascript" src="'+hrefStr+'lib/rsa/rng.js"></script>');
	*/
	document.write('<script type="text/javascript" src="'+hrefStr+'lib/toast/jquery.toastmessage.js"></script>');
	document.write('<link rel="stylesheet" type="text/css" href="'+hrefStr+'lib/toast/css/jquery.toastmessage.css"/>');
	
	document.write('<script type="text/javascript" src="'+hrefStr+'lib/common.js"></script>');
	document.write('<script type="text/javascript" src="'+hrefStr+'js/common.js"></script>');	
}());
