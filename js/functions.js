/*! Fades in page on load */
$(document).ready(function(){

    $('body').css('display', 'none');
    $('body').fadeIn(1000);
    
    });

/*! Email conversion */
$(function(){
	var spt = $('span.mailme');
	var at = / at /;
	var dot = / dot /g;
	var addr = $(spt).text().replace(at,"@").replace(dot,".");
	$(spt).after('<a href="mailto:'+addr+'" title="Send me an email">'+ addr +'</a>')
	.hover(function(){window.status="Send an Email!";}, function(){window.status="";});
	$(spt).remove();
});