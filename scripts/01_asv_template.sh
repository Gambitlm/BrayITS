#!/usr/bin/env bash
set -euo pipefail

: "${MANIFEST:?Set MANIFEST to a paired-end QIIME 2 manifest.tsv}"
: "${FORWARD_PRIMER:?Set FORWARD_PRIMER to the study-specific forward primer}"
: "${REVERSE_PRIMER:?Set REVERSE_PRIMER to the study-specific reverse primer}"
: "${OUTDIR:?Set OUTDIR to an output directory}"

mkdir -p "$OUTDIR"

qiime tools import   --type 'SampleData[PairedEndSequencesWithQuality]'   --input-format PairedEndFastqManifestPhred33V2   --input-path "$MANIFEST"   --output-path "$OUTDIR/demux.qza"

qiime cutadapt trim-paired   --i-demultiplexed-sequences "$OUTDIR/demux.qza"   --p-front-f "$FORWARD_PRIMER"   --p-front-r "$REVERSE_PRIMER"   --p-discard-untrimmed   --p-cores 4   --o-trimmed-sequences "$OUTDIR/trimmed.qza"

qiime demux summarize   --i-data "$OUTDIR/trimmed.qza"   --o-visualization "$OUTDIR/trimmed_summary.qzv"

# Review trimmed_summary.qzv before finalizing truncation and chimera settings.
qiime dada2 denoise-paired   --i-demultiplexed-seqs "$OUTDIR/trimmed.qza"   --p-trunc-len-f 0   --p-trunc-len-r 0   --p-n-threads 4   --o-table "$OUTDIR/table.qza"   --o-representative-sequences "$OUTDIR/repset.qza"   --o-denoising-stats "$OUTDIR/denoising_stats.qza"

qiime tools export --input-path "$OUTDIR/denoising_stats.qza"   --output-path "$OUTDIR/exported_stats"

test -s "$OUTDIR/table.qza"
test -s "$OUTDIR/repset.qza"
test -s "$OUTDIR/exported_stats/stats.tsv"
