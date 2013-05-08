# CS3157 Stats #

This is a simple project to create summary statistics about Jae Woo Lee's
COMSW3157 Advanced Programming class at Columbia: http://www.cs.columbia.edu/~jae/

This started as a way to familiarize myself with ruby before an internship this
summer requires me to use it. This turned into a script that parses the submitted
git patches to look at who commited which lab when, and what they changed.

The result is entirely anonymous in terms of both name and content. Each time
the script is run a new random username is generated, and the output contains
nothing from the contents at all, only the number of files and lines changed.

If you're just interested in using the data from Spring 2013 look at `commits.csv`.

For one graph to look at the data see `commits.pdf`.

## Generate commits.csv ##
The ruby script `summary.rb` generates a CSV file that logs every single commit
in the relevant mboxes. 

1. Install the ruby mbox gem into ~/.gem/ with: gem install --user-install mbox
2. Clone this repository.
3. In the `/home/w3157/submit` directory (or another identically laid out with `labn/uni.mbox`) run the ruby script with ruby1.9.1:   `ruby1.9.1 ~/tmp/5537934/summary.rb`
4. The script will create commits.csv in the current directory.

    name,lab,rawdate,datetime,files,insertions,deletions
    RSXPFNYQ,2,"Thu, 21 Feb 2013 23:13:20 -0500",2013-02-21T23:13:20-05:00,1,65,0
    RSXPFNYQ,3,"Mon, 25 Feb 2013 12:59:10 -0500",2013-02-25T12:59:10-05:00,2,23,10
    RSXPFNYQ,3,"Mon, 4 Mar 2013 20:41:34 -0500",2013-03-04T20:41:34-05:00,3,64,41

This CSV is potentially quite interesting, for example to see how close to the deadline students work, the impact of YAX, time of day/day of week, how much code change there is, etc. 


## Generate commits.pdf ##
I also wrote a small R script to plot each commit. x-axis is time. One row per student. Point size is log of total lines changed. Point color is relative change [(insertions-deletions)/(insertions+deletions)], where green is all insertions and red is all deletions. A version of the graph with a dataset synthesized by based on my commits is attached.

5. In the same directory as commits.csv run: R
6. In R: `source("graph.R")` (wherver `graph.R` is)
7. Press "y" when it asks if you want to install ggplot2 to a personal library. ggplot2 is the better R graphing library.
8. `quit()`  and press n
