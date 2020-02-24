# Make script
nano wolves.sh

# Proyect
# Bárbara Cruz Salazar

## Enter in the cluster with user and password

# Do a variable in "data" because the file is in this directory
vcftools="docker run -u 1600 --rm -v /home/cirio/bcruz/BioinfinvRepro/Unidad5/ProyectoUni5/data:/data biocontainers/vcftools:0.1.15 vcftools"

# (a) How many indiviuals and variants (SNPs) does the file have?
## Because my wd is bin, the direction to dates (wolves.vcf) is ../data/
$vcftools --vcf ../data/wolves.vcf

# (b) Calculate the frequency of each allele for all individuals within the file and save the result in a file.
## The location of the file and the output file is indicated, being bin my wd.
$vcftools --vcf ../data/wolves.vcf --freq --out ../data/freq_each_allele_by_ind

# (c) How many sites in the file do not have missing data?
## --max-missing count sites without missing data
$vcftools --vcf ../data/wolves.vcf --max-missing 1

# (d) Calculate the frequncy of each allele for all individuals but only for the sites without missing data and save the result in a file.
$vcftools --vcf ../data/wolves.vcf --freq --max-missing 1 --out ../data/freq_without_missing_data

# (e) How many sites have a minor allele frequency <0.05?
## --max-maf filter sites with allele frequency <0.05
$vcftools --vcf ../data/wolves.vcf --max-maf 0.05

# (f) Calculate the heterozygosity of each individual.
## --het is for calculate the heterozygosity
$vcftools --vcf ../data/wolves.vcf --het --out ../data/heterozygosity

# (g) Calculate the nucleotide diversity by site.
## --site-pi calculate pi
$vcftools --vcf ../data/wolves.vcf --site-pi --out ../data/nucleot_diversity

# (h) Calculate the nucleotide diversity by site only for the sites of chromosome 3.
## --ch indicate the chromosome that you want analyze
$vcftools --vcf ../data/wolves.vcf --site-pi --chr chr03 --out ../data/nucleot_diversity_3

# (i) Filter the sites that have a minor allele frequency <0.05 and create a new file called wolves_maf05.vcf.
## --recode generate a vcf or BCF file
$vcftools --vcf ../data/wolves.vcf --max-maf 0.05 --recode --out ../data/wolves_maf0.5

# (j) Convert the wolves_maf05.vcf file to plink format.
## --plink create a plink file.
$vcftools --vcf ../data/wolves_maf05.recode.vcf --plink
