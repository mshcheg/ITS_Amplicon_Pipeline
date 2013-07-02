#Plot Read Number by Sample
temp <- read.csv('Read_OTU_Counts.csv', header=T)
temp <- temp[with(temp, order(Sample)),]
pdf('ReadNumber.pdf', height=8, width=11)
par(las=3)
plot(temp$Reads, pch=20, xaxt='n', xlab='Sample', ylab='ITS Reads')
axis(1,at=c(1:47), label=temp$Sample)
dev.off()

#Plot OTU by Sample
pdf('OTUs.pdf', height=8, width=11)
par(las=3)
plot(temp$OTUs, pch=20, xaxt='n', xlab='Sample', ylab='ITS OTUs')
axis(1,at=c(1:47), label=temp$Sample)
dev.off()

#Plot Reads by OTUs
pdf('ReadNumber_OTUs.pdf')
plot(temp$Reads, temp$OTUs, pch=20, xlab="ITS Reads", ylab="ITS OTUs")
dev.off()
