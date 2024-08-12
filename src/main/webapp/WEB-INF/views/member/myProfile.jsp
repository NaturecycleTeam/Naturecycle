<%@ page import="com.mbc.domain.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   
<%@ include file="../include/header.jsp" %>  

<aside class="question">
	<ul>
		<%-- <li><a href='<c:url value="myProfile.do"/>'>내 정보</a></li> --%>
		<li><a href='<c:url value="question.do"/>'>문의하기</a></li>
		<li><a href='<c:url value="listQ.do?mid=${sessionScope.loginDTO.id}"/>'>문의사항 확인</a></li>
		<li><a href='<c:url value="pwChange.do"/>'>비밀번호 변경</a></li>
	</ul>
</aside>

 <div class='container w-50 shadow mt-5 p-5 rounded-3 border'>                                                               
 <h2>회원 정보</h2>                                                                        
 <form action='memberUpdate.do' method='post'>          
    <input type='text' name='no' value=''>                                 
                                 
       <table class='table table-borderless'>
          <thead>
                 <th colspan='2'><h3 class='text-center'>님 회원정보 </h3>                                         
           </thead>                                                                             
          <tr>                                                                                          
             <td>번호</td>                                                                             
             <td><input class='form-control' type='text' name='no' value='' disabled /></td>
          </tr>                                                                                        
          <tr>                                                                                         
             <td>아이디</td>                                                                          
             <td><input class='form-control' type='text' name='id' value='' disabled /></td>                                                                                  
          </tr>                                                                                      
          <tr>                                                                                       
             <td>비밀번호</td>                                                                      
             <td><input class='form-control' type='text' name='pw' value='' disabled /></td>                                                                                  
          </tr>                                                                                         
          <tr>                                                                                          
             <td>이름</td>                                                                             
             <td><input class='form-control' type='text' name='name' value='' disabled /></td>                                                                                  
          </tr>                                                                                        
          <tr>                                                                                         
             <td>나이</td>                                                                            
             <td><input class='form-control' type='text' name='age' value=''/></td>   
          </tr>                                                                                        
          <tr>                                                                                         
             <td>이메일</td>                                                                          
             <td><input class='form-control' type='text' name='email' value=''/></td> 
          </tr>                                                                                          
          <tr>                                                                                        
             <td>전화번호</td>                                                                       
             <td><input class='form-control' type='text' name='tel' value=''/></td>  
          </tr>                                                                                    
          <tr>                                                                                     
             <td colspan='2' class='text-center p-4'>                                             
                <input type='submit' value='수정하기' class='btn btn-primary'>                   
                <input type='reset' value='취소' class='btn btn-warning'>                        
                <a href='memberList.do' class='btn btn-info'>리스트</a>                  
             </td>                                                                               
          </tr>                                                                                   
       </table>                                                                      
 </form>                                                    
 </div>                                                   
<%@ include file="../include/footer.jsp" %>