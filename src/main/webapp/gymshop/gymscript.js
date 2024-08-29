/**
 * 
 */

 function allCheck(obj){
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
 
 function selectCartDelete() {
    var rcheck = document.getElementsByName("rowcheck");
    var flag = false;
    var confirmation = confirm("정말로 삭제하시겠습니까?");
    
    if (!confirmation) {
		flag=false;
        return;
    }

    for (var i = 0; i < rcheck.length; i++) {
        if (rcheck[i].checked) {
            flag = true;
            break;
        }
    }

    if (!flag) {
        alert("선택한 항목이 없습니다");
        return;
    }
    
    document.delform.submit();
}



function orderSelectedItems() {
    var rowcheck = document.getElementsByName("rowcheck");
    var flag = false;
    var cnoList = [];
    // 체크된 상품의 cno 값을 배열에 저장
    for (var i = 0; i < rowcheck.length; i++) {
        if (rowcheck[i].checked) {
            cnoList.push(rowcheck[i].value);
            flag = true;
        }
    }
    if (!flag) {
        alert("주문할 상품을 선택해주세요.");
    } else {
        document.orderform.submit(cnoList);
    }
}
