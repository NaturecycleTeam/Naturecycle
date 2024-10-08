<%@page import="org.apache.ibatis.reflection.SystemMetaObject"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../include/ad_header.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<link href="<c:url value="/resources/css/ad_main.css"/>" rel="stylesheet" />


<main class="d-flex">
	
	<nav class="container p-5 me-5" style="width:20%; background:#eee;">
			
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
				  <li><a class="dropdown-item" href="reservationList.do">예약관리</a></li>
                  <li><a class="dropdown-item" href="adQuestionList.do">문의사항</a></li>
              </ul>
            </li>
		</ul>	
	</nav>
	<div class="chart-area pt-5 pb-5" style="width:80%;">
		<div class="d-flex">
			<div class="figure m-2">오늘매출 : <b><span id="today_amount"></span></b></div>	
			<div class="figure m-2">총매출 : <b><span id="tot_amount"></span></b></div> 					
		</div>
		<div class="container d-flex pt-2">		
			<div class="graph m-2" ondrop="drop(event)" ondragover="allowDrop(event)">
			    <button class="close-btn" onclick="removeGraph(event)">×</button>
			    <canvas id="myChart1"></canvas>
			</div>
			<div class="graph m-2" ondrop="drop(event)" ondragover="allowDrop(event)">
				<button class="close-btn" onclick="removeGraph(event)">×</button>
				<canvas id="myChart2"></canvas>
			</div>		
		</div>
		<div class="container d-flex pt-2">
			<div class="graph m-2" ondrop="drop(event)" ondragover="allowDrop(event)">
				<button class="close-btn" onclick="removeGraph(event)">×</button>
				<canvas id="myChart3"></canvas>
			</div>
			<div class="graph m-2" ondrop="drop(event)" ondragover="allowDrop(event)">
				<button class="close-btn" onclick="removeGraph(event)">×</button>
				<canvas id="myChart4"></canvas>
			</div>		
		</div>
	</div>
	<aside class="sidebar" style="width: 20%; float: left;">
	    <div class="item-list">
	    	<p><i class="fa-solid fa-circle-exclamation" style="line-height: 1.5;"> 원하는 옵션을 <br/> drag&drop으로 추가해보세요!!</i></p>
	        <div class="item" draggable="true" data-chart="weekly" ondragstart="drag(event)"><i class="fa-solid fa-chart-column"> 주매출</i></div>
	        <div class="item" draggable="true" data-chart="monthly" ondragstart="drag(event)"><i class="fa-solid fa-chart-column"> 월매출</i></div>
	        <div class="item" draggable="true" data-chart="yearly" ondragstart="drag(event)"><i class="fa-solid fa-chart-column"> 연매출</i></div>
	        <div class="item" draggable="true" data-chart="totalProduct" ondragstart="drag(event)"><i class="fa-solid fa-chart-pie"> 상품판매량</i></div>
	        <div class="item" draggable="true" data-chart="monthlyDonation" ondragstart="drag(event)"><i class="fa-solid fa-chart-column"> 기부금</i></div>
	        <div class="item" draggable="true" data-chart="monthlyDonation" ondragstart="drag(event)"><i class="fa-solid fa-chart-column"> 예약</i></div>
	        <div class="item" draggable="true" data-chart="monthlyDonation" ondragstart="drag(event)"><i class="fa-solid fa-chart-column"> 문의</i></div>
	        <div class="item" draggable="true" data-chart="monthlyDonation" ondragstart="drag(event)"><i class="fa-solid fa-chart-column"> 캠페인참여율</i></div>
	           
	    </div>
	</aside>
	<button id="toggleSidebarBtn" style="position: fixed; right: 10px; top: 15px;">편집모드</button>
	
</main>
</body>
<%@include file="../include/ad_footer.jsp" %>


<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js" ></script>

<script type="text/javascript">

/* $(function() {
    $(".container").sortable({
        revert: true,
        placeholder: "sortable-placeholder"
    });
}); */


// 편집모드 버튼
let isSortableActive = false;

document.getElementById('toggleSidebarBtn').addEventListener('click', function() {
    // 사이드바 보이기
	const sidebar = document.querySelector('.sidebar');
    sidebar.classList.toggle('active');
    
    // 삭제버튼 활성화
    const closeButtons = document.querySelectorAll('.close-btn');
    closeButtons.forEach(button => {
        button.classList.toggle('active');
    });
    
    const graphs = document.querySelectorAll('.graph');
    graphs.forEach(graph => {
    	graph.classList.toggle('active');
    });
    
    // sortable 활성화/비활성화 토글
    if (isSortableActive) {
        $(".container").sortable("destroy"); // sortable 비활성화
    } else {
        $(".container").sortable({
            revert: true,
            placeholder: "sortable-placeholder"
        }); // sortable 활성화
    }
    
    // 상태 토글
    isSortableActive = !isSortableActive;
    
});



//////////////  드래그앤드롭 기능 : 차트 그래프 생성 /////////////////
// 드롭 허락
function allowDrop(event) {
    event.preventDefault();
    event.target.classList.add('over'); // Add class for visual feedback
}

// Remove visual feedback when drag leaves
function dragLeave(event) {
    event.target.classList.remove('over');
}

// 드래그 기능
function drag(event) {
    event.dataTransfer.setData("text", event.target.getAttribute("data-chart"));
    console.log("Dragging item with data-chart: " + event.target.getAttribute("data-chart"));

}

// 드롭 기능
function drop(event) {
    event.preventDefault();
    event.target.classList.remove('over'); // Remove visual feedback

    // 드롭 타켓 얻기
    let dropTarget = event.target;

    // Traverse up the DOM tree to find a parent div with class 'graph' if needed
    while (dropTarget && !dropTarget.classList.contains('graph')) {
        dropTarget = dropTarget.parentElement;
    }

    // 'graph'를 포함한 클래스명을 가졌는지 확인
    if (dropTarget && dropTarget.classList.contains('graph')) {
        let canvas = dropTarget.querySelector('canvas');

        // canvas 존재 여부 체크
        if (canvas) {
            updateChart(canvas);
        } else {
            console.error('canvas가 존재하지 않습니다.');
        }
    } else {
        console.error('유효한 div가 아닙니다.');
    }
}

// 드롭 후 차트 그래프 생성
function updateChart(canvas) {
    let ctx = canvas.getContext('2d');

    let chartType = event.dataTransfer.getData("text");
    console.log("chartType : " + chartType);
    let chart;

    // ajax, chart.js 사용
    switch (chartType) {
        case 'weekly':
        	var order_date = [];
        	var daily_purchase = [];
        	const dataUrl = "dailyPurchase.do";
        	
        	$.ajax({
        		url: "dailyPurchase.do",
        		async: true,
        		type: "GET",
        		dataType: "json",
        		contentType: "application/json; charset=utf-8",
        		success: function(data) {
        			
        			for(let i = 0; i < data.length; i++){
        				order_date.push(data[i].date);
        				daily_purchase.push(data[i].sum);        				
        			}
        			console.log(daily_purchase);
        			
       		         chart = new Chart(ctx, {
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
            break;
            
        case 'monthly':
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
        			
        		    chart = new Chart(ctx, {
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
            break;
        case 'yearly':
            chart = new Chart(ctx, {
                type: 'pie',
                data: {
                    labels: ['Q1', 'Q2', 'Q3', 'Q4'],
                    datasets: [{
                        label: 'Yearly Amount',
                        data: [300, 400, 500, 600],
                        backgroundColor: [
                            'rgba(255, 99, 132, 0.2)',
                            'rgba(54, 162, 235, 0.2)',
                            'rgba(255, 206, 86, 0.2)',
                            'rgba(75, 192, 192, 0.2)'
                        ],
                        borderColor: [
                            'rgba(255, 99, 132, 1)',
                            'rgba(54, 162, 235, 1)',
                            'rgba(255, 206, 86, 1)',
                            'rgba(75, 192, 192, 1)'
                        ],
                        borderWidth: 1
                    }]
                }
            });
            break;
        case 'totalProduct':
        	/* 카테고리별 총 상품판매량 */
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
        			

        	          chart = new Chart(ctx, {
        	            type: 'doughnut', // 차트 타입을 'doughnut'으로 설정
        	            data: {
        	                labels: category_name,
        	                datasets: [{
        	                    label: '카테고리별 상품 누적 판매량',
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
        	                        text: '카테고리별 상품 판매량', // 제목 텍스트
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
            break;
        case 'monthlyDonation':
        	var donation_month = [];
        	var monthly_amount = [];

        	$.ajax({
        	    url: "monthlyDonation.do",
        	    async: true,
        	    type: "GET",
        	    dataType: "json",
        	    contentType: "application/json; charset=utf-8",
        	    success: function(data) {
        	        // Extract data from the response
        	        for (let i = 0; i < data.length; i++) {
        	            donation_month.push(data[i].date).toString();  // Assuming 'date' is the month
        	            monthly_amount.push(data[i].sum);   // Assuming 'sum' is the amount
        	        }
        	        console.log(donation_month);
        	        console.log(monthly_amount);
        	        
        	         chart = new Chart(ctx, {
        	            type: 'bar', // Chart type
        	            data: {
        	                labels: donation_month, // x-axis labels (e.g., months)
        	                datasets: [{
        	                    label: '기부금 현황', // Label for the dataset
        	                    data: monthly_amount, // Data for each label
        	                    backgroundColor: 'lightblue', // Background color of bars
        	                    borderColor: 'lightblue', // Border color of bars
        	                    borderWidth: 1 // Width of border
        	                }]
        	            },
        	            options: {
        	                plugins: {
        	                    legend: {
        	                        display: true // Display legend
        	                    }
        	                },
        	                scales: {
        	                    x: {
        	                        beginAtZero: true // Start x-axis at zero
        	                    },
        	                    y: {
        	                        beginAtZero: true // Start y-axis at zero
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
            break;
    }
    
	// canvasId 설정
    const targetCanvas = event.target.closest('canvas');

    if (targetCanvas) {
        // Get the ID of the target canvas
        const canvasId = targetCanvas.id;
        console.log('Dropped onto canvas ID:', canvasId);
        
        // dataUrl 설정
        let dataUrl = "";
        if (chartType === "weekly") {
            dataUrl = "dailyPurchase.do";  
        } else if (chartType === "monthly") {
            dataUrl = "monthlyPurchase.do";  
        } else if (chartType === "yearly") {
            dataUrl = "yealyPurchase.do";  
        } else if (chartType === "totalProduct") {
            dataUrl = "prod_purchase.do";  
        } else if (chartType === "monthlyDonation") {
            dataUrl = "monthlyDonation.do";  
        }
        console.log("dataUrl : " + dataUrl)
    	
        saveChartConfig(canvasId, dataUrl);
        
        // Store chart in window object 
        window.myChart = chart;
        
    }else{
        console.error('Canvas요소가 정의되지 않았음');
    }
      
}

////////////// 데이터베이스 : 차트 그래프 저장/삭제 /////////////////
// 차트 그래프 데이터 저장
function saveChartConfig(canvasId, dataUrl) {
    
    const chartConfig = {
        canvasId: canvasId,  
        dataUrl: dataUrl     
    };

    if (canvasId && dataUrl) {
	    $.ajax({
	        url: 'saveChartConfig.do', 
	        type: 'POST',
	        contentType: 'application/json; charset=utf-8',
	        data: JSON.stringify(chartConfig),  
	        success: function(response) {
	        	 if (response.status === "error") {              
	                 alert(response.message);
	                 
	             } else {                 
	                 console.log(response.message);
	
	             }
	         },
	         error: function(xhr, status, error) {
	             console.error("AJAX error:", error);  
	        }
	    });
    }
}

// 차트 불러오기
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
	
	// 저장한 카트 불러오기
	$.ajax({
	    url: 'getSavedChart.do', 
	    type: 'GET',
	    dataType: 'json',
	    success: function(chartConfigs) {
	        
	        chartConfigs.forEach(function(chartConfig) {
	            const canvasId = chartConfig.canvasId;
	            const dataUrl = chartConfig.dataUrl;

	            $.ajax({
	                url: dataUrl,
	                type: 'GET',
	                dataType: 'json',
	                success: function(data) {
	                	
	                	let order_date = [], daily_purchase = [];
	                    let order_month = [], monthly_purchase = [];
	                    let order_yearly = [], yearly_purchase = [];
	                    let cumulPQTY = [], category_name = [];
	                    let donation_month = [], monthly_amount = [];

	                    data.forEach(function(item) {
	                        if (dataUrl === "dailyPurchase.do") {
	                            order_date.push(item.date);
	                            daily_purchase.push(item.sum);
	                        } else if (dataUrl === "monthlyPurchase.do") {
	                            order_month.push(item.date);
	                            monthly_purchase.push(item.sum);
	                        } else if (dataUrl === "yealyPurchase.do") {
	                            order_yearly.push(item.year);
	                            yearly_purchase.push(item.sum);
	                        } else if (dataUrl === "prod_purchase.do") {
	                            cumulPQTY.push(item.totPQTY);
	                            category_name.push(item.cat_name);
	                        } else if (dataUrl === "monthlyDonation.do") {
	                            donation_month.push(item.date);
	                            monthly_amount.push(item.sum);
	                        }
	                    });
	                        
	                    // 차트 생성
	                    const ctx = document.getElementById(canvasId).getContext('2d');
	                    let chartType = dataUrl === "prod_purchase.do" ? 'doughnut' : 'bar';

	                    new Chart(ctx, {
	                        type: chartType,
	                        data: {
	                            labels: (() => {
	                                if (dataUrl === "dailyPurchase.do") return order_date;
	                                if (dataUrl === "monthlyPurchase.do") return order_month;
	                                if (dataUrl === "yealyPurchase.do") return order_yearly;
	                                if (dataUrl === "prod_purchase.do") return category_name;
	                                if (dataUrl === "monthlyDonation.do") return donation_month;
	                            })(),
	                            datasets: [{
	                                label: (() => {
	                                    if (dataUrl === "dailyPurchase.do") return '일주일 매출(최근 7일)';
	                                    if (dataUrl === "monthlyPurchase.do") return '월매출';
	                                    if (dataUrl === "yealyPurchase.do") return '연매출';
	                                    if (dataUrl === "prod_purchase.do") return '상품 판매량(카테고리별)';
	                                    if (dataUrl === "monthlyDonation.do") return '월 기부금 현황';
	                                })(),
	                                data: (() => {
	                                    if (dataUrl === "dailyPurchase.do") return daily_purchase;
	                                    if (dataUrl === "monthlyPurchase.do") return monthly_purchase;
	                                    if (dataUrl === "yealyPurchase.do") return yearly_purchase;
	                                    if (dataUrl === "prod_purchase.do") return cumulPQTY;
	                                    if (dataUrl === "monthlyDonation.do") return monthly_amount;
	                                })(),
	                                backgroundColor: (() => {
	                                    if (dataUrl === "prod_purchase.do") return ['rgb(255, 99, 132)','rgb(54, 162, 235)','rgb(255, 205, 86)','rgb(75, 192, 192)', 'rgb(153, 102, 255)', 'rgb(255, 159, 64)'];
	                                    return 'lightblue';
	                                })(),
	                                /* borderColor: 'black', */
	                                type: chartType
	                            }]
	                        },
	                        options: {
	                            responsive: true, // Make chart responsive to screen size
	                            maintainAspectRatio: false, // Prevent aspect ratio distortion
	                            plugins: {
	                                legend: {
	                                    position: dataUrl === "prod_purchase.do" ? 'right' : 'top', // Legend position for doughnut chart
	                                    labels: {
	                                        color: '#333',
	                                        font: {
	                                            size: 12
	                                        }
	                                    }
	                                },
	                                tooltip: {
	                                    callbacks: {
	                                        label: function(tooltipItem) {
	                                            return tooltipItem.label + ': ' + tooltipItem.raw;
	                                        }
	                                    }
	                                },
	                                // Additional options for doughnut chart only
	                                title: {
	                                    display: chartType === 'doughnut', // Show title only for doughnut chart
	                                    text: '카테고리별 상품 판매량', // Title text for doughnut chart
	                                    font: {
	                                        size: 14
	                                    },
	                                    color: '#333'
	                                }
	                            },
	                            scales: (() => {
	                                // Only show scales for non-doughnut charts
	                                if (chartType !== 'doughnut') {
	                                    return {
	                                        x: { beginAtZero: true },
	                                        y: { beginAtZero: true }
	                                    };
	                                }
	                                return {}; 
	                            })(),
	                            maintainAspectRatio: false, // Prevent scaling issues for doughnut charts
	                            cutout: chartType === 'doughnut' ? '60%' : 0 
	                        }
	                    });
	                },
	                error: function(xhr, status, error) {
	                    console.error("AJAX 요청 에러:", error);
	                    alert("데이터를 불러오는 중 문제가 발생했습니다.");
	                }
	            });
	        });
	    },
	    error: function(xhr, status, error) {
	        console.error("AJAX 요청 에러:", error);
	        alert("차트 설정을 불러오는 중 문제가 발생했습니다.");
	    }
	});

});

//차트 그래프 선택적 삭제
function removeGraph(event) {
    // Find the canvas element
    const canvas = event.target.closest('.graph').querySelector('canvas');

    
    if (canvas) {
        const canvasId = canvas.id; // Get the canvas ID
	 	console.log("캔버스 아이디 : " + canvasId)
        // Clear the canvas content
        const ctx = canvas.getContext('2d');
        ctx.clearRect(0, 0, canvas.width, canvas.height);

        // Send an AJAX request to delete the chart from the database
        $.ajax({
            url: 'deleteChart.do',
            type: 'POST',
            contentType: 'application/json; charset=utf-8',
            data: JSON.stringify({ canvasId: canvasId }),
            success: function(response) {
                console.log('차트 삭제 성공:', response);
            },
            error: function(xhr, status, error) {
                console.error('차트 삭제 실패:', error);
            }
        });
    }
}


</script>


