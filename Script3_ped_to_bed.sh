# Bárbara Cruz Salazar
# Script for converted the files to R

## For do PCA is we need plink files (.fam, .bim and .bed)

## Download plink to the computer
curl http://s3.amazonaws.com/plink1-assets/plink_mac_20200219.zip --output plink

## unzip
unzip plink

## Run
./plink

## Converted .ped to .fam, .bim,.bed
./plink --file ../data/plinkformat --make-bed --chr-set 37 no-xy --out ../data/plinkformat > ../data/converted

## Since I could not download vcftools program on my computer, I had to work in cluster
## and then download the files.
## For download the files, first change wd to data in wolves on the computer

scp -P 45789 cirio@200.12.166.164:/home/cirio/bcruz/BioinfinvRepro/Unidad5/ProyectoUni5/data/plinkformat.* ./
