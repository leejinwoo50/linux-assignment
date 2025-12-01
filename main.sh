#!/bin/bash
# ----------------------
# 서점 관리 시스템 - 메뉴 정의 (팀원 버전)
# ----------------------

# 1. 기존 함수들(등록, 조회 등)을 통합하기 위해 함수 호출 방식을 변경합니다.
#    현재는 main.sh에 로직이 없으므로, 외부 스크립트(.sh)를 호출하는 방식을 사용합니다.
#    실제 구현된 파일 이름으로 대체해야 합니다.
#    예: register_book.sh, view_stock.sh

show_menu() {
    echo "--- 서점 관리 시스템 ---"
    # 팀원은 메뉴 번호 대신 알파벳을 사용합니다.
    echo "[A] 도서 등록" 
    echo "[B] 재고 조회"
    echo "[C] 판매 처리"
    echo "[D] 베스트셀러 조회"
    echo "[E] 종료"
}

# 2. 메인 루프 함수 (사용자 입력 및 실행)
main_loop() {
    CHOICE="" # 변수 초기화

    # 무한 루프 시작 (종료를 선택하기 전까지 계속 반복)
    while true; do
        show_menu
        read -p "기능을 선택하세요 (A~E): " CHOICE

        # 소문자 입력에도 대응하기 위해 소문자로 변환 (Bash 내장 기능)
        CHOICE=$(echo $CHOICE | tr '[:lower:]' '[:upper:]')

        # case 문을 사용하여 선택된 기능 실행
        case $CHOICE in
            "A")
                echo "-> 도서 등록 기능을 실행합니다."
                
                ./register_book.sh 
                ;;
            "B")
                echo "-> 재고 조회 기능을 실행합니다."
                ./view_stock.sh 
                ;;
            "C")
                echo "-> 판매 처리 기능을 실행합니다."
                
                ./sale_process.sh 
                ;;
            "D")
                echo "-> 베스트셀러 조회 기능을 실행합니다."
                
                ./bestseller.sh
                ;;
            "E")
                echo "시스템을 종료합니다. 감사합니다."
                break # 루프 탈출
                ;;
            *)
                echo "잘못된 입력입니다. A~E 중 선택해주세요."
                ;;
        esac
        echo ""
    done
}

# 메인 루프 실행
main_loop