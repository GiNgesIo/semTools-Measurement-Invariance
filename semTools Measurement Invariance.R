############## semTools Measurement Invariance ##############
## Purpose of script: The is a reproducible example of the new approach to get the deprecated semTools measurement invariance output using the Holzinger and Swineford (1939) dataset.
## Script name: semTools Measurement Invariance
## This script file is licensed under a CC-BY 4.0 license.
## See http://creativecommons.org/licenses/by/4.0/
## Notes: For privacy reasons the data has been splitted into a sample description file and a data file.

# load library
library(lavaan)

# read data
data(HolzingerSwineford1939)

# define model
your_model <- ' 
  visual =~ x1 + x2 + x3
  verbal =~ x4 + x5 + x6
  speed  =~ x7 + x8 + x9 
'

# new approach for measurement invariance
test.seq <- c("loadings","intercepts","means","residuals")

meq.list <- list()

for (i in 0:length(test.seq)) {
  if (i == 0L) {
    meq.label <- "configural"
    group.equal <- ""
  } else {
    meq.label <- test.seq[i]
    group.equal <- test.seq[1:i]
  }
  
  meq.list[[meq.label]] <- 
    semTools::measEq.syntax(
      configural.model = your_model,
      data = HolzingerSwineford1939,
      ID.fac = "auto.fix.first",
      group = "school",
      group.equal = group.equal,
      return.fit = TRUE
    )
}

semTools::compareFit(meq.list)
