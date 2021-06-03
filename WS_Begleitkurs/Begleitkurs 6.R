
load("/Users/chrigro/School/FFHS/documentation-ffhs-bsc-informatik/WS/WS_Begleitkurs/datenSehhilfe.RData")

t.test(
  daten$groesse,
  conf.level=.95
)

load("/Users/chrigro/School/FFHS/documentation-ffhs-bsc-informatik/WS/WS_Begleitkurs/datenGewicht.RData")


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



brilleTab <- table(daten$brilleInd) # Tabelle erzeugen (wird von R nicht angezeigt)
prop.test(
  brilleTab,
  conf.level=0.95
)
remove(brilleTab) # aufräumen


