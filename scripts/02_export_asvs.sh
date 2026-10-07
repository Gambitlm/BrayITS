#!/usr/bin/env bash
set -euo pipefail

: "${OUTDIR:?Set OUTDIR to the directory created by 01_asv_template.sh}"
mkdir -p "$OUTDIR/exported_table" "$OUTDIR/exported_repset"

qiime tools export --input-path "$OUTDIR/table.qza" --output-path "$OUTDIR/exported_table"
qiime tools export --input-path "$OUTDIR/repset.qza" --output-path "$OUTDIR/exported_repset"

test -s "$OUTDIR/exported_table/feature-table.biom"
test -s "$OUTDIR/exported_repset/dna-sequences.fasta"
