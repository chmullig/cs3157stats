if (!require("ggplot2")) {
    r <- getOption("repos")
    r["CRAN"] <- "http://cran.cnr.Berkeley.edu"
    options(repos =r)
    install.packages(c("ggplot2", "plyr"))
    require("ggplot2")
}
require("plyr")

commits <- read.csv("commits.csv")
commits$d <- strptime(commits$rawdate, "%a, %d %b %Y %H:%M:%S %z")

events <- read.csv("events.csv")
events$dates <- strptime(events$date, "%m/%d/%y %H:%M")

ggplot(data=commits, aes(x=d, y=name)) + 
    geom_point(alpha=I(1/2), aes(size=log(insertions+deletions), 
                              colour=(insertions-deletions)/(insertions+deletions))) +
    geom_text(data=events,aes(x=dates,y=-1,label=names),inherit_aes=FALSE,
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
ggsave("commits.png", width=11, height=8.5)

print("=== Statistics ===")
print(paste("Total Commits:", nrow(commits)))
print("Commits Per Lab:")
print(ddply(commits, 'lab', function(x) c(count=nrow(x))))
