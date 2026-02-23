#extract_dna_sequences_from_bedfile(300 bp upstream,300 bp downstream,Total ~600 bp sequence)
cd /home /g89x126 /sc_wgs /snpeff /



python - <<EOF
import pandas as pd
df = pd.read_excel("snp.xlsx")
df.to_csv("snp.csv", index=False)
EOF

awk -F',' 'NR>1 {
    chrnum=$2
    if(length(chrnum)==1) chrnum="0"chrnum
    chrom="M6_v4.1_chr"chrnum
    start=$3-301
    end=$3+300
    if(start < 0) start=0
    print chrom"\t"start"\t"end"\t"$1
}' snp.csv > snp_300bp.bed

head snp_300bp.bed

bedtools getfasta \
    -fi /home/g89x126/sc_wgs/snpeff/data/solanum_chacoense_m6/sequences.fa \
    -bed snp_300bp.bed \
    -fo snp_300bp_regions.fa \
    -name
    
grep "^>" snp_300bp_regions.fa
grep -c "^>" snp_300bp_regions.fa
