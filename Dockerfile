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

ADD tool_yml_files/11.1_package_snpeff_4_1.yml $GALAXY_ROOT/tool_yml_files/11.1_package_snpeff_4_1.yml
RUN install-tools $GALAXY_ROOT/tool_yml_files/11.1_package_snpeff_4_1.yml

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

 ####=======ADD tool_xml_replacements/hisat2.xml /shed_tools/toolshed.g2.bx.psu.edu/repos/iuc/hisat2/2ec097c8e843/hisat2/hisat2.xml
#----------------------------------------------------------




#====================== gatk2 ============================
COPY tool_sources/GenomeAnalysisTK-2.8-1.tar.bz2 $GALAXY_HOME/software/
RUN cd $GALAXY_HOME/software/ && \
    tar -xvjf GenomeAnalysisTK-2.8-1.tar.bz2 && mv GenomeAnalysisTK-2.8-1-* GenomeAnalysisTK-2.8-1  && \
    echo 'GATK2_PATH=$GALAXY_HOME/software/GenomeAnalysisTK-2.8-1; export GATK2_PATH' > /tool_deps/environment_settings/GATK2_PATH/iuc/gatk2/84584664264c/env.sh && \
    # GATK 2.8 requires java 7.
    echo 'PATH=/usr/lib/jvm/java-7-openjdk-amd64/jre/bin:$PATH; export PATH' >> /tool_deps/environment_settings/GATK2_PATH/iuc/gatk2/84584664264c/env.sh 
#----------------------------------------------------------


#====================== stringtie ============================
RUN /tool_deps/_conda/bin/conda install -y stringtie==1.3.3 && \
        cd /tool_deps/_conda/pkgs/stringtie-1.3.3-0/bin && \
        sh $GALAXY_ROOT/fix_anaconda_intepreter_issue.sh
 ####=======ADD tool_xml_replacements/stringtie.xml /shed_tools/toolshed.g2.bx.psu.edu/repos/iuc/stringtie/6e45b443ef1f/stringtie/stringtie.xml
 ####=======ADD tool_xml_replacements/stringtie_merge.xml /shed_tools/toolshed.g2.bx.psu.edu/repos/iuc/stringtie/6e45b443ef1f/stringtie/stringtie_merge.xml
#-------------------------------------------------------------


#====================== htseq ============================
# the htseq-count wrapper is based on version 0.6.1.post1, which requires python 2.7.
#RUN /tool_deps/_conda/bin/conda install -y htseq==0.6.1.post1 && \
#        cd /tool_deps/_conda/pkgs/htseq-0.6.1.post1-py27_1/bin && \
#        sh $GALAXY_ROOT/fix_anaconda_intepreter_issue.sh
 ####=======ADD tool_xml_replacements/htseq-count.xml /shed_tools/toolshed.g2.bx.psu.edu/repos/lparsons/htseq_count/620d5603d1a8/htseq_count/htseq-count.xml
ADD tool_yml_files/21_package_htseq_0_6.yml $GALAXY_ROOT/tool_yml_files/21_package_htseq_0_6.yml
RUN install-tools $GALAXY_ROOT/tool_yml_files/21_package_htseq_0_6.yml
#-------------------------------------------------------------



#====================== trinity ===============================
RUN /tool_deps/_conda/bin/conda install -y trinity==2.4.0 && \
        cd /tool_deps/_conda/pkgs/bowtie2-2.3.0-py35_1/bin && \
        sh $GALAXY_ROOT/fix_anaconda_intepreter_issue.sh
 ####=======ADD tool_xml_replacements/trinity.xml /shed_tools/toolshed.g2.bx.psu.edu/repos/iuc/trinity/e65e640e6196/trinity/trinity.xml
#----------------------------------------------------------------


#====================== snpeff =================================
RUN /tool_deps/_conda/bin/conda install -y snpeff==4.3k && \
    cd /tool_deps/_conda/pkgs/snpeff-4.3k-0/share/snpeff-4.3k-0 && mkdir -p data && chown -R galaxy:root data
#----------------------------------------------------------------


#======================= bwa ====================================
RUN /tool_deps/_conda/bin/conda install -y bwa==0.7.15
#------------------------------------------------------------------

COPY tool_xml_replacements $GALAXY_HOME/tool_xml_replacements
RUN cd $GALAXY_HOME && \
    cp tool_xml_replacements/hisat2.xml /shed_tools/toolshed.g2.bx.psu.edu/repos/iuc/hisat2/2ec097c8e843/hisat2/hisat2.xml && \
    cp tool_xml_replacements/stringtie.xml /shed_tools/toolshed.g2.bx.psu.edu/repos/iuc/stringtie/6e45b443ef1f/stringtie/stringtie.xml && \
    cp tool_xml_replacements/stringtie_merge.xml /shed_tools/toolshed.g2.bx.psu.edu/repos/iuc/stringtie/6e45b443ef1f/stringtie/stringtie_merge.xml && \
    cp tool_xml_replacements/htseq-count.xml /shed_tools/toolshed.g2.bx.psu.edu/repos/lparsons/htseq_count/620d5603d1a8/htseq_count/htseq-count.xml && \
    cp tool_xml_replacements/trinity.xml /shed_tools/toolshed.g2.bx.psu.edu/repos/iuc/trinity/e65e640e6196/trinity/trinity.xml && \
    cp tool_xml_replacements/bwa.xml /shed_tools/toolshed.g2.bx.psu.edu/repos/devteam/bwa/051eba708f43/bwa/bwa.xml && \
    cp tool_xml_replacements/bwa.xml /shed_tools/toolshed.g2.bx.psu.edu/repos/devteam/bwa/051eba708f43/bwa/bwa-mem.xml

