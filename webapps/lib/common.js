//-----------------------------------------------
function is_arr(o){
	return Object.prototype.toString.call(o) === "[object Array]"; 
}

//-----------------------------------------------
function checkbox_is_checked(checkbox){
	if(!is_arr(checkbox)){
		if(checkbox.checked){
			return true;
		}
		else{
			return false;
		}
	}

	for(var i = 0; i < checkbox.length; i++){
		if(checkbox[i].checked){
			return true;
		}
	}
	return false;
}

//-----------------------------------------------
function checkbox_check_all(checkbox){
	if(!is_arr(checkbox)){
		checkbox.checked = true;
	}

	for(var i = 0; i < checkbox.length; i++){
		checkbox[i].checked = true;
	}
}

//-----------------------------------------------
function checkbox_uncheck_all(checkbox){
	if(!is_arr(checkbox)){
		checkbox.checked = false;
	}

	for(var i = 0; i < checkbox.length; i++){
		checkbox[i].checked = false;
	}
}

//-----------------------------------------------
function checkbox_toggle_all(checkbox){
	if(checkbox_is_checked(checkbox)){
		checkbox_uncheck_all(checkbox);
		return;
	}
	checkbox_check_all(checkbox);
}

//-----------------------------------------------
function radio_is_checked(radio){
	for(var i = 0; i < radio.length; i++){
		if(radio[i].checked){
			return true;
		}
	}
	return false;
}

//-----------------------------------------------
function radio_get_value(radio){
	for(var i = 0; i < radio.length; i++){
		if(radio[i].checked){
			return radio[i].value;
		}
	}
}

//-----------------------------------------------
function radio_uncheck_all(radio){
	for(var i = 0; i < radio.length; i++){
		radio[i].checked = false;
	}
}

//-----------------------------------------------
function checkbox_toggle_all2(source, tgt_name){
	arr = document.getElementsByName(tgt_name);
	for(var i = 0; i < arr.length; i++){
		arr[i].checked = source.checked;
	}
}

//-----------------------------------------------
function checkbox_toggle_all3(tgt_name){
	checkbox = document.getElementsByName(tgt_name);
	if(checkbox_is_checked(checkbox)){
		checkbox_uncheck_all(checkbox);
		return;
	}
	checkbox_check_all(checkbox);
}

//-----------------------------------------------
function window_open(url){
	window.open(url);
}

//-----------------------------------------------
function enter_submit(e, form){
	var key = e.keyCode || e.which;
	if(key == 13){
		form.submit();
	}
}
