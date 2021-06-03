# Vorbereitung PVA 2

load("~/WebstormProjects/documentation-ffhs-bsc-informatik/WS/WS_Begleitkurs/datenGewicht2.RData")

# 4.2 Univariate Diagramme

## 1.Formatieren und Exportieren von Diagrammen

par.default <- par(no.readonly=TRUE)

par(
  mar=c(4.5,4.5,1,1),
  las=1,
  cex.axis=1,
  cex.lab=1.5
)

par(par.default)


## Darstellung von diskreten Variablen

barplot(
  table(daten$haarfarbe),
  xlab="Haarfarbe",
  ylab="Absolute Häufigkeit"
)

barplot(
  prop.table(table(daten$haarfarbe)),
  xlab="Haarfarbe",
  ylab="Relative Häufigkeit"
)

## 3.Darstellung von stetigen Variablen

hist(
  daten$groesse
)

hist(
  daten$groesse,
  breaks=c(150, 160, 165, 170, 175, 180, 190),
  freq=FALSE,
  xlab="Grösse [cm]",
  ylab="Dichte",
  main=""
)

plot(
  ecdf(daten$bmi),
  pch=NA,
  main="",
  xlab="BMI [kg/m^2]",
  ylab="F"
)

plot(
  ecdf(daten$bmi),
  pch=20,
  main="",
  xlab="BMI [kg/m^2]",
  ylab="F"
)

### Boxplot

par(mar=c(1, 4.5, 1, 1))
boxplot(
  daten$bmi,
  ylab="BMI [kg/m^2]"
)

# 4.3 Bivariate Diagramme

## 1. Globale Grafikparameter setzen

par.default <- par(no.readonly=TRUE) 

par(
  mar=c(4.5,4.5,1,1),
  las=1,
  cex.axis=1,
  cex.lab=1.5
)

par(par.default)

## 2. Diskrete Variable versus diskrete Variable

barplot(
    table(
      daten$haarfarbe,
      daten$geschlecht
    ),
    beside=TRUE,
    legend.text=TRUE,
    xlab="Geschlecht",
    ylab="Absolute Häufigkeit"
  )

barplot(
    prop.table(
      table(
        daten$haarfarbe,
        daten$geschlecht
      )
    ),
    beside=TRUE,
    legend.text=TRUE,
    xlab="Geschlecht",
    ylab="Relative Häufigkeit"
  )

## 3. Stetige Variable versus diskrete Variable

### Boxplot

boxplot(
    daten$bmi ~ daten$geschlecht,
    xlab="Geschlecht",
    ylab="BMI [kg/m^2]"
  )

## 4. Stetige Variable vesus stetige Variable

plot(
    daten$groesse,
    daten$bmi,
    xlab="Körpergrösse [cm]",
    ylab="BMI [kg/m^2]"
  )


pairs(
    daten[c("groesse",
    "gewicht",
    "bmi")],
    labels=c("Grösse [cm]",
    "Gewicht [kg]",
    "BMI [kg/m^2]")
  )


plot(
    daten$groesse,
    daten$gewicht,
    pch=c(1,19)[daten$geschlecht],
    xlab="Grösse [cm]",
    ylab="Gewicht [kg]"
  )

with(daten, Dotplot(bmi, bin=FALSE))
with(daten, Dotplot(gewicht, bin=FALSE))

indexplot(daten[,c('bmi', 'gewicht', 'groesse'), drop=FALSE], type='h', 
  id.method='y', id.n=2)


summary(daten)

with(daten, Hist(bmi, scale="frequency", breaks="Sturges", col="darkgray"))


densityPlot( ~ bmi, data=daten, bw=bw.SJ, adjust=1, kernel=dnorm, 
  method="adaptive")

library(aplpack, pos=17)
with(daten, stem.leaf(bmi, na.rm=TRUE))


scatterplot(groesse~bmi, regLine=FALSE, smooth=FALSE, boxplots=FALSE, 
  data=daten)

scatterplotMatrix(~bmi+gewicht+groesse, regLine=FALSE, smooth=FALSE, 
  diagonal=list(method="density"), data=daten)

with(daten, lineplot(groesse, bmi))

library(lattice, pos=18)
with(daten, Barplot(geschlecht, xlab="geschlecht", ylab="Frequency", 
  label.bars=TRUE))


library(colorspace, pos=19)
with(daten, piechart(geschlecht, xlab="", ylab="", main="geschlecht", 
  col=rainbow_hcl(2), scale="frequency"))

