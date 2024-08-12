<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../include/ad_header.jsp" %>

<main class="container d-flex">
	<nav class="container w-25 pt-5">
		<h5>[관리자 페이지]</h5>	
		<ul class="navbar-nav">
			<li class="nav-item"><a class="nav-link" href="#">카테고리 등록</a></li>
			<li class="nav-item"><a class="nav-link" href="#">카테고리 리스트</a></li>
			<li class="nav-item"><a class="nav-link" href="#">상품 등록</a></li>
			<li class="nav-item"><a class="nav-link" href="#">상품 리스트</a></li>
			<li class="nav-item"><a class="nav-link" href="#">매출관리</a></li>
			<li class="nav-item"><a class="nav-link" href="#">상품관리</a></li>
			<li class="nav-item"><a class="nav-link" href="#">회원관리</a></li>
			<li class="nav-item"><a class="nav-link" href="#">기타</a></li>
		</ul>	
	</nav>
	<div class="w-75">
		<div class="graph-container d-flex">			
			<div class="figure m-2" style="width:190px; height:50px; background:#eee; text-align: center; line-height: 50px;">일일매출</div> 	
			<div class="figure m-2" style="width:190px; height:50px; background:#eee; text-align:center; line-height: 50px;">누적매출</div> 	
			<div class="figure m-2" style="width:190px; height:50px; background:#eee; text-align:center; line-height: 50px;">일일방문자</div> 	
			<div class="figure m-2" style="width:190px; height:50px; background:#eee; text-align:center; line-height: 50px;">총방문자</div> 				
		</div>
		<div class="graph-container d-flex">			
			<div class="graph m-2" style="width:400px; height:200px; background:#eee; text-align:center;">
				<canvas id="myChart"></canvas>
			</div>
			<div class="graph m-2" style="width:400px; height:200px; background:#eee; text-align:center;">
				<canvas id="myChart2"></canvas>
			</div>		
		</div>
		<div class="graph-container d-flex">
			<div class="graph m-2" style="width:400px; height:200px; background:#eee; text-align:center;">
				<canvas id="myChart3"></canvas>
			</div>
			<div class="graph m-2" style="width:400px; height:200px; background:#eee; text-align:center;">
				<canvas id="myChart4"></canvas>
			</div>		
		</div>
	</div>
</main>

<!-- <script src="https://code.jquery.com/jquery-3.4.1.js"></script>  -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script type="text/javascript">
$(document).ready(function() {
	var saleQty = [];
	var saleName = [];
	
	// Fetch dynamic data for the first chart
	$.ajax({
		url: "getData.do",
		async: true,
		type: "GET",
		dataType: "json",
		contentType: "application/json; charset=utf-8",
		success: function(data) {
			/* $.each(data, function() {
				saleQty.push(this["tqty"]);
				saleName.push(this["tname"]);
			}); */
			
			for(let i = 0; i < data.length; i++){
				saleQty.push(data[i].tqty);
				saleName.push(data[i].tname);
			}
			console.log(saleQty);
			console.log(saleName);
			
			const ctx1 = document.getElementById('myChart').getContext('2d');
			new Chart(ctx1, {
				type: 'line',
				data: {
					labels: saleName,
					datasets: [{
						label: '상품 판매량 현황',
						data: saleQty,
						backgroundColor: 'lightblue',
						borderColor: 'lightblue',
						borderWidth: 3
					}]
				},
				options: {
					scales: {
						y: {
							beginAtZero: true
						}
					}
				}
			});
		}
	});
	
	// Initialize other static charts
	const ctx2 = document.getElementById('myChart2').getContext('2d');
	new Chart(ctx2, {
		type: 'bar',
		data: {
			labels: ['Red', 'Blue', 'Yellow', 'Green', 'Purple', 'Orange'],
			datasets: [{
				label: '# of Votes',
				data: [12, 19, 3, 5, 2, 3],
				backgroundColor: ['Red', 'Blue', 'Yellow', 'Green', 'Purple', 'Orange'],
				borderWidth: 1
			}]
		},
		options: {
			scales: {
				y: {
					beginAtZero: true
				}
			}
		}
	});

	const ctx3 = document.getElementById('myChart3').getContext('2d');
	new Chart(ctx3, {
		type: 'doughnut',
		data: {
			labels: ['Red', 'Blue', 'Yellow', 'Green', 'Purple', 'Orange'],
			datasets: [{
				label: '# of Votes',
				data: [12, 19, 3, 5, 2, 3],
				backgroundColor: ['Red', 'Blue', 'Yellow', 'Green', 'Purple', 'Orange'],
				borderWidth: 1
			}]
		},
		options: {
			scales: {
				y: {
					beginAtZero: true
				}
			}
		}
	});

	const ctx4 = document.getElementById('myChart4').getContext('2d');
	new Chart(ctx4, {
		type: 'line',
		data: {
			labels: ['Red', 'Blue', 'Yellow', 'Green', 'Purple', 'Orange'],
			datasets: [{
				label: '# of Votes',
				data: [12, 19, 3, 5, 2, 3],
				backgroundColor: 'rgba(75, 192, 192, 0.2)',
				borderColor: 'rgba(75, 192, 192, 1)',
				borderWidth: 1
			}]
		},
		options: {
			scales: {
				y: {
					beginAtZero: true
				}
			}
		}
	});
});
</script>

<%@include file="../include/ad_footer.jsp" %>
