myfile <- read.csv("OTU_Rank_Abundance.csv", header=T)
myfile["log.Rank"] <- NA
myfile$log.Rank <- log(myfile$Rank)
myfile["log.Proportional.Abundance"] <- NA
myfile$log.Proportional.Abundance <- log(myfile$Proportional.Abundance)
mynames <- names(table(myfile$Sample))
nSamples <- length(mynames)
xrange <- range(myfile$Rank)
yrange <- range(myfile$log.Proportional.Abundance)
pdf("Rank_Abundance.pdf", height=8, width=11)
plot(xrange, yrange, type='n', xlab="OTU Rank", ylab="Proportional Abundance (log)")
colors <- rainbow(nSamples)
linetype <- c(1:nSamples)
plotchar <- 20
count = 0
for (i in mynames){
    count = count + 1
    mySamp <- subset(myfile, Sample==i)
    mySamp <- mySamp[order(mySamp$Rank),]   
    lines(mySamp$Rank, mySamp$log.Proportional.Abundance, type="b", lwd=1.5, lty=linetype[count], col=colors[count], pch=plotchar)
}
legend("topright", legend=names, col = colors, ncol=3, pch=plotchar, bty='n')
dev.off()
