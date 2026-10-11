# Candidate ITS reference v0.2

This folder is a **candidate sequence catalog**, not a validated species classifier.

| File | Meaning |
|---|---|
| `assembly_inventory.tsv` | 936 selected genome accessions and original NCBI name tokens. The names have not all been confirmed. |
| `its_inserts.fasta` | 307 distinct ITS inserts after removing primer sites. `DNH` identifies a sequence, not a species or strain. |
| `haplotype_sources.tsv` | Sequence-to-source-assembly links. One sequence may occur in multiple genomes. |
| `haplotype_labels.tsv` | Provisional evidence tier for each sequence. `UNRESOLVED` indicates insufficient species evidence. |

The source assemblies were selected after a reported-quality metadata screen. Candidate inserts were extracted from the assay region, and identical inserts were combined. Genome-level comparisons informed review of the original species names; they were not used to assign whole-genome ANI values to ASVs. Near-primer computational matches are not experimental amplification results.
