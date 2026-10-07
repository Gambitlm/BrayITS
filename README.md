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
