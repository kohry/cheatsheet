#graphics

plot에 들어가는 option들

- main
- xlab
- ylab

- grid()
- points(x,y)
- legend

with(iris,plot(iris$Petal.Length, iris$Petal.Width), pch=as.integer(Species))

# histogram

hist(sample(1:6, 10000, replace=T), breaks = 0:6)

## ggplot histogram
ggplot(mau.payment.summary, aes(x = log_month, y = total.payment,
                                fill = user.type)) + geom_bar(stat="identity") + scale_y_continuous(label = comma)

ggplot(mau.payment[mau.payment$payment > 0 & mau.payment$user.type == "install", ], 
       aes(x = payment, fill = log_month)) + geom_histogram(position = "dodge", binwidth = 20000)


## 레이더차트
fsmb