package org.zerock.domain;

public class Criteria {
	private int page; //limit ? //첫번째 자리
	private int perPageNum; //limit x,? // 두번째 자리
	
	
	public Criteria() { //첫페이지 실행시 적용될 값들 (기본 생성자)
		this.page = 1; //첫 페이지 초기화
		this.perPageNum = 9; //한 페이지당 출력 할 게시물 수
	}
	
	public void setPage(int page) {
		if(page <= 0) {
			this.page = 1;
			return;
		}
		this.page = page;
	}	
	public int getPage() {
		return page;
	}	
	
	//Mybatis SQL mapper - 			

		//sql 구문에서 limit ?,페이지당 출력 수 설정
		public void setPerPageNum(int perPageNum) {
			if(perPageNum <= 0) {
				this.perPageNum = 9;
				return; 
			}
			this.perPageNum = perPageNum;
		}	
		public int getPerPageNum() {
			return perPageNum;
		}
		
		// limit 시작 값 ( 메서드 처리 )
		public int getPageStart() {
			return (this.page - 1) * this.perPageNum;
		}
		
		@Override
		public String toString() {
			return "Criteria [page=" + page + ", perPageNum=" + perPageNum + "]";
		}
}
