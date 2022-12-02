variants <- read.csv("/Users/rugaremaruzani/Library/CloudStorage/OneDrive-TheUniversityofLiverpool/GitHub/synthetic-read-duplication/final.csv")
library(UpSetR)

png(filename = "frequency_full.png", width = 15, height = 10, units = "in", res = 300)

upset(variants, nsets = 6, number.angles = 30, point.size = 2.5, line.size = 0.5, 
      mainbar.y.label = "Intersects", sets.x.label = "Total number of variants called", 
      text.scale = c(1.5, 1.5, 1.5, 1.5, 1.5, 1.5),order.by = "degree", nintersects = 60, 
      set_size.show = FALSE, set_size.numbers_size = 8, set_size.scale_max = 34000,
      show.numbers = "no")
dev.off()

?upset
