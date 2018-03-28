workflow testrsem {
    File rsem_index
    File anno_bam
    String endedness
    String read_strand
    Int rnd_seed
    Int ncpus
    Int ramGB

    call rsem_quant { input:
        rsem_index = rsem_index,
        rnd_seed = rnd_seed,
        anno_bam = anno_bam,
        endedness = endedness,
        read_strand = read_strand,
        ncpus = ncpus,
        ramGB = ramGB,
    }
}

    task rsem_quant {
        File rsem_index
        File anno_bam
        String endedness
        String read_strand
        Int rnd_seed
        Int ncpus
        Int ramGB

        command {
            python3 $(which rsem_quant.py) \
                --rsem_index ${rsem_index} \
                --anno_bam ${anno_bam} \
                --endedness ${endedness} \
                --read_strand ${read_strand} \
                --rnd_seed ${rnd_seed} \
                --ncpus ${ncpus} \
                --ramGB ${ramGB}
        }

        output {
            File genes_results = glob("*.genes.results")[0]
            File isoforms_results = glob("*.isoforms.results")[0]
        }

        runtime {
            docker : "quay.io/encode-dcc/rna-seq-pipeline:latest"
        }
    }