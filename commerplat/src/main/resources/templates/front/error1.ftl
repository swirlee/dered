<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<script type="text/javascript" src="../js/jquery-3.3.1.js"></script>
<script type="text/javascript">
	$(function(){
		/* 五秒后自动跳转页面  */
		window.setTimeout(one,5000);
		function one(){
			location.href='/front/mycart';
		}
		
	})

</script>
<body>
	<center>
		<!-- <div ><h2>${message}</h2></div><br> -->
		<div ><h2>${status}</h2></div>
		<div><h2>&nbsp;</h2></div>
		<p><img src="/images/2.gif"></p>
		
		
		<!-- 自动跳转的方法：window.settimeout(hh,1000) -->
		
		
		
	</center>
</body>
</html>