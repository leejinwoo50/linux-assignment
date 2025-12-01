#!/bin/bash

# B
# 파일 경로 변수 설정
DB_FILE="books.db"
## 재고 조회 함수 정의
    echo "====================================="
    echo "           재고 조회 시스템          "
    echo "====================================="
    
    read -p "조회할 도서 ID 또는 제목 일부를 입력하세요 (전체 조회: Enter): " KEYWORD
    
    if [ -z "$KEYWORD" ]; then
        # KEYWORD가 비어있으면 전체 목록 출력
        echo "--- 전체 도서 목록 (ID, 제목, 재고) ---"
        # cut: |를 구분자로 사용(-d'|'), 1, 2, 5번째 필드(-f1,2,5) 출력
        cat "$DB_FILE" | cut -d'|' -f1,2,5 | column -t -s '|'
    else
        # KEYWORD가 있으면 검색 후 해당 필드만 출력
        echo "--- '$KEYWORD' 검색 결과 (ID, 제목, 재고) ---"
        # grep: KEYWORD가 포함된 줄 검색
        # cut: 검색된 줄에서 1, 2, 5번째 필드 출력
        grep -i "$KEYWORD" "$DB_FILE" | cut -d'|' -f1,2,5 | column -t -s '|'
    fi
    echo "====================================="
