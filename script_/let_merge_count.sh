#!/bin/bash

# counts 파일이 있는 디렉토리
COUNT_DIR="./"  # 필요시 경로 변경

# 임시 작업 디렉토리
TMP_DIR="./tmp_counts_merge"
mkdir -p "$TMP_DIR"

# 결과 파일 초기화
OUT_FILE="merged_counts.tsv"
HEADER="Ensembl_ID"

# 파일별로 필요한 열만 추출 (1열: Ensembl ID, 2열: count 값)
for file in "$COUNT_DIR"/*.counts; do
    # 파일 이름에서 경로 제거
    base=$(basename "$file")
    
    # ID 열과 count 열만 추출
    cut -f1,2 "$file" > "$TMP_DIR/${base}.cut"
    
    # 헤더에 파일 이름 추가
    HEADER+="\t${base}"
done

# 첫 번째 파일 기준으로 병합 시작
paste "$TMP_DIR"/*.cut | \
    awk -F'\t' -v OFS='\t' -v header="$HEADER" '
    BEGIN {
        print header
    }
    {
        # Ensembl ID는 각 파일마다 반복되므로 첫 번째 열마다 하나만 가져오고, 이후 열은 2,4,6,...만 출력
        printf "%s", $1
        for (i = 2; i <= NF; i += 2) {
            printf "\t%s", $i
        }
        printf "\n"
    }' > "$OUT_FILE"

# 정리
rm -r "$TMP_DIR"

echo "병합 완료: $OUT_FILE"

