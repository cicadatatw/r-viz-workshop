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

R的主打就是向量式的運算，什麼？你說請講中文？好吧那廢話不多說讓我們直接來看看R會吐什麼給我們，請分別輸入以下指令：
	
	c(1, 2, 3) + 1
	c(1, 2, 3) + c(2, 3, 4)

### 沒關係不重要，搞懂Dataframe就好

先把資料用 `data_frame` 的格式，存到 `DF` 這個變數裡。

	DF <- data_frame("colA" = c("A", "B", "C"), "num" = c(1, 2, 3))

然後呼喚他的名字：

	DF

## 開始用ggplot2畫圖八！

### 讀入資料 

- [臺北市政府警察局交通警察大隊/交通事故資料](http://data.taipei/opendata/datalist/datasetMeta?oid=2f238b4f-1b27-4085-93e9-d684ef0e2735)
- 使用**readr**的**read_csv**函數，而不是內建的**read.csv**

我們把資料讀進來，存在`traffic`這個變數裡。

	traffic <- read_csv("traffic_eng.csv")

接著一起來看看這個檔案長什麼樣子。用`head()`來看檔案的前幾行，括號內的第一個argument填入我們想看的資料`traffic`，`n=3` 則是告訴R我們想看前三行。

	head(traffic, n=3)

### 探索資料　 

- 看一下時間分佈好了

用`select()`選擇`time.month`、`time.day`、`time.hour`、`time.minute`這四個欄位，然後用`summary()`看一下各欄位的基本統計值。

	traffic %>%
	    select(time.month, time.day, time.hour, time.minute) %>%
	    summary()

看的出來是24小時制的紀錄方式，但如果想知道整體分配，這樣好像看不出什麼貓膩。改用`group_by()`來看看。這個函數可以把資料按照指定欄位——在這裡我們指定的是`time.hour`——分組排好，然後再用`count()`來計算每一組裡面有幾筆資料。最後把資料存在`pivot.time.hour`這個變數裡。

	traffic %>%
	    group_by(time.hour) %>%
	    count() -> pivot.time.hour

接著來看看剛剛分好組的資料：

	pivot.time.hour %>% head(5)

用肉眼雖然可以大致看出多少，但對各組之間相對的大小好像還是沒什麼概念，這時候就需要畫張圖來看看啦。
 
### 用ggplot2畫圖+探索資料

首先，用`ggplot`開一張畫布，並且存在`qq`裡，指定資料來自剛剛製作的`pivot.time.hour`：

	qq <- ggplot(data = pivot.time.hour)

接著告訴R我們要畫長條圖`geom_bar`，x軸使用`time.hour`這個欄位，y軸使用`n`：

	qq <- qq + geom_bar(aes(x=time.hour, y=n), stat = "identity")

但東西畫到哪去了呢？用`print()`把他呼喚出來：

	print(qq)


