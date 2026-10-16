# BrayITS

BrayITS is a developing reference and classification framework for the bacterial 16S–23S rRNA ITS region amplified from soybean nodules. The assay follows [Teraishi et al.](https://doi.org/10.1002/pld3.70069). This repository shares a **candidate reference snapshot**, not a finished diagnostic classifier or GWAS phenotype.

![BrayITS workflow](brayits.png)

The figure sketches the research idea; its abundance bars are illustrative. Its Step 5 label “unresolved” is an earlier shorthand for a species-level conflict. Under the current counting rule, an exact match to a genome-backed *Bradyrhizobium* ITS with uncertain species is counted within **Others**, not discarded. The figure itself is retained as originally supplied while its wording is reviewed.

## Candidate reference

We surveyed publicly available *Bradyrhizobium* genome assemblies, screened the reported assembly-quality metadata, reviewed source names against type-material genomes, and extracted the assay's primer-bounded ITS segment. Identical primer-trimmed sequences were grouped into haplotypes. The main screen contains **936 assembly accessions** and yielded **306 unique candidate ITS sequences**. One additional *B. barranii* hard-negative ITS, supported by seven QC-review assemblies outside that main screen, brings the candidate catalog to **307 sequences**. A genome name or a similar ITS sequence alone is not treated as proof of species identity.

The [reference directory](reference/candidate_v0_2/) contains:

- `assembly_inventory.tsv` — assembly accession and its original NCBI species name;
- `its_inserts.fasta` — distinct candidate ITS sequences, identified by `DNH` IDs;
- `haplotype_sources.tsv` — which assemblies contributed each candidate sequence;
- `haplotype_labels.tsv` — provisional species-evidence status for each sequence;
- `supplemental_assemblies.tsv` — seven QC-review sources of the added hard-negative ITS;
- `unrecovered_assemblies.tsv` — 104 main-screen assemblies without an exact-primer ITS extraction and their preliminary homology-review status;
- `cross_name_ani_review.tsv` — genome ANI evidence for the four ITS haplotypes shared by assemblies with different original species names.

These records support inspection of the candidate reference. They do not certify all 307 sequences to species level. Detailed laboratory processing records and raw sequence data are outside this public release.

## Classification concept and current limit

An ASV classifier proposes *B. japonicum* (Bj), *B. elkanii* (Be), or another class. An exact match to a genome-backed *Bradyrhizobium* ITS with unresolved species evidence blocks a Bj/Be species call and is counted within **Others**. This is a **species-label check**, not a validated genus test. The classifier and the proposed Bj/Be/Others abundance denominator still need independent validation before use as a final phenotype.

The historical `djmix` analysis grouped *B. diazoefficiens* with Bj. This candidate catalog keeps the two species distinct. Results under these definitions should be compared only after the Bj phenotype is explicitly defined. The public repository is a reference snapshot and method overview; the full analysis scripts and laboratory records are not part of this release.
