<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<head>
<title>일정</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<link href="css/fullcalendar.min.css" rel="stylesheet" />
<link href="css/fullcalendar.print.min.css" rel="stylesheet" media="print" />
<script src="lib/moment.min.js"></script>
<script src="lib/jquery.min.js"></script>
<script src="js/fullcalendar.min.js"></script>
<script src="js/ko.js"></script>

<!-- 부트스트랩 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>

<link rel="stylesheet" type="text/css" href="css/datepicker3.css" />
<script type="text/javascript" src="js/bootstrap-datepicker.js"></script>
<script type="text/javascript" src="js/bootstrap-datepicker.kr.js"></script>
 


<script>
//풀캘린더 시작
$(document).ready(function(){
	
	/* datePicker */
	$('.dateRangePicker').datepicker({
		 format: "yyyy-mm-dd",
		 language: "kr",
		 autoclose:true
	 });

	$('#calendar').fullCalendar({
		/* 옵션 */
  		header: {
		    left: 'prev,next today',
		    center: 'title',
		    right: 'month,agendaWeek,agendaDay,listWeek'
		},
	   	defaultDate: new Date(),
     	editable: true, 
     	selectable: true,
  		selectHelper: true,
  		/* 일정 데이터  */
     	events: function (start, end, timezone, callback) {
			
     		$.ajax({
				url : '/scheduler/GetEvents',
				type: "POST",
				async: false,
				datatype: 'json',
				success: function(data){
	       	  		
					var events = [];
				
					$.each(data, function(i, obj) {
						
						events.push({
							title : obj.title, 
							start : obj.start, 
							end : obj.end,
							no : obj.no
						});					
					
					});
					
	          		callback(events);
	          		
         		 },error : function(req, status) {
         			alert(status + ': ' + req.status);
         		 }
         		 
			});
   		},
     	eventAfterRender: function (start, event, element, view) {
     		return false;
     	},
     	
     	select: function (info, date) {
     		
	   		 $("[name=startdate]").val(date.format(info.startStr));
       		 $("[name=enddate]").val(date.format(info.endStr));
			 $("#newModal").modal();
		},
     	
     	/* 날짜 클릭 */
		dayClick: function(date, jsEvent, view) {
			
			console.log(date.format());
			
			 $("[name=startdate]").val(date.format());
			 $("#newModal").modal();
		},
		
		/* 일정 이벤트 클릭 */
		eventClick: function(info) {
		  
			var no = info.no;
			var title = info.title;
			var startdate = info.start._i;
			var enddate = info.end._i;
			
			console.log(info);
			
			// 자바스크립트 하루더하기 ::: enddate - 1
			
			$("[name=no]").val(no);
			$("[name=title2]").val(title);
			$("[name=startdate2]").val(startdate);
			$("[name=enddate2]").val(enddate);
			
			//select2
			$("#updateModal").modal();
		}

	});
	
});
	// 등록
	function go_add() {
		if( $('[name=title]').val() == ''){
			alert('제목을 입력하세요.');
			$('[name=title]').focus();
			return;
		}else if( $('[name=startdate]').val() == ''){
			alert('시작날짜를 입력하세요.');
			$('[name=startdate]').focus();
			return;
		}else if( $('[name=enddate]').val() == ''){
			alert('끝나는 날을 입력하세요.');
			$('[name=enddate]').focus();
			return;
		}
		
		$('form').attr("method","POST");
		$('form').attr("action","/scheduler/add");
 		$('form').submit();
	
	}//go_add()
	
	// 수정
	function go_update() {
		if( $('[name=title2]').val() == ''){
			alert('제목을 입력하세요.');
			$('[name=title2]').focus();
			return;
		}else if( $('[name=startdate2]').val() == ''){
			alert('시작날짜를 입력하세요.');
			$('[name=startdate2]').focus();
			return;
		}else if( $('[name=enddate2]').val() == ''){
			alert('끝나는 날을 입력하세요.');
			$('[name=enddate2]').focus();
			return;
		}
		
		$('[name=title]').val($('[name=title2]').val());
		$('[name=startdate]').val($('[name=startdate2]').val());
		$('[name=enddate]').val($('[name=enddate2]').val());
		
 		$('form').attr("action","/scheduler/update");
 		$('form').submit();
	
	}
	
	// 삭제
	function go_delete() {
		
		if(confirm('정말 삭제하시겠습니까?')){
			
 		$('form').attr("action","/scheduler/delete");
 		$('form').submit();
 		
		}else{
			return false;
		}
	}


</script>

<style>

  body {
    margin: 40px 10px;
    padding: 0;
    font-family: "Lucida Grande",Helvetica,Arial,Verdana,sans-serif;
    font-size: 14px;
  }

  #calendar {
    max-width: 900px;
    margin: 0 auto;
  }

</style>
</head>

<body>
<form id="form" name="form" method="post">
 	<input type="hidden" id="no" name="no"/> 
	<!-- 일정 추가 버튼 -->
	<div style="max-width: 900px; margin: 0 auto; height: 60px;" >
		<div style="float: right;">
	  		<button type="button" class="btn btn-primary btn-lg" data-toggle="modal" data-target="#newModal">
	 			 일정 추가
			</button>
		</div>
	</div>

	<!-- 캘린더  -->
  	<div id='calendar'></div>
  	
	  <!-- 일정 추가 모달 -->
		<div class="modal fade" id="newModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		  <div class="modal-dialog">
		    <div class="modal-content">
		      <div class="modal-header">
		        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
		        <h5 class="modal-title" id="myModalLabel" style="font-weight: bold;">일정 추가</h5>
		      </div>
		      <div class="modal-body">
		     	 <h6>일정 제목</h6>
		        	<input type="text" name="title">
		        <h6>일정 시작하는 날(yyyy-mm-dd)</h6>
		        	<input type="text" name="startdate" class="dateRangePicker" autocomplete="off">
		        <h6>일정 끝나는 날(yyyy-mm-dd)</h6>
		       	 <input type="text" name="enddate" class="dateRangePicker" autocomplete="off" >
		        </div>
		      <div class="modal-footer">
		        <button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
		        <button type="button" class="btn btn-primary" onclick="go_add()">추가하기</button>
		      </div>
		    </div>
		  </div>
		  
		 
		</div>
		
	<!-- 수정/삭제 모달  -->
		<div class="modal fade" id="updateModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		  <div class="modal-dialog">
		    <div class="modal-content">
		      <div class="modal-header">
		        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
		        <h5 class="modal-title" id="myModalLabel" style="font-weight: bold;">일정 변경</h5>
		      </div>
		      <div class="modal-body">
		     	 <h6>일정 제목</h6><input type="text" name="title2">
		     	 <h6>일정 시작하는 날(yyyy-mm-dd)</h6><input type="text" name="startdate2" class="dateRangePicker" autocomplete="off">
		         <h6>일정 끝나는 날(yyyy-mm-dd)</h6><input type="text" name="enddate2" class="dateRangePicker" autocomplete="off">
		      </div>
		      <div class="modal-footer">
		        <button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
		        <button type="button" class="btn btn-primary" onclick="go_update()">수정하기</button>
		        <button type="button" class="btn btn-danger" onclick="go_delete()">삭제하기</button>
		      </div>
		    </div>
		  </div>
		</div>
  </form>
</body>
<!-- 일정 추가 다이얼로그 -->