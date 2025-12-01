#!/bin/bash

# 데이터 파일 경로 변수 설정
DB_FILE="books.db"

## 판매 처리 함수 정의
process_sale() {
    echo "====================================="
    echo "           도서 판매 시스템         "
    echo "====================================="

    # 1. 판매할 도서 ID 입력 받기
    read -p "판매할 도서 ID를 입력하세요: " SALE_ID
    
    # 2. AWK를 사용하여 재고 및 판매 횟수 업데이트
    # AWK 스크립트:
    # 1) 필드 구분자(|)와 출력 구분자(|) 설정
    # 2) 입력 ID와 일치하는 레코드를 찾음 ($1 == id)
    # 3) 재고($5)가 0보다 큰지 확인
    # 4) 재고를 1 줄이고, 판매 횟수($6)를 1 늘림
    # 5) 재고가 없으면 경고 출력
    
    awk -F'|' -v id="$SALE_ID" 'BEGIN{OFS="|"; sold=0}
    {
        if ($1 == id) {
            if ($5 > 0) {
                $5 = $5 - 1;
                $6 = $6 + 1;
                sold=1;
                print $0;
            } else {
                print $0;
                print "재고 부족: 도서 ID " id "의 재고가 없습니다!" > "/dev/stderr";
            }
        } else {
            print $0;
        }
    }
    END {
        if (sold==1) {
            print "판매 성공: 도서 ID " id " 판매가 처리되었습니다." > "/dev/stderr";
        } else if (sold==0 && id != "") {
             # ID가 파일에 없는 경우
             # print "오류: 해당 ID를 찾을 수 없습니다." > "/dev/stderr";
        }
    }' "$DB_FILE" > temp.db && mv temp.db "$DB_FILE"

    echo ""
}

# 함수 실행
process_sale