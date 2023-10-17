library(pheatmap)
library(gplots)
library(ggplot2)
library(DESeq2)
library(edgeR)
library("RColorBrewer")
library(knitr)
library(kableExtra)
library(reshape)
library("DRIMSeq")
library("GenomicFeatures")
library(factoextra)
library(svglite)
library("ggpubr")
library(goseq)
supportedOrganisms()

setwd("/Users/haertyw/Documents/projects/droso/")

rawCountTable <- read.table("reads_counts_expression_matrix_abdomen_noV.txt", header=TRUE, sep="\t", row.names=1)
sampleInfo <- read.table("annotations_full_set_abdomen_short.txt", header=TRUE)
attach(sampleInfo)
head(sampleInfo)
dim(sampleInfo)
dim(rawCountTable)
dgeFull <- DGEList(rawCountTable, group=sampleInfo$NAME)
dim(dgeFull$counts)

dgeFull <- DGEList(dgeFull$counts[apply(dgeFull$counts, 1, sum) != 0, ],
                   group=dgeFull$samples$group)
dim(dgeFull)
head(dgeFull$counts[,0])
write.table(dgeFull$counts[,0], file="Expressed_genes_abdomen.txt", sep="\t", quote=F, row.names = TRUE, col.names = TRUE)

design <- model.matrix(~Evolutionary_regime + Experimental_food + Mating_status + 
                         Evolutionary_regime:Experimental_food , 
                       data=rawCountTable)


#design <- model.matrix(~Evolutionary_regime + Experimental_food + Mating_status + 
 #                        Evolutionary_regime:Experimental_food + Evolutionary_regime:Mating_status + 
 #                        Experimental_food:Mating_status + Evolutionary_regime:Experimental_food:Mating_status, 
 #                      data=rawCountTable)

design

dgeFull <- estimateDisp(dgeFull, design, robust=TRUE)
dgeFull$common.dispersion
plotBCV(dgeFull)
fit <- glmQLFit(dgeFull, design)
colnames(fit)

#[1] "(Intercept)"                             "Evolutionary_regimeL"                    "Experimental_foodL"                     
#[4] "Mating_statusP"                          "Evolutionary_regimeL:Experimental_foodL"

qlf <- glmQLFTest(fit, coef=2)
topTags(qlf)
plotMD(qlf)
summary(decideTests(qlf))

head (qlf$table)

q<-topTags(qlf, n=87)
row.names(q)
write.table(q, file="Evolutionary_regime_abdomen_test.txt", sep="\t", quote=F, row.names = TRUE, col.names = TRUE)

length(row.names(q))

z<-dgeFull$counts[,0]
head(z)
length(z)


write.table(qlf$table, file="Evolutionary_regime_abdomen.txt", sep="\t", quote=F, row.names = TRUE, col.names = TRUE)

#       Evolutionary_regimeL
#Down                      0
#NotSig                15306
#Up                        0

qlf <- glmQLFTest(fit, coef=3)
topTags(qlf)
plotMD(qlf)
summary(decideTests(qlf))
q<-topTags(qlf, n=8997)
write.table(q, file="Experimental_food_abdomen_test.txt", sep="\t", quote=F, row.names = TRUE, col.names = TRUE)


#       Experimental_foodL
#Down                 3632
#NotSig               8024
#Up                   3650

write.table(qlf$table, file="Experimental_food.txt", sep="\t", quote=F, row.names = TRUE, col.names = TRUE)

genes.Seq <- as.integer(p.adjust(res1$pvalue[res$log2FoldChange != 0], method = "BH") < 0.05)
names(genes.Seq) = row.names(res1[res1$log2FoldChange != 0, ])
length(genes.Seq)


qlf <- glmQLFTest(fit, coef=4)
topTags(qlf)
plotMD(qlf)
summary(decideTests(qlf))
#       Mating_statusP
#Down                0
#NotSig          15306
#Up                  0

write.table(qlf$table, file="Mating_status.txt", sep="\t", quote=F, row.names = TRUE, col.names = TRUE)


qlf <- glmQLFTest(fit, coef=5)
topTags(qlf)
plotMD(qlf)
summary(decideTests(qlf))

q<-topTags(qlf, n=1442)

#       Evolutionary_regimeL:Experimental_foodL
#Down                                         0
#NotSig                                   15306
#Up                                           0
write.table(q, file="interaction_Evolution_experiment_abdomen_test.txt", sep="\t", quote=F, row.names = TRUE, col.names = TRUE)

write.table(qlf$table, file="interaction_Evolution_experiment_abdomen.txt", sep="\t", quote=F, row.names = TRUE, col.names = TRUE)


qlf <- glmQLFTest(fit, coef=6)
topTags(qlf)
plotMD(qlf)
summary(decideTests(qlf))

qlf <- glmQLFTest(fit, coef=7)
topTags(qlf)
plotMD(qlf)
summary(decideTests(qlf))

qlf <- glmQLFTest(fit, coef=8)
topTags(qlf)
plotMD(qlf)
summary(decideTests(qlf))



dgeFull <- DGEList(rawCountTable, group=sampleInfo$NAME)
dim(dgeFull$counts)

dgeFull <- DGEList(dgeFull$counts[apply(dgeFull$counts, 1, sum) != 0, ],
                   group=dgeFull$samples$group)
dim(dgeFull)

dgeFull <- calcNormFactors(dgeFull, method="TMM")
dgeFull$samples

design <- model.matrix(~sampleInfo$CELL)
design <- model.matrix(~0+group, data=y$samples)


rownames(design) <- colnames(dgeFull)
design
dgeFull <- estimateDisp(dgeFull, design, robust=TRUE)
dgeFull$common.dispersion
plotBCV(dgeFull)

fit <- glmFit(dgeFull, design)
lrt <- glmLRT(fit)
topTags(lrt)




meta<-data.frame(row.names=colnames(rawCountTable), cell_type=factor(Experimental_food), sampe_names=factor(NAME))
dds<-DESeqDataSetFromMatrix(countData=rawCountTable,meta,formula(~cell_type))
idx <- which(rowSums(counts(dds)) > 0)
dds <- dds[idx,]
dds <- estimateSizeFactors(dds)

temp2<-counts(dds, normalized=TRUE)

write.table(temp2, file="normalized_counts_complete_set.txt", sep="\t", quote=F, row.names = TRUE, col.names = TRUE)

vsd <- vst(dds, blind=FALSE)
write.table(assay(vsd), file="vsd_counts_complete_set.txt", sep="\t", quote=F, row.names = TRUE, col.names = TRUE)

sampleDist<-dist(t(assay(vsd)))
sampleDistMatrix <- as.matrix(sampleDist)
rownames(sampleDistMatrix) <- paste(vsd$position)
colnames(sampleDistMatrix) <- NULL
colors <- colorRampPalette( rev(brewer.pal(9, "Blues")) )(255)
pheatmap(sampleDistMatrix, clustering_distance_rows=sampleDist, clustering_distance_cols=sampleDist, col=colors, treeheight_row=0, fontsize=5)

pcaResult<-prcomp(t(assay(vsd)))
summary(pcaResult)

#PC1      PC2      PC3      PC4      PC5      PC6    PC7     PC8     PC9    PC10    PC11
#Standard deviation     147.1737 27.53668 16.85122 11.83079 11.08028 10.20073 9.3469 8.61189 8.02731 7.76997 7.61703
#Proportion of Variance   0.8687  0.03041  0.01139  0.00561  0.00492  0.00417 0.0035 0.00297 0.00258 0.00242 0.00233
#Cumulative Proportion    0.8687  0.89910  0.91049  0.91610  0.92102  0.92520 0.9287 0.93168 0.93426 0.93668 0.93901

write.table(pcaResult$x, file="pca_results_complete_set_deseq2.txt", sep="\t", quote=F, col.names = TRUE, row.names = TRUE)



#head

rawCountTable <- read.table("reads_counts_expression_matrix_head_all_samples.out", header=TRUE, sep="\t", row.names=1)
sampleInfo <- read.table("annotations_full_set_head.txt", header=TRUE)
attach(sampleInfo)
head(sampleInfo)

meta<-data.frame(row.names=colnames(rawCountTable), cell_type=factor(Experimental_food), sampe_names=factor(NAME))
dds<-DESeqDataSetFromMatrix(countData=rawCountTable,meta,formula(~cell_type))
idx <- which(rowSums(counts(dds)) > 0)
dds <- dds[idx,]
dds <- estimateSizeFactors(dds)

temp2<-counts(dds, normalized=TRUE)

write.table(temp2, file="normalized_counts_complete_set_head.txt", sep="\t", quote=F, row.names = TRUE, col.names = TRUE)

vsd <- vst(dds, blind=FALSE)
write.table(assay(vsd), file="vsd_counts_complete_set_head.txt", sep="\t", quote=F, row.names = TRUE, col.names = TRUE)

sampleDist<-dist(t(assay(vsd)))
sampleDistMatrix <- as.matrix(sampleDist)
rownames(sampleDistMatrix) <- paste(vsd$position)
colnames(sampleDistMatrix) <- NULL
colors <- colorRampPalette( rev(brewer.pal(9, "Blues")) )(255)
pheatmap(sampleDistMatrix, clustering_distance_rows=sampleDist, clustering_distance_cols=sampleDist, col=colors, treeheight_row=0, fontsize=5)

pcaResult<-prcomp(t(assay(vsd)))
summary(pcaResult)

#                          PC1    PC2     PC3     PC4     PC5     PC6     PC7    PC8     PC9    PC10    PC11    PC12
#Standard deviation     16.185 8.6829 7.54135 7.07672 5.76679 5.23640 4.90441 4.6240 3.63348 3.61795 3.55198 3.35556
#Proportion of Variance  0.354 0.1019 0.07687 0.06769 0.04495 0.03706 0.03251 0.0289 0.01784 0.01769 0.01705 0.01522
#Cumulative Proportion   0.354 0.4560 0.53281 0.60050 0.64545 0.68251 0.71502 0.7439 0.76176 0.77946 0.79651 0.81173

write.table(pcaResult$x, file="pca_results_complete_set_head_deseq2.txt", sep="\t", quote=F, col.names = TRUE, row.names = TRUE)


#abdomen
rawCountTable <- read.table("reads_counts_expression_matrix_abdomen_all_samples.out", header=TRUE, sep="\t", row.names=1)
sampleInfo <- read.table("annotations_full_set_abdomen.txt", header=TRUE)
attach(sampleInfo)
head(sampleInfo)

meta<-data.frame(row.names=colnames(rawCountTable), cell_type=factor(Experimental_food), sampe_names=factor(NAME))
dds<-DESeqDataSetFromMatrix(countData=rawCountTable,meta,formula(~cell_type))
idx <- which(rowSums(counts(dds)) > 0)
dds <- dds[idx,]
dds <- estimateSizeFactors(dds)

temp2<-counts(dds, normalized=TRUE)

write.table(temp2, file="normalized_counts_complete_set_abdomen.txt", sep="\t", quote=F, row.names = TRUE, col.names = TRUE)

vsd <- vst(dds, blind=FALSE)
write.table(assay(vsd), file="vsd_counts_complete_set_abdomen.txt", sep="\t", quote=F, row.names = TRUE, col.names = TRUE)

sampleDist<-dist(t(assay(vsd)))
sampleDistMatrix <- as.matrix(sampleDist)
rownames(sampleDistMatrix) <- paste(vsd$position)
colnames(sampleDistMatrix) <- NULL
colors <- colorRampPalette( rev(brewer.pal(9, "Blues")) )(255)
pheatmap(sampleDistMatrix, clustering_distance_rows=sampleDist, clustering_distance_cols=sampleDist, col=colors, treeheight_row=0, fontsize=5)

pcaResult<-prcomp(t(assay(vsd)))
summary(pcaResult)
head(pcaResult$x)

#                           PC1     PC2     PC3     PC4     PC5     PC6     PC7     PC8     PC9    PC10   PC11
#Standard deviation     30.9186 8.91417 7.94568 6.73587 5.89851 4.58990 4.48136 4.10973 3.79477 3.52044 3.2681
#Proportion of Variance  0.6891 0.05728 0.04551 0.03271 0.02508 0.01519 0.01448 0.01218 0.01038 0.00893 0.0077
#Cumulative Proportion   0.6891 0.74639 0.79190 0.82461 0.84969 0.86487 0.87935 0.89153 0.90191 0.91084 0.9185

write.table(pcaResult$x, file="pca_results_complete_set_abdomen_deseq2.txt", sep="\t", quote=F, col.names = TRUE, row.names = TRUE)



essai1<-read.table("pca_results_complete_set_deseq2.txt", header=T)
attach(essai1)
q1<-ggplot(essai1,aes(x=PC1, y=PC2, color=Experimental_food, shape=Tissue))+theme_bw() + geom_point(size=1, aes(fill=Experimental_food)) + geom_point(size=1) + theme(legend.text=element_text(size=5), legend.title=element_text(size=5), axis.title = element_text(size=8), axis.text = element_text(size=8))+xlab("PC1 (86.87%)")+ylab("PC2 (3.41%)") 
q1

essai2<-read.table("pca_results_complete_set_abdomen_deseq2.txt", header=T)
attach(essai2)

q2<-ggplot(essai2,aes(x=PC1, y=PC2, color=Experimental_food, shape=Mating_status))+theme_bw() + geom_point(size=1, aes(fill=Experimental_food)) + geom_point(size=1) + theme(legend.text=element_text(size=5), legend.title=element_text(size=5), axis.title = element_text(size=8), axis.text = element_text(size=8))+xlab("PC1 (68.91%)")+ylab("PC2 (5.73%)")
q2

essai3<-read.table("pca_results_complete_set_head_deseq2.txt", header=T)
attach(essai3)

q3<-ggplot(essai3,aes(x=PC1, y=PC2, color=Experimental_food, shape=Mating_status))+theme_bw() + geom_point(size=1, aes(fill=Experimental_food)) + geom_point(size=1) + theme(legend.text=element_text(size=5), legend.title=element_text(size=5), axis.title = element_text(size=8), axis.text = element_text(size=8))+xlab("PC1 (35.04%)")+ylab("PC2 (10.19%)")

q3

figure <- ggarrange(q1, q2, q3, labels = c("All samples", "Abdomen", "Head/Thorax"),ncol = 2, nrow = 2)

figure
pdf("all_pcas.pdf")
figure
dev.off()

ggarrange(
  q1,                # First row with line plot
  # Second row with box and dot plots
  ggarrange(q2, q3, ncol = 2, labels = c("B", "C")), 
  nrow = 2, 
  labels = "A"       # Label of the line plot
) 

ggsave("all_pcas_complete_set.pdf", width = 16, height = 12, units = "cm")
ggsave("all_pcas_complete_set.png", width = 16, height = 10, units = "cm")


