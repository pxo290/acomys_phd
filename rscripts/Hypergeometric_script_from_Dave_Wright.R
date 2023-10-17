# R
library(DPQ)

m<-13507 # total RBM15 binding in background list
N<-33624 # size of background list
n<-20117 # where n = N-m
k<-16586 # size of DEgenes list
x<-10166 # total RBM15 binding in DEgenes list

RBM15_pval <- phyper(q=x-1,m=m, n=n, k=k, lower.tail = FALSE)
RBM15_pval
