#!/usr/bin/env Rscript

## 사용자 전용 라이브러리 경로 설정
user_lib <- file.path(Sys.getenv("HOME"), "R", paste0("x86_64-pc-linux-gnu-library/", R.Version()$major, ".", R.Version()$minor))
if (!dir.exists(user_lib)) dir.create(user_lib, recursive = TRUE)
.libPaths(user_lib)

## BiocManager 없으면 설치
if (!requireNamespace("BiocManager", quietly = TRUE)) {
  install.packages("BiocManager", repos = "http://cran.us.r-project.org")
}

## 필요한 패키지 설치 (없을 경우만)
if (!requireNamespace("edgeR", quietly = TRUE)) {
  BiocManager::install("edgeR", ask = FALSE)
}
if (!requireNamespace("readr", quietly = TRUE)) {
  install.packages("readr", repos = "http://cran.us.r-project.org")
}
if (!requireNamespace("dplyr", quietly = TRUE)) {
  install.packages("dplyr", repos = "http://cran.us.r-project.org")
}
if (!requireNamespace("lattice", quietly = TRUE)) {
  install.packages("lattice", repos = "http://cran.us.r-project.org")
}



## 패키지 로드
library(edgeR)
library(readr)
library(dplyr)
library(lattice)

cat("Current working directory:\n")
print(getwd())

## 데이터 불러오기 (.tsv) 및 마지막 4줄 제거
raw_data <- read_tsv("merged_counts.tsv", col_names = TRUE)

# gene name (1열) 따로 저장
gene_names <- raw_data[[1]]

# count 데이터만 추출
data <- select(raw_data, -1)

# 마지막 4줄 제거
data <- head(data, -5)
gene_names <- head(gene_names, -5)

## normalization
y <- DGEList(counts = data)
y <- calcNormFactors(y)
cps <- cpm(y, normalized.lib.sizes = TRUE)

## log2(CPM + 1) 변환
log_cps <- log2(cps + 1)

## gene name 다시 붙이기
log_cps_with_gene <- cbind(Gene = gene_names, as.data.frame(log_cps))

## 저장
write.table(log_cps_with_gene, file = "log2_norm_count_result.txt", sep = "\t", row.names = FALSE, quote = FALSE)

cat("Normalization + log2(CPM+1) complete. Output written to log2_norm_count_result.txt\n")

