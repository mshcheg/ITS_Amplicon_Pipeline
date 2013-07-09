library(gridExtra)
library(ggplot2)
library(ape)

tax <- read.csv("Taxonomy.csv", header=T)
phy <- table(tax$phylum, tax$sample)
class <- table(tax$class, tax$sample)
order <- table(tax$order, tax$sample)

bray <- read.table("../beta_diversity/bray_curtis_otu_table_mc2_w_tax.txt", sep="\t", header=T, row.names=1)
brayDists <- as.dist(bray)
PcoaBray <- pcoa(brayDists)

#plot ordination
cords <- PcoaBray$vectors[,c(1:2)]
df<-data.frame(as.character(rownames(cords)),cords)
colnames(df)[1]="Var2"
p1 <- ggplot(data=df, aes(x=Axis.1, y=Axis.2))+geom_text(aes(label=df$Var2,size=1,hjust=0,vjust=0)) + theme_bw() + theme(legend.position="none")
pdf("pcoa.pdf")
p1
dev.off()

test <- data.frame(phy)
test <- subset(test, test$Freq != 0)
new <- merge(test, df, by="Var2")
pdf("pcoa_phylum.pdf", width=19, height=8)
p2 <- ggplot(new, aes(x = new$Axis.1, y= new$Axis.2, label=new$Var1)) + geom_point(aes(size=new$Freq, color = new$Var1)) + theme_bw() + scale_size(guide=F, range = c(4,13)) + xlab("Axis.1") + ylab("Axis.2") + scale_colour_discrete(name ="Phylum")
grid.arrange(p1, p2, ncol=2)
dev.off()

test <- data.frame(class)
test <- subset(test, test$Freq != 0)
new <- merge(test, df, by="Var2")
pdf("pcoa_class.pdf", width=19, height=8)
p2 <- ggplot(new, aes(x = new$Axis.1, y= new$Axis.2, label=new$Var1)) + geom_point(aes(size=new$Freq, color = new$Var1)) + theme_bw() + scale_size(guide=F, range = c(6,15)) + xlab("Axis.1") + ylab("Axis.2") + scale_colour_discrete(name ="Phylum")
grid.arrange(p1, p2, ncol=2)
dev.off()

test <- data.frame(order)
test <- subset(test, test$Freq != 0)
new <- merge(test, df, by="Var2")
pdf("pcoa_order.pdf", width=19, height=8)
p2 <- ggplot(new, aes(x = new$Axis.1, y= new$Axis.2, label=new$Var1)) + geom_point(aes(size=new$Freq, color = new$Var1)) + theme_bw() + scale_size(guide=F, range = c(6,15)) + xlab("Axis.1") + ylab("Axis.2") + scale_colour_discrete(name ="Phylum")
grid.arrange(p1, p2, ncol=2)
dev.off()


