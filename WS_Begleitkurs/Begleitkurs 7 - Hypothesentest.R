
load("/Users/chrigro/School/FFHS/documentation-ffhs-bsc-informatik/WS/WS_Begleitkurs/datenGewicht.RData")

### 2. Anteilstest

# Variable braunInd vorbereiten

daten$braunInd <- ifelse(
  daten$haarfarbe == "braun",
  1, 			# falls haarfarbe == "braun"
  2 			# sonst
)
daten$braunInd <- factor( # "braunInd" als Faktor definieren
  daten$braunInd,
  labels = c("braun", "nicht braun")
)
table( # Kontrolle der Variable "braunInd": Kreuztabelle mit "haarfarbe"
  daten$braunInd,
  daten$haarfarbe
)

#################

		blond braun rot schwarz
  braun           0     4    0      0
  nicht braun     2     0    1      3

#################

# Binomialtest auf braunInd durchführen
# Kann für grosse Tests lange dauern

braunTab <- table( 			# Tabelle erzeugen (wird von R nicht angezeigt)
  daten$braunInd
)
binom.test( 			# Binomialtest durchführen
  braunTab,
  p = 0.6, 			# Anteil, auf welchen getestet werden soll
  alternative = "two.sided", # zweiseitiger Test
  conf.level = 0.95 # Konfidenzniveau 1-alpha für das Konf.intervall des Anteils
)
remove(braunTab) 			# aufräumen

#################

	Exact binomial test
data:  braunTab
number of successes = 4, number of trials = 10, p-value = 0.2126
alternative hypothesis: true probability of success is not equal to 0.6
95 percent confidence interval:
 0.1215523 0.7376219
sample estimates:
probability of success 
                   0.4

#################

### 3. t-Tests

#### 3.1. Einstichproben-t-Test

# Signifikanzniveau = a = 0.1
# Nullhypothese = Mittelwert der Körpergrösse grösser als 170 cm

t.test(
  daten$groesse,
  alternative='greater', # rechtsseitiger Test
  mu=170, 			# postulierter Mittelwert mu_0 in der Gesamtheit
  conf.level=.9 			# Konfidenzniveau 1-alpha für das Konf.intervall des Mittelwerts
)

#################

data:  daten$groesse
t = 0.80656, df = 8, p-value = 0.2216
alternative hypothesis: true mean is greater than 170
90 percent confidence interval:
 168.6177      Inf
sample estimates:
mean of x 
 171.8889

#################

#### 3.2. Ungepaarter Zweistichproben-t-Test

# Signifikanzniveau a = 0.05
# Nullhypothese = die Mittelwerte in der Gesamtheit nicht voneinander unterscheiden

t.test(
  groesse~geschlecht, 		# Formeleingabe, zu interpretieren als "groesse in Abhängigkeit von geschlecht"
  alternative="two.sided", # zweiseitiger Test
  conf.level=.95, 			# Konfidenzniveau 1-alpha für das Konf.intervall der Differenz der Mittelwerte
  data=daten # damit R weiss, wo es die Variablen suchen soll
)

#################

	Welch Two Sample t-test
data:  groesse by geschlecht
t = 1.1967, df = 5.5342, p-value = 0.2801
alternative hypothesis: true difference in means is not equal to 0
95 percent confidence interval:
 -6.142043 17.442043
sample estimates:
mean in group männlich mean in group weiblich 
                174.40                 168.75

#################


#### 3.3. Gepaarter Zweistichproben-t-Test (Paardifferenzen-Test)

# Signifikanzniveau a = 0.01
# Nullhypothese = der Mittelwert der Blutdruckdifferenz in allen je dieses Medikament verwendenden Personen gleich Null ist

#################

load("/Users/chrigro/School/FFHS/documentation-ffhs-bsc-informatik/WS/WS_Begleitkurs/datenBlutdruck.RData")


t.test(
  daten$blutdruckVor,
  daten$blutdruckNach,
  alternative='two.sided', # zweiseitiger Test
  conf.level=.99, 			# Konfidenzniveau 1-alpha für das Konf.intervall der mittleren Differenz
  paired=TRUE 			# gepaarter Test
)

#################

	Paired t-test
data:  daten$blutdruckVor and daten$blutdruckNach
t = 3.0987, df = 19, p-value = 0.005912
alternative hypothesis: true difference in means is not equal to 0
99 percent confidence interval:
  0.6839139 17.1392800
sample estimates:
mean of the differences 
               8.911597


#################

### 4. Chiquadrat-Tests

load("/Users/chrigro/School/FFHS/documentation-ffhs-bsc-informatik/WS/WS_Begleitkurs/datenGewicht.RData")

#### 4.1. Chiquadrat-Anpassungstest

# Nullhypothese = die Haarfarbe in der Bevölkerung der diskreten Verteilung P("schwarz") = 0.15, P("braun") = 0.6, P("blond") = 0.2 und P("rot") = 0.05 

haarTab <- table( 			# Tabelle von "haarfarbe" erzeugen (wird von R nicht angezeigt)
  daten$haarfarbe
)
chisq.test( 			# Chiquadrat-Test durchführen
  haarTab,
  p=c(0.15,0.6,0.2,0.05)# vorgegebene Verteilung (gleiche Reihenfolge wie Werte von "haarfarbe")
)
remove(haarTab) # aufräumen

#################

	Chi-squared test for given probabilities
data:  haarTab
X-squared = 13.833, df = 3, p-value = 0.003141

#################

#### 4.2. Chiquadrat-Unabhängigkeitstest

# Nullhypothese = die Haarfarbe unter Männern und Frauen dieselbe Verteilung hat

geschlHaarTab <- table(	# Kreuztabelle "haarfarbe" vs "geschlecht" erzeugen (wird von R nicht angezeigt)
  daten$geschlecht, 			# Zeilenvariable
  daten$haarfarbe   			# Spaltenvariable
)
chisq.test( 			# Chiquadrat-Test durchführen
  geschlHaarTab
)
remove(geschlHaarTab) 		# aufräumen

#################

	Pearson's Chi-squared test
data:  geschlHaarTab
X-squared = 2.0139, df = 3, p-value = 0.5695

#################



library(abind, pos=17)
local({
  .Table <- xtabs(~haarfarbe+geschlecht, data=daten)
  cat("\nFrequency table:\n")
  print(.Table)
  .Test <- chisq.test(.Table, correct=FALSE)
  print(.Test)
})
local({
  .Table <- xtabs(~geschlecht+haarfarbe, data=daten)
  cat("\nFrequency table:\n")
  print(.Table)
  .Test <- chisq.test(.Table, correct=FALSE)
  print(.Test)
})
load("/Users/chrigro/School/FFHS/documentation-ffhs-bsc-informatik/WS/WS_Begleitkurs/datenBlutdruck.RData")

with(
	daten, (
		t.test(
			blutdruckVor,
			blutdruckNach,
			alternative='two.sided', 
			conf.level=.99, 
  			paired=TRUE
		)
	)
)

with(daten, (t.test(blutdruckVor, blutdruckNach, alternative='two.sided', conf.level=.99, 
  paired=TRUE)))
load("/Users/chrigro/School/FFHS/documentation-ffhs-bsc-informatik/WS/WS_Begleitkurs/datenGewicht.RData")
t.test(
	groesse~geschlecht, 
	alternative='two.sided', 
	conf.level=.95, 
	var.equal=FALSE, 
  	data=daten
)
load("/Users/chrigro/School/FFHS/documentation-ffhs-bsc-informatik/WS/WS_Begleitkurs/datenBlutdruck.RData")
with(daten, (t.test(blutdruckVor, blutdruckNach, alternative='two.sided', conf.level=.99, 
  paired=TRUE)))
load("/Users/chrigro/School/FFHS/documentation-ffhs-bsc-informatik/WS/WS_Begleitkurs/datenGewicht.RData")
with(daten, (t.test(groesse, alternative='less', mu=170, conf.level=.90)))
with(
	daten, (
		t.test(
			groesse, 
			alternative='greater', 
			mu=170, 
			conf.level=.90
		)
	)
)
local({
  .Table <- data.frame(Probability=dbinom(0:20, size=20, prob=0.5))
  rownames(.Table) <- 0:20 
  print(.Table)
})

t.test(
  daten$groesse,
  conf.level=.95
)

daten$brilleInd <- ifelse(
  daten$sehhilfe=="Brille",
  1, # falls BrillenträgerIn
  2 # falls nicht BrillenträgerIn
)
daten$brilleInd <- factor( # "brilleInd" als Faktor definieren
  daten$brilleInd,
  levels=1:2,
  labels=c("Brille", "keine Brille")
)
table( # Mit einer Kontingenztabelle prüfen, ob "brilleInd" korrekt codiert ist
  daten$sehhilfe,
  daten$brilleInd
)
load("/Users/chrigro/School/FFHS/documentation-ffhs-bsc-informatik/WS/WS_Begleitkurs/datenSehhilfe.RData")

brilleTab <- table(daten$brilleInd) # Tabelle erzeugen (wird von R nicht angezeigt)
prop.test(
  brilleTab,
  conf.level=0.95
)
remove(brilleTab) # aufräumen

load("/Users/chrigro/Library/Mobile Documents/com~apple~CloudDocs/01_Weiterbildung/FFHS/WS/Aufgaben/PVA4/zufallsdaten4A.RData")

local({
  .Table <- with(zufallsdaten, table(bernoullivar1))
  cat("\ncounts:\n")
  print(.Table)
  cat("\npercentages:\n")
  print(round(100*.Table/sum(.Table), 2))
})
local({
  .Table <- with(zufallsdaten, table(bernoullivar2))
  cat("\ncounts:\n")
  print(.Table)
  cat("\npercentages:\n")
  print(round(100*.Table/sum(.Table), 2))
})
t.test(id~bernoullivar1, alternative='two.sided', conf.level=.95, var.equal=FALSE, 
  data=zufallsdaten)
t.test(id~bernoullivar2, alternative='two.sided', conf.level=.95, var.equal=FALSE, 
  data=zufallsdaten)


zufallsdaten$aInd <- ifelse(
  zufallsdaten$bernoullivar2 == "A",
  1, 			# falls == "A"
  2 			# sonst
)
zufallsdaten$aInd <- factor( # "A" als Faktor definieren
  zufallsdaten$aInd,
  labels = c("A", "B")
)
table( # Kontrolle der Variable "braunInd": Kreuztabelle mit "haarfarbe"
  zufallsdaten$aInd,
  zufallsdaten$bernoullivar2
)

kreuztabelle <- xtabs(~ zufallsdaten$bernoullivar1 + zufallsdaten$bernoullivar2)
kreuztabelle

prop.table(kreuztabelle) # Gesamtheit auf 100%

prop.table(kreuztabelle, 1) # Zeilenweise auf 100%

prop.table(kreuztabelle, 2) # Spaltenweise auf 100%

N <- sum(kreuztabelle)

erwartet <- outer (rowSums(kreuztabelle), colSums(kreuztabelle)) / N
erwartet

