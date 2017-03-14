# 使用R進行視覺化吧！

用R進行資料整理與視覺化的工作坊的講義們在此

## 目錄

- [RStudio快捷鍵](#RStudio快捷鍵們)
- [安裝／載入套件](#首先安裝／載入今天要使用使用的套件：tidyverse)
- [R基礎語法](#R基礎語法)
- [ggplot2繪圖](#開始用ggplot2畫圖八！)


## RStudio快捷鍵們

[All RStudio keyboard shortcuts](https://support.rstudio.com/hc/en-us/articles/200711853-Keyboard-Shortcuts)

功能                    | Windows & Linux    | Mac
----------------------- | ------------------ | --------------------
顯示快捷鍵              | Alt+Shift+K        | Option+Shift+K
自動補完	              | Tab or Ctrl+Space  | Tab or Command+Space
執行（單行／選取範圍）  | Ctrl+Enter         | Command+Enter
註解（單行／選取範圍）  | Ctrl+Shift+C       | Command+Shift+C
存擋                    | Ctrl+S             | Command+S
縮排                    | Ctrl+I             | Command+I

## 開始用R柳

### 首先安裝／載入今天要使用使用的套件：tidyverse

安裝：（如果已經安裝過就可以挑過這個步驟囉）
	install.packages("tidyverse")

載入：

	library("tidyverse")

## R基礎語法

### 向量式的運算

R 的主打就是向量式的運算，什麼？你說請講中文？好吧那廢話不多說讓我們直接來看看 R 會吐什麼給我們，請分別輸入以下指令：
	
	c(1, 2, 3) + 1
	c(1, 2, 3) + c(2, 3, 4)

### 沒關係不重要，搞懂 `Dataframe` 就好

先把資料用 `data_frame` 的格式，存到 `DF` 這個變數裡。

	DF <- data_frame("colA" = c("A", "B", "C"), "num" = c(1, 2, 3))

然後呼喚他的名字：

	DF

## 開始用ggplot2畫圖八！


