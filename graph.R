if (!require("ggplot2")) {
    r <- getOption("repos")
    r["CRAN"] <- "http://cran.cnr.Berkeley.edu"
    options(repos =r)
    install.packages("ggplot2")
    require("ggplot2")
}
commits <- read.csv("commits.csv")
commits$d <- strptime(commits$rawdate, "%a, %d %b %Y %H:%M:%S %z")

# # For Debugging Purposes
# orig <- commits
# for (i in 1:139) {
#    t <- orig
#    t$d <- t$d + rnorm(length(t$d), -500, 50000)
#    t$name <- paste(sample(LETTERS, 8), collapse="")
#    commits <- rbind(commits, t)
# }

duedates <- data.frame(names=c("Lab 1", "Lab 2", "Lab 3", "Lab 4", "Lab 5", "Lab 6", "Lab 7", "Lab 9", "Lab 10"),
                       dates=strptime(c("2013-02-10 11:59 pm -0400", "2013-02-24 11:59 pm -0400", "2013-03-04 11:59 pm -0400", "2013-03-16 11:59 pm -0500", "2013-03-26 12:00 pm -0500", "2013-04-11 11:59 pm -0500", "2013-04-24 11:59 pm -0500", "2013-04-29 11:59 pm -0500", "2013-05-08 12:00 pm -0500")
                                      , "%Y-%m-%d %I:%M %p %z"))

ggplot(data=commits, aes(x=d, y=name)) + 
    geom_point(alpha=I(1/2), aes(size=log(insertions+deletions), 
                              colour=(insertions-deletions)/(insertions+deletions))) +
    geom_text(data=duedates,aes(x=dates,y=-1,label=names),inherit_aes=FALSE,
              vjust=0,hjust=-0,size=3,angle=45, alpha=.9)+
    scale_color_gradient2(limits=c(-1, 1), low="#DE2D26", high="#31A354", mid="#FEE6CE", midpoint=0) +
    guides(size=guide_legend("total lines changed"),
           colour=guide_colorbar("Relative Net Change"),
           direction="horizontal") +
    ggtitle("COMS3157 Commits") +
    ylab("Each row is one student") +
    xlab("Date") +
    theme(legend.position="none", legend.direction="horizontal",
          axis.text.y=element_blank(),
          axis.ticks.y=element_blank(),
          axis.line.y=element_blank(),
          panel.grid.major.y=element_blank(),
          panel.grid.minor.y=element_blank())
ggsave("commits.pdf", width=11, height=8.5)