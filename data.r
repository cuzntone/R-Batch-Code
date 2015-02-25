i = as.numeric(Sys.getenv("PBS_ARRAYID"))
###read seed data
dataseed = read.table("/home/tongx/seed.txt", sep="\t")
seed=dataseed[i,]
cat("Starting run i = ",i, seed,"\n")
set.seed(seed)
###simulate data for mixed models
p=tau=0.2
M <- 100
n <- 10
test <- data.frame(x1 = rnorm(n*M,5,0.5),x2=rbinom(n*M,1, 0.5), group = rep(1:M,each=n))
error=rchisq(n*M, 3)
Q_tau=quantile(error, probs=tau)[1]
B_0 = rnorm(n*M, 0, 0.2)
yn = rbinom(n*M, 1, 11/18)
B_1 = rnorm(n*M, mean=ifelse(yn, -0.4, 0.55), sd=ifelse(yn, sqrt(0.02), sqrt(0.03)))
B_2 = rep(0, n*M)
test$y <- 1+(2)*test$x1 +3*test$x2+(1)*error +B_0+B_1*test$x1+B_2*test$x2
#fit.lqmm <- lqmm(fixed = y ~ x1+x2, random = ~ 1+x1+x2, group = group,data = test, tau = tau, nK = 11, type = "normal")
#out=summary(fit.lqmm)$tTable[,1:4]
#true=c(quantile(error, probs=tau)+1,quantile(error, probs=tau)+2, 3)
#print (cbind(out,true))
write.table(test, paste("~/hello_world/output/data_",i,".txt", sep=''), sep="\t")
# do something useful and store R workspace
#outputName=paste("task-",i,".RData",sep="")
#outputPath=file.path("/home/tongx/output/",outputName)
#save("results",file=outputPath)
