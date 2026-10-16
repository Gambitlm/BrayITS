# Candidate ITS reference v0.2

This folder is a **candidate sequence catalog**, not a validated species classifier.

| File | Meaning |
|---|---|
| `assembly_inventory.tsv` | 936 main-screen genome accessions and original NCBI name tokens. The names have not all been confirmed. |
| `supplemental_assemblies.tsv` | Seven QC-review assemblies supporting the added *B. barranii* hard-negative ITS; these are outside the 936 main-screen accessions. |
| `its_inserts.fasta` | 306 distinct main-screen ITS inserts plus one supplemental insert, after removing primer sites. `DNH` identifies a sequence, not a species or strain. |
| `haplotype_sources.tsv` | Sequence-to-source-assembly links. One sequence may occur in multiple genomes. |
| `haplotype_labels.tsv` | Provisional evidence tier for each sequence. `UNRESOLVED` indicates insufficient species evidence. |
| `cross_name_ani_review.tsv` | ANI review of genomes whose original names differ within the same ITS haplotype. Original-name disagreement alone does not settle the species label. |
| `unrecovered_assemblies.tsv` | 104 main-screen assemblies without an exact-primer insert; 86 have a candidate homologous region and 18 have no long-seed hit in this review. The cause of non-extraction is not established by this table. |

The main-screen assemblies were selected after a reported-quality metadata screen. Candidate inserts were extracted from the assay region, and identical inserts were combined. Genome-level comparisons informed review of the original species names; they were not used to assign whole-genome ANI values to ASVs. Near-primer computational matches are not experimental amplification results.
