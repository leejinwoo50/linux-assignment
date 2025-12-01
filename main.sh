#!/bin/bash
# ----------------------
# 서점 관리 시스템 - 메뉴 정의 (통합 버전)
# ----------------------

# 외부 스크립트 호출 방식을 사용합니다.
# 예: ./register_book.sh, ./view_stock.sh

show_menu() {
    echo "--- 서점 관리 시스템 ---"
    # 숫자 선택에 맞게 메뉴를 정리합니다.
    echo "1. 도서 등록"
    echo "2. 재고 조회"
    echo "3. 판매 처리"
    echo "4. 베스트셀러 조회"
    echo "5. 종료"
}

# 2. 메인 루프 함수 (사용자 입력 및 실행)
main_loop() {
    CHOICE="" # 변수 초기화

    # 무한 루프 시작 (종료를 선택하기 전까지 계속 반복)
    while true; do
        show_menu
        # 숫자로 입력받도록 프롬프트를 수정합니다.
        read -p "기능을 선택하세요 (1~5): " CHOICE

        # 숫자 입력이므로 소문자 변환 로직은 제거합니다.

        # case 문을 사용하여 선택된 기능 실행
        case $CHOICE in
            "1")
                echo "-> 도서 등록 기능을 실행합니다."
                ./register.sh 
                ;;
            "2")
                echo "-> 재고 조회 기능을 실행합니다."
                ./view_stock.sh 
                ;;
            "3")
                echo "-> 판매 처리 기능을 실행합니다."
                ./sale_process.sh 
                ;;
            "4")
                echo "-> 베스트셀러 조회 기능을 실행합니다."
                ./bestseller.sh
                ;;
            "5")
                echo "시스템을 종료합니다. 감사합니다."
                break # 루프 탈출
                ;;
            *)
                echo " 잘못된 입력입니다. 1~5 중 선택해주세요."
                ;;
        esac
        echo ""
    done
}

# 메인 루프 실행
main_loop




