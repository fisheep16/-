install.packages("ggplot2")
install.packages("MASS")#内含mgcv包
library("ggplot2")
library(mgcv)#调用mgcv包拟合一个广义可加模型，用于大数据平滑曲线绘制
library(splines)#使用自然样条；运用线性模型作为平滑器
library(MASS)

dsmall<-diamonds[sample(nrow(diamonds),100),]

qplot(carat,price,data=dsmall,main="默认散点图")#默认散点图
qplot(log(carat),log(price),data=dsmall,alpha=I(1/5),main="注意点的透明度")#设置点的透明程度

qplot(carat,price,data=diamonds,geom=c("point","smooth"),method="gam",formula=y~s(x,bs="cs"),main="平滑曲线")#绘制平滑曲线

qplot(carat,price,data=dsmall,geom=c("point","smooth"),method="lm",formula=y~ns(x,5),main="自然样条lm")#自然样条
qplot(carat,price,data=dsmall,geom=c("point","smooth"),method="rlm",main="自然样条rlm")#与lm方法类似，但采用一种更稳健的拟合算法，对异常值不敏感

qplot(color,price/carat,data=dsmall,geom="jitter",alpha=I(1/5),main="扰动点图")#抖动图

qplot(carat,data=diamonds,geom="histogram",fill=color)#fill是填满
qplot(carat,data=dsmall,geom="histogram",binwidth=1,xlim=c(0,3),main="bar-binwidth")
qplot(carat,data=dsmall,geom="density",color=color)#密度曲线图，此处颜色为线 添加
qplot(color,data=diamonds,geom="bar",weight=carat)+scale_y_continuous("carat")#按重量加权的条形图

#时间序列中的线条图和路径图
qplot(date,unemploy/pop,data=economics,geom="line")
qplot(date,uempmed,data=economics,geom="line")

#将年份映射到color上
year<-function(x) as.POSIXlt(x)$year+1900

qplot(unemploy/pop,uempmed,data=economics,geom=c("point","path"),xlab="xtest",ylab="ytest")
qplot(unemploy/pop,uempmed,data=economics,geom="path",colour=year(date))

#两个绘图展示分面技巧，它们是以颜色为条件的重量的直方图。第二列的直方图绘制的是比例，这使得比较不同组的分布时
#不会受该组样本量大小的影响。第一幅直方图的y轴并不是原始数据的取值，而是将数据进行分组后的计数；
#..density..则为新语法，它目的在于将密度而不是频数映射到y轴
#log="x",log="y",log="xy"
qplot(carat,data=diamonds,facets=color ~ .,geom="histogram",binwidth=0.1,xlim=c(0,3))
qplot(carat,..density..,data=diamonds,facets=color ~.,geom="histogram",binwidth=0.1,xlim=c(0,3))
qplot(
  carat,price,data=dsmall,xlab="Price($)",ylab="Weight(carats)",
  main="Price-weight relationship",xlim=c(.2,1)
)


qplot(displ,hwy,data=mpg,facets=.~year)+geom_smooth()#分面和多图层

