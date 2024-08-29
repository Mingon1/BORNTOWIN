/**
 * 
 */

function allDelete(obj){
		var rcheck = document.getElementsByName("rowcheck");
		var check = obj.checked;
		if(check){
			for(var i=0; i<rcheck.length; i++){
				rcheck[i].checked = true;
				}
			}else{
				for(var i=0; i<rcheck.length; i++){
					rcheck[i].checked = false;
			}
		}
	}
	
	function selectDelete(){
		//alert("삭제");
		var rcheck = document.getElementsByName("rowcheck");
		var flag = false;
		for(var i=0; i<rcheck.length; i++){
			if(rcheck[i].checked){
				flag = true;
				break;
			}
		}
		if(!flag){
			alert("삭제할 항목을 선택하세요.");
			return;
		}
		document.f.submit();

	}