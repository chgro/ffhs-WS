
with(WS_KT_PVA2, Hist(Price, scale="frequency", breaks="Sturges", 
  col="red"))

WS_KT_PVA2_ordered <- WS_KT_PVA2[order(WS_KT_PVA2$Year, WS_KT_PVA2$Month, WS_KT_PVA2$Volume), ]

xVect <- 1:72

plot(
        xVect,
        WS_KT_PVA2_ordered$Volume,
        type="l",
        xlab="Month/Year",
        ylab="Volume",
        main="Aktienpreise"
      )

