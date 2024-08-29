/**
 * 
 */
 
$(function(){
            $('#textBox').keyup(function (e) {
                var content = $(this).val();
                
                // 글자수 세기
                if (content.length == 0 || content == '') {
                    $('.textCount').html('0자');
                } else {
                    $('.textCount').html(content.length + '자');
                }
                
                // 글자수 제한
                if (content.length > 200) {
                    // 200자 이상 입력되면 제한
                    $(this).val(content.substring(0, 200));
                    // 200자 초과 알림
                    alert('글자수는 200자까지 입력 가능합니다.');
                }
            });
       
       
        });
        
    
