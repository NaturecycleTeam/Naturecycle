package com.mbc.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.mbc.domain.ProdPageDTO;
import com.mbc.domain.ProductDTO;

public interface ProductService {
	//////////////////관리자 /////////////////////
	// 상품 등록
	void prodRegister(Map map);

	// 상품 리스트
	List<ProductDTO> productList(); 
	
	/*
	 * // 홈화면 상품 리스트 List<ProductDTO> homeProductList(ProdPageDTO pDto);
	 */

	// 상품 삭제
	void deleteProduct(int pnum);
	
	// 상품 정보 가져오기
	ProductDTO getProduct(int pnum);
	
	// 상품 수정
	void updateProduct(Map map);
	
	////////////////////////////회원 ///////////////////////////
	// 카테고리별 상품 리스트 (뷰 단에 뿌리기)
	ArrayList<ProductDTO> getProdByCategory(String code);
	
	// 스펙별 상품 리스트 (뷰 단에 뿌리기)
	ArrayList<ProductDTO> getProdBySpec(String pSpec);

	List<ProductDTO> prodSearch(ProductDTO pDto);

	List<ProductDTO> uprodList();
	
	// 상품 검색
	
	
	
	

}
