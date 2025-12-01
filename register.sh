#!/bin/bash

# B
# 파일 경로 변수 설정
DB_FILE="books.db"

## 도서 등록 함수 정의
register_book() {
    echo "====================================="
    echo "         ��� 도서 등록 시스템          "
    echo "====================================="

    # 1. 사용자에게 정보 입력 받기
    read -p "도서 ID (4자리 숫자): " BOOK_ID
    read -p "제목: " TITLE
    read -p "저자: " AUTHOR
    read -p "가격: " PRICE
    read -p "초기 재고 수량: " STOCK

    # 2. ID 중복 확인 (grep 사용)
    # ^$BOOK_ID| : 해당 ID가 파일 시작 부분에 정확히 일치하는지 확인
    if grep -q "^${BOOK_ID}|" "$DB_FILE"; then
        echo "⛔ 오류: 입력하신 도서 ID($BOOK_ID)는 이미 등록되어 있습니다."
        return 1
    fi

    # 3. 데이터 형식 정의 (판매 횟수는 0으로 시작)
    # 필드: ID | 제목 | 저자 | 가격 | 재고 | 판매횟수
    NEW_RECORD="${BOOK_ID}|${TITLE}|${AUTHOR}|${PRICE}|${STOCK}|0"

    # 4. 파일에 기록 (>> 사용)
    printf "%s\n" "$NEW_RECORD" >> "$DB_FILE"
    echo "✅ 성공: 도서 [$TITLE] (ID: $BOOK_ID) 등록이 완료되었습니다."
    echo ""

}	
# 함수 실행
register_book