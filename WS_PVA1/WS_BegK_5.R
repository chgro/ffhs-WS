xVect <- 0:10 # Vektor der Zahlen (0, 1, 2, ..., 10)
  fVect <- dbinom(xVect, size=10, prob=0.2) # f(x) für x aus {0, 1, ..., 10}
  barplot(
    fVect,
    names.arg=xVect, # Skalierung der x-Achse mit den Werten 0, 1, ..., 10
    xlab="x", # Beschriftung der Abszisse ("x-Achse")
    ylab="f(x)", # Beschriftung der Ordinate ("y-Achse")
    main="" # kein Titel
  )


xVect <- 0:10 # Vektor der Zahlen (0, 1, 2, ..., 10)
  FVect <- pbinom(xVect, size=10, prob=0.2) # F(x) für x aus {0, 1, ..., 10}
  plot(
    xVect,
    FVect,
    type="s", # Treppendiagramm erstellen
    xlab="x",
    ylab="F(x)",
    main=""
  )


xVect <- seq(from=142, to=188, by=0.1) # Vektor (142.0, 142.1, ..., 188.0)
  fVect <- dnorm(xVect, mean=165, sd=7) # f(x) für x aus {142.0, 142.1, ..., 188.0}
  plot(
    xVect,
    fVect,
    type="l", # Liniendiagramm erstellen
    xlab="x",
    ylab="f(x)",
    main=""
  )


xVect <- seq(from=142, to=188, by=0.1) # Vektor (142.0, 142.1, ..., 188.0)
  FVect <- pnorm(xVect, mean=165, sd=7) # F(x) für x aus {142.0, 142.1, ..., 188.0}
  plot(
    xVect,
    FVect,
    type="l", # Liniendiagramm erstellen
    xlab="x",
    ylab="F(x)",
    main=""
  )


