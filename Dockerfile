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

ADD tool_yml_files/20_htseq_count.yml $GALAXY_ROOT/tool_yml_files/20_htseq_count.yml
RUN install-tools $GALAXY_ROOT/tool_yml_files/20_htseq_count.yml

ADD tool_yml_files/21_trinity.yml $GALAXY_ROOT/tool_yml_files/21_trinity.yml
RUN install-tools $GALAXY_ROOT/tool_yml_files/21_trinity.yml


#========================================================
#--------- Fix tool installation issues -----------------

#--------------------------------------------------------
# add a script to fix anaconda bad intepreter issue
ADD fix_anaconda_intepreter_issue.sh $GALAXY_ROOT/fix_anaconda_intepreter_issue.sh

#====================== hisat2 ==========================
RUN /tool_deps/_conda/bin/conda install -y samtools==1.4 && \
        cd /tool_deps/_conda/pkgs/samtools-1.4-0/bin && \
        sh $GALAXY_ROOT/fix_anaconda_intepreter_issue.sh && \
    /tool_deps/_conda/bin/conda install -y hisat2==2.0.5 && \
        cd /tool_deps/_conda/pkgs/hisat2-2.0.5-py35_1/bin && \
        sh $GALAXY_ROOT/fix_anaconda_intepreter_issue.sh

ADD tool_xml_replacements/hisat2.xml /shed_tools/toolshed.g2.bx.psu.edu/repos/iuc/hisat2/2ec097c8e843/hisat2/hisat2.xml
#----------------------------------------------------------



#====================== gatk2 ============================
ADD tool_sources/GenomeAnalysisTK-2.8-1.tar.bz2 $GALAXY_ROOT/software/
RUN cd $GALAXY_ROOT/software && \
    tar -xvjf GenomeAnalysisTK-2.8-1.tar.bz2 && \
    echo GATK2_PATH=$GALAXY_ROOT/software/GenomeAnalysisTK-2.8-1; export GATK2_PATH > /tool_deps/environment_settings/GATK2_PATH/iuc/gatk2/84584664264c/env.sh
#----------------------------------------------------------


#====================== stringtie ============================
RUN /tool_deps/_conda/bin/conda install -y stringtie==1.3.3 && \
        cd /tool_deps/_conda/pkgs/stringtie-1.3.3-0/bin && \
        sh $GALAXY_ROOT/fix_anaconda_intepreter_issue.sh
ADD tool_xml_replacements/stringtie.xml /shed_tools/toolshed.g2.bx.psu.edu/repos/iuc/stringtie/6e45b443ef1f/stringtie/stringtie.xml
ADD tool_xml_replacements/stringtie_merge.xml /shed_tools/toolshed.g2.bx.psu.edu/repos/iuc/stringtie/6e45b443ef1f/stringtie/stringtie_merge.xml
#-------------------------------------------------------------


#====================== trinity ===============================
RUN /tool_deps/_conda/bin/conda install -y trinity==2.4.0 && \
        cd /tool_deps/_conda/pkgs/bowtie2-2.3.0-py35_1/bin && \
        sh $GALAXY_ROOT/fix_anaconda_intepreter_issue.sh
ADD tool_xml_replacements/trinity.xml /shed_tools/toolshed.g2.bx.psu.edu/repos/iuc/trinity/e65e640e6196/trinity/trinity.xml
