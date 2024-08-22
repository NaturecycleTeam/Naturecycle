<%@page import="org.apache.ibatis.reflection.SystemMetaObject"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../include/ad_header.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 

<main class="container d-flex">
	
	<nav class="container w-25 pt-5">
			
		<h5>[관리자 페이지]</h5>	
		<ul class="navbar-nav">
		  	<li class="nav-item dropdown">
              <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                  상품 관리
              </a>
              <ul class="dropdown-menu" aria-labelledby="navbarDropdown">
	              <li><a class="dropdown-item" href="catInput.do">카테고리 등록</a></li>
				  <li><a class="dropdown-item" href="catList.do">카테고리 리스트</a></li>
                  <li><a class="dropdown-item" href="prodInput.do">상품 등록</a></li>
                  <li><a class="dropdown-item" href="prodList.do">상품 리스트</a></li>
              </ul>
            </li>
			<li class="nav-item"><a class="nav-link" href="salesInfo.do">매출관리</a></li>
			<li class="nav-item dropdown">
              <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                  회원 관리
              </a>
              <ul class="dropdown-menu" aria-labelledby="navbarDropdown">
	              <li><a class="dropdown-item" href="memberList.do">회원 리스트</a></li>
				  <li><a class="dropdown-item" href="#">예약관리</a></li>
                  <li><a class="dropdown-item" href="listQT.do">문의사항</a></li>
              </ul>
            </li>
			<!-- <li class="nav-item"><a class="nav-link" href="memberList.do">회원관리</a></li>
			<li class="nav-item"><a class="nav-link" href="listQT.do">문의사항</a></li> -->
		</ul>	
	</nav>
	<div class="w-75 mt-5">
		<div class="graph-container d-flex">
					
			<div class="figure m-2" style="width:190px; height:50px; background:#eee; text-align: center; line-height: 50px;">
				오늘매출 : <b><span id="today_amount"></span></b></div>	
			<div class="figure m-2" style="width:190px; height:50px; background:#eee; text-align:center; line-height: 50px;">
				총매출 : <b><span id="tot_amount"></span></b></div> 	
			<!-- <div class="figure m-2" style="width:190px; height:50px; background:#eee; text-align:center; line-height: 50px;">일일방문자</div> 	
			<div class="figure m-2" style="width:190px; height:50px; background:#eee; text-align:center; line-height: 50px;">총방문자</div>  -->				
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
/* function getInputDayLabel() { 
	var order_date = [];       
	var week = new Array('일요일', '월요일', '화요일', '수요일', '목요일', '금요일', '토요일');        
	var today = new Date(order_date).getDay();    
	var todayLabel = week[today]; 
	       
	return todayLabel;	
}  
console.log(getInputDayLabel())	 */


$(document).ready(function() {
	
	 // 숫자를 천 단위로 구분하여 포맷팅하는 함수
    function formatNumber(num) {
        return Number(num).toLocaleString(); // 기본 천 단위 구분
    }

    // 오늘매출
    $.ajax({
        url: "todayPurchase.do",
        type: "GET",
        success: function(data) {
            if (data) {
                $("#today_amount").text(formatNumber(data) + " 원");
            } else {
                $("#today_amount").text("0 원");
            }
        },
        error: function(xhr, status, error) {
            console.error("AJAX 요청 에러:", error);
            $("#today_amount").text("Error");
        }
    });

    // 총매출
    $.ajax({
        url: "totalPurchase.do",
        type: "GET",
        success: function(data) {
            if (data) {
                $("#tot_amount").text(formatNumber(data) + " 원");
            } else {
                $("#tot_amount").text("0 원");
            }
        },
        error: function(xhr, status, error) {
            console.error("AJAX 요청 에러:", error);
            $("#tot_amount").text("Error");
        }
    });
		
	// 첫번째 그래프(일일매출 최근 7일)
	var order_date = [];
	var daily_purchase = [];
	
	$.ajax({
		url: "dailyPurchase.do",
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
				order_date.push(data[i].date);
				daily_purchase.push(data[i].sum);
				
			}
			console.log(daily_purchase);
			
			
			 const ctx1 = document.getElementById('myChart').getContext('2d');
		        new Chart(ctx1, {
		            type: 'bar', // 기본 차트 타입을 bar로 설정
		            data: {
		                labels: order_date,
		                datasets: [
		                	{
		                        label: ' ', // 공백으로 레이블을 설정
		                        data: daily_purchase,
		                        backgroundColor: 'transparent', // 배경색을 투명으로 설정
		                        borderColor: 'black', // 선 색상
		                        borderWidth: 1,
		                        type: 'line' // 이 데이터 세트는 line 차트로 표시
		                    },
		                    {
		                        label: '일일 매출', // bar 차트의 레이블
		                        data: daily_purchase,
		                        backgroundColor: 'lightblue',
		                        borderColor: 'lightblue',
		                        borderWidth: 1,
		                        type: 'bar' // 이 데이터 세트는 bar 차트로 표시
		                    }		                    
		                ]
		            },
		            options: {
		                plugins: {
		                    legend: {
		                        display: true, // 전체 범례를 표시
		                        labels: {
		                            filter: function(item, chart) {
		                                // 범례의 레이블이 ' '인 데이터 세트만 숨김
		                                return item.text !== ' ';
		                            }
		                        }
		                    }
		                },
		                scales: {
		                    x: {
		                        beginAtZero: true
		                    },
		                    y: {
		                        beginAtZero: true
		                    }
		                }
		            }
		        });
		    },
		    error: function(xhr, status, error) {
		        console.error("AJAX 요청 에러:", error);
		        alert("데이터를 불러오는 중 문제가 발생했습니다.");
		    }
		});
	
	// 두번째 그래프(상품 총 판매량)
	var cumulPQTY = [];
	var category_name = [];

	$.ajax({
		url: "prod_purchase.do",
		async: true,
		type: "GET",
		dataType: "json",
		contentType: "application/json; charset=utf-8",
		success: function(data) {
			
			for(let i = 0; i < data.length; i++){
				cumulPQTY.push(data[i].totPQTY);
				category_name.push(data[i].cat_name);
			}
			console.log(cumulPQTY);
			console.log(category_name);
			
			const ctx1 = document.getElementById('myChart2').getContext('2d');
	        new Chart(ctx1, {
	            type: 'doughnut', // 차트 타입을 'doughnut'으로 설정
	            data: {
	                labels: category_name,
	                datasets: [{
	                    label: '상품 누적 판매량',
	                    data: cumulPQTY,
	                    backgroundColor: [
	                        'rgb(255, 99, 132)',
	                        'rgb(54, 162, 235)',
	                        'rgb(255, 205, 86)',
	                        'rgb(75, 192, 192)',
	                        'rgb(153, 102, 255)',
	                        'rgb(255, 159, 64)'
	                    ],
	                    hoverOffset: 4
	                }]
	            },
	            options: {
	                responsive: true, // 차트를 화면 크기에 맞게 조정
	                plugins: {
	                    title: {
	                        display: true, // 제목을 표시하도록 설정
	                        text: '상품 판매량', // 제목 텍스트
	                        font: {
	                            size: 14 // 제목 텍스트 크기
	                        },
	                        color: '#333' // 제목 텍스트 색상
	                    },
	                    legend: {
	                        position: 'right', // 범례 위치 설정 (top, bottom, left, right)
	                        labels: {
	                            color: '#333', // 범례 텍스트 색상
	                            font: {
	                                size: 12 // 범례 텍스트 크기
	                            }
	                        }
	                    },
	                    tooltip: {
	                        callbacks: {
	                            label: function(tooltipItem) {
	                                return tooltipItem.label + ': ' + tooltipItem.raw; // 툴팁 텍스트 형식 설정
	                            }
	                        }
	                    }
	                },
	                cutout: '60%', // 도넛 차트의 중앙 비율 설정 (60% 비우기)
	                maintainAspectRatio: false // 차트의 종횡비를 유지하지 않음
	            }
	        });
	    },
	    error: function(xhr, status, error) {
	        console.error("AJAX 요청 에러:", error);
	        alert("데이터를 불러오는 중 문제가 발생했습니다.");
	    }
	});
	
	// 세번째 그래프(월매출)
	var order_month = [];
	var monthly_purchase = [];
	$.ajax({
		url: "monthlyPurchase.do",
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
				order_month.push(data[i].date);
				monthly_purchase.push(data[i].sum);
			}
			console.log(order_month);
			console.log(monthly_purchase);
			
			const ctx1 = document.getElementById('myChart3').getContext('2d');
			new Chart(ctx1, {
	            type: 'bar', // 기본 차트 타입을 bar로 설정
	            data: {
	                labels: order_month,
	                datasets: [
	                	{
	                        label: ' ', // 공백으로 레이블을 설정
	                        data: monthly_purchase,
	                        backgroundColor: 'transparent', // 배경색을 투명으로 설정
	                        borderColor: 'black', // 선 색상
	                        borderWidth: 1,
	                        type: 'line' // 이 데이터 세트는 line 차트로 표시
	                    },
	                    {
	                        label: '월 매출', // bar 차트의 레이블
	                        data: monthly_purchase,
	                        backgroundColor: 'lightblue',
	                        borderColor: 'lightblue',
	                        borderWidth: 1,
	                        type: 'bar' // 이 데이터 세트는 bar 차트로 표시
	                    }		                    
	                ]
	            },
	            options: {
	                plugins: {
	                    legend: {
	                        display: true, // 전체 범례를 표시
	                        labels: {
	                            filter: function(item, chart) {
	                                // 범례의 레이블이 ' '인 데이터 세트만 숨김
	                                return item.text !== ' ';
	                            }
	                        }
	                    }
	                },
	                scales: {
	                    x: {
	                        beginAtZero: true
	                    },
	                    y: {
	                        beginAtZero: true
	                    }
	                }
	            }
	        });
	    },
	    error: function(xhr, status, error) {
	        console.error("AJAX 요청 에러:", error);
	        alert("데이터를 불러오는 중 문제가 발생했습니다.");
	    }
	});

	
	// 4번쨰 그래프 (미정)
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
