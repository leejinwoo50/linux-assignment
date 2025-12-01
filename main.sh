#!/bin/bash
# ----------------------
# 서점 관리 시스템 - 메뉴 정의 (팀원 버전)
# ----------------------
   

show_menu() {
    echo "--- 서점 관리 시스템 ---"
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
        read -p "기능을 선택하세요 (1~5): " CHOICE

        
        CHOICE=$(echo $CHOICE)

        # case 문을 사용하여 선택된 기능 실행
        case $CHOICE in
            "1")
                echo "-> 도서 등록 기능을 실행합니다."
                
                ./register_book.sh 
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
                echo "잘못된 입력입니다. 1~5 중 선택해주세요."
                ;;
        esac
        echo ""
    done
}

# 메인 루프 실행
main_loop