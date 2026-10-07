# BrayITS

A compact template for processing *Bradyrhizobium* ITS amplicons and summarizing *B. japonicum* (Bj) and *B. elkanii* (Be) reads in soybean nodule samples.

![BrayITS workflow](brayits.png)

## Workflow

1. Trim the experiment-specific primers from paired-end FASTQ reads.
2. Denoise and merge reads into ASV sequences and an ASV-by-sample count table.
3. Use a curated, amplicon-region ITS reference to train a sequence classifier. It proposes Bj, Be, or Other for each ASV.
4. If an ASV exactly matches a reference ITS that remains unresolved, label it Unresolved instead of accepting the classifier proposal.
5. Join the final ASV calls with the count table to summarize Bj, Be, Other, and Unresolved reads per sample.

Genome quality and ANI are **upstream checks on reference labels**. The sample classifier does not calculate genome ANI for an ASV. The figure is conceptual: its “genome evidence check” refers to reference curation; the current per-ASV safeguard is the exact-match unresolved check in step 4.

A within-target fraction can be computed as `Bj / (Bj + Be)`, with NA if both counts are zero. Bj divided by **all** *Bradyrhizobium* reads needs a separately validated genus-level denominator.

## Building the ITS reference

**Published starting point.** Teraishi et al. amplified a partial *Bradyrhizobium* 16S–23S ITS region. Their forward primer was designed in a conserved tRNA-Ala segment within ITS; the reverse primer used the ITS-R site near the 23S rRNA end. The exact assay primers and index design are given in their Supplementary Table S4 and Figure S5. This project uses that assay region as the target, so reference sequences and sample ASVs cover comparable bases.

**BrayITS adaptation.** Screen candidate genomes for quality, compare their species labels with type-strain genomes using whole-genome ANI, and extract every plausible amplicon copy bounded by the study primers. Review genomes lacking an exact primer hit rather than treating them as absent. Remove primers, collapse identical inserts, retain genome/accession provenance, and flag identical ITS sequences that occur under conflicting species labels. Use the curated, unambiguous sequences for classifier training; keep unresolved sequences for the exact-match safeguard. Validate species calls on independent genomes or mock communities before using the resulting reference for phenotypes. ANI checks the *genome label*; it does not classify a sample ASV directly.

**Primer choice.** Use the published assay primers when reproducing the Teraishi amplicon. If a study uses different primers, rebuild the reference for that exact amplified region and check coverage and off-target amplification again. Primer sequences are supplied by the user rather than hard-coded in this template.

**Citation:** Teraishi M. et al. (2025). [Identification of Novel Candidate Genes Associated With the Symbiotic Compatibility of Soybean With Rhizobia Under Natural Conditions](https://doi.org/10.1002/pld3.70069). *Plant Direct* 9(5): e70069.

## Template scripts

The shell scripts in [`scripts/`](scripts/) illustrate the QIIME 2 input and ASV stages. Set your own manifest and primer sequences. No reads, reference sequences, genome assemblies, trained models, or sample metadata are bundled here.

```bash
export MANIFEST=/path/to/manifest.tsv
export FORWARD_PRIMER=YOUR_FORWARD_PRIMER
export REVERSE_PRIMER=YOUR_REVERSE_PRIMER
export OUTDIR=/path/to/output
bash scripts/01_asv_template.sh
bash scripts/02_export_asvs.sh
```

The paired-end manifest needs `sample-id`, `forward-absolute-filepath`, and `reverse-absolute-filepath` columns. Inspect read quality and amplicon length before choosing DADA2 truncation lengths. Zero truncation in the template is a starting value, not a universal recommendation.

## Scope

This is a **workflow template**, not a released reference database or a validated classifier package. A new study needs a versioned ITS reference, independent validation, and explicit handling of unresolved and non-target reads.
