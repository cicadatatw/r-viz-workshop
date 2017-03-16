# 給初學者的 R 入門碎碎念
過去的學習經驗發現，學會基本指令後，直接找個題目實作，進步的速度會比跟著教學慢慢爬快多了，雖然痛苦指數會稍微高一點，不過收穫也相對多很多喔。
## 安裝
首先請先安裝以下軟體：
- [R](https://www.r-project.org/)
- [RStudio](https://www.rstudio.com/products/rstudio/download3/)

RStudio 是一個 IDE，提供圖形化介面，幫助我們更輕鬆地操作 R。
## 開始
在這裡會先很快的帶過會常常用到的函數們。

首先載入內建資料集 iris 鳶尾花

    # 我是柱姐，不對，註解
    data(iris)
接著看一下 data 的概述

    # 方法1：看資料型態
    str(iris)
    # 方法2：看數值欄位的資料分佈
    summary(iris)

也可以用各種方法看一下資料

    # 資料的頭
    head(iris)
    # 資料的尾巴
    tail(iris)
    # 資料某個欄位的的平均數、中位數、變異數
    mean(iris$Sepal.Length)
    median(iris$Petal.Length)
    var(iris$Petal.Length)

等等，中間 ````$```` 是做什麼的？！````$```` 用來表示我們要呼喚資料表（Data Frame）裡面的某一個欄位（Column），用法是 ````資料表$欄位名````。

### 畫個圖吧
同時我們也可以利用 R 內建的畫圖模組來看一下資料的長相，雖然有點醜，但是看分布快又有效(?)。

    # 散佈圖
    plot(iris$Sepal.Length, iris$Sepal.Width)
    # 長條圖
    plot(iris$Species)
    # 盒狀圖
    plot(iris$Species, iris$Sepal.Length)
    # 散佈圖矩陣
    plot(iris)

要一直打 ````iris$```` 好像有點煩QQ 讓我們偷懶一下，使用 ````attach()```` 先將 ````iris```` 設為我們的預設(?)資料表，這樣就不用一直重複打字了歐耶！

    attach(iris)
    # 散佈圖
    plot(Sepal.Length, Sepal.Width)
    # 長條圖
    plot(Species)
    # 盒狀圖
    plot(Species, Sepal.Length)
    # 散佈圖矩陣
    plot(iris)
    # 用完之後要記得 detach
    detach()
    
### 跑個回歸～
回歸的函數叫 ````lm````，用法是 ````lm(y~x)````

    lm1 = lm(Sepal.Length~Sepal.Width)
    
看一下我們的模型：

    lm1

好像資訊沒有很多，用 ````summary```` 來看看：

    summary(lm1)
    
同時我們也可以一次放入很多變項：

    lm3 = lm(Sepal.Length~Sepal.Width+Petal.Length+Petal.Width)

### 我講完惹！
基礎大概就這樣柳，現在大家一起找個題目來做做看吧！
#### 以下是指令小筆記
    train = read.csv("train.csv", stringsAsFactors=FALSE)
    cbind()
    rbind()
    library("dplyr")
    arrange(data, Sepal.Length)
    
# 2017/02/18

## 飯粒資料

首先請先下載飯粒資料： [台北市交通事故資料](https://drive.google.com/open?id=1MvyXiyolhs-NzPa61FDqktyzyptrX2wf5-1rXo7SdU0)，飯粒資料整理自 [台北市政府公開資料](http://data.taipei/opendata/datalist/datasetMeta?oid=2f238b4f-1b27-4085-93e9-d684ef0e2735)

## 準備工作
### library 下載：ggplot2, dplyr

RStudio 右下角區域，有一個 tab 叫作 `Packages`，找找看是否清單裡已經有 `ggplot2` 和 `dplyr` 兩個 library，如果沒有的話，按下 `install` 並分別 library。如果想要自行安裝，可以在左邊 console 中鍵入：

    install.packages("ggplot2")
    install.packages("dplyr")

### 載入 library

在library前面的小框框打勾即可！如果想使用 console，可鍵入：

    library("ggplot2")
    library("dplyr")

### 讀取資料

按下右上角 `import dataset`，並選擇你要匯入的檔案即可。手動的話，請輸入：

    traffic2 = read.csv("~/Documents/R/traffic2.csv")

## 開始畫圖！（進度怎麼有點快）
### 發現上次好像沒教直方圖 hist()，先補一下進度

`hist()` 直方圖是我們的好朋友，和上次的 `plot()` 一樣，可以很快看一下一組資料的分佈。 `hist()` 主要是用來看一組純數值資料中的分配狀況。`plot()`則是同時看兩組純數值(?)資料以及他們的相關情形。不過我看了半天，這組資料大概只有 `年齡` 是比較連續的數值資料，所以我們用 `年齡` 這一欄來看看 `hist()`怎麼使用吧。（決定等等用說解釋`dplyr`⋯⋯）

    temp = select(traffic2, 年齡) %>% filter(年齡 > 0)
    hist(temp)

    
值得注意的是，這組資料的列舉方法，和我們的直覺略有不同。一般而言，我們會覺得每一列就是一場車禍，但實際上為了詳列每位當事人的狀況，資料中每一列代表的是車禍中的一位當事人，也就是說，如果一場車禍有 4 位當事人，這場車禍在這組資料就會有 4 列。這 4 列的時間、地點、受傷人數及死亡人數都是相同的，只有當事人序車種、性別、年齡、受傷程度是不同的。剛剛屁話了這麼多，只是要說：上圖畫出來的並不是「所有肇事者」的年齡分佈，而是「肇事者和衰小被捲入車禍事件的所有當事人」的年齡分佈喔。

    temp = filter(traffic2, 年齡 > 0, 性別 == "女") %>% select(年齡, 性別)
    hist(temp)
    temp = filter(traffic2, 年齡 > 0, 性別 == "男") %>% select(年齡, 性別)
    hist(temp)
    
身為喜愛引戰的人類，我們當然也可以分別來畫畫男性和女性的年齡分布圖。（Plots 下面的兩個小箭頭可以往返你所有畫過的圖喔。）雖然兩張圖看起來有微妙的不同，不過既然包括了所有無辜捲入ㄉ人們，我們很難只用這兩張圖就說男性跟女性在交通事故的出現機率不同就是ㄌ～～～

### 言歸正傳，ggplot2 來也

首先，我們來認識一下 `ggplot2` 程式碼的組成。畫圖的第一件事就是跟 R 說：ㄟ我們要開一張 `ggplot2` 的畫布，畫 `traffic2` 這個資料。

    ggplot(traffic2)

沒錯，方法就是這麼簡單，輸入`ggplot2(資料的名字)`即可。不過我們通常會先把他存到一個變數裡頭，方便我們等等叫他出來面對：

    c = ggplot(traffic2)

接下來再告訴 R 我們到底要畫啥。使用`geom_bar()`招喚出長條圖，並秉持著戰男女的精神，繼續來畫性別。這時候把長條圖加在我們原本的畫布 `c` 上面。

    c + geom_bar(aes(性別))

好的， R 什麼反應都沒有，完全不知道他做了啥，這時候再輸入`c`就可以把圖招喚出來。

    c

沒有意外ㄉ話，大家會看到一張，很多方格子的圖⋯⋯用中文(?)來說的話，就是亂碼。只好來拯救它一下。

    c + theme(text=element_text(family="STHeiti", size=12))

這時候再招喚 `c` 就會得到一張比較正常ㄉ圖了。

#### ggplot2 到底在幹麻

ggplot2 基本上就是以 `+` 把畫布上不同的元素跟設定放在一起，所以 ggplot2 畫圖的程式碼通常是一大串由 `+` 串連起來的英文(????)，像這樣：

    g = ggplot(traffic2) + #開畫布
        geom_bar(aes(車種, fill=處理別)) + #我要畫車種的長條圖！還要用處理別填色
        coord_flip() + #把他轉90度
        theme(text=element_text(family="STHeiti", size=12)) #設定字型
    g #呼喚他

時間來不及ㄌ，下面是各種圖ㄉcode⋯⋯一次貼一組蛤

    # 我是一張圖
    g = ggplot(traffic2, aes(道路型態, fill=性別)) + geom_bar() + coord_flip()+ 
      theme(text=element_text(family="STHeiti", size=12))
    g

    # 我是一張圖
    g = ggplot(traffic2, aes(車種, fill=性別)) + geom_bar() + coord_flip()+ 
      theme(text=element_text(family="STHeiti", size=12))

    # 我是一張圖
    g = ggplot(traffic2, aes(車種, fill=受傷程度)) + geom_bar() + coord_flip()+ 
      theme(text=element_text(family="STHeiti", size=12))
    g

    # 我是一張圖
    g = ggplot(traffic2, aes(車種, fill=處理別)) + geom_bar() + coord_flip()+ 
      theme(text=element_text(family="STHeiti", size=12))
    g

    # 我在整理資料
    t1 = filter(traffic2, 當事人序==1)
    t1$發生月 = as.factor(t1$發生月)
    t2 = filter(traffic2, 當事人序==2)

    # 我是一張圖
    g = ggplot(t1, aes(區序, fill=性別)) + geom_bar() + coord_flip()+ 
      theme(text=element_text(family="STHeiti", size=12))
    g

    # 我是一張圖
    g = ggplot(t1, aes(發生月, fill=性別)) + geom_bar() + 
      theme(text=element_text(family="STHeiti", size=12))
    g

    g = ggplot(t1, aes(車種, fill=處理別)) + geom_bar() + coord_flip()+ 
      theme(text=element_text(family="STHeiti", size=12))
    g

    # 我是一張圖
    g = ggplot(t1, aes(速限, fill=處理別)) + geom_bar() + coord_flip()+ 
      theme(text=element_text(family="STHeiti", size=12))
    g

    # 我在整理資料
    df1 = t1 %>%
      group_by(發生時, 處理別) %>%
      summarise(次數 = sum(當事人序), 受傷人數 = sum(受傷人數), 死亡人數 = sum(死亡人數))

    # 我是一張圖
    g = ggplot(df1, aes(發生時, 次數, colour=處理別)) + geom_line() + 
      theme(text=element_text(family="STHeiti", size=12))
    g

    # 我在整理資料
    df2 = filter(df1, 處理別 == "重大")

    # 我是一張圖
    g = ggplot(df2, aes(發生時, 次數, colour=處理別)) + geom_line() + 
      theme(text=element_text(family="STHeiti", size=12))
    g

    # 我在整理資料
    df3 = filter(df1, 死亡人數 > 0)

    # 我是一張圖
    g = ggplot(df3, aes(發生時, 次數)) + geom_line() + 
      theme(text=element_text(family="STHeiti", size=12))
    g

    # 我是一張圖
    g = ggplot(df1, aes(發生時, 受傷人數, colour=處理別)) + geom_line() + 
      theme(text=element_text(family="STHeiti", size=12))
    g


