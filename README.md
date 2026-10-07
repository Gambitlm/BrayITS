# BrayITS

A compact template for processing *Bradyrhizobium* ITS amplicons and summarizing *B. japonicum* (Bj) and *B. elkanii* (Be) reads in soybean nodule samples.

![BrayITS workflow](brayits.png)

## What the diagram means

Paired-end FASTQ reads are primer-trimmed and denoised into ASV sequences plus an ASV-by-sample count table. A sequence classifier proposes Bj, Be, or Others for each ASV. Exact reference matches are then checked for label conflicts: a *Bradyrhizobium* sequence whose species is uncertain goes to **Others**, while a sequence whose genus is uncertain goes to **Unresolved**. Final ASV calls are joined to the count table to produce per-sample read counts.

Genome quality and ANI are **upstream reference-label checks**. The example classifier does not calculate ANI for a sample ASV. The genus check and exact-match override must be validated before using final Bj/Be/Others calls for phenotypes.

For the main three-part composition, use `Bj / (Bj + Be + Others)` and the analogous Be and Others fractions. **Others** includes any ASV supported as *Bradyrhizobium* but not reliably called Bj or Be, including named non-target species and genus-confirmed sequences without a species name. **Unresolved** means that *Bradyrhizobium* genus membership is not established; confirmed off-target sequences are tracked separately. Both are excluded from the three-part denominator but their read counts are reported for quality review. The separate `Bj / (Bj + Be)` measure answers only the Bj-versus-Be question. Set fractions to `NA` when their denominator is zero.

## Building the ITS reference

**Published starting point.** Teraishi et al. amplified a partial *Bradyrhizobium* 16S–23S ITS region. Their forward primer was designed in a conserved tRNA-Ala segment within ITS; the reverse primer used the ITS-R site near the 23S rRNA end. The exact assay primers and index design are given in their Supplementary Table S4 and Figure S5. This project uses that assay region as the target, so reference sequences and sample ASVs cover comparable bases.

**BrayITS adaptation.** Screen candidate genomes for quality, compare their species labels with type-strain genomes using whole-genome ANI, and extract every plausible amplicon copy bounded by the study primers. Review genomes lacking an exact primer hit rather than treating them as absent. Remove primers, collapse identical inserts, retain genome/accession provenance, and flag identical ITS sequences that occur under conflicting species labels. Use the curated, unambiguous sequences for classifier training; keep unresolved sequences for the exact-match safeguard. Validate species calls on independent genomes or mock communities before using the resulting reference for phenotypes. ANI checks the *genome label*; it does not classify a sample ASV directly.

**Primer choice.** Use the published assay primers when reproducing the Teraishi amplicon. If a study uses different primers, rebuild the reference for that exact amplified region and check coverage and off-target amplification again. Primer sequences are intentionally supplied by the user rather than hard-coded in this template.

**Citation:** Teraishi M. et al. (2025). [Identification of Novel Candidate Genes Associated With the Symbiotic Compatibility of Soybean With Rhizobia Under Natural Conditions](https://doi.org/10.1002/pld3.70069). *Plant Direct* 9(5): e70069.

## Template scripts

The shell scripts in [`scripts/`](scripts/) show the QIIME 2 input and ASV stages. Replace the example manifest and primer placeholders with experiment-specific values. The scripts deliberately do not bundle reads, reference sequences, genome assemblies, trained models, or sample metadata.

```bash
export MANIFEST=/path/to/manifest.tsv
export FORWARD_PRIMER=YOUR_FORWARD_PRIMER
export REVERSE_PRIMER=YOUR_REVERSE_PRIMER
export OUTDIR=/path/to/output
bash scripts/01_asv_template.sh
bash scripts/02_export_asvs.sh
```

`manifest.tsv` must use QIIME 2's paired-end manifest format with `sample-id`, `forward-absolute-filepath`, and `reverse-absolute-filepath` columns. Check read quality and amplicon length before choosing DADA2 truncation values. The template uses zero truncation as a starting point, not as a universally recommended setting.

## Scope

This is a **workflow template**, not a released reference database or a validated classifier package. Species calls for a new study require a versioned ITS reference, independent strain or mock-community validation, and an explicit treatment of uncertain-genus and off-target reads. The diagram is conceptual: its “genome evidence check” refers to reference curation upstream of sample classification. An exact match to a species-uncertain but genus-confirmed reference belongs in Others, not Unresolved.
