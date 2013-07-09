library(ggplot2)
library(reshape2)

tax <- read.csv("Taxonomy.csv", header=T)

tax$phylum <- as.character(tax$phylum)
tax$phylum[tax$phylum == ""] <- "unidentified"
tax$class[tax$class == "Incertae_sedis"] <- "unidentified"
phy <- table(tax$phylum, tax$sample)
names <- rownames(phy)
len <- length(names)
col <- sample(rainbow(100), len, replace=F)
pdf("Phylum_BarPlot.pdf", height=8, width=11)
par(las=3)
barplot(phy, col=col)
legend("topright", legend=names, fill=col)
dev.off()

df2 <- data.frame(phy)
index <- df2$Var1 == "unidentified"
df2$Freq[index] <- 0
df2 <- df2[order(df2$Freq, decreasing=T),]
df4 <- df2[!duplicated(df2$Var2),]
df4 <- df4[order(df4$Var2, decreasing=T),]
df4 <- subset(df4, df4$Freq != 0)
df4.m <- melt(df4, measure.vars = "Var2")
pdf("MostAbundentPhyla.pdf", height=8, width=17)
ggplot(df4.m, aes(x = df4$Var2, y= df4$Var1, label=df4$Var2)) + geom_point(aes(size=df4$Freq, color = df4$Var2)) + scale_size(range = c(5,13)) + theme_bw() + xlab("Sample") + ylab("Most Abundent Identified Phyla") + theme(legend.position="none")+ theme(axis.text.y = element_text(size="11"), axis.text.x = element_text(size="14", angle=45, hjust=1))
dev.off()

tax$class <- as.character(tax$class)
tax$class[tax$class == ""] <- "unidentified"
tax$class[tax$class == "Incertae_sedis"] <- "unidentified"
class <- table(tax$class, tax$sample)
names <- rownames(class)
len <- length(names)
col <- sample(rainbow(100), len, replace=F)
pdf("Class_BarPlot.pdf", height=8, width=11)
par(las=3)
barplot(class, col=col)
legend("topright", legend=names, fill=col)
dev.off()

df2 <- data.frame(class)
index <- df2$Var1 == "unidentified"
df2$Freq[index] <- 0
df2 <- df2[order(df2$Freq, decreasing=T),]
df4 <- df2[!duplicated(df2$Var2),]
df4 <- df4[order(df4$Var2, decreasing=T),]
df4 <- subset(df4, df4$Freq != 0)
df4.m <- melt(df4, measure.vars = "Var2")
pdf("MostAbundentClasses.pdf", height=8, width=17)
ggplot(df4.m, aes(x = df4$Var2, y= df4$Var1, label=df4$Var2)) + geom_point(aes(size=df4$Freq, color = df4$Var2)) + scale_size(range = c(5,13)) + theme_bw() + xlab("Sample") + ylab("Most Abundent Identified Classes") + theme(legend.position="none") + theme(axis.text.y = element_text(size="11"), axis.text.x = element_text(size="14", angle=45, hjust=1))
dev.off() 

tax$order <- as.character(tax$order)
tax$order[tax$order == ""] <- "unidentified"
tax$order[tax$order == "Incertae_sedis"] <- "unidentified"
order <- table(tax$order, tax$sample)
names <- rownames(order)
len <- length(names)
col <- sample(rainbow(100), len, replace=F)
pdf("Order_BarPlot.pdf", height=8, width=11)
par(las=3)
barplot(order, col=col)
legend("topright", legend=names, fill=col, ncol=2)
dev.off()

df2 <- data.frame(order)
index <- df2$Var1 == "unidentified"
df2$Freq[index] <- 0
df2 <- df2[order(df2$Freq, decreasing=T),]
df4 <- df2[!duplicated(df2$Var2),]
df4 <- df4[order(df4$Var2, decreasing=T),]
df4 <- subset(df4, df4$Freq != 0)
df4.m <- melt(df4, measure.vars = "Var2")
pdf("MostAbundentOrders.pdf", height=8, width=17)
ggplot(df4.m, aes(x = df4$Var2, y= df4$Var1, label=df4$Var2)) + geom_point(aes(size=df4$Freq, color = df4$Var2)) + scale_size(range = c(5,13)) + theme_bw() + xlab("Sample") + ylab("Most Abundent Identified Orders") + theme(legend.position="none") + theme(axis.text.y = element_text(size="11"), axis.text.x = element_text(size="14", angle=45, hjust=1)) 
dev.off()

tax$family <- as.character(tax$family)
tax$family[tax$family == ""] <- "unidentified"
tax$family[tax$family == "Incertae_sedis"] <- "unidentified"
family <- table(tax$family, tax$sample)
names <- rownames(family)
len <- length(names)
col <- sample(rainbow(100), len, replace=F)
pdf("Family_BarPlot.pdf", height=8, width=11)
par(las=3)
barplot(family, col=col)
legend("topright", legend=names, fill=col, ncol=3, cex=0.80)
dev.off()

df2 <- data.frame(family)
index <- df2$Var1 == "unidentified"
df2$Freq[index] <- 0
df2 <- df2[order(df2$Freq, decreasing=T),]
df4 <- df2[!duplicated(df2$Var2),]
df4 <- df4[order(df4$Var2, decreasing=T),]
df4 <- subset(df4, df4$Freq != 0)
df4.m <- melt(df4, measure.vars = "Var2")
pdf("MostAbundentFamilies.pdf", height=8, width=17)
ggplot(df4.m, aes(x = df4$Var2, y= df4$Var1, label=df4$Var2)) + geom_point(aes(size=df4$Freq, color = df4$Var2)) + scale_size(range = c(5,13)) + theme_bw() + xlab("Sample") + ylab("Most Abundent Identified Families") + theme(legend.position="none") + theme(axis.text.y = element_text(size="11"), axis.text.x = element_text(size="14", angle=45, hjust=1)) 
dev.off()

tax$genus <- as.character(tax$genus)
tax$genus[tax$genus == ""] <- "unidentified"
tax$genus[tax$genus == "Incertae_sedis"] <- "unidentified"
genus <- table(tax$genus, tax$sample)
names <- rownames(genus)
len <- length(names)
col <- sample(rainbow(200), len, replace=F)
pdf("Genus_BarPlot.pdf", height=8, width=11)
par(las=3)
barplot(genus, col=col)
legend("topright", legend=names, fill=col, ncol=4, cex=0.60)
dev.off()

df2 <- data.frame(genus)
index <- df2$Var1 == "unidentified"
df2$Freq[index] <- 0
df2 <- df2[order(df2$Freq, decreasing=T),]
df4 <- df2[!duplicated(df2$Var2),]
df4 <- df4[order(df4$Var2, decreasing=T),]
df4 <- subset(df4, df4$Freq != 0)
df4.m <- melt(df4, measure.vars = "Var2")
pdf("MostAbundentGenera.pdf", height=8, width=17)
ggplot(df4.m, aes(x = df4$Var2, y= df4$Var1, label=df4$Var2)) + geom_point(aes(size=df4$Freq, color = df4$Var2)) + scale_size(range = c(5,13)) + theme_bw() + xlab("Sample") + ylab("Most Abundent Identified Genera") + theme(legend.position="none") + theme(axis.text.y = element_text(size="11"), axis.text.x = element_text(size="14", angle=45, hjust=1)) 
dev.off()

tax$species <- as.character(tax$species)
tax$species[tax$species == ""] <- "unidentified"
tax$species[tax$species == "Incertae_sedis"] <- "unidentified"
species <- table(tax$species, tax$sample)
#names <- rownames(species)
#len <- length(names)
#col <- sample(rainbow(200), len, replace=F)
#par(las=3)
#barplot(species, col=col)
#legend("topright", legend=names, fill=col, ncol=4)

df2 <- data.frame(species)
index <- df2$Var1 == "unidentified"
df2$Freq[index] <- 0
df2 <- df2[order(df2$Freq, decreasing=T),]
df4 <- df2[!duplicated(df2$Var2),]
df4 <- df4[order(df4$Var2, decreasing=T),]
df4 <- subset(df4, df4$Freq != 0)
df4.m <- melt(df4, measure.vars = "Var2")
pdf("MostAbundentSpecies.pdf", height=8, width=17)
ggplot(df4.m, aes(x = df4$Var2, y= df4$Var1, label=df4$Var2)) + geom_point(aes(size=df4$Freq, color = df4$Var2)) + scale_size(range = c(5,13)) + theme_bw() + xlab("Sample") + ylab("Most Abundent Identified Species") + theme(legend.position="none") + theme(axis.text.y = element_text(size="11"), axis.text.x = element_text(size="14", angle=45, hjust=1)) 
dev.off()



