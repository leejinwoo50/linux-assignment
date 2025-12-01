#!/bin/bash

# 데이터 파일 경로 변수 설정
DB_FILE="books.db"

## 베스트셀러 조회 함수 정의
view_bestsellers() {
    echo "====================================="
    echo "         베스트셀러 TOP 5 조회       "
    echo "====================================="

    # 1. 상위 몇 개를 보여줄지 설정
    TOP_N=5

    # 2. sort, head, column 명령어를 이용한 정렬 및 출력
    # cat: DB 파일 내용을 파이프(|)로 넘김
    # sort -t'|' -k6 -nr: 
    #   -t'|': 구분자(Delimiter)를 파이프(|)로 지정
    #   -k6: 6번째 필드(판매 횟수)를 기준으로 정렬
    #   -n: 숫자(Numeric)로 정렬
    #   -r: 내림차순(Reverse) 정렬 (판매 횟수가 높은 순)
    # head -n $TOP_N: 상위 TOP_N개만 추출
    # column -t -s '|': 파이프를 기준으로 열을 깔끔하게 정렬
    
    cat "$DB_FILE" | sort -t'|' -k6 -nr | head -n "$TOP_N" | cut -d'|' -f2,3,6 | column -t -s '|'
    
    echo "====================================="
}

# 함수 실행
view_bestsellers