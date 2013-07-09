rare <- read.table("../alpha_collated/observed_species.txt", sep="\t", header=T, row.names=1, na.strings="n/a")
group_means_data <- ddply(rare, .(sequences.per.sample), colwise(mean, na.rm=T))
sem = function(x, na.rm=T) sqrt (var(x)/length(x))
group_error_data <- ddply(rare, .(sequences.per.sample), colwise(sem, na.rm=T))
roundUp <- function(x, round=10) ceiling(max(x+10^-9)/round + 1/round)*round
myMatrix <- as.matrix(group_means_data[,3:length(colnames(group_means_data))])
myMatrix <- myMatrix[,sort(colnames(myMatrix))]
names <- colnames(myMatrix)
myMax <- apply(group_means_data[,3:length(colnames(group_means_data))],2,max,na.rm=T)
ylim <- roundUp(max(myMax))
xlim <- roundUp(max(group_means_data$sequences.per.sample))
pdf("rarefraction.pdf", width=11, height=8)
plot(1, xlim=c(0,xlim), ylim=c(0,ylim), xlab="Sequences Sampled", ylab="Observed OTUs")
matlines(group_means_data$sequences.per.sample, myMatrix, col=colors, lty="solid")
legend("topleft", legend=names, lty="solid", col=colors, ncol=3, cex=0.85, bty="n")
dev.off()


