# Galaxy DIBBs
#
# VERSION 0.1

FROM mingchen0919/docker-grreport:latest

#-------Install tools from Galaxy toolshed--------
ADD tool_yml_files/01_fastqc.yml $GALAXY_ROOT/tool_yml_files/01_fastqc.yml
RUN install-tools $GALAXY_ROOT/tool_yml_files/01_fastqc.yml

ADD tool_yml_files/02_trimmomatic.yml $GALAXY_ROOT/tool_yml_files/02_trimmomatic.yml
RUN install-tools $GALAXY_ROOT/tool_yml_files/02_trimmomatic.yml

ADD tool_yml_files/03_bcftools_call.yml $GALAXY_ROOT/tool_yml_files/03_bcftools_call.yml
RUN install-tools $GALAXY_ROOT/tool_yml_files/03_bcftools_call.yml

ADD tool_yml_files/04_samtools_mpileup.yml $GALAXY_ROOT/tool_yml_files/04_samtools_mpileup.yml
RUN install-tools $GALAXY_ROOT/tool_yml_files/04_samtools_mpileup.yml

ADD tool_yml_files/05_samtools_flagstat.yml $GALAXY_ROOT/tool_yml_files/05_samtools_flagstat.yml
RUN install-tools $GALAXY_ROOT/tool_yml_files/05_samtools_flagstat.yml

ADD tool_yml_files/06_bwa.yml $GALAXY_ROOT/tool_yml_files/06_bwa.yml
RUN install-tools $GALAXY_ROOT/tool_yml_files/06_bwa.yml

ADD tool_yml_files/07_bowtie2.yml $GALAXY_ROOT/tool_yml_files/07_bowtie2.yml
RUN install-tools $GALAXY_ROOT/tool_yml_files/07_bowtie2.yml

ADD tool_yml_files/08_hisat2.yml $GALAXY_ROOT/tool_yml_files/08_hisat2.yml
RUN install-tools $GALAXY_ROOT/tool_yml_files/08_hisat2.yml

ADD tool_yml_files/09_cuffmerge.yml $GALAXY_ROOT/tool_yml_files/09_cuffmerge.yml
RUN install-tools $GALAXY_ROOT/tool_yml_files/09_cuffmerge.yml

ADD tool_yml_files/10_stringtie.yml $GALAXY_ROOT/tool_yml_files/10_stringtie.yml
RUN install-tools $GALAXY_ROOT/tool_yml_files/10_stringtie.yml

ADD tool_yml_files/11_snpeff.yml $GALAXY_ROOT/tool_yml_files/11_snpeff.yml
RUN install-tools $GALAXY_ROOT/tool_yml_files/11_snpeff.yml

ADD tool_yml_files/12_gatk2.yml $GALAXY_ROOT/tool_yml_files/12_gatk2.yml
RUN install-tools $GALAXY_ROOT/tool_yml_files/12_gatk2.yml

ADD tool_yml_files/13_fastq_stats.yml $GALAXY_ROOT/tool_yml_files/13_fastq_stats.yml
RUN install-tools $GALAXY_ROOT/tool_yml_files/13_fastq_stats.yml

ADD tool_yml_files/14_fastq_groomer.yml $GALAXY_ROOT/tool_yml_files/14_fastq_groomer.yml
RUN install-tools $GALAXY_ROOT/tool_yml_files/14_fastq_groomer.yml

ADD tool_yml_files/15_fasta_to_tabular.yml $GALAXY_ROOT/tool_yml_files/15_fasta_to_tabular.yml
RUN install-tools $GALAXY_ROOT/tool_yml_files/15_fasta_to_tabular.yml

ADD tool_yml_files/16_ncbi_blast_plus.yml $GALAXY_ROOT/tool_yml_files/16_ncbi_blast_plus.yml
RUN install-tools $GALAXY_ROOT/tool_yml_files/16_ncbi_blast_plus.yml

ADD tool_yml_files/17_megablast_xml_parser.yml $GALAXY_ROOT/tool_yml_files/17_megablast_xml_parser.yml
RUN install-tools $GALAXY_ROOT/tool_yml_files/17_megablast_xml_parser.yml

ADD tool_yml_files/18_interproscan.yml $GALAXY_ROOT/tool_yml_files/18_interproscan.yml
RUN install-tools $GALAXY_ROOT/tool_yml_files/18_interproscan.yml

ADD tool_yml_files/19_augustus.yml $GALAXY_ROOT/tool_yml_files/19_augustus.yml
RUN install-tools $GALAXY_ROOT/tool_yml_files/19_augustus.yml


#--------- Fix tool installation issues -----------------
#                                                       #
#--------------------------------------------------------

ADD fix_anaconda_intepreter_issue.sh $GALAXY_ROOT/fix_anaconda_intepreter_issue.sh

#====================== hisat2 ==========================
RUN /tool_deps/_conda/bin/conda install -y samtools==1.4 && \
        cd /tool_deps/_conda/pkgs/samtools-1.4-0/bin && \
        sh $GALAXY_ROOT/fix_anaconda_intepreter_issue.sh && \
    /tool_deps/_conda/bin/conda install -y hisat2==2.0.5 && \
        cd /tool_deps/_conda/pkgs/hisat2-2.0.5-py35_1/bin && \
        sh $GALAXY_ROOT/fix_anaconda_intepreter_issue.sh

ADD tool_xml_replacements/hisat2.xml /shed_tools/toolshed.g2.bx.psu.edu/repos/iuc/hisat2/2ec097c8e843/hisat2/hisat2.xml