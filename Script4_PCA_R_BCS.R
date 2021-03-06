# Script PCA with R
# Bárbara Cruz Salazar

## Install Bioconductor
if (!requireNamespace("BiocManager", quietly = TRUE))
  install.packages("BiocManager")
BiocManager::install(version = "3.10")
BiocManager::install(c("gdsfmt","SNPRelate"))

## Call libreries
library(SNPRelate)
library(ape)
library(ggplot2)

## Download plink to my computer
# I did not know how to download the data from the repository to the computer, so I did the exercise with the corn data that was already available


## Convert .bed, .fam, .bim
### It is converted with plink, from .ped file; to have the .ped file you must convert the .vcf file to .ped with vcftools

## Change session
## Load dates in gds format from plink 
snpgdsBED2GDS("../data/maicesArtegaetal2015.bed", 
              "../data/maicesArtegaetal2015.fam", 
              "../data/maicesArtegaetal2015.bim", 
              out.gdsfn="../data/maices.gds", # here indicate name of gds file
              option = snpgdsOption(Z=10)) # 10 cromosomas, this information is know

# See summary 
snpgdsSummary("../data/maices.gds")

# Load gds file created from .bed, .fam and .bim files
gdsfile <- snpgdsOpen("../data/maices.gds")

# Check snp.ids
head(read.gdsn(index.gdsn(gdsfile, "snp.id")))

# Check sample.ids
head(read.gdsn(index.gdsn(gdsfile, "sample.id")))

# Create an object to names the samples of gdsn
sample.id <- read.gdsn(index.gdsn(gdsfile, "sample.id"))
sample.id

# Metadates
# load
metadata<- read.delim(file= "../meta/maizteocintle_SNP50k_meta_extended.txt")

# check
head(metadata)
nrow(metadata)
head(metadata$NSiembra) # ID number of the samples 
head(sample.id)


## Do PCA
pca <- snpgdsPCA(gdsfile, num.thread=2)

# Calculate the variation percentaje for first components  
pc.percent <- pca$varprop*100 # multiply by 100 to see the value in percentage
head(round(pc.percent, 2)) # see the values with two digits 

# To round the values, use round function
x<-round(pc.percent, 2) # 2 digits

# See sum of comonents
sum(x[1:4])
sum(x[1:10])
sum(x[1:30])

# For do a plot I have to do a data frame
table_pca <- data.frame(sample.id = pca$sample.id, # sample.id of PCA in a column
                  EV1 = pca$eigenvect[,1],    # the first eigenvector
                  EV2 = pca$eigenvect[,2],    # the second eigenvector
                  stringsAsFactors = FALSE)
head(table_pca)

# Do a plot
ggplot(data = table_pca, aes(x=EV2, y=EV1)) + geom_point() + # plot will be of points
  ylab(paste0("Eigenvector 1 explain ", round(pc.percent, 1)[1], "%")) + # round will put the rounding you did up
  xlab(paste0("Eigenvector 2 explain ", round(pc.percent, 1)[2], "%")) # 1 indicate one digit; the number in brackets is the component
### paste0 paste

# Load metadates for PCA
group <- as.vector(metadata$DivFloristic) # Do a vector with the information of geographic zone to group the genetic data with that factor

# Do the data frame again including the factor (DivFloristic)
table_pca_group <- data.frame(sample.id = pca$sample.id,
                  pop = factor(group)[match(pca$sample.id, sample.id)], # pop will be the factor (group), 
                                                                        # match function makes it fit the data frame considering the new column included, 
                                                                        # and that the data is not messy. 
                  EV1 = pca$eigenvect[,1],    # the first eigenvector
                  EV2 = pca$eigenvect[,2],    # the second eigenvector
                  stringsAsFactors = FALSE)

# Do plot of PCA

ggplot(data = table_pca_group, aes(x=EV2, y=EV1, colour = pop)) + geom_point() + #Indicate that color according to the group that was created (group=DivFloristic)
  ylab(paste0("Eigenvector 1 explain ", round(pc.percent, 1)[1], "%")) +
  xlab(paste0("Eigenvector 2 explain ", round(pc.percent, 1)[2], "%"))


# Do an others plots 
boxplot(EV1 ~ pop, data=table_pca_group)

# Do an other object
race_by_state <- as.vector(metadata$Raza)

# Do an other data frame that include the race
table_two <- data.frame(sample.id=pca$sample.id, pop = factor(group)[match(pca$sample.id, sample.id)], group=factor(race_by_state)[match(pca$sample.id, sample.id)],
                        EV1 = pca$eigenvect[,1])


ggplot (data =table_two, aes(x=EV1, y=group,colour=pop)) + geom_line() +
  labs (x= "Eigenvector 1", y = "Race")

ggplot (data = metadata, aes(x=Raza, y=Altitud, col=DivFloristic)) + geom_line() +
  labs (x="Raza", y="Estado")









