#ENCODE DCC RNA-Seq pipeline merge-annotation
#Maintainer: Otto Jolanki

workflow merge_anno {
    # input filenames
    File annotation
    File tRNA
    File spikeins
    # output filename
    String output_filename

    call merge_annotation { input :
        annotation = annotation,
        tRNA = tRNA,
        spikeins = spikeins,
        output_filename = output_filename,
    }
}

task merge_annotation {
    File annotation
    File tRNA
    File spikeins
    String output_filename

    command {
        python3 $(which merge_annotation.py) \
            ${"--annotation " + annotation} \
            ${"--tRNA " + tRNA} \
            ${"--spikeins " + spikeins} \
            ${"--output_filename " + output_filename}
    }
    output {
        File merged_annotation = glob("${output_filename}")[0]
    }
}