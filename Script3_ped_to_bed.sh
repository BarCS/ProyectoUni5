# Bárbara Cruz Salazar
# Script for converted the files to R

## For do PCA is we need plink files (.fam, .bim and .bed)

## Download plink to my computer
curl http://s3.amazonaws.com/plink1-assets/plink_mac_20200219.zip --output plink

## unzip
unzip plink

## Run
./plink

## Converted .ped to .fam, .bim,.bed
./plink --file ../data/plinkformat --make-bed --chr-set 37 no-xy --out ../data/plinkformat > ../data/converted
