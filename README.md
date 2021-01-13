# Introduction
Incremental and adaptive Agile processes have reshaped the software development world over the last two+ decades. Processes that are Agile in nature are just beginning to impact modern mainstream actuarial practice, which is in various stages of the journey to modernize with the use of modern tools and processes. These modern tools and processes are more effectively tailored for certain modeling, analytics, and communication tasks that have traditionally fallen within the actuarial space.

Actuaries are trained to be subject matter experts in statistics and finance, but [our profession also emphasizes the importance of the actuary as an excellent communicator](https://github.com/bentwheel/asop-viz). The evolving common standards of communication excellence for the modern actuary emphasize effective communicating within not only those domain areas considered to be the traditional actuarial subject areas of statistics and finance, but in the far more nebulous and novel area of *process* definition as well. Data visualization can profoundly impact and inform the modern actuary's efforts to assess process deficiencies, and can also tell the increasingly complicated stories within the finance and statistics domains the actuarial practice has always sought to tell, but with elegance, expedience, and ease. 

A key part of the software dev space's Agile journey into modernization is communication about *process*, fostered in no small part by [git](https://git-scm.com/). Git allows for teams and collaborators to seamlessly share code and democratically organize their incremental development efforts. 

It won't be long until git fluency will be a part of the commmon toolkit required by many actuarial analysts. If you are a project management actuary, git might be the silver bullet you're looking for! If you're a data science actuary, I doubt you've made it far along without some use of git in your day-to-day work. And to all other actuaries: some of your favorite packages and libraries that you use routinely in Python and R, such as [ggplot2](https://github.com/tidyverse/ggplot2) and [pandas](https://github.com/pandas-dev/pandas), are openly developed by rich and vibrant collaboration communities on git hosting platforms such as [Github](https://github.com/) and [Gitlab](https://about.gitlab.com/). You could easily contribute to the improvement of your favorite analytics and modeling tools by extending their functionalities or reporting bugs you've encountered! As actuarial modernization brings our practice closer to the cloud, publicly and privately hosted git platforms stand as the well-defined basis of CI/CD pipelines that enable the rapid deployment of revolutionary features that are modernizing the insurance space.

Git is a natural complement to data visualization code written and maintained by actuaries. If you are an actuary, I recommend that you get on board with git.

# About this repository
This Git repository contains resources written in SAS and R to retrieve, uncompress, and load the datasets provided by the [SOA Data Visualization Contest](https://www.soa.org/research/opportunities/2020-data-visualization-contest/). This code is shared freely, provided I have correctly evaluated the contest rules as *not explicitly* restricting potential contestants from sharing code publicly. 

Furthermore, this code is completely free to use and I expect nothing in return should you use it as part of your submission to the contest, you should cite this repository appropriately.

# How do I use this repository?

To use this repository, you will need to clone this repository using a [git](https://git-scm.com/) utility of your choice.

If you are completely new to cloning a repository in git and are using Windows or macOS, I recommend you use Github Desktop:
- [Get Github Desktop](https://desktop.github.com/)
- [How to clone a repository in Github Desktop](https://docs.github.com/en/free-pro-team@latest/desktop/contributing-and-collaborating-using-github-desktop/cloning-a-repository-from-github-to-github-desktop)

When you clone a repository using Github Desktop, you can work directly with the cloned repository files in your local filesystem from within a development environment of your choice.

If you have some experience with using git, then I'm happy to share that both SAS and R feature git integration in their respective most popular development environments!
**R**
- [How to clone a git repository in RStudio](https://resources.github.com/whitepapers/github-and-rstudio/)

**SAS**
- [SAS Studio git integration](https://go.documentation.sas.com/?cdcId=webeditorcdc&cdcVersion=3.8&docsetId=webeditorug&docsetTarget=p04gbo1x6ajfjyn1jcm1wm33yaad.htm&locale=en)

# How do I access free programming environments to use these datasets?
**R**
- [RStudio](https://rstudio.com/products/rstudio/)
- [RStudio Cloud](https://rstudio.cloud/) - skip installing RStudio and run an RStudio session on the cloud

**SAS**
- [SAS University Edition](https://www.sas.com/en_us/software/university-edition.html) - free SAS Studio environment that runs on your computer
- [SAS OnDemand for Academics](https://www.sas.com/en_us/software/on-demand-for-academics.html) - free SAS software in the cloud

# How do I learn data visualization in R and SAS?
**R**
- [Data Visualization](https://socviz.co/) is a fantastic resource by Duke sociologist Kieran Healy. This book and code examples are available entirely online, but you should throw the author some bones if and buy the hardcopy if you find it useful.
- [Shiny](https://shiny.rstudio.com/tutorial/) - from the team that brought you RStudio comes Shiny, a reactive data visualization engine

**SAS**
- [Visualizing Data with SAS](https://support.sas.com/content/dam/SAS/support/en/books/free-books/vds.pdf) - one of [many free eBooks offered by SAS](https://support.sas.com/en/books/free-books.html).
- [Drag-and-drop data visualization with SAS Viya](https://www.sas.com/en_us/trials.html) - SAS Viya enables cloud-native, drag-and-drop, no-code data visualization and analytics capabilities

# Why did you write this in both SAS and R but not Python?
Python is great, and I love Python! In fact, JupyterHub with Python is included alongside [SAS University Edition](https://www.sas.com/en_us/software/university-edition.html). However, I am most comfortable with programming in the [tidyverse](https://www.tidyverse.org/) with R (which includes the legendary `ggplot`) and in SAS with [PROC SGPLOT](https://go.documentation.sas.com/?cdcId=pgmsascdc&cdcVersion=9.4_3.5&docsetId=grstatproc&docsetTarget=n0yjdd910dh59zn1toodgupaj4v9.htm&locale=en). Both `ggplot` and `PROC SGPLOT` utilize a consistent grammar of graphics for layers/geoms, mapping aesthetics to data, and other bells and whistles, and both are very easy to pick up!

- [ggplot cheat sheet](https://rstudio.com/wp-content/uploads/2015/03/ggplot2-cheatsheet.pdf)
- [PROC SGPLOT tipsheet](https://support.sas.com/rnd/datavisualization/papers/tipsheets/SGF2018_SGPlot_TipSheet_Teal_QR.pdf)

No matter what language you use out of Python/R/SAS, they can each invoke and run code written in another through the use of the [reticulate](https://rstudio.github.io/reticulate/) package for R, the [rpy2](https://pypi.org/project/rpy2/) library for Python, and [SAS Viya](https://www.sas.com/en_us/software/viya.html), just to name a few approaches. 

All have mature visualization features for both static and reactive visualizations, and all are cloud native and have git-integrated development environments. So you should definitely write in the code you feel most comfortable in!

# Good luck!
Don't forget, the SOA Data Visualization Contest deadline is FRIDAY, January 15, 2021!

-Seth
