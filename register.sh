#!/bin/bash

# B
# 파일 경로 변수 설정
DB_FILE="books.db"
## 재고 조회 함수 정의
view_stock() {
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
}
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
echo "1. 도서 등록"
echo "2. 재고 조회"
read -p "원하는 기능을 선택하세요 (1/2): " CHOICE

if [ "$CHOICE" == "1" ]; then
    register_book
elif [ "$CHOICE" == "2" ]; then
    view_stock
else
    echo "잘못된 선택입니다."
fi