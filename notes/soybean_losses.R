
# soybean lossess from sclerotinia stem rot
# http://extension.cropsciences.illinois.edu/fieldcrops/diseases/yield_reductions.php
#
x <- c(22572000,
       35189000,
       18704000,
       2699000,
       9655000,
       2483000,
       2918000,
       2081178,
       60008000,
       5991000,
       13305000,
       5114000,
       11608000,
       59275000,
       23651000,
       3902656,
       16115617,
       37265435)

y <- 1996:2014
y <- setNames(y, y)
y[] <- NA
y[-15] <- x

format(mean(y, na.rm = TRUE), big.mark = ",")
plot(names(y), y/1e6, type = "l",
     xlab = "Year",
     ylab = "Millions of Bushels",
     main = "Soybean Losses from Sclerotinia Stem Rot",
     sub = "http://extension.cropsciences.illinois.edu/fieldcrops/diseases/yield_reductions.php")
