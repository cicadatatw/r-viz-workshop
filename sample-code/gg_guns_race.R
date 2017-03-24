# 讀入檔案
guns <- read.csv("~/Downloads/guns.csv")

# 調整
levels(guns$race)
# # [1] "Asian/Pacific Islander"         "Black"                         
# # [3] "Hispanic"                       "Native American/Native Alaskan"
# # [5] "White"  
levels(guns$race) <- c("亞裔", "非裔", "拉丁裔", "原住民", "白人")
levels(guns$race)
# # [1] "亞裔"   "非裔"   "拉丁裔" "原住民" "白人" 

levels(guns$intent)
# # [1] "Accidental"   "Homicide"     "Suicide"      "Undetermined"
levels(guns$intent) <- c("意外", "謀殺", "自殺", "未知")
levels(guns$intent)
# # [1] "意外" "謀殺" "自殺" "未知"

# 美國白人好厭世？
gg <- ggplot(data = guns)
gg <- gg + geom_bar(aes(x = age, fill = intent))
gg <- gg + facet_grid(race ~.)
gg <- gg + scale_x_continuous(breaks = seq(0,100,10))
gg <- gg + scale_fill_discrete(name="事件類型")
gg <- gg + theme(text=element_text(family="Noto Sans CJK TC", size=14), 
                 axis.title.y = element_text(angle = 0, vjust = 0.5),
                 legend.position = "bottom")
gg <- gg + labs(y = "人數", x = "年齡", title = "美國白人好厭世？\n槍殺案死亡種族年齡分布圖")
print(gg)