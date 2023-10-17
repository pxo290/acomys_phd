#R_Scrapboook_2
#Started on 2023-04-10

#The R-image saving here
tic()
save.image("~/Google Drive/PhD/Scripts/R_working_directory/2023-05-17.RData")
toc()

#Get size of objects in R
 data.frame('object' = ls()) %>% 
      dplyr::mutate(size_unit = object %>%sapply(. %>% get() %>% object.size %>% format(., unit = 'auto')),
                    size = as.numeric(sapply(strsplit(size_unit, split = ' '), FUN = function(x) x[1])),
                    unit = factor(sapply(strsplit(size_unit, split = ' '), FUN = function(x) x[2]), levels = c('Gb', 'Mb', 'Kb', 'bytes'))) %>% 
      dplyr::arrange(unit, dplyr::desc(size)) %>% 
      dplyr::select(-size_unit)

#2023-04-10
#Making a combined kraken and kaiju figure for number of taxids detected versus the changing factor for the human mock files
`2022.03.06_Kraken_human_mock_detailed_taxID_known_members_breakdown` <- read.csv("~/Google Drive/PhD/2022-Paper_1-Chapter_1_Benchmarking_and_pilot_samples/2022-03-06_Kraken_human_mock_detailed_taxID_known_members_breakdown.csv")
`2022_03_07_melted_krak_hum_mock_detailed` <- reshape2::melt(`2022.03.06_Kraken_human_mock_detailed_taxID_known_members_breakdown`, id=as.factor("Confidence.score"), measure.vars=c("Unique.taxIDs", "TaxIDs.with.more.than.100.reads", "Exact.strain.occurrences", "Exact.species.only.taxID.occurrences", "Fuzzy.false.positive.taxID.occurrences", "Genus.false.positive.taxID.occurrences", "Exact.strain.reads.classified", "Exact.species.only.reads.classified", "Fuzzy.false.positive.reads.classified", "Genus.false.positive.reads.classified", "None.same.genus.taxids.detected", "None.same.genus.reads.classified"))
ggplot(`2022_03_07_melted_krak_hum_mock_detailed`[`2022_03_07_melted_krak_hum_mock_detailed`$variable == "Unique.taxIDs",], aes(x = Confidence.score, y = value)) + geom_point(fill = "#0f0f0f", size = 3) + geom_line(colour = "#0f0f0f", size = 1.5) + theme(text = element_text(family = "Tex Gyre Heroes")) + theme(legend.title=element_blank()) + scale_x_continuous(breaks=pretty_breaks(n=10)) + scale_y_continuous(limits = c(0, 300), breaks=pretty_breaks(n=20)) + geom_hline(yintercept = 20, linetype = "dashed", color = "#ed872d", size = 1) + theme(legend.position =c(0.8,0.9)) + theme_classic() + xlab("Confidence score (%)") + ylab("Detected NCBI taxIDS") + theme(legend.position = "none")

`2023-04-10-processed_pilot_human_mock_kraken2_number_taxids_detected` <- ggplot(`2022_03_07_melted_krak_hum_mock_detailed`[`2022_03_07_melted_krak_hum_mock_detailed`$variable == "Unique.taxIDs",], aes(x = Confidence.score, y = value)) + geom_point(fill = "#0f0f0f", size = 3) + geom_line(colour = "#0f0f0f", size = 1.5) + theme(text = element_text(family = "Tex Gyre Heroes")) + theme(legend.title=element_blank()) + scale_x_continuous(breaks=pretty_breaks(n=10)) + scale_y_continuous(limits = c(0, 300), breaks=pretty_breaks(n=20)) + geom_hline(yintercept = 20, linetype = "dashed", color = "#ed872d", size = 1) + theme(legend.position =c(0.8,0.9)) + theme_classic() + xlab("Confidence score (%)") + ylab("Detected NCBI taxIDS") + theme(legend.position = "none")

ggplot(`2022.04.04_Melted_Kaiju_human_mock_detailed_taxID_known_members_breakdown`[`2022.04.04_Melted_Kaiju_human_mock_detailed_taxID_known_members_breakdown`$variable == "Unique taxIDs",], aes(x = Allowed.errors, y = value)) + geom_point(fill = "#0f0f0f", size = 3) + geom_line(colour = "#0f0f0f", size = 1.5) + theme(text = element_text(family = "Tex Gyre Heroes")) + theme(legend.title=element_blank()) + scale_x_continuous(breaks=pretty_breaks(n=20)) + scale_y_continuous(limits = c(0, 14000), breaks=pretty_breaks(n=20)) + geom_hline(yintercept = 20, linetype = "dashed", color = "#ed872d", size = 1) + theme(legend.position =c(0.8,0.9)) + theme_classic() + xlab("Number allowed errors in match") + ylab("Detected NCBI taxIDS") + theme(legend.position = "none")
`2023-04-10-processed_pilot_human_mock_kaiju_number_taxids_detected` <- ggplot(`2022.04.04_Melted_Kaiju_human_mock_detailed_taxID_known_members_breakdown`[`2022.04.04_Melted_Kaiju_human_mock_detailed_taxID_known_members_breakdown`$variable == "Unique taxIDs",], aes(x = Allowed.errors, y = value)) + geom_point(fill = "#0f0f0f", size = 3) + geom_line(colour = "#0f0f0f", size = 1.5) + theme(text = element_text(family = "Tex Gyre Heroes")) + theme(legend.title=element_blank()) + scale_x_continuous(breaks=pretty_breaks(n=20)) + scale_y_continuous(limits = c(0, 14000), breaks=pretty_breaks(n=20)) + geom_hline(yintercept = 20, linetype = "dashed", color = "#ed872d", size = 1) + theme(legend.position =c(0.8,0.9)) + theme_classic() + xlab("Number allowed errors in match") + ylab("") + theme(legend.position = "none")

`2023-04-10-processed_pilot_human_mock_kraken2_number_taxids_detected` + `2023-04-10-processed_pilot_human_mock_kaiju_number_taxids_detected` + plot_annotation(tag_levels = 'A')

#As above but this time each figure has two lines, one for the number of taxids detected and one for taxids with at least 100 reads assigned to them
ggplot(`2022_03_07_melted_krak_hum_mock_detailed`[`2022_03_07_melted_krak_hum_mock_detailed`$variable == "Unique.taxIDs" | `2022_03_07_melted_krak_hum_mock_detailed`$variable == "TaxIDs.with.more.than.100.reads",], aes(x = Confidence.score, y = value, fill = variable, colour = variable)) + geom_point(size = 3) + geom_line(size = 1.5) + theme(text = element_text(family = "Tex Gyre Heroes")) + theme(legend.title=element_blank()) + scale_x_continuous(breaks=pretty_breaks(n=10)) + scale_y_continuous(limits = c(0, 300), breaks=pretty_breaks(n=20)) + geom_hline(yintercept = 20, linetype = "dashed", color = "#ed872d", size = 1) + theme(legend.position =c(0.8,0.9)) + theme_classic() + xlab("Confidence score (%)") + ylab("Detected NCBI taxIDS") + theme(legend.position = "none") + scale_colour_manual(values = c("Unique.taxIDs" = "#0f0f0f", "TaxIDs.with.more.than.100.reads" = "#2d93ed")) + scale_fill_manual(values = c("Unique.taxIDs" = "#0f0f0f", "TaxIDs.with.more.than.100.reads" = "#2d93ed"))
ggplot(`2022.04.04_Melted_Kaiju_human_mock_detailed_taxID_known_members_breakdown`[`2022.04.04_Melted_Kaiju_human_mock_detailed_taxID_known_members_breakdown`$variable == "Unique taxIDs" | `2022.04.04_Melted_Kaiju_human_mock_detailed_taxID_known_members_breakdown`$variable == "TaxIDs with more than 100 reads",], aes(x = Allowed.errors, y = value, fill = variable, colour = variable)) + geom_point(size = 3) + geom_line(size = 1.5) + theme(text = element_text(family = "Tex Gyre Heroes")) + theme(legend.title=element_blank()) + scale_x_continuous(breaks=pretty_breaks(n=20)) + scale_y_continuous(limits = c(0, 14000), breaks=pretty_breaks(n=20)) + geom_hline(yintercept = 20, linetype = "dashed", color = "#ed872d", size = 1) + theme(legend.position =c(0.8,0.9)) + theme_classic() + xlab("Number allowed errors in match") + ylab("Detected NCBI taxIDS") + theme(legend.position = "none") + scale_colour_manual(values = c("Unique taxIDs" = "#0f0f0f", "TaxIDs with more than 100 reads" = "#2d93ed")) + scale_fill_manual(values = c("Unique taxIDs" = "#0f0f0f", "TaxIDs with more than 100 reads" = "#2d93ed"))

`2023-04-10-processed_pilot_human_mock_kraken2_number_taxids_detected_and_100_read_min_taxids` <- ggplot(`2022_03_07_melted_krak_hum_mock_detailed`[`2022_03_07_melted_krak_hum_mock_detailed`$variable == "Unique.taxIDs" | `2022_03_07_melted_krak_hum_mock_detailed`$variable == "TaxIDs.with.more.than.100.reads",], aes(x = Confidence.score, y = value, fill = variable, colour = variable)) + geom_point(size = 3) + geom_line(size = 1.5) + theme(text = element_text(family = "Tex Gyre Heroes")) + theme(legend.title=element_blank()) + scale_x_continuous(breaks=pretty_breaks(n=10)) + scale_y_continuous(limits = c(0, 300), breaks=pretty_breaks(n=20)) + geom_hline(yintercept = 20, linetype = "dashed", color = "#ed872d", size = 1) + theme(legend.position =c(0.8,0.9)) + theme_classic() + xlab("Confidence score (%)") + ylab("Detected NCBI taxIDS") + theme(legend.position = "none") + scale_colour_manual(values = c("Unique.taxIDs" = "#0f0f0f", "TaxIDs.with.more.than.100.reads" = "#2d93ed")) + scale_fill_manual(values = c("Unique.taxIDs" = "#0f0f0f", "TaxIDs.with.more.than.100.reads" = "#2d93ed"))
`2023-04-10-processed_pilot_human_mock_kaiju_number_taxids_detected_and_100_read_min_taxids` <- ggplot(`2022.04.04_Melted_Kaiju_human_mock_detailed_taxID_known_members_breakdown`[`2022.04.04_Melted_Kaiju_human_mock_detailed_taxID_known_members_breakdown`$variable == "Unique taxIDs" | `2022.04.04_Melted_Kaiju_human_mock_detailed_taxID_known_members_breakdown`$variable == "TaxIDs with more than 100 reads",], aes(x = Allowed.errors, y = value, fill = variable, colour = variable)) + geom_point(size = 3) + geom_line(size = 1.5) + theme(text = element_text(family = "Tex Gyre Heroes")) + theme(legend.title=element_blank()) + scale_x_continuous(breaks=pretty_breaks(n=20)) + scale_y_continuous(limits = c(0, 14000), breaks=pretty_breaks(n=20)) + geom_hline(yintercept = 20, linetype = "dashed", color = "#ed872d", size = 1) + theme(legend.position =c(0.8,0.9)) + theme_classic() + xlab("Number allowed errors in match") + ylab("Detected NCBI taxIDS") + theme(legend.position = "none") + scale_colour_manual(values = c("Unique taxIDs" = "#0f0f0f", "TaxIDs with more than 100 reads" = "#2d93ed")) + scale_fill_manual(values = c("Unique taxIDs" = "#0f0f0f", "TaxIDs with more than 100 reads" = "#2d93ed"))

`2023-04-10-processed_pilot_human_mock_kraken2_number_taxids_detected_and_100_read_min_taxids` + `2023-04-10-processed_pilot_human_mock_kaiju_number_taxids_detected_and_100_read_min_taxids` + plot_annotation(tag_levels = 'A')

`2023-04-10_processed_pilot_human_mock_combined_kaiju_kraken_fig_taxids_detected_black_taxids_with_100_reads_min_blue` <- `2023-04-10-processed_pilot_human_mock_kraken2_number_taxids_detected_and_100_read_min_taxids` + `2023-04-10-processed_pilot_human_mock_kaiju_number_taxids_detected_and_100_read_min_taxids` + plot_annotation(tag_levels = 'A')
ggsave(filename = "2023-04-10_processed_pilot_human_mock_combined_kaiju_kraken_fig_taxids_detected_black_taxids_with_100_reads_min_blue.pdf", `2023-04-10_processed_pilot_human_mock_combined_kaiju_kraken_fig_taxids_detected_black_taxids_with_100_reads_min_blue`)

#Making a figure for the difference between the processed and unprocessed read file % classifications for all tools
`2022.09.30_raw_read_classification_percentages_tools_compared_processed` <- read.csv("~/Google Drive/PhD/2022-Paper_1-Chapter_1_Benchmarking_and_pilot_samples/2022-09-30_raw_read_classification_percentages_tools_compared_processed.csv")
view(`2022.09.30_raw_read_classification_percentages_tools_compared_processed`)

`2022.09.30_melted_raw_read_classification_percentages_tools_compared_processed` <- reshape2::melt(`2022.09.30_raw_read_classification_percentages_tools_compared_processed`, id=c("Sample.1", "Host.species", "Sample"))
view(`2022.09.30_melted_raw_read_classification_percentages_tools_compared_processed`)

#Variable with shorter name containing the pilot samples for rodent only results, raw and processed percent classified reads each tool
`2023-04-12_rodent_pilots_classifications` <- `2022.09.30_melted_raw_read_classification_percentages_tools_compared_processed`[`2022.09.30_melted_raw_read_classification_percentages_tools_compared_processed`$Host.species != "HS",]

#Metaphlan
`2023-04-12_metaphlan_pilot_rodents_percent_classified_raw_vs_processed_boxplots` <- ggplot(data = `2023-04-12_rodent_pilots_classifications`[`2023-04-12_rodent_pilots_classifications`$variable == "Metaphlan.estimated.percent.reads.classified.from.raw" | `2023-04-12_rodent_pilots_classifications`$variable == "Metaphlan.estimated.percent.reads.classified.from.processed",], aes(x = variable, y = value)) + geom_boxplot(aes(fill = Host.species), colour = "#0f0f0f", alpha = 0.85) + xlab("File type") + ylab("Estimated percent reads classified (%)") + ggtitle("Metaphlan") + scale_x_discrete(labels = c("Raw", "Processed")) + scale_fill_manual(name = "Host species", values = c("MM" = "#1a1a1a", "AC" = "#858585", "AR" = "#c9c9c9")) + facet_wrap(~ Host.species) + ylim(0, 100) + stat_compare_means(method = "wilcox.test", label = 'p.signif') + theme_classic() + theme(text = element_text(family = "Tex Gyre Heroes"))

#mOTus
`2023-04-12_mOTUs_pilot_rodents_percent_classified_raw_vs_processed_boxplots` <- ggplot(data = `2023-04-12_rodent_pilots_classifications`[grepl("mOTUs*",`2023-04-12_rodent_pilots_classifications`$variable),], aes(x = variable, y = value)) + geom_boxplot(aes(fill = Host.species), colour = "#0f0f0f", alpha = 0.85) + xlab("File type") + ylab("Log10 percent reads classified (%)") + ggtitle("mOTUs") + scale_x_discrete(labels = c("Raw", "Processed")) + scale_fill_manual(name = "Host species", values = c("MM" = "#1a1a1a", "AC" = "#858585", "AR" = "#c9c9c9")) + stat_compare_means(method = "wilcox.test", label = 'p.signif') + facet_wrap(~ Host.species) + scale_y_continuous(trans='log10') + ylim(0, 0.1) + theme_classic() + theme(text = element_text(family = "Tex Gyre Heroes"))

#Kraken 2
`2023-04-12_kraken2_pilot_rodents_percent_classified_raw_vs_processed_boxplots` <- ggplot(data = `2023-04-12_rodent_pilots_classifications`[grepl("Kraken.10..confidence.percent.classified.reads.from.*", `2023-04-12_rodent_pilots_classifications`$variable),], aes(x = variable, y = value)) + geom_boxplot(aes(fill = Host.species), colour = "#0f0f0f", alpha = 0.85) + xlab("File type") + ylab("Estimated percent reads classified (%)") + ggtitle("Kraken 2") + scale_x_discrete(labels = c("Raw", "Processed")) + scale_fill_manual(name = "Host species", values = c("MM" = "#1a1a1a", "AC" = "#858585", "AR" = "#c9c9c9")) + facet_wrap(~ Host.species) + ylim(0, 100) + stat_compare_means(method = "wilcox.test", label = 'p.signif') + theme_classic() + theme(text = element_text(family = "Tex Gyre Heroes")) + theme(legend.position = "none")

#Kaiju
`2023-04-12_kaiju_pilot_rodents_percent_classified_raw_vs_processed_boxplots` <- ggplot(data = `2023-04-12_rodent_pilots_classifications`[grepl("Kaiju.20.errors.percent.classified.reads*", `2023-04-12_rodent_pilots_classifications`$variable),], aes(x = variable, y = value)) + geom_boxplot(aes(fill = Host.species), colour = "#0f0f0f", alpha = 0.85) + xlab("File type") + ylab("Estimated percent reads classified (%)") + ggtitle("Kaiju") + scale_x_discrete(labels = c("Raw", "Processed")) + scale_fill_manual(name = "Host species", values = c("MM" = "#1a1a1a", "AC" = "#858585", "AR" = "#c9c9c9")) + facet_wrap(~ Host.species) + ylim(0, 100) + stat_compare_means(method = "wilcox.test", label = 'p.signif') + theme_classic() + theme(text = element_text(family = "Tex Gyre Heroes")) + theme(legend.position = "none")

#Combined Metaphlan and mOTUs figure
`2023-04-12_combined_metaphlan_motus_pilot_rodents_percent_classified_raw_vs_processed_boxplots` <- `2023-04-12_metaphlan_pilot_rodents_percent_classified_raw_vs_processed_boxplots` + `2023-04-12_mOTUs_pilot_rodents_percent_classified_raw_vs_processed_boxplots` + plot_annotation(tag_levels = 'A') + plot_layout(guides = 'collect')

#Combined Kraken and Kaiju figure
`2023-04-12_combined_kaiju_kraken2_pilot_rodents_percent_classified_raw_vs_processed_boxplots` <- `2023-04-12_kaiju_pilot_rodents_percent_classified_raw_vs_processed_boxplots` + `2023-04-12_kraken2_pilot_rodents_percent_classified_raw_vs_processed_boxplots` + plot_annotation(tag_levels = 'A') + plot_layout(guides = 'collect')

#Combo combined figure?
`2023-04-12_combined_all_four_tools_pilot_rodents_percent_classified_raw_vs_processed_boxplots` <- `2023-04-12_combined_metaphlan_motus_pilot_rodents_percent_classified_raw_vs_processed_boxplots` / `2023-04-12_combined_kaiju_kraken2_pilot_rodents_percent_classified_raw_vs_processed_boxplots` + plot_annotation(tag_levels = 'A') + plot_layout(guides = 'collect')

#Saving the combo combined figure
ggsave(filename = "/Users/osbourne/Google Drive/PhD/2022-Paper_1-Chapter_1_Benchmarking_and_pilot_samples/2023-04-12_combined_all_four_tools_pilot_rodents_percent_classified_raw_vs_processed_boxplots.pdf", `2023-04-12_combined_all_four_tools_pilot_rodents_percent_classified_raw_vs_processed_boxplots`)

scale_fill_manual(values = c("HS" = "#8d1eff", "MM" = "#1a1a1a", "AC" = "#858585", "AR" = "#c9c9c9"))

#2023-04-25
#Getting the numbers for the pilot samples processing steps
`2022.09.22_all_samples_read_counts_R1_each_QC_step` <- read.delim("~/Google Drive/PhD/2022-Paper_1-Chapter_1_Benchmarking_and_pilot_samples/2022-09-22_all_samples_read_counts_R1_each_QC_step.txt")
`2022.09.22_all_samples_read_counts_R1_each_QC_step_non_human` <- `2022.09.22_all_samples_read_counts_R1_each_QC_step`[`2022.09.22_all_samples_read_counts_R1_each_QC_step`$Sample %notin% "Human_mock",]
`2022.09.22_all_samples_read_counts_R1_each_QC_step_non_human_melted` <- reshape2::melt(`2022.09.22_all_samples_read_counts_R1_each_QC_step_non_human`, id=c("Sample", "Raw.Read.Count", "Qced.read.count", "Qced.and.cleansed.read.count", "Percent.original.reads.in.subsampled.files", "Percent.Qced.and.cleansed.reads.in.subsampled.file", "Host.species"))

#Mean and median for the QC, cleansing and subsampling - for each rodent species - giving the % lost from the original so will be 100 - the averages
100 - mean(`2022.09.22_all_samples_read_counts_R1_each_QC_step_non_human_melted`[`2022.09.22_all_samples_read_counts_R1_each_QC_step_non_human_melted`$Host.species == "Acomys cahirinus",]$Percent.original.reads.in.subsampled.files)
100 - median(`2022.09.22_all_samples_read_counts_R1_each_QC_step_non_human_melted`[`2022.09.22_all_samples_read_counts_R1_each_QC_step_non_human_melted`$Host.species == "Acomys cahirinus",]$Percent.original.reads.in.subsampled.files)

100 - mean(`2022.09.22_all_samples_read_counts_R1_each_QC_step_non_human_melted`[`2022.09.22_all_samples_read_counts_R1_each_QC_step_non_human_melted`$Host.species == "Acomys russatus",]$Percent.original.reads.in.subsampled.files)
100 - median(`2022.09.22_all_samples_read_counts_R1_each_QC_step_non_human_melted`[`2022.09.22_all_samples_read_counts_R1_each_QC_step_non_human_melted`$Host.species == "Acomys russatus",]$Percent.original.reads.in.subsampled.files)

100 - mean(`2022.09.22_all_samples_read_counts_R1_each_QC_step_non_human_melted`[`2022.09.22_all_samples_read_counts_R1_each_QC_step_non_human_melted`$Host.species == "Mus musculus",]$Percent.original.reads.in.subsampled.files)
100 - median(`2022.09.22_all_samples_read_counts_R1_each_QC_step_non_human_melted`[`2022.09.22_all_samples_read_counts_R1_each_QC_step_non_human_melted`$Host.species == "Mus musculus",]$Percent.original.reads.in.subsampled.files)

#2023-04-26
#Getting the numbers for pilot samples, raw and processed for Kaiju and mOTUS AR since they had a statistically significant difference
view(`2022.09.30_melted_raw_read_classification_percentages_tools_compared_processed`)

#Kaiju AR raw
mean(`2022.09.30_melted_raw_read_classification_percentages_tools_compared_processed`[`2022.09.30_melted_raw_read_classification_percentages_tools_compared_processed`$Host.species == "AR" & `2022.09.30_melted_raw_read_classification_percentages_tools_compared_processed`$variable == "Kaiju.20.errors.percent.classified.reads.from.raw",]$value)
#Kaiju AR processed
mean(`2022.09.30_melted_raw_read_classification_percentages_tools_compared_processed`[`2022.09.30_melted_raw_read_classification_percentages_tools_compared_processed`$Host.species == "AR" & `2022.09.30_melted_raw_read_classification_percentages_tools_compared_processed`$variable == "Kaiju.20.errors.percent.classified.reads.from.processed",]$value)

#mOTUS AR raw
mean(`2022.09.30_melted_raw_read_classification_percentages_tools_compared_processed`[`2022.09.30_melted_raw_read_classification_percentages_tools_compared_processed`$Host.species == "AR" & `2022.09.30_melted_raw_read_classification_percentages_tools_compared_processed`$variable == "mOTUs.percent.reads.classified.from.raw",]$value)
#mOTUS AR processed
mean(`2022.09.30_melted_raw_read_classification_percentages_tools_compared_processed`[`2022.09.30_melted_raw_read_classification_percentages_tools_compared_processed`$Host.species == "AR" & `2022.09.30_melted_raw_read_classification_percentages_tools_compared_processed`$variable == "mOTUs.percent.reads.classified.from.processed",]$value)

#Now doing the stuff for mOTUs more generally, from sample with most and least non-zero detections to the most commonly detected mOTU refs and the ones with the highest average detection in each of the three rodent species. Plus need to try and do the human mock stuff for it as well.
`2023.04.10_TRANSPOSED_all_pilot_processed_files_percent_reads_classified_any_detected_mOTUs_across_all_samples` <- read.csv("~/Google Drive/PhD/2022-Paper_1-Chapter_1_Benchmarking_and_pilot_samples/2023-04-10_TRANSPOSED_all_pilot_processed_files_percent_reads_classified_any_detected_mOTUs_across_all_samples.csv")
view(`2023.04.10_TRANSPOSED_all_pilot_processed_files_percent_reads_classified_any_detected_mOTUs_across_all_samples`)
`2023.04.10_melted_TRANSPOSED_all_pilot_processed_files_percent_reads_classified_any_detected_mOTUs_across_all_samples` <- reshape2::melt(`2023.04.10_TRANSPOSED_all_pilot_processed_files_percent_reads_classified_any_detected_mOTUs_across_all_samples`, id = c("mOTU_ref", "Host", "File_status"))
view(`2023.04.10_melted_TRANSPOSED_all_pilot_processed_files_percent_reads_classified_any_detected_mOTUs_across_all_samples`)

`2023.04.26_mOTU_processed_human_mock_only` <- `2023.04.10_melted_TRANSPOSED_all_pilot_processed_files_percent_reads_classified_any_detected_mOTUs_across_all_samples`[`2023.04.10_melted_TRANSPOSED_all_pilot_processed_files_percent_reads_classified_any_detected_mOTUs_across_all_samples`$mOTU_ref == "Human_mock",]

`2023.04.26_mOTU_processed_rodents_only` <- `2023.04.10_melted_TRANSPOSED_all_pilot_processed_files_percent_reads_classified_any_detected_mOTUs_across_all_samples`[`2023.04.10_melted_TRANSPOSED_all_pilot_processed_files_percent_reads_classified_any_detected_mOTUs_across_all_samples`$mOTU_ref != "Human_mock",]

#Making a version without the SRR samples which you excluded previously anyway
`2023.04.26_mOTU_processed_rodents_only_final` <- `2023.04.26_mOTU_processed_rodents_only`[! `2023.04.26_mOTU_processed_rodents_only`$mOTU_ref == "SRR9205148" & ! `2023.04.26_mOTU_processed_rodents_only`$mOTU_ref == "SRR9205149",]


#Loop to get the number of non-zero mOTU ref detections per sample
tic()
`mOTUs_processed_rodents` <- data.frame(matrix(ncol = 8, nrow = 0, dimnames = list(NULL, c("Sample", "Host", "Most abundant", "Least abundant", "Non zero mOTU refs", "Mean abundance", "Median abundance", "Total abundance"))))
for (sample in as.list(unique(`2023.04.26_mOTU_processed_rodents_only_final`$mOTU_ref))) {
    sampleID.zoot <- paste(sample)
    host.zoot <- unique(`2023.04.26_mOTU_processed_rodents_only_final`[`2023.04.26_mOTU_processed_rodents_only_final`$mOTU_ref == sampleID.zoot,]$Host)
    num.non.zero.zoot <- as.numeric(nrow(as.data.frame(unique(`2023.04.26_mOTU_processed_rodents_only_final`[`2023.04.26_mOTU_processed_rodents_only_final`$mOTU_ref == sampleID.zoot & `2023.04.26_mOTU_processed_rodents_only_final`$value > 0,]$variable))))
    most.abundant.zoot <- as.character(head(`2023.04.26_mOTU_processed_rodents_only_final` %>% filter(mOTU_ref == sampleID.zoot) %>% filter(value > 0) %>% arrange(desc(value)), 1)$variable)
    least.abundant.zoot <- as.character(tail(`2023.04.26_mOTU_processed_rodents_only_final` %>% filter(mOTU_ref == sampleID.zoot) %>% filter(value > 0) %>% arrange(desc(value)), 1)$variable)
    mean.percentage.zoot <- `2023.04.26_mOTU_processed_rodents_only_final` %>% filter(mOTU_ref == sampleID.zoot) %>% filter(value > 0) %>% pull(value) %>% mean()
    median.percentage.zoot <- `2023.04.26_mOTU_processed_rodents_only_final` %>% filter(mOTU_ref == sampleID.zoot) %>% filter(value > 0) %>% pull(value) %>% median()
    total.percentage.zoot <- `2023.04.26_mOTU_processed_rodents_only_final` %>% filter(mOTU_ref == sampleID.zoot) %>% filter(value > 0) %>% pull(value) %>% sum()
    `mOTUs_processed_rodents`[nrow(`mOTUs_processed_rodents`) + 1,] <- c(sampleID.zoot, host.zoot, most.abundant.zoot, least.abundant.zoot, num.non.zero.zoot, mean.percentage.zoot, median.percentage.zoot, total.percentage.zoot)
    `mOTUs_processed_rodents`[,c(5:8)] <- sapply(`mOTUs_processed_rodents`[,c(5:8)], as.numeric)
    rm(list=ls(pattern='*zoot'))
}
view(`mOTUs_processed_rodents`)
write.table(`mOTUs_processed_rodents`, file = "2022-04-26_mOTUs_pilot_rodents_per_sample_most_least_abundant_and_mean_median_and_sum_abundances.csv", sep=",", row.names=FALSE)
toc()

`mOTUs_processed_rodents` %>% filter(Host == "AC") %>% arrange(desc(Total.abundance))

#2023-04-28
#Making the combined figure for the Metaphlan, Kaiju and Kraken 2 percentage of reads classified
p1 <- ggplot(data = `06_09_met_read_percent`, aes(x = "Processed read files", y = Estimated_reads_mapped_to_known_clades_by_Metaphlan_as_percentage_reads_in_subsampled_read_file)) + theme_classic() + theme(text = element_text(family = "Tex Gyre Heroes")) + geom_violin(color="black", fill='#8a795d', alpha = 0.65) + geom_boxplot(width = 0.4, fill = '#f2f3f4') + xlab("") + ylab("Estimated mapped reads no. as\npercentage of total input reads (%)")
p2 <- ggplot(data = `06_09_melted_krak_read_percent`[(`06_09_melted_krak_read_percent`$variable == "Percent_reads_classified_Bacteria"), ], aes(x = Kraken_minimum_confidence_score_required, y = value, group = Kraken_minimum_confidence_score_required)) + theme_classic() + theme(text = element_text(family = "Tex Gyre Heroes")) + geom_violin(color="black", fill='#8a795d', alpha = 0.65, width = 12) + geom_boxplot(width = 1, fill = '#f2f3f4') + xlab("Minimum confidence score required\nfor classification (%)") + ylab("Reads classified as bacteria\npercent of input reads (%)") + scale_x_continuous(breaks=seq(0,100,5), guide = guide_axis(n.dodge = 2))
p3 <- ggplot(data = `06_10_melted_kaiju_read_percent`, aes(x = Errors_allowed, y = value, group = Errors_allowed)) + theme_classic() + theme(text = element_text(family = "Tex Gyre Heroes")) + geom_violin(color="black", fill='#8a795d', alpha = 0.65, width = 1) + geom_boxplot(width = 0.5, fill = '#f2f3f4') + scale_x_continuous(breaks=seq(0,20,1), guide = guide_axis(n.dodge = 2)) + xlab("Allowed errors in match") + ylab("Percent input reads classified (%)")

#Now need to get and process the mOTUs data as well to do the same thing
`2023.04.29_all_cleansed_Acomys_files_percent_classified_mOTUs_excluding_unassigned` <- read.delim("~/Google Drive/PhD/2022-Paper_2-Chapter_3/2023-04-29_all_cleansed_Acomys_files_percent_classified_mOTUs_excluding_unassigned.tsv")
view(`2023.04.29_all_cleansed_Acomys_files_percent_classified_mOTUs_excluding_unassigned`)

p4 <- ggplot(data = `2023.04.29_all_cleansed_Acomys_files_percent_classified_mOTUs_excluding_unassigned`, aes(x = "Cleaned read files", y = Percent.classified)) + geom_violin(color="black", fill='#8a795d', alpha = 0.65) + geom_boxplot(width = 0.4, fill = '#f2f3f4') + xlab("") + ylab("Classified reads as\npercentage of total input reads (%)") + theme_classic()

ggarrange(p1, p2, p3, p4, labels = c("A", "B", "C", "D"), ncol = 2, nrow = 2)
`2023-04-29_all_four_tools_all_samples_percent_reads_classified` <- ggarrange(p1, p2, p3, p4, labels = c("A", "B", "C", "D"), ncol = 2, nrow = 2)


ggsave(filename = "2023-04-29_all_four_tools_all_samples_percent_reads_classified.pdf", `2023-04-29_all_four_tools_all_samples_percent_reads_classified`)

`2023.04.29_melted_all_cleansed_Acomys_files_percent_classified_mOTUs_excluding_unassigned` <- reshape2::melt(`2023.04.29_all_cleansed_Acomys_files_percent_classified_mOTUs_excluding_unassigned`, id=c("Sample.ID", "Host.species", "Month", "Host.x.month"))

view(`2023.04.29_melted_all_cleansed_Acomys_files_percent_classified_mOTUs_excluding_unassigned`)
#Getting some key stats for the mOTUs results for each species to put in the text
max(`2023.04.29_melted_all_cleansed_Acomys_files_percent_classified_mOTUs_excluding_unassigned`[`2023.04.29_melted_all_cleansed_Acomys_files_percent_classified_mOTUs_excluding_unassigned`$Host.species == "AC",]$value)
max(`2023.04.29_melted_all_cleansed_Acomys_files_percent_classified_mOTUs_excluding_unassigned`[`2023.04.29_melted_all_cleansed_Acomys_files_percent_classified_mOTUs_excluding_unassigned`$Host.species == "AR",]$value)
min(`2023.04.29_melted_all_cleansed_Acomys_files_percent_classified_mOTUs_excluding_unassigned`[`2023.04.29_melted_all_cleansed_Acomys_files_percent_classified_mOTUs_excluding_unassigned`$Host.species == "AC",]$value)
min(`2023.04.29_melted_all_cleansed_Acomys_files_percent_classified_mOTUs_excluding_unassigned`[`2023.04.29_melted_all_cleansed_Acomys_files_percent_classified_mOTUs_excluding_unassigned`$Host.species == "AR",]$value)
median(`2023.04.29_melted_all_cleansed_Acomys_files_percent_classified_mOTUs_excluding_unassigned`[`2023.04.29_melted_all_cleansed_Acomys_files_percent_classified_mOTUs_excluding_unassigned`$Host.species == "AC",]$value)
median(`2023.04.29_melted_all_cleansed_Acomys_files_percent_classified_mOTUs_excluding_unassigned`[`2023.04.29_melted_all_cleansed_Acomys_files_percent_classified_mOTUs_excluding_unassigned`$Host.species == "AR",]$value)

#Now the things about the reference mOTUs
`2023-04-29_all_cleansed_Acomys_files_number_ref-mOTUs_non_zero_relative_abundance` <- read.delim("~/Google Drive/PhD/2022-Paper_2-Chapter_3/2023-04-29_all_cleansed_Acomys_files_number_ref-mOTUs_non_zero_relative_abundance.tsv", header=FALSE)
view(`2023-04-29_all_cleansed_Acomys_files_number_ref-mOTUs_non_zero_relative_abundance`)

#First is the numbers of unique non-zero ref-mOTUs per sample
`2023-04-29_melted_all_cleansed_Acomys_files_number_ref-mOTUs_non_zero_relative_abundance` <- reshape2::melt(`2023-04-29_all_cleansed_Acomys_files_number_ref-mOTUs_non_zero_relative_abundance`, id=c("V1", "V3", "V4", "V5"))
view(`2023-04-29_melted_all_cleansed_Acomys_files_number_ref-mOTUs_non_zero_relative_abundance`)

max(`2023-04-29_melted_all_cleansed_Acomys_files_number_ref-mOTUs_non_zero_relative_abundance`[`2023-04-29_melted_all_cleansed_Acomys_files_number_ref-mOTUs_non_zero_relative_abundance`$V3 == "AC",]$value)
max(`2023-04-29_melted_all_cleansed_Acomys_files_number_ref-mOTUs_non_zero_relative_abundance`[`2023-04-29_melted_all_cleansed_Acomys_files_number_ref-mOTUs_non_zero_relative_abundance`$V3 == "AR",]$value)
median(`2023-04-29_melted_all_cleansed_Acomys_files_number_ref-mOTUs_non_zero_relative_abundance`[`2023-04-29_melted_all_cleansed_Acomys_files_number_ref-mOTUs_non_zero_relative_abundance`$V3 == "AC",]$value)
median(`2023-04-29_melted_all_cleansed_Acomys_files_number_ref-mOTUs_non_zero_relative_abundance`[`2023-04-29_melted_all_cleansed_Acomys_files_number_ref-mOTUs_non_zero_relative_abundance`$V3 == "AR",]$value)

#Now which reference mOTUs were the most relatively abundant across all samples and each host species
`2023.04.29_transposed_all_samples_relative_abundance_non_zero_refs_min_one_sample_all_possible` <- read.delim("~/Google Drive/PhD/2022-Paper_2-Chapter_3/2023-04-29_transposed_all_samples_relative_abundance_non_zero_refs_min_one_sample_all_possible.txt")
view(`2023.04.29_transposed_all_samples_relative_abundance_non_zero_refs_min_one_sample_all_possible`)

`2023.04.29_melted_transposed_all_samples_relative_abundance_non_zero_refs_min_one_sample_all_possible` <- reshape2::melt(`2023.04.29_transposed_all_samples_relative_abundance_non_zero_refs_min_one_sample_all_possible`, id=c("Reference", "Host", "Month", "Host.x.season"))
view(`2023.04.29_melted_transposed_all_samples_relative_abundance_non_zero_refs_min_one_sample_all_possible`)

`2023.04.29_melted_transposed_all_samples_relative_abundance_non_zero_refs_min_one_sample_all_possible` %>% mutate_if(is.factor, as.character) -> `2023.04.29_melted_transposed_all_samples_relative_abundance_non_zero_refs_min_one_sample_all_possible`

tic()
`mOTUs_processed_rodents_refmotuses` <- data.frame(matrix(ncol = 10, nrow = 0, dimnames = list(NULL, c("Reference", "AC max", "AC median", "AR max", "AR median", "Both max", "Both median", "AC.sum", "AR.sum", "Sample most abundant"))))
for (reference in as.list(unique(`2023.04.29_melted_transposed_all_samples_relative_abundance_non_zero_refs_min_one_sample_all_possible`$variable))) {
    reference.zoot <- paste(reference)
    ac.max.zoot <- max(`2023.04.29_melted_transposed_all_samples_relative_abundance_non_zero_refs_min_one_sample_all_possible`[`2023.04.29_melted_transposed_all_samples_relative_abundance_non_zero_refs_min_one_sample_all_possible`$variable == reference.zoot & `2023.04.29_melted_transposed_all_samples_relative_abundance_non_zero_refs_min_one_sample_all_possible`$Host == "AC",]$value)
    ac.median.zoot <- median(`2023.04.29_melted_transposed_all_samples_relative_abundance_non_zero_refs_min_one_sample_all_possible`[`2023.04.29_melted_transposed_all_samples_relative_abundance_non_zero_refs_min_one_sample_all_possible`$variable == reference.zoot & `2023.04.29_melted_transposed_all_samples_relative_abundance_non_zero_refs_min_one_sample_all_possible`$Host == "AC",]$value)
    ar.max.zoot <- max(`2023.04.29_melted_transposed_all_samples_relative_abundance_non_zero_refs_min_one_sample_all_possible`[`2023.04.29_melted_transposed_all_samples_relative_abundance_non_zero_refs_min_one_sample_all_possible`$variable == reference.zoot & `2023.04.29_melted_transposed_all_samples_relative_abundance_non_zero_refs_min_one_sample_all_possible`$Host == "AR",]$value)
    ar.median.zoot <- median(`2023.04.29_melted_transposed_all_samples_relative_abundance_non_zero_refs_min_one_sample_all_possible`[`2023.04.29_melted_transposed_all_samples_relative_abundance_non_zero_refs_min_one_sample_all_possible`$variable == reference.zoot & `2023.04.29_melted_transposed_all_samples_relative_abundance_non_zero_refs_min_one_sample_all_possible`$Host == "AR",]$value)
    both.max.zoot <- max(`2023.04.29_melted_transposed_all_samples_relative_abundance_non_zero_refs_min_one_sample_all_possible`[`2023.04.29_melted_transposed_all_samples_relative_abundance_non_zero_refs_min_one_sample_all_possible`$variable == reference.zoot,]$value)
    both.median.zoot <- median(`2023.04.29_melted_transposed_all_samples_relative_abundance_non_zero_refs_min_one_sample_all_possible`[`2023.04.29_melted_transposed_all_samples_relative_abundance_non_zero_refs_min_one_sample_all_possible`$variable == reference.zoot,]$value)
    ac.sum.zoot <- sum(`2023.04.29_melted_transposed_all_samples_relative_abundance_non_zero_refs_min_one_sample_all_possible`[`2023.04.29_melted_transposed_all_samples_relative_abundance_non_zero_refs_min_one_sample_all_possible`$variable == reference.zoot & `2023.04.29_melted_transposed_all_samples_relative_abundance_non_zero_refs_min_one_sample_all_possible`$Host == "AC",]$value)
    ar.sum.zoot <- sum(`2023.04.29_melted_transposed_all_samples_relative_abundance_non_zero_refs_min_one_sample_all_possible`[`2023.04.29_melted_transposed_all_samples_relative_abundance_non_zero_refs_min_one_sample_all_possible`$variable == reference.zoot & `2023.04.29_melted_transposed_all_samples_relative_abundance_non_zero_refs_min_one_sample_all_possible`$Host == "AR",]$value)
    sample.most.zoot <- as.character(head(`2023.04.29_melted_transposed_all_samples_relative_abundance_non_zero_refs_min_one_sample_all_possible` %>% filter(variable == reference.zoot) %>% arrange(desc(value)), 1)$Reference)
    `mOTUs_processed_rodents_refmotuses`[nrow(`mOTUs_processed_rodents_refmotuses`) +1,] <- c(reference.zoot, ac.max.zoot, ac.median.zoot, ac.max.zoot, ac.median.zoot, both.max.zoot, both.median.zoot, ac.sum.zoot, ar.sum.zoot, sample.most.zoot)
    `mOTUs_processed_rodents_refmotuses`[,c(2:9)] <- sapply(`mOTUs_processed_rodents_refmotuses`[,c(2:9)], as.numeric)
    rm(list=ls(pattern='*zoot'))
}
view(`mOTUs_processed_rodents_refmotuses`)
write.table(`mOTUs_processed_rodents_refmotuses`, file = "2022-04-29_mOTUs_all_cleansed_Acomys_all_possible_non_zero_ref_mOTUses_some_stats.csv", sep=",", row.names=FALSE)
toc()

options(scipen = 999)
#Making two supplemental figures, the summed relative abundances of all ref-mOTUs for each host species
`2023-04-30_AC_all_cleansed_mOTUs_summed_relative_abundances_box_and_violin_fig` <- ggplot(data = `mOTUs_processed_rodents_refmotuses`, aes(x = "Cleansed read files", y = AC.sum)) + theme_classic() + theme(text = element_text(family = "Tex Gyre Heroes")) + geom_violin(color="black", fill="#1e90ff", alpha = 0.65, width = 12) + geom_boxplot(width = 1, fill = '#f2f3f4') + scale_y_log10() + xlab("") + ylab("Summed relative abundance\nacross all samples (log10 %)") + geom_jitter(data = `mOTUs_processed_rodents_refmotuses`[`mOTUs_processed_rodents_refmotuses`$AC.sum >= 1,], colour = "black", size = 2.5) + geom_label_repel(data = `mOTUs_processed_rodents_refmotuses`[`mOTUs_processed_rodents_refmotuses`$AC.sum >= 1,], aes(label = Reference), box.padding   = 0.75, point.padding = 0.75,segment.color = 'grey50') 

`2023-04-30_AR_all_cleansed_mOTUs_summed_relative_abundances_box_and_violin_fig` <- ggplot(data = `mOTUs_processed_rodents_refmotuses`, aes(x = "Cleansed read files", y = AR.sum)) + theme_classic() + theme(text = element_text(family = "Tex Gyre Heroes")) + geom_violin(color="black", fill="#ff8d1e", alpha = 0.65, width = 12) + geom_boxplot(width = 1, fill = '#f2f3f4') + scale_y_log10() + xlab("") + ylab("Summed relative abundance\nacross all samples (log10 %)") + geom_jitter(data = `mOTUs_processed_rodents_refmotuses`[`mOTUs_processed_rodents_refmotuses`$AR.sum >= 1,], colour = "black", size = 2.5) + geom_label_repel(data = `mOTUs_processed_rodents_refmotuses`[`mOTUs_processed_rodents_refmotuses`$AR.sum >= 1,], aes(label = Reference), box.padding   = 0.75, point.padding = 0.75,segment.color = 'grey50') 

`2023-04-30_AC_all_cleansed_mOTUs_summed_relative_abundances_box_and_violin_fig` + `2023-04-30_AR_all_cleansed_mOTUs_summed_relative_abundances_box_and_violin_fig` + plot_annotation(tag_levels = 'A')

`2023-04-30_all_cleansed_by_host_mOTUs_summed_relative_abundances_refs_box_and_violin_labelled_points_1_or_greater` <- `2023-04-30_AC_all_cleansed_mOTUs_summed_relative_abundances_box_and_violin_fig` + `2023-04-30_AR_all_cleansed_mOTUs_summed_relative_abundances_box_and_violin_fig` + plot_annotation(tag_levels = 'A')

ggsave(filename = "2023-04-30_all_cleansed_by_host_mOTUs_summed_relative_abundances_refs_box_and_violin_labelled_points_1_or_greater.pdf", `2023-04-30_all_cleansed_by_host_mOTUs_summed_relative_abundances_refs_box_and_violin_labelled_points_1_or_greater`)

#Try and make a stacked bar chart for genus level results for Metaphlan, one per host species but if that fails will just remake the genus level box and violin plots for genus level metaphlan stuff as a pdf with the classic theme


ggplot(data = `2022.11.01.metaphlan.melted`[`2022.11.01.metaphlan.melted`$variable %in% `2022.11.01.metaphlan.melted.genus.count.samples.detected.in`[`2022.11.01.metaphlan.melted.genus.count.samples.detected.in`$n > 1,]$variable & `2022.11.01.metaphlan.melted`$value > 0,], aes(x = Species.x.season, y = value, fill = Species.x.season)) + geom_violin() + geom_boxplot(fill = "#e4e6e8", width = 0.15) + scale_fill_manual(name = "Host species and\ncollection month", values = c("ACJ" = "#1ec8ff", "ACN" = "#006ad1", "ARJ" = "#ff551e", "ARN" = "#d16700")) + theme_linedraw() + xlab("Host species and collection month") + ylab("Relative abundance (%)") + facet_wrap(~ variable) + theme(text = element_text(family = "Tex Gyre Heroes"))

install.packages("pals")
library("pals")
ggplot(data = `2022.11.01.metaphlan.melted`[`2022.11.01.metaphlan.melted`$variable %in% `2022.11.01.metaphlan.melted.genus.count.samples.detected.in`[`2022.11.01.metaphlan.melted.genus.count.samples.detected.in`$n > 1,]$variable & `2022.11.01.metaphlan.melted`$value > 0,], aes(x = SampleID, y = value, fill = variable)) + geom_bar(position="stack", stat = "identity") + theme_classic() + theme(text = element_text(family = "Tex Gyre Heroes"), axis.text.x=element_text(angle = -90, hjust = 0)) + facet_wrap(~ Species.x.season, scales = "free_x") + scale_fill_manual(name = "Genus",values=as.vector(kelly(17))) + xlab("Sample ID") + ylab("Estimated relative\nabundance (%)")

`2023-04-30_metaphlan_subsampled_all_Acomys_relative_abundance_genus_stacked_bars_facet_by_host_and_month_fig` <- ggplot(data = `2022.11.01.metaphlan.melted`[`2022.11.01.metaphlan.melted`$variable %in% `2022.11.01.metaphlan.melted.genus.count.samples.detected.in`[`2022.11.01.metaphlan.melted.genus.count.samples.detected.in`$n > 1,]$variable & `2022.11.01.metaphlan.melted`$value > 0,], aes(x = SampleID, y = value, fill = variable)) + geom_bar(position="stack", stat = "identity") + theme_classic() + theme(text = element_text(family = "Tex Gyre Heroes"), axis.text.x=element_text(angle = -90, hjust = 0)) + facet_wrap(~ Species.x.season, scales = "free_x") + scale_fill_manual(name = "Genus",values=as.vector(kelly(17))) + xlab("Sample ID") + ylab("Estimated relative\nabundance (%)")

ggsave(filename = "2023-04-30_metaphlan_subsampled_all_Acomys_relative_abundance_genus_stacked_bars_facet_by_host_and_month_fig.pdf", `2023-04-30_metaphlan_subsampled_all_Acomys_relative_abundance_genus_stacked_bars_facet_by_host_and_month_fig`)

#Will now make a combined figure for the raw versus processed percent classifications for all subsampled reads for Metaphlan, Kaiju and Kraken
#instead of the current three separate figures facetted by host x month
`2023-04-30_metaphlan_all_subsampled_raw_versus_processed_percent_classified_boxplot` <- ggplot(data = `2022-10-22_working_melted`[`2022-10-22_working_melted`$variable == "Raw.Metaphlan.estimated.percent.reads.classified" | `2022-10-22_working_melted`$variable == "Processed.Metaphlan.estimated.percent.reads.classified",], aes(x = variable, y = value)) + geom_boxplot(aes(fill = Host), colour = "#0f0f0f", alpha = 0.85) + xlab("File type") + ylab("Estimated percent reads classified (%)") + scale_x_discrete(labels = c("Raw", "Processed")) + theme_classic() + scale_fill_manual(name = "Host species", values = c("AC" = "#1e90ff", "AR" = "#ff8d1e")) + stat_compare_means(method = "wilcox.test", label.y = 25.5, label = 'p.signif') + facet_wrap(~ Host) + theme(text = element_text(family = "Tex Gyre Heroes"))

`2023-04-30_kraken_all_subsampled_raw_versus_processed_percent_classified_boxplot` <- ggplot(data = `2022-10-22_working_melted`[`2022-10-22_working_melted`$variable == "Raw.Kraken.percent.reads.classified" | `2022-10-22_working_melted`$variable == "Processed.Kraken.percent.reads.classified",], aes(x = variable, y = value)) + geom_boxplot(aes(fill = Host), colour = "#0f0f0f", alpha = 0.85) + xlab("File type") + ylab("Percent reads classified (%)") + scale_x_discrete(labels = c("Raw", "Processed")) + theme_classic() + scale_fill_manual(name = "Host species", values = c("AC" = "#1e90ff", "AR" = "#ff8d1e")) + stat_compare_means(method = "wilcox.test", label.y = 25.5, label = 'p.signif') + facet_wrap(~ Host) + theme(text = element_text(family = "Tex Gyre Heroes"))

`2023-04-30_kaiju_all_subsampled_raw_versus_processed_percent_classified_boxplot` <- ggplot(data = `2022-10-22_working_melted`[`2022-10-22_working_melted`$variable == "Raw.Kaiju.percent.reads.classified" | `2022-10-22_working_melted`$variable == "Processed.Kaiju.percent.reads.classified",], aes(x = variable, y = value)) + geom_boxplot(aes(fill = Host), colour = "#0f0f0f", alpha = 0.85) + xlab("File type") + ylab("Percent reads classified (%)") + scale_x_discrete(labels = c("Raw", "Processed")) + theme_classic() + scale_fill_manual(name = "Host species", values = c("AC" = "#1e90ff", "AR" = "#ff8d1e")) + stat_compare_means(method = "wilcox.test", label.y = 25.5, label = 'p.signif') + facet_wrap(~ Host) + theme(text = element_text(family = "Tex Gyre Heroes"))

`2023-04-30_combined_kaiju_kraken_metaphlan_percent_classified_raw_vs_processed_boxplots` <- `2023-04-30_metaphlan_all_subsampled_raw_versus_processed_percent_classified_boxplot` + `2023-04-30_kraken_all_subsampled_raw_versus_processed_percent_classified_boxplot` + `2023-04-30_kaiju_all_subsampled_raw_versus_processed_percent_classified_boxplot` + plot_annotation(tag_levels = 'A') + plot_layout(guides = "collect")

ggsave(filename = "2023-04-30_combined_kaiju_kraken_metaphlan_percent_classified_raw_vs_processed_boxplots_fig.pdf", `2023-04-30_combined_kaiju_kraken_metaphlan_percent_classified_raw_vs_processed_boxplots`)

#Now a figure for Kraken 2 50% min score doing a violin plot for all taxa with min 2.5% reads classified in at least one sample faceted by host species and sampling month, showing only the novogene results
#Making a dataframe which has the taxa names with spaces between multiple words instead of periods
`melted_2022_09_02_Transposed_050_min_confidence_all_processed_subsampled_samples_Kraken_all_potential_TAXONS_percentages_from_report_file` -> `tempor_dataframe`
`melted_2022_09_02_Transposed_050_min_confidence_all_processed_subsampled_samples_Kraken_all_potential_TAXONS_percentages_from_report_file`$variable = gsub("[.]", " ", `melted_2022_09_02_Transposed_050_min_confidence_all_processed_subsampled_samples_Kraken_all_potential_TAXONS_percentages_from_report_file`$variable)

`2023-04-30_all_novogene_sequenced_acomys_kraken2_boxplot_and_violin_min_2_point_5_percent_rel_abund_taxa_fig` <- ggplot(data = `melted_2022_09_02_Transposed_050_min_confidence_all_processed_subsampled_samples_Kraken_all_potential_TAXONS_percentages_from_report_file` %>% filter(Sequencing == "Novogene") %>% filter(value >= 2.5) %>% filter(variable != "unclassified") %>% filter(variable != "root") %>% filter(variable != "cellular organisms"), aes(x = variable, y = value, fill = Species_x_season), colour = "black") + geom_violin(alpha = 1, width = 1) + geom_boxplot(fill = "#e4e6e8",width = 0.15) + scale_fill_manual(name = "Host species and\ncollection month", values = c("ACJ" = "#1ec8ff", "ACN" = "#006ad1", "ARJ" = "#ff551e", "ARN" = "#d16700")) + facet_wrap(~ Species_x_season, scales = "free_x") + theme(text = element_text(family = "Tex Gyre Heroes")) + theme_classic() + theme(axis.text.x=element_text(angle = 45, hjust = 1, size = 7.5)) + ylab("Percent reads classified as taxon (%)") + xlab("Taxa")

ggsave(filename = "2023-04-30_all_novogene_sequenced_acomys_kraken2_boxplot_and_violin_min_2_point_5_percent_rel_abund_taxa_fig.pdf",`2023-04-30_all_novogene_sequenced_acomys_kraken2_boxplot_and_violin_min_2_point_5_percent_rel_abund_taxa_fig`)

#Now need to try and make a stacked bar of genus level results somehow, not sure if I have that level of results already

#2023-05-01
#Continuing on from above
#But making the phylum level figs first
`2023.04.30_kraken2_all_possible_phyla_relative_abundance_subsampled_reads` <- read.delim("~/Google Drive/PhD/2022-Paper_2-Chapter_3/2023-04-30_kraken2_all_possible_phyla_relative_abundance_subsampled_reads.tsv")
view(`2023.04.30_kraken2_all_possible_phyla_relative_abundance_subsampled_reads`)
`2023.04.30_transposed_kraken2_all_possible_phyla_relative_abundance_subsampled_reads` <- setNames(data.frame(t(`2023.04.30_kraken2_all_possible_phyla_relative_abundance_subsampled_reads`[,-1])), `2023.04.30_kraken2_all_possible_phyla_relative_abundance_subsampled_reads`[,1])
`2023.04.30_transposed_kraken2_all_possible_phyla_relative_abundance_subsampled_reads`[] <- lapply(`2023.04.30_transposed_kraken2_all_possible_phyla_relative_abundance_subsampled_reads`, type.convert, as.is = TRUE)
`2023.04.30_transposed_kraken2_all_possible_phyla_relative_abundance_subsampled_reads`$SampleID <- row.names(`2023.04.30_transposed_kraken2_all_possible_phyla_relative_abundance_subsampled_reads`)
`2023.04.30_melted_transposed_kraken2_all_possible_phyla_relative_abundance_subsampled_reads` <- reshape2::melt(`2023.04.30_transposed_kraken2_all_possible_phyla_relative_abundance_subsampled_reads`, id = c("SampleID", "Host", "Month", "Host.x.month"))

ggplot(data = `2023.04.30_melted_transposed_kraken2_all_possible_phyla_relative_abundance_subsampled_reads`, aes(x = SampleID, y = value, fill = variable)) + geom_bar(position="stack", stat = "identity") + theme_classic() + theme(text = element_text(family = "Tex Gyre Heroes"), axis.text.x=element_text(angle = -90, hjust = 0)) + facet_wrap(~ Host.x.month, scales = "free_x") + xlab("Sample ID") + scale_fill_manual(name = "Genus",values=as.vector(kelly(22))) + ylab("Relative\nabundance (%)")

`tempor4_krak2_phyla` <- data.frame(matrix(ncol = 2, nrow = 0, dimnames = list(NULL, c("Phylum", "Summed.value"))))
for (reference in as.list(unique(`2023.04.30_melted_transposed_kraken2_all_possible_phyla_relative_abundance_subsampled_reads`$variable))) {
    phylum.zoot <- paste(reference)
    summed.zoot <- sum(`2023.04.30_melted_transposed_kraken2_all_possible_phyla_relative_abundance_subsampled_reads`[`2023.04.30_melted_transposed_kraken2_all_possible_phyla_relative_abundance_subsampled_reads`$variable == phylum.zoot,]$value)
    `tempor4_krak2_phyla`[nrow(`tempor4_krak2_phyla`) +1,] <- c(phylum.zoot, summed.zoot)
    `tempor4_krak2_phyla`[,c(2)] <- sapply(`tempor4_krak2_phyla`[,c(2)], as.numeric)
    rm(list=ls(pattern='*zoot'))
}
view(`tempor4_krak2_phyla`)

ggplot(data = `2023.04.30_melted_transposed_kraken2_all_possible_phyla_relative_abundance_subsampled_reads`[`2023.04.30_melted_transposed_kraken2_all_possible_phyla_relative_abundance_subsampled_reads`$variable %in% `tempor4_krak2_phyla`[`tempor4_krak2_phyla`$Summed.value >= 0.01,]$Phylum,], aes(x = SampleID, y = value, fill = variable)) + geom_bar(position="stack", stat = "identity") + theme_classic() + theme(text = element_text(family = "Tex Gyre Heroes"), axis.text.x=element_text(angle = -90, hjust = 0)) + facet_wrap(~ Host.x.month, scales = "free_x") + xlab("Sample ID") + scale_fill_manual(name = "Genus",values=as.vector(kelly(6))) + ylab("Relative\nabundance (%)")

`2023-05-01_Kraken2_all_processed_reads_050_conf_phyla_summed_min_001_percent_relative_abundance_stacked_bars_fig` <- ggplot(data = `2023.04.30_melted_transposed_kraken2_all_possible_phyla_relative_abundance_subsampled_reads`[`2023.04.30_melted_transposed_kraken2_all_possible_phyla_relative_abundance_subsampled_reads`$variable %in% `tempor4_krak2_phyla`[`tempor4_krak2_phyla`$Summed.value >= 0.01,]$Phylum,], aes(x = SampleID, y = value, fill = variable)) + geom_bar(position="stack", stat = "identity") + theme_classic() + theme(text = element_text(family = "Tex Gyre Heroes"), axis.text.x=element_text(angle = -90, hjust = 0)) + facet_wrap(~ Host.x.month, scales = "free_x") + xlab("Sample ID") + scale_fill_manual(name = "Phylum",values= c("#8a795d", "#0f0f0f", "#d6dadd", "#8d1eff", "#ed872d", "#00ced1")) + ylab("Reads classified (%)")

ggsave(filename = "2023-05-01_Kraken2_all_processed_reads_050_conf_phyla_summed_min_001_percent_relative_abundance_stacked_bars_fig.pdf",`2023-05-01_Kraken2_all_processed_reads_050_conf_phyla_summed_min_001_percent_relative_abundance_stacked_bars_fig`)

#Now the same for the genera, in this case might do the ten highest summed relative abundances for genus
`2023.04.30_kraken2_all_possible_genera_relative_abundance_subsampled_reads` <- read.delim("~/Google Drive/PhD/2022-Paper_2-Chapter_3/2023-04-30_kraken2_all_possible_genera_relative_abundance_subsampled_reads.tsv")
view(`2023.04.30_kraken2_all_possible_genera_relative_abundance_subsampled_reads`)
`2023.04.30_transposed_kraken2_all_possible_genera_relative_abundance_subsampled_reads` <- setNames(data.frame(t(`2023.04.30_kraken2_all_possible_genera_relative_abundance_subsampled_reads`[,-1])), `2023.04.30_kraken2_all_possible_genera_relative_abundance_subsampled_reads`[,1])
`2023.04.30_transposed_kraken2_all_possible_genera_relative_abundance_subsampled_reads`[] <- lapply(`2023.04.30_transposed_kraken2_all_possible_genera_relative_abundance_subsampled_reads`, type.convert, as.is = TRUE)
`2023.04.30_transposed_kraken2_all_possible_genera_relative_abundance_subsampled_reads`$SampleID <- row.names(`2023.04.30_transposed_kraken2_all_possible_genera_relative_abundance_subsampled_reads`)
`2023.04.30_melted_transposed_kraken2_all_possible_genera_relative_abundance_subsampled_reads` <- reshape2::melt(`2023.04.30_transposed_kraken2_all_possible_genera_relative_abundance_subsampled_reads`, id = c("SampleID", "Host", "Month", "Host.x.month"))

`tempor4_krak2_genera` <- data.frame(matrix(ncol = 2, nrow = 0, dimnames = list(NULL, c("Genus", "Summed.value"))))
for (reference in as.list(unique(`2023.04.30_melted_transposed_kraken2_all_possible_genera_relative_abundance_subsampled_reads`$variable))) {
    Genus.zoot <- paste(reference)
    summed.zoot <- sum(`2023.04.30_melted_transposed_kraken2_all_possible_genera_relative_abundance_subsampled_reads`[`2023.04.30_melted_transposed_kraken2_all_possible_genera_relative_abundance_subsampled_reads`$variable == Genus.zoot,]$value)
    `tempor4_krak2_genera`[nrow(`tempor4_krak2_genera`) +1,] <- c(Genus.zoot, summed.zoot)
    `tempor4_krak2_genera`[,c(2)] <- sapply(`tempor4_krak2_genera`[,c(2)], as.numeric)
    rm(list=ls(pattern='*zoot'))
}
view(`tempor4_krak2_genera`)

head(`tempor4_krak2_genera` %>% filter(Summed.value >= 0.01) %>% arrange(desc(Summed.value)), 10)$Genus

`2023-05-01_Kraken2_all_processed_reads_050_conf_genera_summed_min_001_percent_relative_abundance_stacked_bars_fig` <- ggplot(data = `2023.04.30_melted_transposed_kraken2_all_possible_genera_relative_abundance_subsampled_reads`[`2023.04.30_melted_transposed_kraken2_all_possible_genera_relative_abundance_subsampled_reads`$variable %in% head(`tempor4_krak2_genera` %>% filter(Summed.value >= 0.01) %>% arrange(desc(Summed.value)), 10)$Genus,], aes(x = SampleID, y = value, fill = variable)) + geom_bar(position="stack", stat = "identity") + theme_classic() + theme(text = element_text(family = "Tex Gyre Heroes"), axis.text.x=element_text(angle = -90, hjust = 0)) + facet_wrap(~ Host.x.month, scales = "free_x") + xlab("Sample ID") + scale_fill_manual(name = "Genus",values=as.vector(kelly(10))) + ylab("Reads classified (%)")

ggsave(filename = "2023-05-01_Kraken2_all_processed_reads_050_conf_genera_summed_min_001_percent_relative_abundance_stacked_bars_fig.pdf",`2023-05-01_Kraken2_all_processed_reads_050_conf_genera_summed_min_001_percent_relative_abundance_stacked_bars_fig`)

#Will also make a supplemental figure which will have the largest 20 of the 41 genera with a >=0.01% summed percentage reads classified giving the range of relative abundances using box and violoin plots for each host x month combo
`2023-05-01_kraken2_050_conf_all_processed_biggest_20_genera_min_summed_reads_classified_001_percent_violin_plots_fig` <- ggplot(data = `2023.04.30_melted_transposed_kraken2_all_possible_genera_relative_abundance_subsampled_reads`[`2023.04.30_melted_transposed_kraken2_all_possible_genera_relative_abundance_subsampled_reads`$variable %in% head(`tempor4_krak2_genera` %>% filter(Summed.value >= 0.01) %>% arrange(desc(Summed.value)), 20)$Genus,], aes(x = Host.x.month, y = value, fill = Host.x.month)) + geom_violin(alpha = 1, width = 1) + scale_fill_manual(name = "Host species and\ncollection month", values = c("ACJ" = "#1ec8ff", "ACN" = "#006ad1", "ARJ" = "#ff551e", "ARN" = "#d16700")) + facet_wrap(~ variable, scales = "free") + theme_classic() + xlab("Host species and\ncollection month") + ylab("Reads classified (%)") + theme(strip.text=element_text(size=7)) + theme(text = element_text(family = "Tex Gyre Heroes"), axis.text.x=element_blank(), axis.ticks.x = element_blank())

ggsave(filename = "2023-05-01_kraken2_050_conf_all_processed_biggest_20_genera_min_summed_reads_classified_001_percent_violin_plots_fig.pdf",`2023-05-01_kraken2_050_conf_all_processed_biggest_20_genera_min_summed_reads_classified_001_percent_violin_plots_fig`)

#Now doing the two figures for the differential taxa according to Kraken 2 for the two host species by sampling month
temp_df$Taxon = gsub("[.]", " ", temp_df$Taxon)
`2023-05-01_kraken2_050_conf_log_change_taxa_within_AC_dataframe` <- temp_df
`2023-05-01_kraken2_50_percent_min_conf_all_subsampled_reads_geometric_means_percentage_classified_reads_AC_only_log2_plus_one_change_June_to_November` <- ggplot(data = temp_df, aes(x = Log2.plus.one.fold.change.ACJ.to.ACN, y = reorder(Taxon, -Log2.plus.one.fold.change.ACJ.to.ACN), fill = ifelse(Log2.plus.one.fold.change.ACJ.to.ACN < 0, 'red', 'black'))) + geom_col() + theme_classic() + ylab("Taxon") + xlab("") + scale_fill_manual(values = c("#006ad1" ,"#1ec8ff"), name = "Month enriched", labels = c("November", "June")) + theme(text = element_text(family = "Tex Gyre Heroes"))

`kraken_050_taxa_species_X_season_geometric_means`$Taxon = gsub("[.]", " ", `kraken_050_taxa_species_X_season_geometric_means`$Taxon)
`2023-05-01_kraken2_050_conf_log_change_taxa_within_AR_dataframe` <- `kraken_050_taxa_species_X_season_geometric_means`

`2023-05-01_kraken2_50_percent_min_conf_all_subsampled_reads_geometric_means_percentage_classified_reads_AR_only_log2_plus_one_change_June_to_November` <- ggplot(`kraken_050_taxa_species_X_season_geometric_means`[!is.infinite(`kraken_050_taxa_species_X_season_geometric_means`$Log2.plus.one.fold.change.ARJ.to.ARN) & !is.na(`kraken_050_taxa_species_X_season_geometric_means`$Log2.plus.one.fold.change.ARJ.to.ARN),], aes(x = Log2.plus.one.fold.change.ARJ.to.ARN, y = reorder(Taxon, -Log2.plus.one.fold.change.ARJ.to.ARN), fill = ifelse(Log2.plus.one.fold.change.ARJ.to.ARN < 0, 'red', 'black'))) + geom_col() + theme_classic() + ylab("Taxon") + xlab("Log2()+1 change in geometric mean percentage reads\nassigned from June to November") + scale_fill_manual(values = c("#d16700", "#ff551e"), name = "Month enriched", labels = c("November", "June")) + theme(text = element_text(family = "Tex Gyre Heroes"))

#Actually will make one, combo figure so have edited the individual figure producing commands to remove the x axis title from the AC figure
`2023-05-01_kraken2_50_percent_min_conf_all_subsampled_reads_geometric_means_percentage_classified_reads_both_species_combo_figure_log2_plus_one_change_June_to_November` <- `2023-05-01_kraken2_50_percent_min_conf_all_subsampled_reads_geometric_means_percentage_classified_reads_AC_only_log2_plus_one_change_June_to_November` / `2023-05-01_kraken2_50_percent_min_conf_all_subsampled_reads_geometric_means_percentage_classified_reads_AR_only_log2_plus_one_change_June_to_November` + plot_annotation(tag_levels = 'A')

ggsave(filename = "2023-05-01_kraken2_50_percent_min_conf_all_subsampled_reads_geometric_means_percentage_classified_reads_both_species_combo_figure_log2_plus_one_change_June_to_November.pdf",`2023-05-01_kraken2_50_percent_min_conf_all_subsampled_reads_geometric_means_percentage_classified_reads_both_species_combo_figure_log2_plus_one_change_June_to_November`)

#Now redoing the Kaiju figures and making the phylum and genus level stacked bar charts for the 0 error results.
#Phylum level stacked bar first
`2023.05.01_kaiju_0_error_all_possible_phyla_relative_abundance_subsampled_reads` <- read.delim("~/Google Drive/PhD/2022-Paper_2-Chapter_3/2023-05-01_kaiju_0_error_all_possible_phyla_relative_abundance_subsampled_reads.tsv")
`2023.05.01_transposed_kaiju_0_error_all_possible_phyla_relative_abundance_subsampled_reads` <- setNames(data.frame(t(`2023.05.01_kaiju_0_error_all_possible_phyla_relative_abundance_subsampled_reads`[,-1])), `2023.05.01_kaiju_0_error_all_possible_phyla_relative_abundance_subsampled_reads`[,1])
`2023.05.01_transposed_kaiju_0_error_all_possible_phyla_relative_abundance_subsampled_reads`[] <- lapply(`2023.05.01_transposed_kaiju_0_error_all_possible_phyla_relative_abundance_subsampled_reads`, type.convert, as.is = TRUE)
`2023.05.01_transposed_kaiju_0_error_all_possible_phyla_relative_abundance_subsampled_reads`$SampleID <- row.names(`2023.05.01_transposed_kaiju_0_error_all_possible_phyla_relative_abundance_subsampled_reads`)
`2023.05.01_melted_transposed_kaiju_0_error_all_possible_phyla_relative_abundance_subsampled_reads` <- reshape2::melt(`2023.05.01_transposed_kaiju_0_error_all_possible_phyla_relative_abundance_subsampled_reads`, id = c("SampleID", "Host", "Month", "Host.x.month"))
view(`2023.05.01_melted_transposed_kaiju_0_error_all_possible_phyla_relative_abundance_subsampled_reads`)

#Making a dataframe of the summed percentages for all the phyla to use for picking which ones to show results for
tic()
`tempor4_kaiju_phyla` <- data.frame(matrix(ncol = 2, nrow = 0, dimnames = list(NULL, c("Phylum", "Summed.value"))))
for (reference in as.list(unique(`2023.05.01_melted_transposed_kaiju_0_error_all_possible_phyla_relative_abundance_subsampled_reads`$variable))) {
    phylum.zoot <- paste(reference)
    summed.zoot <- sum(`2023.05.01_melted_transposed_kaiju_0_error_all_possible_phyla_relative_abundance_subsampled_reads`[`2023.05.01_melted_transposed_kaiju_0_error_all_possible_phyla_relative_abundance_subsampled_reads`$variable == phylum.zoot,]$value)
    `tempor4_kaiju_phyla`[nrow(`tempor4_kaiju_phyla`) +1,] <- c(phylum.zoot, summed.zoot)
    `tempor4_kaiju_phyla`[,c(2)] <- sapply(`tempor4_kaiju_phyla`[,c(2)], as.numeric)
    rm(list=ls(pattern='*zoot'))
}
view(`tempor4_kaiju_phyla`)
toc()

`2023-05-01_kaiju_all_processed_reads_0_errors_phyla_summed_min_1_percent_relative_abundance_top_10_stacked_bars_fig` <- ggplot(data = `2023.05.01_melted_transposed_kaiju_0_error_all_possible_phyla_relative_abundance_subsampled_reads`[`2023.05.01_melted_transposed_kaiju_0_error_all_possible_phyla_relative_abundance_subsampled_reads`$variable %in% head(`tempor4_kaiju_phyla` %>% filter(Summed.value >= 1) %>% arrange(desc(Summed.value)), 10)$Phylum,], aes(x = SampleID, y = value, fill = variable)) + geom_bar(position="stack", stat = "identity") + theme_classic() + theme(text = element_text(family = "Tex Gyre Heroes"), axis.text.x=element_text(angle = -90, hjust = 0)) + facet_wrap(~ Host.x.month, scales = "free_x") + xlab("Sample ID") + scale_fill_manual(name = "Phylum",values=as.vector(kelly(10))) + ylab("Reads classified (%)")

ggsave(filename = "2023-05-01_kaiju_all_processed_reads_0_errors_phyla_summed_min_1_percent_relative_abundance_top_10_stacked_bars_fig.pdf",`2023-05-01_kaiju_all_processed_reads_0_errors_phyla_summed_min_1_percent_relative_abundance_top_10_stacked_bars_fig`)

#Making the remade log2+1 geometric mean change figure for the kaiju taxa for both species
`2023-05-01_kaiju_0_errors_genus_level_log2_plus_one_change_geometric_means_ACJ_to_ACN_greater_0_point_75_positive_or_negative_bar_plot` <- ggplot(data = `all_host.x.season_combos_larger_than_0_kaiju_subsampled_genus_level_0_errors_species_X_season_geometric_means`[is.finite(`all_host.x.season_combos_larger_than_0_kaiju_subsampled_genus_level_0_errors_species_X_season_geometric_means`$Log2.plus.one.fold.change.ACJ.to.ACN),] %>% filter(Log2.plus.one.fold.change.ACJ.to.ACN > 0.75 | Log2.plus.one.fold.change.ACJ.to.ACN < -0.75), aes(x = Log2.plus.one.fold.change.ACJ.to.ACN, y = reorder(Genus, -Log2.plus.one.fold.change.ACJ.to.ACN), fill = ifelse(Log2.plus.one.fold.change.ACJ.to.ACN < 0, 'red', 'black'))) + geom_col() + theme_classic() + ylab("Genus") + xlab("") + scale_fill_manual(values = c("#006ad1", "#1ec8ff"), name = "Month enriched", labels = c("November", "June")) + theme(text = element_text(family = "Tex Gyre Heroes"))

`2023-05-01_kaiju_0_errors_genus_level_log2_plus_one_change_geometric_means_ARJ_to_ARN_greater_0_point_75_positive_or_negative_bar_plot` <- ggplot(`all_host.x.season_combos_larger_than_0_kaiju_subsampled_genus_level_0_errors_species_X_season_geometric_means`[!is.infinite(`all_host.x.season_combos_larger_than_0_kaiju_subsampled_genus_level_0_errors_species_X_season_geometric_means`$Log2.plus.one.fold.change.ARJ.to.ARN) & !is.na(`all_host.x.season_combos_larger_than_0_kaiju_subsampled_genus_level_0_errors_species_X_season_geometric_means`$Log2.plus.one.fold.change.ARJ.to.ARN) & (`all_host.x.season_combos_larger_than_0_kaiju_subsampled_genus_level_0_errors_species_X_season_geometric_means`$Log2.plus.one.fold.change.ARJ.to.ARN > 0.75 | `all_host.x.season_combos_larger_than_0_kaiju_subsampled_genus_level_0_errors_species_X_season_geometric_means`$Log2.plus.one.fold.change.ARJ.to.ARN < -0.75),], aes(x = Log2.plus.one.fold.change.ARJ.to.ARN, y = reorder(Genus, -Log2.plus.one.fold.change.ARJ.to.ARN), fill = ifelse(Log2.plus.one.fold.change.ARJ.to.ARN < 0, 'red', 'black'))) + geom_col() + theme_classic() + ylab("Genus") + xlab("Log2()+1 change in geometric mean percentage reads\nassigned from June to November") + scale_fill_manual(values = c("#d16700", "#ff551e"), name = "Month enriched", labels = c("November", "June")) + theme(text = element_text(family = "Tex Gyre Heroes"))

`2023-05-01_kaiju_0_errors_genus_level_log2_plus_one_change_geometric_means_June_to_November_both_species_combined_barcharts_fig` <- `2023-05-01_kaiju_0_errors_genus_level_log2_plus_one_change_geometric_means_ACJ_to_ACN_greater_0_point_75_positive_or_negative_bar_plot` / `2023-05-01_kaiju_0_errors_genus_level_log2_plus_one_change_geometric_means_ARJ_to_ARN_greater_0_point_75_positive_or_negative_bar_plot` + plot_annotation(tag_levels = 'A')

ggsave(filename = "2023-05-01_kaiju_0_errors_genus_level_log2_plus_one_change_geometric_means_June_to_November_both_species_combined_barcharts_fig.pdf",`2023-05-01_kaiju_0_errors_genus_level_log2_plus_one_change_geometric_means_June_to_November_both_species_combined_barcharts_fig`)

#Now the genus level stacked bar chart
`2023.05.01_kaiju_0_error_all_possible_genera_relative_abundance_subsampled_reads` <- read.delim("~/Google Drive/PhD/2022-Paper_2-Chapter_3/2023-05-01_kaiju_0_error_all_possible_genera_relative_abundance_subsampled_reads.tsv")
`2023.05.01_transposed_kaiju_0_error_all_possible_genera_relative_abundance_subsampled_reads` <- setNames(data.frame(t(`2023.05.01_kaiju_0_error_all_possible_genera_relative_abundance_subsampled_reads`[,-1])), `2023.05.01_kaiju_0_error_all_possible_genera_relative_abundance_subsampled_reads`[,1])
`2023.05.01_transposed_kaiju_0_error_all_possible_genera_relative_abundance_subsampled_reads`[] <- lapply(`2023.05.01_transposed_kaiju_0_error_all_possible_genera_relative_abundance_subsampled_reads`, type.convert, as.is = TRUE)
`2023.05.01_transposed_kaiju_0_error_all_possible_genera_relative_abundance_subsampled_reads`$SampleID <- row.names(`2023.05.01_transposed_kaiju_0_error_all_possible_genera_relative_abundance_subsampled_reads`)
`2023.05.01_melted_transposed_kaiju_0_error_all_possible_genera_relative_abundance_subsampled_reads` <- reshape2::melt(`2023.05.01_transposed_kaiju_0_error_all_possible_genera_relative_abundance_subsampled_reads`, id = c("SampleID", "Host", "Month", "Host.x.month"))
view(`2023.05.01_melted_transposed_kaiju_0_error_all_possible_genera_relative_abundance_subsampled_reads`)

tic()
`tempor4_kaiju_genera` <- data.frame(matrix(ncol = 2, nrow = 0, dimnames = list(NULL, c("Genus", "Summed.value"))))
for (reference in as.list(unique(`2023.05.01_melted_transposed_kaiju_0_error_all_possible_genera_relative_abundance_subsampled_reads`$variable))) {
    phylum.zoot <- paste(reference)
    summed.zoot <- sum(`2023.05.01_melted_transposed_kaiju_0_error_all_possible_genera_relative_abundance_subsampled_reads`[`2023.05.01_melted_transposed_kaiju_0_error_all_possible_genera_relative_abundance_subsampled_reads`$variable == phylum.zoot,]$value)
    `tempor4_kaiju_genera`[nrow(`tempor4_kaiju_genera`) +1,] <- c(phylum.zoot, summed.zoot)
    `tempor4_kaiju_genera`[,c(2)] <- sapply(`tempor4_kaiju_genera`[,c(2)], as.numeric)
    rm(list=ls(pattern='*zoot'))
}
view(`tempor4_kaiju_genera`)
toc()

`2023-05-01_kaiju_all_processed_reads_0_errors_genera_summed_min_1_percent_relative_abundance_top_10_stacked_bars_fig` <- ggplot(data = `2023.05.01_melted_transposed_kaiju_0_error_all_possible_genera_relative_abundance_subsampled_reads`[`2023.05.01_melted_transposed_kaiju_0_error_all_possible_genera_relative_abundance_subsampled_reads`$variable %in% head(`tempor4_kaiju_genera` %>% filter(Summed.value >= 1) %>% arrange(desc(Summed.value)), 10)$Genus,], aes(x = SampleID, y = value, fill = variable)) + geom_bar(position="stack", stat = "identity") + theme_classic() + theme(text = element_text(family = "Tex Gyre Heroes"), axis.text.x=element_text(angle = -90, hjust = 0)) + facet_wrap(~ Host.x.month, scales = "free_x") + xlab("Sample ID") + scale_fill_manual(name = "Genus",values=as.vector(kelly(11))) + ylab("Reads classified (%)")

ggsave(filename = "2023-05-02_kaiju_all_processed_reads_0_errors_genera_summed_min_1_percent_relative_abundance_top_10_stacked_bars_fig.pdf",`2023-05-01_kaiju_all_processed_reads_0_errors_genera_summed_min_1_percent_relative_abundance_top_10_stacked_bars_fig`)

#Supplemental figure of the percentage reads classified for the 20 most abundant genera by Kaiju for host and month combinations
`2023-05-02_kaiju_0_errors_allowed_all_processed_biggest_20_genera_min_summed_reads_classified_001_percent_violin_plots_fig` <- ggplot(data = `2023.05.01_melted_transposed_kaiju_0_error_all_possible_genera_relative_abundance_subsampled_reads`[`2023.05.01_melted_transposed_kaiju_0_error_all_possible_genera_relative_abundance_subsampled_reads`$variable %in% head(`tempor4_kaiju_genera` %>% filter(Summed.value >= 1) %>% arrange(desc(Summed.value)), 20)$Genus,],aes(x = Host.x.month, y = value, fill = Host.x.month)) + geom_violin(alpha = 1, width = 1) + scale_fill_manual(name = "Host species and\ncollection month", values = c("ACJ" = "#1ec8ff", "ACN" = "#006ad1", "ARJ" = "#ff551e", "ARN" = "#d16700")) + facet_wrap(~ variable, scales = "free") + theme_classic() + xlab("Host species and\ncollection month") + ylab("Reads classified (%)") + theme(strip.text=element_text(size=8)) + theme(text = element_text(family = "Tex Gyre Heroes"), axis.text.x=element_blank(), axis.ticks.x = element_blank())

ggsave(filename = "2023-05-02_kaiju_0_errors_allowed_all_processed_biggest_20_genera_min_summed_reads_classified_001_percent_violin_plots_fig.pdf",`2023-05-02_kaiju_0_errors_allowed_all_processed_biggest_20_genera_min_summed_reads_classified_001_percent_violin_plots_fig`)

#Now making the bins QC figure as a pdf and without the linedraw theme, this time will only make the figure with the completeness and contamination for the axes instead of doing three different ones.
`2023-05-02_checkm_bins_completeness_against_contamination_figure` <- ggplot(data = `2022.04.10_CheckM_output_all_bins`, aes(x = Completeness, y = Contamination, colour = ifelse(Completeness > 80 & Contamination < 5, 'black', 'red'))) + geom_jitter() + theme_classic() + theme(text = element_text(family = "Tex Gyre Heroes", size = 14)) + xlab("Completeness (%)") + ylab("Contamination (%)") + geom_vline(xintercept=c(80), col="#1e90ff", linetype = "dashed", size = 1.35) + geom_hline(yintercept=c(5), col="#ff8d1e", linetype = "dashed", size = 1.35) + theme(legend.position = "none") + scale_colour_manual(values = c("#0f0f0f", "#adb4ba"))

ggsave(filename = "2023-05-02_checkm_bins_completeness_against_contamination_figure.pdf",`2023-05-02_checkm_bins_completeness_against_contamination_figure`)

#Now the bins to genera bar chart figure
`2023-05-02_gtdb-tk_strict_bins_genera_7_most_abundant_bar_chart_fig` <- ggplot(data = temp_bins_genus_top_7_and_other_strict_bins_count, aes(x = Genus, y = Bins, fill = Genus)) + geom_bar(stat = "identity", colour = 'black') + scale_fill_manual(values=as.vector(kelly(8))) + theme(text = element_text(family = "Tex Gyre Heroes", size = 14)) + guides(fill = guide_legend(title = "Genera")) + theme_classic() + theme(axis.text.x = element_blank(), axis.ticks.x = element_blank()) + theme(legend.position = "left")

ggsave(filename = "2023-05-02_gtdb-tk_strict_bins_genera_7_most_abundant_bar_chart_fig.pdf",`2023-05-02_gtdb-tk_strict_bins_genera_7_most_abundant_bar_chart_fig`)

#2023-05-03
#Mapping figures, first the subsampling depth to percentage reads mapping figure
`2023-05-03_melted_samtools_flagstats_mapping_percentage_from_BAM_files_merged_contigs_subsampled_read_file_mapping_box_and_violin_plot` <- ggplot(data = `2022.11.10_melted_samtools_flagstats_mapping_percentage_from_BAM_files_merged_contigs_subsampled_read_file_mapping`, aes(x = Species.x.season, y = value, fill = Species.x.season)) + geom_violin() + geom_boxplot(fill = "#e4e6e8", alpha = 0.6, width = 0.15) + xlab("Host species and sample month") + ylab("Mapping reads (%)") + scale_fill_manual(values = c("#1ec8ff", "#006ad1", "#ff551e", "#d16700")) + facet_wrap(~ Sequencing) + guides(fill = guide_legend(title = "Host species and sampling month")) + theme_classic() + theme(strip.text.x = element_text(size = 15), text = element_text(family = "Tex Gyre Heroes"))

ggsave(filename = "2023-05-03_melted_samtools_flagstats_mapping_percentage_from_BAM_files_merged_contigs_subsampled_read_file_mapping_box_and_violin_plot.pdf",`2023-05-03_melted_samtools_flagstats_mapping_percentage_from_BAM_files_merged_contigs_subsampled_read_file_mapping_box_and_violin_plot`)

#Now the PCA plots for the novogene paired mappings, just the three biplots and skip the components one
`2023-05-03_PCA_biplot_novogene_paired_subsampled_salmon_mapping_bins_reference_PC1_vs_PC2_fig` <- ggbiplot::ggbiplot(`2022-09-14_PCA_only_novogene_paired_subsampled_reads_mapped_all_strict_bins_Salmon_TPMs_GC_and_bias_flagged`, choices = c(1,2), obs.scale = 1, var.scale = 1, ellipse = TRUE, groups = `2022-09-14_only_novogene_paired_subsampled_reads_mapped_all_strict_bins_Salmon_TPMs_GC_and_bias_flagged`$Species, ellipse.prob = 0.75, circle = TRUE, var.axes = FALSE, plot.loadings = TRUE) + theme_classic() + geom_point(aes(shape=factor(`2022-09-14_only_novogene_paired_subsampled_reads_mapped_all_strict_bins_Salmon_TPMs_GC_and_bias_flagged`$Season), color=factor(`2022-09-14_only_novogene_paired_subsampled_reads_mapped_all_strict_bins_Salmon_TPMs_GC_and_bias_flagged`$Species)), size = 4) + scale_color_manual(values = c("AC" = '#1e90ff', "AR" = '#ff8d1e')) + scale_shape_manual(values = c("J" = 17, "N" = 16)) + labs(shape="Month of collection", colour="Host species") + scale_x_continuous(labels = comma) + scale_y_continuous(labels = comma) + theme_classic() + theme(text = element_text(family = "Tex Gyre Heroes")) + theme(legend.position = "none")

`2023-05-03_PCA_biplot_novogene_paired_subsampled_salmon_mapping_bins_reference_PC1_vs_PC3_fig` <- ggbiplot::ggbiplot(`2022-09-14_PCA_only_novogene_paired_subsampled_reads_mapped_all_strict_bins_Salmon_TPMs_GC_and_bias_flagged`, choices = c(1,3), obs.scale = 1, var.scale = 1, ellipse = TRUE, groups = `2022-09-14_only_novogene_paired_subsampled_reads_mapped_all_strict_bins_Salmon_TPMs_GC_and_bias_flagged`$Species, ellipse.prob = 0.75, circle = TRUE, var.axes = FALSE, plot.loadings = TRUE) + theme_classic() + geom_point(aes(shape=factor(`2022-09-14_only_novogene_paired_subsampled_reads_mapped_all_strict_bins_Salmon_TPMs_GC_and_bias_flagged`$Season), color=factor(`2022-09-14_only_novogene_paired_subsampled_reads_mapped_all_strict_bins_Salmon_TPMs_GC_and_bias_flagged`$Species)), size = 4) + scale_color_manual(values = c("AC" = '#1e90ff', "AR" = '#ff8d1e')) + scale_shape_manual(values = c("J" = 17, "N" = 16)) + labs(shape="Month of collection", colour="Host species") + scale_x_continuous(labels = comma) + scale_y_continuous(labels = comma) + theme_classic() + theme(text = element_text(family = "Tex Gyre Heroes")) + theme(legend.position = "none")

`2023-05-03_PCA_biplot_novogene_paired_subsampled_salmon_mapping_bins_reference_PC2_vs_PC3_fig` <- ggbiplot::ggbiplot(`2022-09-14_PCA_only_novogene_paired_subsampled_reads_mapped_all_strict_bins_Salmon_TPMs_GC_and_bias_flagged`, choices = c(2,3), obs.scale = 1, var.scale = 1, ellipse = TRUE, groups = `2022-09-14_only_novogene_paired_subsampled_reads_mapped_all_strict_bins_Salmon_TPMs_GC_and_bias_flagged`$Species, ellipse.prob = 0.75, circle = TRUE, var.axes = FALSE, plot.loadings = TRUE) + theme_classic() + geom_point(aes(shape=factor(`2022-09-14_only_novogene_paired_subsampled_reads_mapped_all_strict_bins_Salmon_TPMs_GC_and_bias_flagged`$Season), color=factor(`2022-09-14_only_novogene_paired_subsampled_reads_mapped_all_strict_bins_Salmon_TPMs_GC_and_bias_flagged`$Species)), size = 4) + scale_color_manual(values = c("AC" = '#1e90ff', "AR" = '#ff8d1e')) + scale_shape_manual(values = c("J" = 17, "N" = 16)) + labs(shape="Month of collection", colour="Host species") + scale_x_continuous(labels = comma) + scale_y_continuous(labels = comma) + theme_classic() + theme(text = element_text(family = "Tex Gyre Heroes"))

`2023-05-03_PCA_biplot_novogene_paired_subsampled_salmon_mapping_bins_reference_combined_multiple_PCs_fig` <- `2023-05-03_PCA_biplot_novogene_paired_subsampled_salmon_mapping_bins_reference_PC1_vs_PC2_fig` + `2023-05-03_PCA_biplot_novogene_paired_subsampled_salmon_mapping_bins_reference_PC1_vs_PC3_fig` + `2023-05-03_PCA_biplot_novogene_paired_subsampled_salmon_mapping_bins_reference_PC2_vs_PC3_fig` + plot_annotation(tag_levels = 'A')

ggsave(filename = "2023-05-03_PCA_biplot_novogene_paired_subsampled_salmon_mapping_bins_reference_combined_multiple_PCs_fig.pdf",`2023-05-03_PCA_biplot_novogene_paired_subsampled_salmon_mapping_bins_reference_combined_multiple_PCs_fig`)

ggsave(filename = "2023-05-03_PCA_biplot_novogene_paired_subsampled_salmon_mapping_bins_reference_combined_multiple_PCs_fig.svg",`2023-05-03_PCA_biplot_novogene_paired_subsampled_salmon_mapping_bins_reference_combined_multiple_PCs_fig`)

#Now the two within species significance bin mapping figures, AC one first
`2023-05-03_within_AC_seasonal_change_novogene_paired_mapping_strict_bins_Salmon_RPMs_GC_and_seq_bias_flagged_fold_change_corrected_pvalue_figure` <- ggplot(data = `2022-0-23_AC_seasonal_raw_pvalue_SORTED`, aes(x = log2.add.one.AC.seasonal.fold.change, y = -log10(Sorted_BH_corrected_pvalues), label = Bin, colour = ifelse((log2.add.one.AC.seasonal.fold.change > 1 & -log10(Sorted_BH_corrected_pvalues) > -log10(0.05)) | (log2.add.one.AC.seasonal.fold.change < -1 & -log10(Sorted_BH_corrected_pvalues) > -log10(0.05)), 'black', 'red'))) + geom_point() + theme_classic() + geom_vline(xintercept=c(-1, 1), col="#c80815") + geom_hline(yintercept=(-log10(0.05)), col="#c80815") + ggtitle("Within AC seasonal change in bin mapping") + ylab("-Log10 BH Corrected P-values") + xlab("log2()+1 fold change of geometric means per bin") + geom_vline(xintercept=c(-0.5, 0.5), col="#c82b08", linetype = "dashed") + scale_colour_manual(values = c("#1e90ff", "#b5b5b3")) + theme(text = element_text(size = 14)) + geom_label_repel(aes(label = ifelse((log2.add.one.AC.seasonal.fold.change > 1 & -log10(Sorted_BH_corrected_pvalues) > -log10(0.05)) | (log2.add.one.AC.seasonal.fold.change < -1 & -log10(Sorted_BH_corrected_pvalues) > -log10(0.05)), as.character(Bin), ''), hjust = 0, vjust = 0), colour = "#004385", min.segment.length = 0) + theme(text = element_text(family = "Tex Gyre Heroes")) + theme(legend.position = "none")

ggsave(filename = "2023-05-03_within_AC_seasonal_change_novogene_paired_mapping_strict_bins_Salmon_RPMs_GC_and_seq_bias_flagged_fold_change_corrected_pvalue_figure.pdf",`2023-05-03_within_AC_seasonal_change_novogene_paired_mapping_strict_bins_Salmon_RPMs_GC_and_seq_bias_flagged_fold_change_corrected_pvalue_figure`)

`2023-05-03_within_AR_seasonal_change_novogene_paired_mapping_strict_bins_Salmon_RPMs_GC_and_seq_bias_flagged_fold_change_corrected_pvalue_figure` <- ggplot(data = `2022-0-23_AR_seasonal_raw_pvalue_SORTED`, aes(x = log2.add.one.AR.seasonal.fold.change, y = -log10(Sorted_BH_corrected_pvalues), label = Bin, colour = ifelse((log2.add.one.AR.seasonal.fold.change > 1 & -log10(Sorted_BH_corrected_pvalues) > -log10(0.05)) | (log2.add.one.AR.seasonal.fold.change < -1 & -log10(Sorted_BH_corrected_pvalues) > -log10(0.05)), 'black', 'red'))) + geom_point() + theme_classic() + geom_vline(xintercept=c(-1, 1), col="#c80815") + geom_hline(yintercept=(-log10(0.05)), col="#c80815") + ggtitle("Within AR seasonal change in bin mapping") + ylab("-Log10 BH Corrected P-values") + xlab("log2()+1 fold change of geometric means per bin") + geom_vline(xintercept=c(-0.5, 0.5), col="#c82b08", linetype = "dashed") + scale_colour_manual(values = c("#ff8d1e", "#b5b5b3")) + theme(text = element_text(size = 14)) + geom_label_repel(aes(label = ifelse((log2.add.one.AR.seasonal.fold.change > 1 & -log10(Sorted_BH_corrected_pvalues) > -log10(0.05)) | (log2.add.one.AR.seasonal.fold.change < -1 & -log10(Sorted_BH_corrected_pvalues) > -log10(0.05)), as.character(Bin), ''), hjust = 0, vjust = 0), colour = "#9e4e00", min.segment.length = 0) + theme(text = element_text(family = "Tex Gyre Heroes")) + theme(legend.position = "none")

ggsave(filename = "2023-05-03_within_AR_seasonal_change_novogene_paired_mapping_strict_bins_Salmon_RPMs_GC_and_seq_bias_flagged_fold_change_corrected_pvalue_figure.pdf",`2023-05-03_within_AR_seasonal_change_novogene_paired_mapping_strict_bins_Salmon_RPMs_GC_and_seq_bias_flagged_fold_change_corrected_pvalue_figure`)

#Now the combined across species and across months figure
`2023-05-03_host_effect_significance_novogene_paired_only_Salmon_RPMs_mapping_to_bins` <- ggplot(data = `bin_geometric_means_novogene_paired_salmon_TPMs_strict_bin_single_contigs_and_corrected_pvalues_and_log2_add_one_fold_change`, aes(x = AC.to.AR.log2fold.add.one.change, y = -log10(Host.corrected.pvalue), colour = ifelse((AC.to.AR.log2fold.add.one.change > 1 & -log10(Host.corrected.pvalue) > -log10(0.05)) | (AC.to.AR.log2fold.add.one.change < -1 & -log10(Host.corrected.pvalue) > -log10(0.05)), 'black', 'red'))) + geom_point() + theme(text = element_text(family = "Tex Gyre Heroes")) + theme_classic() + geom_vline(xintercept=c(-1, 1), col="#c80815") + geom_hline(yintercept=(-log10(0.05)), col="#c80815") + ylab("-Log10 Q-values") + xlab("") + geom_vline(xintercept=c(-0.5, 0.5), col="#c82b08", linetype = "dashed") + scale_colour_manual(values = c("#0f0f0f", "#b5b5b3")) + theme(text = element_text(size = 14)) + theme(legend.position = "none")
`2023-05-03_month_effect_significance_novogene_paired_only_Salmon_RPMs_mapping_to_bins` <- ggplot(data = `bin_geometric_means_novogene_paired_salmon_TPMs_strict_bin_single_contigs_and_corrected_pvalues_and_log2_add_one_fold_change`, aes(x = June.to.November.log2fold.add.one.change, y = -log10(Season.corrected.pvalue), colour = ifelse((June.to.November.log2fold.add.one.change > 1 & -log10(Season.corrected.pvalue) > -log10(0.05)) | (June.to.November.log2fold.add.one.change < -1 & -log10(Season.corrected.pvalue) > -log10(0.05)), 'black', 'red'))) + geom_point() + theme(text = element_text(family = "Tex Gyre Heroes")) + theme_classic() + geom_vline(xintercept=c(-1, 1), col="#c80815") + geom_hline(yintercept=(-log10(0.05)), col="#c80815") + ylab("") + xlab("") + geom_vline(xintercept=c(-0.5, 0.5), col="#c82b08", linetype = "dashed") + scale_colour_manual(values = c("#b5b5b3", "#0f0f0f")) + theme(text = element_text(size = 14)) + theme(legend.position = "none")

`2023-05-03_host_and_month_effect_novogene_paired_only_Salmon_RPMs_mapping_strict_bins_Qvalue_and_fold_change_volcano_plots_figure` <- grid.arrange(patchworkGrob(`2023-05-03_host_effect_significance_novogene_paired_only_Salmon_RPMs_mapping_to_bins` + `2023-05-03_month_effect_significance_novogene_paired_only_Salmon_RPMs_mapping_to_bins` + plot_annotation(tag_levels = 'A')), bottom = "log2()+1 fold change of geometric means per bin")

ggsave(filename = "2023-05-03_host_and_month_effect_novogene_paired_only_Salmon_RPMs_mapping_strict_bins_Qvalue_and_fold_change_volcano_plots_figure.pdf",`2023-05-03_host_and_month_effect_novogene_paired_only_Salmon_RPMs_mapping_strict_bins_Qvalue_and_fold_change_volcano_plots_figure`)

#Now the old dutch flag figure for the mapping values for the families for the differentially abundant bins
`2023-05-03_subsampled_novogene_paired_reads_mapping_strict_bins_Salmon_RPMs_significant_families_old_dutch_flag_figure` <- ggplot(data = `2022_10_11_bin_geometric_means_novogene_paired_salmon_TPMs_strict_bin_single_contigs_and_corrected_pvalues_and_log2_add_one_fold_change_with_GTDB_TK_families_alone_in_last_field`[`2022_10_11_bin_geometric_means_novogene_paired_salmon_TPMs_strict_bin_single_contigs_and_corrected_pvalues_and_log2_add_one_fold_change_with_GTDB_TK_families_alone_in_last_field`$Host.corrected.pvalue < 0.05 & is.finite(`2022_10_11_bin_geometric_means_novogene_paired_salmon_TPMs_strict_bin_single_contigs_and_corrected_pvalues_and_log2_add_one_fold_change_with_GTDB_TK_families_alone_in_last_field`$AC.to.AR.log2fold.add.one.change), ], aes(x = GTDB.TK.family, y = AC.to.AR.log2fold.add.one.change, colour = ifelse((AC.to.AR.log2fold.add.one.change > 1 & -log10(Host.corrected.pvalue) > -log10(0.05)) | (AC.to.AR.log2fold.add.one.change < -1 & -log10(Host.corrected.pvalue) > -log10(0.05)), 'black', 'red'))) + scale_colour_manual(values = c("#0f0f0f", "#b5b5b3")) + ylab("Log2()+1 fold change of geometric means per bin") + facet_wrap(~ GTDB.TK.family, scales = "free_x") + theme_classic() + theme(text = element_text(family = "Tex Gyre Heroes"), strip.text = element_text(face = "italic")) + theme(legend.position = "none", axis.title.x=element_blank(), axis.text.x=element_blank(), axis.ticks.x=element_blank()) + annotate("rect", ymin = -1, ymax = -Inf, xmin = -Inf, xmax = Inf, colour = "white", fill = "#1e90ff", alpha = 0.25) + annotate("rect", ymin = 1, ymax = Inf, xmin = -Inf, xmax = Inf, colour = "white", fill = "#ff8d1e", alpha = 0.25) + geom_hline(yintercept=c(-1), col="#1e90ff") + geom_hline(yintercept=c(1), col="#ff8d1e") + geom_jitter()

ggsave(filename = "2023-05-03_subsampled_novogene_paired_reads_mapping_strict_bins_Salmon_RPMs_significant_families_old_dutch_flag_figure.pdf",`2023-05-03_subsampled_novogene_paired_reads_mapping_strict_bins_Salmon_RPMs_significant_families_old_dutch_flag_figure`)

#Now the horizontal box and violin plots for top 10 bins per host salmon RPMs
`2023_05_03_ten_most_AC_enriched_bins_all_tpms_plots_box_and_violin` <- ggplot(data = `only_novogene_paired_melted_good_tpms`[`only_novogene_paired_melted_good_tpms`$variable %in% `bin_geometric_means_novogene_paired_salmon_TPMs_strict_bin_single_contigs_and_corrected_pvalues_and_log2_add_one_fold_change`[`bin_geometric_means_novogene_paired_salmon_TPMs_strict_bin_single_contigs_and_corrected_pvalues_and_log2_add_one_fold_change`$Host.corrected.pvalue < 0.05 & `bin_geometric_means_novogene_paired_salmon_TPMs_strict_bin_single_contigs_and_corrected_pvalues_and_log2_add_one_fold_change`$AC.to.AR.log2fold.add.one.change < -2.84 & is.finite(`bin_geometric_means_novogene_paired_salmon_TPMs_strict_bin_single_contigs_and_corrected_pvalues_and_log2_add_one_fold_change`$AC.to.AR.log2fold.add.one.change),]$Bin, ], aes(x = value, y = Species, fill = Species, shape = Species)) + geom_violin(alpha = 0.85) + scale_fill_manual(values = c("#1e90ff", "#ff8d1e")) + scale_colour_manual(values = c ("#1e90ff", "#ff8d1e")) + theme(text = element_text(family = "Tex Gyre Heroes")) + theme_classic() + facet_wrap(~variable, strip.position="top") + scale_y_discrete(expand = expansion(mult = c(0.01, .425))) + theme(strip.text.x = element_text(size = 11, colour = "Black", face = "bold")) + theme(strip.background = element_rect(colour = "black", fill = "#f2f3f4")) + xlab("RPMs from mapping of\nsubsampled reads to concatenated Bins reference") + ylab("Host species") + geom_boxplot(fill = "#f2f3f4", width = 0.175, alpha = 0.75) + geom_jitter(width = 0.25, alpha = 0.75) + scale_x_continuous(trans = "log10", labels = comma, guide = guide_axis(n.dodge = 2)) + theme(text = element_text(size = 15))
ggsave(filename = "2023_05_03_ten_most_AC_enriched_bins_all_tpms_plots_box_and_violin.pdf", `2023_05_03_ten_most_AC_enriched_bins_all_tpms_plots_box_and_violin`)

`2023_05_03_ten_most_AR_enriched_bins_all_tpms_plots_box_and_violin` <- ggplot(data = `only_novogene_paired_melted_good_tpms`[`only_novogene_paired_melted_good_tpms`$variable %in% `bin_geometric_means_novogene_paired_salmon_TPMs_strict_bin_single_contigs_and_corrected_pvalues_and_log2_add_one_fold_change`[`bin_geometric_means_novogene_paired_salmon_TPMs_strict_bin_single_contigs_and_corrected_pvalues_and_log2_add_one_fold_change`$Host.corrected.pvalue < 0.05 & `bin_geometric_means_novogene_paired_salmon_TPMs_strict_bin_single_contigs_and_corrected_pvalues_and_log2_add_one_fold_change`$AC.to.AR.log2fold.add.one.change > 2.6 & is.finite(`bin_geometric_means_novogene_paired_salmon_TPMs_strict_bin_single_contigs_and_corrected_pvalues_and_log2_add_one_fold_change`$AC.to.AR.log2fold.add.one.change),]$Bin, ], aes(x = value, y = Species, fill = Species, shape = Species)) + geom_violin(alpha = 0.85) + scale_fill_manual(values = c("#1e90ff", "#ff8d1e")) + scale_colour_manual(values = c ("#1e90ff", "#ff8d1e")) + theme(text = element_text(family = "Tex Gyre Heroes")) + theme_classic() + facet_wrap(~variable, strip.position="top") + scale_y_discrete(expand = expansion(mult = c(0.01, .425))) + theme(strip.text.x = element_text(size = 11, colour = "Black", face = "bold")) + theme(strip.background = element_rect(colour = "black", fill = "#f2f3f4")) + xlab("RPMs from mapping of\nsubsampled reads to concatenated Bins reference") + ylab("Host species") + geom_boxplot(fill = "#f2f3f4", width = 0.175, alpha = 0.75) + geom_jitter(width = 0.25, alpha = 0.75) + scale_x_continuous(trans = "log10", labels = comma, guide = guide_axis(n.dodge = 2)) + theme(text = element_text(size = 15))
ggsave(filename = "2023_05_03_ten_most_AR_enriched_bins_all_tpms_plots_box_and_violin.pdf", `2023_05_03_ten_most_AR_enriched_bins_all_tpms_plots_box_and_violin`)

#2023-05-04
#Prokka annotations of strict bins, importing the COGs first
`2023.05.04_all_strict_bins_all_unique_COGs_Prokka_counts` <- read.delim("~/Google Drive/PhD/2022-Paper_2-Chapter_3/2023-05-04_all_strict_bins_all_unique_COGs_Prokka_counts.txt")
`2023.05.04_transposed_all_strict_bins_all_unique_COGs_Prokka_counts` <- setNames(data.frame(t(`2023.05.04_all_strict_bins_all_unique_COGs_Prokka_counts`[,-1])), `2023.05.04_all_strict_bins_all_unique_COGs_Prokka_counts`[,1])
`2023.05.04_transposed_all_strict_bins_all_unique_COGs_Prokka_counts`[] <- lapply(`2023.05.04_transposed_all_strict_bins_all_unique_COGs_Prokka_counts`, type.convert, as.is = TRUE)
`2023.05.04_transposed_all_strict_bins_all_unique_COGs_Prokka_counts`$COGs <- row.names(`2023.05.04_transposed_all_strict_bins_all_unique_COGs_Prokka_counts`)
`2023.05.04_melted_transposed_all_strict_bins_all_unique_COGs_Prokka_counts` <- reshape2::melt(`2023.05.04_transposed_all_strict_bins_all_unique_COGs_Prokka_counts`, id = c("COGs"))
view(`2023.05.04_melted_transposed_all_strict_bins_all_unique_COGs_Prokka_counts`)

#2023-05-05
#Continuing to do the work for the Prokka annotations of the strict bins, COGs first
#First a loop to get some basic stats, COG totals for all bins, COG mean and median for all bins, bin with most detections of a COG
tic()
`2023-05-05_prokka_strict_bins_annotation_COGs_simple_details` <- data.frame(matrix(ncol = 7, nrow = 0, dimnames = list(NULL, c("COG", "Summed.counts", "Mean.count", "Median.count", "Max.count", "Min.non-zero.count", "Bin.with.most"))))
`shortdf.delete` <- `2023.05.04_melted_transposed_all_strict_bins_all_unique_COGs_Prokka_counts`
for (coggle in as.list(unique(`shortdf.delete`$variable))) {
    coggle.zoot <- paste(coggle)
    summed.zoot <- sum(`shortdf.delete`[`shortdf.delete`$variable == coggle.zoot,]$value)
    mean.zoot <- mean(`shortdf.delete`[`shortdf.delete`$variable == coggle.zoot,]$value)
    median.zoot <- median(`shortdf.delete`[`shortdf.delete`$variable == coggle.zoot,]$value)
    max.zoot <- max(`shortdf.delete`[`shortdf.delete`$variable == coggle.zoot,]$value)
    min.zoot <- min(`shortdf.delete`[`shortdf.delete`$variable == coggle.zoot & `shortdf.delete`$value != 0,]$value)
    most.bin.zoot <- as.character(head(`shortdf.delete` %>% filter(variable == coggle.zoot) %>% arrange(desc(value)), 1)$COGs)
    `2023-05-05_prokka_strict_bins_annotation_COGs_simple_details`[nrow(`2023-05-05_prokka_strict_bins_annotation_COGs_simple_details`) +1,] <- c(coggle.zoot, summed.zoot, mean.zoot, median.zoot, max.zoot, min.zoot, most.bin.zoot)
    `2023-05-05_prokka_strict_bins_annotation_COGs_simple_details`[,c(2:6)] <- sapply(`2023-05-05_prokka_strict_bins_annotation_COGs_simple_details`[,c(2:6)], as.numeric)
    rm(list=ls(pattern='*zoot'))
}
rm(`shortdf.delete`)
view(`2023-05-05_prokka_strict_bins_annotation_COGs_simple_details`)
write.table(`2023-05-05_prokka_strict_bins_annotation_COGs_simple_details`, file = "2023-05-05_prokka_strict_bins_annotation_COGs_simple_details.csv", sep=",", row.names=FALSE)
toc()

as.numeric(nrow(as.data.frame(`2023-05-05_prokka_strict_bins_annotation_COGs_simple_details` %>% filter(Median.count == 0))))
`2023-05-05_prokka_strict_bins_COGS_bins_with_most_detections_each_bin_table` <- as.data.frame(table(`2023-05-05_prokka_strict_bins_annotation_COGs_simple_details`$Bin.with.most))
view(`2023-05-05_prokka_strict_bins_COGS_bins_with_most_detections_each_bin_table`)
`2023-05-05_prokka_strict_bins_COGs_number_COGs_bin_has_greatest_count_for_density_and_frequency_plot_figure` <- ggplot(data = `2023-05-05_prokka_strict_bins_COGS_bins_with_most_detections_each_bin_table`, aes(x = Freq)) + geom_histogram(aes(y=..density..), binwidth = 5,colour = "#0f0f0f", fill = "#a0a7ae") + geom_density(alpha = 0.35, fill = "#8d1eff") + xlab("Density") + ylab("Frequency") + theme_classic() + theme(text = element_text(family = "Tex Gyre Heroes"))

ggsave(filename = "2023-05-05_prokka_strict_bins_COGs_number_COGs_bin_has_greatest_count_for_density_and_frequency_plot_figure.pdf", `2023-05-05_prokka_strict_bins_COGs_number_COGs_bin_has_greatest_count_for_density_and_frequency_plot_figure`)

#Getting the bin enrichment status
tic()
`2023-05-05_bins_and_enrichment_status` <- data.frame(matrix(ncol = 2, nrow = 0, dimnames = list(NULL, c("Bin", "Enrichment.status"))))
for (binn in as.list(unique(`2023.05.04_melted_transposed_all_strict_bins_all_unique_COGs_Prokka_counts`$COGs))) {
    bin.zoot <- paste(binn)
    status.zoot <- unique(`2022.10.16_melted_transposed_combined_table_all_good_bins_all_unique_single_products_single_hypothetical_protein_simple_counts`[`2022.10.16_melted_transposed_combined_table_all_good_bins_all_unique_single_products_single_hypothetical_protein_simple_counts`$Product == bin.zoot,]$Bin_status)
    `2023-05-05_bins_and_enrichment_status`[nrow(`2023-05-05_bins_and_enrichment_status`) +1,] <- c(bin.zoot, status.zoot)
    rm(list=ls(pattern='*zoot'))
}
view(`2023-05-05_bins_and_enrichment_status`)
write.table(`2023-05-05_bins_and_enrichment_status`, file = "2023-05-05_bins_and_enrichment_status.csv", sep = ",", row.names = FALSE)
toc()

names(`2023.05.04_melted_transposed_all_strict_bins_all_unique_COGs_Prokka_counts`)[names(`2023.05.04_melted_transposed_all_strict_bins_all_unique_COGs_Prokka_counts`) == "COGs"] <- "Bin"
`zoot.table` <- merge(`2023.05.04_melted_transposed_all_strict_bins_all_unique_COGs_Prokka_counts`, `2023-05-05_bins_and_enrichment_status`, by = "Bin")
unique(`zoot.table`$Enrichment.status)
`2023-05-05_melted_transposed_all_strict_bins_all_unique_COGs_Prokka_counts_WITH_bin_enrichment_by_host_status` <- `zoot.table`

tic()
shortdf.delete <- `2023-05-05_melted_transposed_all_strict_bins_all_unique_COGs_Prokka_counts_WITH_bin_enrichment_by_host_status`
`outputdf.rename` <- data.frame(matrix(ncol = 6, nrow = 0 , dimnames = list(NULL, c("Product", "Noise.bins.pvalue", "AC.enriched.versus.bins.pvalue", "AR.enriched.versus.bins.pvalue", "AC.enriched.within.bins.pvalue", "AR.enriched.within.bins.pvalue"))))
for (coggle in as.list(unique(`shortdf.delete`$variable))) {
    total.number.bins.zoot <- 348
    coggle.zoot <- paste(coggle)
    noise.bins.count.zoot <- as.numeric(nrow(as.data.frame(unique(shortdf.delete[shortdf.delete$Enrichment.status == "None" & shortdf.delete$variable == coggle.zoot & shortdf.delete$value > 0,]$Bin))))
    AC.enriched.bins.count.zoot <- as.numeric(nrow(as.data.frame(unique(shortdf.delete[shortdf.delete$Enrichment.status == "AC_enriched_vs" & shortdf.delete$variable == coggle.zoot & shortdf.delete$value > 0,]$Bin))))
    AR.enriched.bins.count.zoot <- as.numeric(nrow(as.data.frame(unique(shortdf.delete[shortdf.delete$Enrichment.status == "AR_enriched_vs" & shortdf.delete$variable == coggle.zoot & shortdf.delete$value > 0,]$Bin))))
    within.AC.bins.count.zoot <- as.numeric(nrow(as.data.frame(unique(shortdf.delete[shortdf.delete$Enrichment.status == "in_AC_effect" & shortdf.delete$variable == coggle.zoot & shortdf.delete$value > 0,]$Bin))))
    within.AR.bins.count.zoot <- as.numeric(nrow(as.data.frame(unique(shortdf.delete[shortdf.delete$Enrichment.status == "in_AR_effect" & shortdf.delete$variable == coggle.zoot & shortdf.delete$value > 0,]$Bin))))
    summed.noise.product.values.zoot <- sum(shortdf.delete[shortdf.delete$Enrichment.status == "None" & shortdf.delete$variable == coggle.zoot,]$value)
    summed.AC.enriched.product.values.zoot <- sum(shortdf.delete[shortdf.delete$Enrichment.status == "AC_enriched_vs" & shortdf.delete$variable == coggle.zoot,]$value)
    summed.AR.enriched.product.values.zoot <- sum(shortdf.delete[shortdf.delete$Enrichment.status == "AR_enriched_vs" & shortdf.delete$variable == coggle.zoot,]$value)
    summed.within.AC.bins.product.values.zoot <- sum(shortdf.delete[shortdf.delete$Enrichment.status == "in_AC_effect" & shortdf.delete$variable == coggle.zoot,]$value)
    summed.within.AR.bins.product.values.zoot <- sum(shortdf.delete[shortdf.delete$Enrichment.status == "in_AR_effect" & shortdf.delete$variable == coggle.zoot,]$value)
    summed.all.bins.product.values.zoot <- sum(shortdf.delete[shortdf.delete$variable == coggle.zoot,]$value)
    noise.bins.product.values.over.zero.zoot <- as.numeric(nrow(as.data.frame(unique(shortdf.delete[shortdf.delete$Enrichment.status == "None" & shortdf.delete$variable == coggle.zoot & shortdf.delete$value > 0,]$Bin))))
    AC.enriched.bins.product.values.over.zero.zoot <- as.numeric(nrow(as.data.frame(unique(shortdf.delete[shortdf.delete$Enrichment.status == "AC_enriched_vs" & shortdf.delete$variable == coggle.zoot & shortdf.delete$value > 0,]$Bin))))
    AR.enriched.bins.product.values.over.zero.zoot <- as.numeric(nrow(as.data.frame(unique(shortdf.delete[shortdf.delete$Enrichment.status == "AR_enriched_vs" & shortdf.delete$variable == coggle.zoot & shortdf.delete$value > 0,]$Bin))))
    within.AC.bins.product.values.over.zero.zoot <- as.numeric(nrow(as.data.frame(unique(shortdf.delete[shortdf.delete$Enrichment.status == "in_AC_effect" & shortdf.delete$variable == coggle.zoot & shortdf.delete$value > 0,]$Bin))))
    within.AR.bins.product.values.over.zero.zoot <- as.numeric(nrow(as.data.frame(unique(shortdf.delete[shortdf.delete$Enrichment.status == "in_AR_effect" & shortdf.delete$variable == coggle.zoot & shortdf.delete$value > 0,]$Bin))))
    total.number.bins.value.product.over.zero.zoot <- as.numeric(nrow(as.data.frame(unique(shortdf.delete[shortdf.delete$variable == coggle.zoot & shortdf.delete$value > 0,]$Bin))))
    noise.bins.product.pvalue.zoot <- phyper(q = (noise.bins.count.zoot - 1), m = summed.noise.product.values.zoot, n = (summed.all.bins.product.values.zoot - summed.noise.product.values.zoot), k = total.number.bins.value.product.over.zero.zoot, lower.tail = FALSE)
    AC.enriched.bins.product.pvalue.zoot <- phyper(q = (AC.enriched.bins.count.zoot - 1), m = summed.AC.enriched.product.values.zoot, n = (summed.all.bins.product.values.zoot - summed.AC.enriched.product.values.zoot), k = total.number.bins.value.product.over.zero.zoot, lower.tail = FALSE)
    AR.enriched.bins.product.pvalue.zoot <- phyper(q = (AR.enriched.bins.count.zoot - 1), m = summed.AR.enriched.product.values.zoot, n = (summed.all.bins.product.values.zoot - summed.AR.enriched.product.values.zoot), k = total.number.bins.value.product.over.zero.zoot, lower.tail = FALSE)
    within.AC.bins.product.pvalue.zoot <- phyper(q = (within.AC.bins.count.zoot - 1), m = summed.within.AC.bins.product.values.zoot, n = (summed.all.bins.product.values.zoot - summed.within.AC.bins.product.values.zoot), k = total.number.bins.value.product.over.zero.zoot, lower.tail = FALSE)
    within.AR.bins.product.pvalue.zoot <- phyper(q = (within.AR.bins.count.zoot - 1), m = summed.within.AR.bins.product.values.zoot, n = (summed.all.bins.product.values.zoot - summed.within.AR.bins.product.values.zoot), k = total.number.bins.value.product.over.zero.zoot, lower.tail = FALSE)
    `outputdf.rename`[nrow(`outputdf.rename`) +1,] <- c(coggle.zoot, noise.bins.product.pvalue.zoot, AC.enriched.bins.product.pvalue.zoot, AR.enriched.bins.product.pvalue.zoot, within.AC.bins.product.pvalue.zoot, within.AR.bins.product.pvalue.zoot)
    `outputdf.rename`[,c(2:6)] <- sapply(`outputdf.rename`[,c(2:6)], as.numeric)
    rm(list=ls(pattern='*zoot'))
}
view(`outputdf.rename`)
toc()
`safehold.df` <- `outputdf.rename`
`outputdf.rename`$BH.corrected.noise.bins.Pvalue <- p.adjust(`outputdf.rename`[order(`outputdf.rename`$Noise.bins.pvalue),]$Noise.bins.pvalue, method = "BH")
`outputdf.rename`$BH.corrected.AC.enriched.versus.bins.Pvalue <- p.adjust(`outputdf.rename`[order(`outputdf.rename`$AC.enriched.versus.bins.pvalue),]$AC.enriched.versus.bins.pvalue, method = "BH")
`outputdf.rename`$BH.corrected.AR.enriched.versus.bins.Pvalue <- p.adjust(`outputdf.rename`[order(`outputdf.rename`$AR.enriched.versus.bins.pvalue),]$AR.enriched.versus.bins.pvalue, method = "BH")
`outputdf.rename`$BH.corrected.AC.enriched.within.bins.Pvalue <- p.adjust(`outputdf.rename`[order(`outputdf.rename`$AC.enriched.within.bins.pvalue),]$AC.enriched.within.bins.pvalue, method = "BH")
`outputdf.rename`$BH.corrected.AR.enriched.within.bins.Pvalue <- p.adjust(`outputdf.rename`[order(`outputdf.rename`$AR.enriched.within.bins.pvalue),]$AR.enriched.within.bins.pvalue, method = "BH")
`2023-05-05_BH_corrected_prokka_COGs_strict_bins_hypergeometric_tests_differential_abundance_by_host_species_bin_enrichment` <- `outputdf.rename`
write.table(`2023-05-05_BH_corrected_prokka_COGs_strict_bins_hypergeometric_tests_differential_abundance_by_host_species_bin_enrichment`, file = "2023-05-05_BH_corrected_prokka_COGs_strict_bins_hypergeometric_tests_differential_abundance_by_host_species_bin_enrichment.csv", sep = ",", row.names = FALSE)
`outputdf.rename.melted` <- reshape2::melt(`outputdf.rename`, id = c("Product"))

#Version without full stops
`outputdf.rename.melted`$variable = gsub("[.]", " ", `outputdf.rename.melted`$variable)

#Figure
`2023-05-06_Prokka_strict_bins_COGs_hypergeometric_test_Q_value_results_by_bin_enrichment_status_jitter_figure` <- ggplot(data = `outputdf.rename.melted`[grepl(glob2rx("BH corrected*"), `outputdf.rename.melted`$variable),], aes(x = value, y = variable, colour = variable, fill = variable)) + geom_vline(xintercept=c(0.05), col="#a0a7ae", linetype = "dashed", size = 0.75, show.legend = FALSE) + geom_jitter() + scale_colour_manual(name = "Bin enrichment status", values = c("BH corrected AC enriched versus bins Pvalue" = "#1ec8ff", "BH corrected AC enriched within bins Pvalue" = "#006ad1", "BH corrected AR enriched versus bins Pvalue" = "#ff551e", "BH corrected AR enriched within bins Pvalue" = "#d16700", "BH corrected noise bins Pvalue" = "#0f0f0f")) + xlab("Q value") + ylab("") + theme_classic() + theme(legend.position = "none") + theme(text = element_text(size = 15, family = "Tex Gyre Heroes"))

ggsave(filename = "2023-05-06_Prokka_strict_bins_COGs_hypergeometric_test_Q_value_results_by_bin_enrichment_status_jitter_figure.pdf", `2023-05-06_Prokka_strict_bins_COGs_hypergeometric_test_Q_value_results_by_bin_enrichment_status_jitter_figure`)

#Getting the Q-value significant COGs to write about them
`outputdf.rename.melted`[grepl(glob2rx("BH corrected*"), `outputdf.rename.melted`$variable),] %>% filter(value <= 0.05)

#Trying the gene based stuff on the HPC in an interactive R session using your overlay
library(dplyr)
library(tictoc)
`2023-05-04_all_strict_bins_all_unique_genes_Prokka_counts` <- read.delim("2023-05-04_all_strict_bins_all_unique_genes_Prokka_counts.txt")
`2023-05-04_transposed_all_strict_bins_all_unique_genes_Prokka_counts` <- setNames(data.frame(t(`2023-05-04_all_strict_bins_all_unique_genes_Prokka_counts`[,-1])), `2023-05-04_all_strict_bins_all_unique_genes_Prokka_counts`[,1])
`2023-05-04_transposed_all_strict_bins_all_unique_genes_Prokka_counts`[] <- lapply(`2023-05-04_transposed_all_strict_bins_all_unique_genes_Prokka_counts`, type.convert, as.is = TRUE)
`2023-05-04_transposed_all_strict_bins_all_unique_genes_Prokka_counts`$Genes <- row.names(`2023-05-04_transposed_all_strict_bins_all_unique_genes_Prokka_counts`)
`2023-05-04_melted_transposed_all_strict_bins_all_unique_genes_Prokka_counts` <- reshape2::melt(`2023-05-04_transposed_all_strict_bins_all_unique_genes_Prokka_counts`, id = c("Genes"))
write.table(`2023-05-04_melted_transposed_all_strict_bins_all_unique_genes_Prokka_counts`, file = "2023-05-04_melted_transposed_all_strict_bins_all_unique_genes_Prokka_counts.csv", sep=",", row.names=FALSE)

tic()
`2023-05-06_prokka_strict_bins_annotation_Genes_simple_details` <- data.frame(matrix(ncol = 7, nrow = 0, dimnames = list(NULL, c("Gene", "Summed.counts", "Mean.count", "Median.count", "Max.count", "Min.non-zero.count", "Bin.with.most"))))
`shortdf.genes.delete` <- `2023-05-04_melted_transposed_all_strict_bins_all_unique_genes_Prokka_counts`
for (coggle in as.list(unique(`shortdf.genes.delete`$variable))) {
    coggle.zoot <- paste(coggle)
    summed.zoot <- sum(`shortdf.genes.delete`[`shortdf.genes.delete`$variable == coggle.zoot,]$value)
    mean.zoot <- mean(`shortdf.genes.delete`[`shortdf.genes.delete`$variable == coggle.zoot,]$value)
    median.zoot <- median(`shortdf.genes.delete`[`shortdf.genes.delete`$variable == coggle.zoot,]$value)
    max.zoot <- max(`shortdf.genes.delete`[`shortdf.genes.delete`$variable == coggle.zoot,]$value)
    min.zoot <- min(`shortdf.genes.delete`[`shortdf.genes.delete`$variable == coggle.zoot & `shortdf.genes.delete`$value != 0,]$value)
    most.bin.zoot <- as.character(head(`shortdf.genes.delete` %>% filter(variable == coggle.zoot) %>% arrange(desc(value)), 1)$Genes)
    `2023-05-06_prokka_strict_bins_annotation_Genes_simple_details`[nrow(`2023-05-06_prokka_strict_bins_annotation_Genes_simple_details`) +1,] <- c(coggle.zoot, summed.zoot, mean.zoot, median.zoot, max.zoot, min.zoot, most.bin.zoot)
    `2023-05-06_prokka_strict_bins_annotation_Genes_simple_details`[,c(2:6)] <- sapply(`2023-05-06_prokka_strict_bins_annotation_Genes_simple_details`[,c(2:6)], as.numeric)
    trove.zoot <- paste("Processed gene:")
    trover.zoot <- paste(trove.zoot, coggle.zoot)
    print(trover.zoot)
    rm(list=ls(pattern='*zoot'))
}
rm(`shortdf.genes.delete`)
write.table(`2023-05-06_prokka_strict_bins_annotation_Genes_simple_details`, file = "2023-05-05_prokka_strict_bins_annotation_COGs_simple_details.csv", sep=",", row.names=FALSE)
toc()

as.numeric(nrow(as.data.frame(`2023-05-06_prokka_strict_bins_annotation_Genes_simple_details` %>% filter(Median.count == 0))))
`2023-05-05_prokka_strict_bins_Genes_bins_with_most_detections_each_bin_table` <- as.data.frame(table(`2023-05-06_prokka_strict_bins_annotation_Genes_simple_details`$Bin.with.most))
View(`2023-05-05_prokka_strict_bins_Genes_bins_with_most_detections_each_bin_table`)
`2023-05-05_prokka_strict_bins_genes_number_Genes_bin_has_greatest_count_for_density_and_frequency_plot_figure` <- ggplot(data = `2023-05-05_prokka_strict_bins_Genes_bins_with_most_detections_each_bin_table`, aes(x = Freq)) + geom_histogram(aes(y=..density..), binwidth = 5,colour = "#0f0f0f", fill = "#a0a7ae") + geom_density(alpha = 0.35, fill = "#8d1eff") + xlab("Density") + ylab("Frequency") + theme_classic() + theme(text = element_text(family = "Tex Gyre Heroes"))

ggsave(filename = "2023-05-05_prokka_strict_bins_COGs_number_COGs_bin_has_greatest_count_for_density_and_frequency_plot_figure.pdf", `2023-05-05_prokka_strict_bins_COGs_number_COGs_bin_has_greatest_count_for_density_and_frequency_plot_figure`)

#Interval, Chapter 4 figs
`2023-05-06_isolate_assemblies_checkm_combined_contamination_completeness_2_axis_figure` <- ggplot(data = `2022.04.08_CheckM_all_isolate_SPADES_assemblies_min_500bp_contig_size`, aes(x = Completeness, y = Contamination, colour = ifelse(Completeness > 80 & Contamination < 5, 'black', 'red'))) + geom_jitter(size = 3.5, alpha = 0.6) + theme_classic() + theme(text = element_text(family = "Tex Gyre Heroes", size = 24)) + xlab("Completeness (%)") + ylab("Contamination (%)") + geom_vline(xintercept=c(80), col="#1e90ff", linetype = "dashed", linewidth = 1.35) + geom_hline(yintercept=c(5), col="#ff8d1e", linetype = "dashed", linewidth = 1.35) + theme(legend.position = "none") + scale_colour_manual(values = c("#0f0f0f", "#adb4ba"))

ggsave(filename = "2023-05-06_isolate_assemblies_checkm_combined_contamination_completeness_2_axis_figure.pdf", `2023-05-06_isolate_assemblies_checkm_combined_contamination_completeness_2_axis_figure`)

`2023-05-06_all_isolates_passing_QC_and_picked_if_ANI_similar_GTDB-TK_genus_level_counts_per_genus_bar_chart` <- ggplot(data = as.data.frame(table(`2022.11.27_GTDB.TK_genera_isolates_passing_QC_and_picked_to_use_when_ANI_over_99_point_9`$Genus)), aes(x = reorder(Var1, - Freq), y = Freq, fill = Var1)) + geom_bar(stat = 'identity', colour = "#0f0f0f") + theme_classic() + theme(axis.text.x = element_text(angle = 45, hjust=1)) + theme(text = element_text(family = "Tex Gyre Heroes", size = 20)) + xlab("Genera") + ylab("Number of isolates classified") + scale_fill_manual(name = "GTDB-TK assigned genus",values=as.vector(kelly(6)))

ggsave(filename = "2023-05-06_all_isolates_passing_QC_and_picked_if_ANI_similar_GTDB-TK_genus_level_counts_per_genus_bar_chart.pdf", `2023-05-06_all_isolates_passing_QC_and_picked_if_ANI_similar_GTDB-TK_genus_level_counts_per_genus_bar_chart`)

#2023-05-07
#Doing some bins gene stuff locally with the csv made on the HPC
`2023.05.05_prokka_strict_bins_annotation_Genes_simple_details` <- read.csv("~/Google Drive/PhD/2022-Paper_2-Chapter_3/2023-05-05_prokka_strict_bins_annotation_Genes_simple_details.csv")
View(`2023.05.05_prokka_strict_bins_annotation_Genes_simple_details`)

#Density and frequency figure
`2023-05-05_prokka_strict_bins_Genes_bins_with_most_detections_each_bin_table` <- as.data.frame(table(`2023.05.05_prokka_strict_bins_annotation_Genes_simple_details`$Bin.with.most))

`2023-05-05_prokka_strict_bins_Genes_number_genes_which_bin_has_greatest_count_for_density_and_frequency_plot_figure` <- ggplot(data = `2023-05-05_prokka_strict_bins_Genes_bins_with_most_detections_each_bin_table`, aes(x = Freq)) + geom_histogram(aes(y=..density..), binwidth = 10,colour = "#0f0f0f", fill = "#a0a7ae") + geom_density(alpha = 0.35, fill = "#8d1eff") + xlab("Density") + ylab("Frequency") + theme_classic() + theme(text = element_text(family = "Tex Gyre Heroes"))

ggsave(filename = "2023-05-05_prokka_strict_bins_Genes_number_genes_which_bin_has_greatest_count_for_density_and_frequency_plot_figure.pdf", `2023-05-05_prokka_strict_bins_Genes_number_genes_which_bin_has_greatest_count_for_density_and_frequency_plot_figure`)

`2023.05.04_melted_transposed_all_strict_bins_all_unique_genes_Prokka_counts` <- read.csv("~/Google Drive/PhD/2022-Paper_2-Chapter_3/2023-05-04_melted_transposed_all_strict_bins_all_unique_genes_Prokka_counts.csv")

#Prokka gene stuff dedicated section including hypergeometric testing
tic()
`2023-05-04_all_strict_bins_all_unique_genes_Prokka_counts` <- read.delim("2023-05-04_all_strict_bins_all_unique_genes_Prokka_counts.txt")
`2023-05-04_transposed_all_strict_bins_all_unique_genes_Prokka_counts` <- setNames(data.frame(t(`2023-05-04_all_strict_bins_all_unique_genes_Prokka_counts`[,-1])), `2023-05-04_all_strict_bins_all_unique_genes_Prokka_counts`[,1])
`2023-05-04_transposed_all_strict_bins_all_unique_genes_Prokka_counts`[] <- lapply(`2023-05-04_transposed_all_strict_bins_all_unique_genes_Prokka_counts`, type.convert, as.is = TRUE)
`2023-05-04_transposed_all_strict_bins_all_unique_genes_Prokka_counts`$Genes <- row.names(`2023-05-04_transposed_all_strict_bins_all_unique_genes_Prokka_counts`)
`2023-05-04_melted_transposed_all_strict_bins_all_unique_genes_Prokka_counts` <- reshape2::melt(`2023-05-04_transposed_all_strict_bins_all_unique_genes_Prokka_counts`, id = c("Genes"))
write.table(`2023-05-04_melted_transposed_all_strict_bins_all_unique_genes_Prokka_counts`, file = "2023-05-04_melted_transposed_all_strict_bins_all_unique_genes_Prokka_counts.csv", sep=",", row.names=FALSE)

`2023-05-06_prokka_strict_bins_annotation_Genes_simple_details` <- data.frame(matrix(ncol = 7, nrow = 0, dimnames = list(NULL, c("Gene", "Summed.counts", "Mean.count", "Median.count", "Max.count", "Min.non-zero.count", "Bin.with.most"))))
`shortdf.genes.delete` <- `2023-05-04_melted_transposed_all_strict_bins_all_unique_genes_Prokka_counts`
for (coggle in as.list(unique(`shortdf.genes.delete`$variable))) {
    coggle.zoot <- paste(coggle)
    summed.zoot <- sum(`shortdf.genes.delete`[`shortdf.genes.delete`$variable == coggle.zoot,]$value)
    mean.zoot <- mean(`shortdf.genes.delete`[`shortdf.genes.delete`$variable == coggle.zoot,]$value)
    median.zoot <- median(`shortdf.genes.delete`[`shortdf.genes.delete`$variable == coggle.zoot,]$value)
    max.zoot <- max(`shortdf.genes.delete`[`shortdf.genes.delete`$variable == coggle.zoot,]$value)
    min.zoot <- min(`shortdf.genes.delete`[`shortdf.genes.delete`$variable == coggle.zoot & `shortdf.genes.delete`$value != 0,]$value)
    most.bin.zoot <- as.character(head(`shortdf.genes.delete` %>% filter(variable == coggle.zoot) %>% arrange(desc(value)), 1)$Genes)
    `2023-05-06_prokka_strict_bins_annotation_Genes_simple_details`[nrow(`2023-05-06_prokka_strict_bins_annotation_Genes_simple_details`) +1,] <- c(coggle.zoot, summed.zoot, mean.zoot, median.zoot, max.zoot, min.zoot, most.bin.zoot)
    `2023-05-06_prokka_strict_bins_annotation_Genes_simple_details`[,c(2:6)] <- sapply(`2023-05-06_prokka_strict_bins_annotation_Genes_simple_details`[,c(2:6)], as.numeric)
    trove.zoot <- paste("Processed gene:")
    trover.zoot <- paste(trove.zoot, coggle.zoot)
    print(trover.zoot)
    rm(list=ls(pattern='*zoot'))
}
rm(`shortdf.genes.delete`)
write.table(`2023-05-06_prokka_strict_bins_annotation_Genes_simple_details`, file = "2023-05-05_prokka_strict_bins_annotation_COGs_simple_details.csv", sep=",", row.names=FALSE)
save.image("2023-05-07.RData")
toc()

`2023-05-05_prokka_strict_bins_Genes_bins_with_most_detections_each_bin_table` <- as.data.frame(table(`2023-05-06_prokka_strict_bins_annotation_Genes_simple_details`$Bin.with.most))

####################
names(`2023-05-04_melted_transposed_all_strict_bins_all_unique_genes_Prokka_counts`)[names(`2023-05-04_melted_transposed_all_strict_bins_all_unique_genes_Prokka_counts`) == "Genes"] <- "Bin"
`zoot.table` <- merge(`2023-05-04_melted_transposed_all_strict_bins_all_unique_genes_Prokka_counts`, `2023-05-05_bins_and_enrichment_status`, by = "Bin")
unique(`zoot.table`$Enrichment.status)
`2023-05-05_melted_transposed_all_strict_bins_all_unique_Genes_Prokka_counts_WITH_bin_enrichment_by_host_status` <- `zoot.table`

tic()
shortdf.delete <- `2023-05-05_melted_transposed_all_strict_bins_all_unique_Genes_Prokka_counts_WITH_bin_enrichment_by_host_status`
`outputdf.genes.rename` <- data.frame(matrix(ncol = 6, nrow = 0 , dimnames = list(NULL, c("Product", "Noise.bins.pvalue", "AC.enriched.versus.bins.pvalue", "AR.enriched.versus.bins.pvalue", "AC.enriched.within.bins.pvalue", "AR.enriched.within.bins.pvalue"))))
for (coggle in as.list(unique(`shortdf.delete`$variable))) {
    total.number.bins.zoot <- 348
    coggle.zoot <- paste(coggle)
    noise.bins.count.zoot <- as.numeric(nrow(as.data.frame(unique(shortdf.delete[shortdf.delete$Enrichment.status == "None" & shortdf.delete$variable == coggle.zoot & shortdf.delete$value > 0,]$Bin))))
    AC.enriched.bins.count.zoot <- as.numeric(nrow(as.data.frame(unique(shortdf.delete[shortdf.delete$Enrichment.status == "AC_enriched_vs" & shortdf.delete$variable == coggle.zoot & shortdf.delete$value > 0,]$Bin))))
    AR.enriched.bins.count.zoot <- as.numeric(nrow(as.data.frame(unique(shortdf.delete[shortdf.delete$Enrichment.status == "AR_enriched_vs" & shortdf.delete$variable == coggle.zoot & shortdf.delete$value > 0,]$Bin))))
    within.AC.bins.count.zoot <- as.numeric(nrow(as.data.frame(unique(shortdf.delete[shortdf.delete$Enrichment.status == "in_AC_effect" & shortdf.delete$variable == coggle.zoot & shortdf.delete$value > 0,]$Bin))))
    within.AR.bins.count.zoot <- as.numeric(nrow(as.data.frame(unique(shortdf.delete[shortdf.delete$Enrichment.status == "in_AR_effect" & shortdf.delete$variable == coggle.zoot & shortdf.delete$value > 0,]$Bin))))
    summed.noise.product.values.zoot <- sum(shortdf.delete[shortdf.delete$Enrichment.status == "None" & shortdf.delete$variable == coggle.zoot,]$value)
    summed.AC.enriched.product.values.zoot <- sum(shortdf.delete[shortdf.delete$Enrichment.status == "AC_enriched_vs" & shortdf.delete$variable == coggle.zoot,]$value)
    summed.AR.enriched.product.values.zoot <- sum(shortdf.delete[shortdf.delete$Enrichment.status == "AR_enriched_vs" & shortdf.delete$variable == coggle.zoot,]$value)
    summed.within.AC.bins.product.values.zoot <- sum(shortdf.delete[shortdf.delete$Enrichment.status == "in_AC_effect" & shortdf.delete$variable == coggle.zoot,]$value)
    summed.within.AR.bins.product.values.zoot <- sum(shortdf.delete[shortdf.delete$Enrichment.status == "in_AR_effect" & shortdf.delete$variable == coggle.zoot,]$value)
    summed.all.bins.product.values.zoot <- sum(shortdf.delete[shortdf.delete$variable == coggle.zoot,]$value)
    noise.bins.product.values.over.zero.zoot <- as.numeric(nrow(as.data.frame(unique(shortdf.delete[shortdf.delete$Enrichment.status == "None" & shortdf.delete$variable == coggle.zoot & shortdf.delete$value > 0,]$Bin))))
    AC.enriched.bins.product.values.over.zero.zoot <- as.numeric(nrow(as.data.frame(unique(shortdf.delete[shortdf.delete$Enrichment.status == "AC_enriched_vs" & shortdf.delete$variable == coggle.zoot & shortdf.delete$value > 0,]$Bin))))
    AR.enriched.bins.product.values.over.zero.zoot <- as.numeric(nrow(as.data.frame(unique(shortdf.delete[shortdf.delete$Enrichment.status == "AR_enriched_vs" & shortdf.delete$variable == coggle.zoot & shortdf.delete$value > 0,]$Bin))))
    within.AC.bins.product.values.over.zero.zoot <- as.numeric(nrow(as.data.frame(unique(shortdf.delete[shortdf.delete$Enrichment.status == "in_AC_effect" & shortdf.delete$variable == coggle.zoot & shortdf.delete$value > 0,]$Bin))))
    within.AR.bins.product.values.over.zero.zoot <- as.numeric(nrow(as.data.frame(unique(shortdf.delete[shortdf.delete$Enrichment.status == "in_AR_effect" & shortdf.delete$variable == coggle.zoot & shortdf.delete$value > 0,]$Bin))))
    total.number.bins.value.product.over.zero.zoot <- as.numeric(nrow(as.data.frame(unique(shortdf.delete[shortdf.delete$variable == coggle.zoot & shortdf.delete$value > 0,]$Bin))))
    noise.bins.product.pvalue.zoot <- phyper(q = (noise.bins.count.zoot - 1), m = summed.noise.product.values.zoot, n = (summed.all.bins.product.values.zoot - summed.noise.product.values.zoot), k = total.number.bins.value.product.over.zero.zoot, lower.tail = FALSE)
    AC.enriched.bins.product.pvalue.zoot <- phyper(q = (AC.enriched.bins.count.zoot - 1), m = summed.AC.enriched.product.values.zoot, n = (summed.all.bins.product.values.zoot - summed.AC.enriched.product.values.zoot), k = total.number.bins.value.product.over.zero.zoot, lower.tail = FALSE)
    AR.enriched.bins.product.pvalue.zoot <- phyper(q = (AR.enriched.bins.count.zoot - 1), m = summed.AR.enriched.product.values.zoot, n = (summed.all.bins.product.values.zoot - summed.AR.enriched.product.values.zoot), k = total.number.bins.value.product.over.zero.zoot, lower.tail = FALSE)
    within.AC.bins.product.pvalue.zoot <- phyper(q = (within.AC.bins.count.zoot - 1), m = summed.within.AC.bins.product.values.zoot, n = (summed.all.bins.product.values.zoot - summed.within.AC.bins.product.values.zoot), k = total.number.bins.value.product.over.zero.zoot, lower.tail = FALSE)
    within.AR.bins.product.pvalue.zoot <- phyper(q = (within.AR.bins.count.zoot - 1), m = summed.within.AR.bins.product.values.zoot, n = (summed.all.bins.product.values.zoot - summed.within.AR.bins.product.values.zoot), k = total.number.bins.value.product.over.zero.zoot, lower.tail = FALSE)
    `outputdf.genes.rename`[nrow(`outputdf.genes.rename`) +1,] <- c(coggle.zoot, noise.bins.product.pvalue.zoot, AC.enriched.bins.product.pvalue.zoot, AR.enriched.bins.product.pvalue.zoot, within.AC.bins.product.pvalue.zoot, within.AR.bins.product.pvalue.zoot)
    `outputdf.genes.rename`[,c(2:6)] <- sapply(`outputdf.genes.rename`[,c(2:6)], as.numeric)
    trove.zoot <- paste("Processed gene:")
    trover.zoot <- paste(trove.zoot, coggle.zoot)
    print(trover.zoot)
    rm(list=ls(pattern='*zoot'))
}
toc()
`safehold.genes.df` <- `outputdf.genes.rename`
`outputdf.genes.rename`$BH.corrected.noise.bins.Pvalue <- p.adjust(`outputdf.genes.rename`[order(`outputdf.genes.rename`$Noise.bins.pvalue),]$Noise.bins.pvalue, method = "BH")
`outputdf.genes.rename`$BH.corrected.AC.enriched.versus.bins.Pvalue <- p.adjust(`outputdf.genes.rename`[order(`outputdf.genes.rename`$AC.enriched.versus.bins.pvalue),]$AC.enriched.versus.bins.pvalue, method = "BH")
`outputdf.genes.rename`$BH.corrected.AR.enriched.versus.bins.Pvalue <- p.adjust(`outputdf.genes.rename`[order(`outputdf.genes.rename`$AR.enriched.versus.bins.pvalue),]$AR.enriched.versus.bins.pvalue, method = "BH")
`outputdf.genes.rename`$BH.corrected.AC.enriched.within.bins.Pvalue <- p.adjust(`outputdf.genes.rename`[order(`outputdf.genes.rename`$AC.enriched.within.bins.pvalue),]$AC.enriched.within.bins.pvalue, method = "BH")
`outputdf.genes.rename`$BH.corrected.AR.enriched.within.bins.Pvalue <- p.adjust(`outputdf.genes.rename`[order(`outputdf.genes.rename`$AR.enriched.within.bins.pvalue),]$AR.enriched.within.bins.pvalue, method = "BH")
`2023-05-05_BH_corrected_prokka_Genes_strict_bins_hypergeometric_tests_differential_abundance_by_host_species_bin_enrichment` <- `outputdf.genes.rename`
write.table(`2023-05-05_BH_corrected_prokka_Genes_strict_bins_hypergeometric_tests_differential_abundance_by_host_species_bin_enrichment`, file = "2023-05-05_BH_corrected_prokka_COGs_strict_bins_hypergeometric_tests_differential_abundance_by_host_species_bin_enrichment.csv", sep = ",", row.names = FALSE)
`outputdf.genes.rename.melted` <- reshape2::melt(`outputdf.genes.rename`, id = c("Product"))
`outputdf.genes.rename.melted`$variable = gsub("[.]", " ", `outputdf.genes.rename.melted`$variable)
write.table(`2023-05-05_BH_corrected_prokka_Genes_strict_bins_hypergeometric_tests_differential_abundance_by_host_species_bin_enrichment`, file = "2023-05-05_BH_corrected_prokka_COGs_strict_bins_hypergeometric_tests_differential_abundance_by_host_species_bin_enrichment.csv", sep = ",", row.names = FALSE)
save.image("2023-05-07.RData")
toc()

#2023-05-09
#Making pdf and classic theme figures for some missing places plus trying a bonus figure for the bins gene level annotation since otherwise it is a short little section of text

#2023-05-10
#Continuing on point from above
`2023.05.10.Cleansed_not_subsampled_novogene_paired_reads_mapping_percentage_good_bbmasked_isolates` <- ggplot(data = `2022.11.30_not_subsampled_mapping_percentages`, aes(x = Host.x.month, y = Mapping.percentage, fill = Host.x.month)) + geom_boxplot(alpha = 0.75) + geom_jitter(colour = "#0f0f0f", width = 0.25, size = 2.25) + theme_classic() + ylab("Mapping of reads to assembly reference (%)") + xlab("Host species and sampling month") + scale_fill_manual(values = c("#1e90ff", "#002d59", "#ff8d1e", "#934a00"), name = "Read host species\nand sample month") + theme(text = element_text(family = "Tex Gyre Heroes"))

`2023.05.10.Subsampled_novogene_paired_reads_mapping_percentage_good_bbmasked_isolates` <- ggplot(data = `2022.11.30_subsampled_mapping_percentages`, aes(x = Host.x.month, y = Mapping.percentage, fill = Host.x.month)) + geom_boxplot(alpha = 0.75) + geom_jitter(colour = "#0f0f0f", width = 0.25, size = 2.25) + theme_classic() + ylab("Mapping of reads to assembly reference (%)") + xlab("Host species and sampling month") + scale_fill_manual(values = c("#1e90ff", "#002d59", "#ff8d1e", "#934a00"), name = "Read host species\nand sample month") + theme(text = element_text(family = "Tex Gyre Heroes"))

`2023.05.10.Cleansed_not_subsampled_novogene_paired_reads_mapping_percentage_good_bbmasked_isolates` + `2023.05.10.Subsampled_novogene_paired_reads_mapping_percentage_good_bbmasked_isolates` + plot_layout(guides = "collect") + plot_annotation(tag_levels = 'A')

ggsave(filename = "2023-05-10_Cleansed_not_subsampled_novogene_paired_reads_mapping_percentage_good_bbmasked_isolates.pdf", `2023.05.10.Cleansed_not_subsampled_novogene_paired_reads_mapping_percentage_good_bbmasked_isolates`)

`2023.05.10.Salmon_isolates_novogene_paired_mapping_Acomys_russatus_derived_isolates` <- ggplot(data = `2022.12.03.melted.transposed.isolates_salmon`[grepl(glob2rx("39*"), `2022.12.03.melted.transposed.isolates_salmon`$variable) | grepl(glob2rx("41*"), `2022.12.03.melted.transposed.isolates_salmon`$variable) | grepl(glob2rx("13*"), `2022.12.03.melted.transposed.isolates_salmon`$variable), ], aes(x = variable, y = value, fill = Host.x.month, shape = Host.x.month)) + geom_violin() + ylab("RPM for assembly on Log10 scale") + xlab("") + scale_y_log10(labels = label_log()) + theme_classic() + theme(text = element_text(family = "Tex Gyre Heroes"), axis.text.x = element_text(size = 11)) + scale_fill_manual(values = c("#1e90ff", "#002d59", "#ff8d1e", "#934a00"), name = "Read host species\nand sample month") + facet_wrap(~ variable, scales = "free_x") + theme(strip.text.x = element_text(size = 12)) + theme(axis.title.x=element_blank(), axis.text.x=element_blank(), axis.ticks.x=element_blank()) + theme(legend.position="none")

`2023.05.10.Salmon_isolates_novogene_paired_mapping_Acomys_cahirinus_derived_isolates` <- ggplot(data = `2022.12.03.melted.transposed.isolates_salmon`[! grepl(glob2rx("39*"), `2022.12.03.melted.transposed.isolates_salmon`$variable) & ! grepl(glob2rx("41*"), `2022.12.03.melted.transposed.isolates_salmon`$variable) & ! grepl(glob2rx("13*"), `2022.12.03.melted.transposed.isolates_salmon`$variable), ], aes(x = variable, y = value, fill = Host.x.month, shape = Host.x.month)) + geom_violin() + ylab("") + xlab("") + scale_y_log10(labels = label_log()) + theme_classic() + theme(text = element_text(family = "Tex Gyre Heroes"), axis.text.x = element_text(size = 11)) + scale_fill_manual(values = c("#1e90ff", "#002d59", "#ff8d1e", "#934a00"), name = "Read host species\nand sample month") + facet_wrap(~ variable, scales = "free_x") + theme(strip.text.x = element_text(size = 12)) + theme(axis.title.x=element_blank(), axis.text.x=element_blank(), axis.ticks.x=element_blank())

`2023-05-10_Salmon_isolates_novogene_paired_mapping_both_Acomys_combined_figure` <- `2023.05.10.Salmon_isolates_novogene_paired_mapping_Acomys_russatus_derived_isolates` + `2023.05.10.Salmon_isolates_novogene_paired_mapping_Acomys_cahirinus_derived_isolates` + plot_annotation(tag_levels = 'A')

ggsave(filename = "2023-05-10_Salmon_isolates_novogene_paired_mapping_both_Acomys_combined_figure.pdf", `2023-05-10_Salmon_isolates_novogene_paired_mapping_both_Acomys_combined_figure`)

#Now the PCA plots - will do the all assemblies one as individual figure and the other two together as a supplemental
`2023.05.10.isolates_salmon_PCA_PC1_vs_PC2` <- ggbiplot(`2022.12.03.isolates_salmon_PCA`, choices = c(1,2), obs.scale = 1, var.scale = 1, ellipse = TRUE, groups = `2022.12.02_Transposed_RPMs_adjusted_seq_and_GC_bias_subsampled_novogene_paired_reads_to_single_contig_per_assembly_concatenated_all_good_Acomys_isolate_assemblies`$Host, ellipse.prob = 0.75, circle = TRUE, var.axes = FALSE, plot.loadings = TRUE) + theme_linedraw() + geom_point(aes(shape = factor(`2022.12.02_Transposed_RPMs_adjusted_seq_and_GC_bias_subsampled_novogene_paired_reads_to_single_contig_per_assembly_concatenated_all_good_Acomys_isolate_assemblies`$Month), color = factor(`2022.12.02_Transposed_RPMs_adjusted_seq_and_GC_bias_subsampled_novogene_paired_reads_to_single_contig_per_assembly_concatenated_all_good_Acomys_isolate_assemblies`$Host)), size = 4) + scale_color_manual(values = c("AC" = "#1e90ff", "AR" = "#ff8d1e")) + scale_shape_manual(values = c("J" = 17, "N" = 16)) + labs(shape="Month of collection", colour="Host species") + scale_x_continuous(labels = comma) + scale_y_continuous(labels = comma) + theme_classic() + theme(text = element_text(family = "Tex Gyre Heroes")) 
ggsave(filename = "2023_05_10_isolates_salmon_PCA_PC1_vs_PC2.pdf", `2023.05.10.isolates_salmon_PCA_PC1_vs_PC2`)

`2023.05.10.cahirinus_isolates_salmon_PCA_PC1_vs_PC2` <- ggbiplot(`2022.12.03.cahirinus_isolates_salmon_PCA`, choices = c(1,2), obs.scale = 1, var.scale = 1, ellipse = TRUE, groups = `2022.12.02_Transposed_RPMs_adjusted_seq_and_GC_bias_subsampled_novogene_paired_reads_to_single_contig_per_assembly_concatenated_all_good_Acomys_isolate_assemblies`$Host, ellipse.prob = 0.75, circle = TRUE, var.axes = FALSE, plot.loadings = TRUE) + theme_linedraw() + geom_point(aes(shape = factor(`2022.12.02_Transposed_RPMs_adjusted_seq_and_GC_bias_subsampled_novogene_paired_reads_to_single_contig_per_assembly_concatenated_all_good_Acomys_isolate_assemblies`$Month), color = factor(`2022.12.02_Transposed_RPMs_adjusted_seq_and_GC_bias_subsampled_novogene_paired_reads_to_single_contig_per_assembly_concatenated_all_good_Acomys_isolate_assemblies`$Host)), size = 4) + scale_color_manual(values = c("AC" = "#1e90ff", "AR" = "#ff8d1e")) + scale_shape_manual(values = c("J" = 17, "N" = 16)) + labs(shape="Month of collection", colour="Host species") + scale_x_continuous(labels = comma) + scale_y_continuous(labels = comma) + theme_classic() + theme(text = element_text(family = "Tex Gyre Heroes")) + theme(legend.position="none")
`2023.05.10.russatus_isolates_salmon_PCA_PC1_vs_PC2` <- ggbiplot(`2022.12.03.russatus_isolates_salmon_PCA`, choices = c(1,2), obs.scale = 1, var.scale = 1, ellipse = TRUE, groups = `2022.12.02_Transposed_RPMs_adjusted_seq_and_GC_bias_subsampled_novogene_paired_reads_to_single_contig_per_assembly_concatenated_all_good_Acomys_isolate_assemblies`$Host, ellipse.prob = 0.75, circle = TRUE, var.axes = FALSE, plot.loadings = TRUE) + theme_linedraw() + geom_point(aes(shape = factor(`2022.12.02_Transposed_RPMs_adjusted_seq_and_GC_bias_subsampled_novogene_paired_reads_to_single_contig_per_assembly_concatenated_all_good_Acomys_isolate_assemblies`$Month), color = factor(`2022.12.02_Transposed_RPMs_adjusted_seq_and_GC_bias_subsampled_novogene_paired_reads_to_single_contig_per_assembly_concatenated_all_good_Acomys_isolate_assemblies`$Host)), size = 4) + scale_color_manual(values = c("AC" = "#1e90ff", "AR" = "#ff8d1e")) + scale_shape_manual(values = c("J" = 17, "N" = 16)) + labs(shape="Month of collection", colour="Host species") + scale_x_continuous(labels = comma) + scale_y_continuous(labels = comma) + theme_classic() + theme(text = element_text(family = "Tex Gyre Heroes"))
`2023-05-10_mapping_novogene_to_isolate_assemblies_PCA_combined_figure_mappings_to_assemblies_by_origin_species_of_assembly` <- `2023.05.10.cahirinus_isolates_salmon_PCA_PC1_vs_PC2` / `2023.05.10.russatus_isolates_salmon_PCA_PC1_vs_PC2` + plot_annotation(tag_levels = 'A') 
ggsave(filename = "2023-05-10_mapping_novogene_to_isolate_assemblies_PCA_combined_figure_mappings_to_assemblies_by_origin_species_of_assembly.pdf", `2023-05-10_mapping_novogene_to_isolate_assemblies_PCA_combined_figure_mappings_to_assemblies_by_origin_species_of_assembly`)

#Getting some stuff for the isolate prokka annotations at the gene level to write about and for a table
`prokka_genes`
`prokka_genes_all_assemblies_summed`
`melted_prokka_genes_all_assemblies_summed`

tic()
`prokka_genes_all_assemblies_summed_v2` <- data.frame(matrix(ncol = 6, nrow = 0, dimnames = list(NULL, c("Gene.name","Assembly with most", "All.summed", "AC.summed", "AR.summed", "AP.summed"))))
for (coggle in as.list(unique(`prokka_genes`$variable))){
  cog.name.zoot <- paste(coggle)
  all.assemblies.cog.summed.zoot <- sum(`prokka_genes`[`prokka_genes`$variable == cog.name.zoot,]$value)
  AC.cog.summed.zoot <- sum(`prokka_genes`[`prokka_genes`$variable == cog.name.zoot & `prokka_genes`$Host == "AC",]$value)
  AR.cog.summed.zoot <- sum(`prokka_genes`[`prokka_genes`$variable == cog.name.zoot & `prokka_genes`$Host == "AR",]$value)
  AP.cog.summed.zoot <- sum(`prokka_genes`[`prokka_genes`$variable == cog.name.zoot & `prokka_genes`$Host == "AP",]$value)
  assembly.with.most.zoot <- as.character(head(`prokka_genes` %>% filter(variable == cog.name.zoot) %>% arrange(desc(value)), 1)$SampleID)
  `prokka_genes_all_assemblies_summed_v2`[nrow(`prokka_genes_all_assemblies_summed_v2`) + 1,] <- c(cog.name.zoot, assembly.with.most.zoot, all.assemblies.cog.summed.zoot, AC.cog.summed.zoot, AR.cog.summed.zoot, AP.cog.summed.zoot)
  `prokka_genes_all_assemblies_summed_v2`[,c(3:6)] <- sapply(`prokka_genes_all_assemblies_summed_v2`[,c(3:6)], as.numeric)
  rm(list=ls(pattern='*zoot'))
}
view(`prokka_genes_all_assemblies_summed_v2`)
write.table(`prokka_genes_all_assemblies_summed_v2`, file = "2023-05-10_Prokka_Genes_all_assemblies_exS125_simple_details.csv", sep=",", row.names=FALSE)
toc()

as.character(head(`prokka_genes` %>% filter(variable == "apt") %>% arrange(desc(value)), 1)$SampleID)

#Now making the combined reads to assemblies mapping figure which was in the discussion of the old paper, the rpms to mappings bar chart and the heat map of read species x sample month to assembly

smlf1 <- ggplot(data = `2022.12.03.melted.transposed.isolates_salmon`, aes(x = value)) + geom_histogram(binwidth = 10000, fill = "#6e7f80", color = "#0f0f0f") + geom_vline(aes(xintercept=mean(value)), color="#ff8d1e", linetype="dashed", size=0.85) + xlab("Reads per million (RPM)") + ylab("Number of mappings") + scale_x_continuous(labels = label_comma()) + theme_classic() + theme(text = element_text(family = "Tex Gyre Heroes", size = 14))
smlf2 <- ggplot(data = `2022.12.03.melted.transposed.isolates_salmon`, aes(y = variable, x = Host.x.month, fill = value)) + geom_tile() + scale_fill_gradient(low="white", high="#6700d1", name = "RPM", labels = label_comma()) + theme_classic() + ylab("Assembly isolate") + xlab("Host species and sampling month for faecal sample") + theme(text = element_text(family = "Tex Gyre Heroes", size = 14))

`2023-05-11_novogene_paired_mapping_isolate_assemblies_combined_fig_rpms_to_num_occurences_and_heatmap_hostxmonth_to_assembly` <- smlf1 + smlf2 + plot_layout(guides = "collect") + plot_annotation(tag_levels = 'A')

ggsave(filename = "2023-05-11_novogene_paired_mapping_isolate_assemblies_combined_fig_rpms_to_num_occurences_and_heatmap_hostxmonth_to_assembly.pdf", `2023-05-11_novogene_paired_mapping_isolate_assemblies_combined_fig_rpms_to_num_occurences_and_heatmap_hostxmonth_to_assembly`)

#2023-05-12
#Assemblies COG annotations getting info for the top 10 table.
`2023-05-12-isolate_assemblies_prokka_COGs_melted` <- `prokka_cogs`
tic()
`assemblies_COGs` <- data.frame(matrix(ncol = 6, nrow = 0, dimnames = list(NULL, c("COG","Assembly with most", "All.summed", "AC.summed", "AR.summed", "AP.summed"))))
for (coggle in as.list(unique(`prokka_cogs`$variable))){
  cog.name.zoot <- paste(coggle)
  all.assemblies.cog.summed.zoot <- sum(`prokka_cogs`[`prokka_cogs`$variable == cog.name.zoot,]$value)
  AC.cog.summed.zoot <- sum(`prokka_cogs`[`prokka_cogs`$variable == cog.name.zoot & `prokka_cogs`$Host == "AC",]$value)
  AR.cog.summed.zoot <- sum(`prokka_cogs`[`prokka_cogs`$variable == cog.name.zoot & `prokka_cogs`$Host == "AR",]$value)
  AP.cog.summed.zoot <- sum(`prokka_cogs`[`prokka_cogs`$variable == cog.name.zoot & `prokka_cogs`$Host == "AP",]$value)
  assembly.with.most.zoot <- as.character(head(`prokka_cogs` %>% filter(variable == cog.name.zoot) %>% arrange(desc(value)), 1)$SampleID)
  `assemblies_COGs`[nrow(`assemblies_COGs`) + 1,] <- c(cog.name.zoot, assembly.with.most.zoot, all.assemblies.cog.summed.zoot, AC.cog.summed.zoot, AR.cog.summed.zoot, AP.cog.summed.zoot)
  `assemblies_COGs`[,c(3:6)] <- sapply(`assemblies_COGs`[,c(3:6)], as.numeric)
  rm(list=ls(pattern='*zoot'))
}
view(`assemblies_COGs`)
write.table(`assemblies_COGs`, file = "2023-05-12_Prokka_COGs_all_assemblies_exS125_simple_details.csv", sep=",", row.names=FALSE)
toc()

#2023-05-15
#Making a missed mOTUs figure, summed all relative abundances for the hostxseason
view(`2023.04.29_melted_transposed_all_samples_relative_abundance_non_zero_refs_min_one_sample_all_possible`)

ggplot(data = `mOTUs_processed_rodents_refmotuses`, aes(x = AC.sum, y = AR.sum)) + geom_point() + scale_x_sqrt() + scale_y_sqrt()

`2023-05-16_supplemental_mOTUs_by_host_all_reads_square_root_transformed_sums_each_non_zero_refMOTU_jitter_plot` <- ggplot(data = `mOTUs_processed_rodents_refmotuses`[`mOTUs_processed_rodents_refmotuses`$AC.sum != 0 & `mOTUs_processed_rodents_refmotuses`$AR.sum != 0,], aes(x = AC.sum, y = AR.sum)) + geom_jitter(colour = "#8d1eff") + scale_x_sqrt() + scale_y_sqrt() + theme_classic() + xlab("Square root transformed\nsummed AC percent classified\n(%)") + ylab("Square root transformed\nsummed AR percent classified\n(%)") + theme(text = element_text(family = "Tex Gyre Heroes"))

ggsave(filename = "2023-05-16_supplemental_mOTUs_by_host_all_reads_square_root_transformed_sums_each_non_zero_refMOTU_jitter_plot.pdf", `2023-05-16_supplemental_mOTUs_by_host_all_reads_square_root_transformed_sums_each_non_zero_refMOTU_jitter_plot`)

`prokka_genes_all_assemblies_summed_v2`

as.numeric(nrow(as.data.frame(`prokka_genes_all_assemblies_summed_v2`[`prokka_genes_all_assemblies_summed_v2`$AC.summed != 0 & `prokka_genes_all_assemblies_summed_v2`$AR.summed == 0 & `prokka_genes_all_assemblies_summed_v2`$AP.summed == 0,]))) - 317
as.numeric(nrow(as.data.frame(`prokka_genes_all_assemblies_summed_v2`[`prokka_genes_all_assemblies_summed_v2`$AR.summed != 0 & `prokka_genes_all_assemblies_summed_v2`$AC.summed == 0 & `prokka_genes_all_assemblies_summed_v2`$AP.summed == 0,]))) - 355
as.numeric(nrow(as.data.frame(`prokka_genes_all_assemblies_summed_v2`[`prokka_genes_all_assemblies_summed_v2`$AP.summed != 0 & `prokka_genes_all_assemblies_summed_v2`$AR.summed == 0 & `prokka_genes_all_assemblies_summed_v2`$AC.summed == 0,]))) - 122

`2023.02.21_melted_transposed_Prokka_all_isolate_assemblies_exS125_all_possible_genes_from_all_assemblies_counts_per_assembly`
bca_1 - unknown
bca_2 - unknown
dgaR_1 - presume also glucose catabolism
dgaR_2 - glucose catabolism
nhaK_1 - presume a pump as well
nhaK_2 - sodium proton antiporter gene associated with thermotolerance (https://pubmed.ncbi.nlm.nih.gov/32015144/)
noxE - remove oxygen from milk (https://www.ncbi.nlm.nih.gov/pmc/articles/PMC2832378/)
as.numeric(nrow(as.data.frame(unique(`2023.02.21_melted_transposed_Prokka_all_isolate_assemblies_exS125_all_possible_genes_from_all_assemblies_counts_per_assembly`[`2023.02.21_melted_transposed_Prokka_all_isolate_assemblies_exS125_all_possible_genes_from_all_assemblies_counts_per_assembly`$variable == "bca_1" & `2023.02.21_melted_transposed_Prokka_all_isolate_assemblies_exS125_all_possible_genes_from_all_assemblies_counts_per_assembly`$Host == "AP",]))))

#Bad bins stuff, just a simple figure and a little bit of text needed I think
`2023.05.16_bad_bins_gtdbtk_family_classifications` <- read.csv("~/Google Drive/PhD/2022-Paper_2-Chapter_3/2023-05-16_bad_bins_gtdbtk_family_classifications.csv")
view(`2023.05.16_bad_bins_gtdbtk_family_classifications`)

`2023.05.16_bad_bins_gtdbtk_genera_classifications` <- read.csv("~/Google Drive/PhD/2022-Paper_2-Chapter_3/2023-05-16_bad_bins_gtdbtk_genera_classifications.csv")
view(`2023.05.16_bad_bins_gtdbtk_genera_classifications`)

`2023.05.16_gtdbtk_strict_versus_bad_bins_family_level` <- read.csv("~/Google Drive/PhD/2022-Paper_2-Chapter_3/2023-05-16_gtdbtk_strict_versus_bad_bins_family_level.csv")
view(`2023.05.16_gtdbtk_strict_versus_bad_bins_family_level`)

`2023-05-16_family_level_bins_pass_vs_fail` <- ggplot(data = `2023.05.16_gtdbtk_strict_versus_bad_bins_family_level` %>% filter(Failed.bins != 0), aes(x = Passed.bins, y = Failed.bins)) + geom_point(colour = "#8d1eff") + theme_classic() + xlab("Number of bins\npassing QC") + ylab("Number of bins\nfailing QC") + theme(text = element_text(family = "Tex Gyre Heroes"))

`2023.05.16_gtdbtk_strict_versus_bad_bins_genus_level` <- read.csv("~/Google Drive/PhD/2022-Paper_2-Chapter_3/2023-05-16_gtdbtk_strict_versus_bad_bins_genus_level.csv")

`2023-05-16_genus_level_bins_pass_vs_fail` <- ggplot(data = `2023.05.16_gtdbtk_strict_versus_bad_bins_genus_level` %>% filter(Failed.bins != 0), aes(x = Passed.bins, y = Failed.bins)) + geom_jitter(colour = "#00d167") + theme_classic() + xlab("Number of bins\npassing QC") + ylab("Number of bins\nfailing QC") + theme(text = element_text(family = "Tex Gyre Heroes"))

`2023-05-16_gtdbtk_strict_vs_failing_bins_family_and_genus_number_bins_classified_combined_figure` <- `2023-05-16_family_level_bins_pass_vs_fail` + `2023-05-16_genus_level_bins_pass_vs_fail` + plot_annotation(tag_levels = 'A')

ggsave(filename = "2023-05-16_gtdbtk_strict_vs_failing_bins_family_and_genus_number_bins_classified_combined_figure.pdf", `2023-05-16_gtdbtk_strict_vs_failing_bins_family_and_genus_number_bins_classified_combined_figure`)

#2023-05-23
#Looking for any probiotic associated genes in the assemblies
as.numeric(nrow(as.data.frame(unique(`prokka_genes` %>% filter(variable == "dgkA") %>% filter(value != 0) %>% filter(Host != "AP"))$Gene)))

#2023-04-29
#Trying the R image you made on the cluster

#Directory where stuff will happen
/hpc-home/osbourne/R_session_stuff

#R image path
/hpc-home/osbourne/Docker_images/2023_04_25-POsborne_R_overlay_thesis_corrections.img

#Running the R image
singularity exec --overlay /hpc-home/osbourne/Docker_images/2023_04_25-POsborne_R_overlay_thesis_corrections.img /ei/software/containers/5e4fe75c-b9b4-4951-89ad-7431eaa78f97/5e4fe75c-b9b4-4951-89ad-7431eaa78f97.img R


#Command to load the workspace
load("2023-04-26.RData")

#Command to set working directory
setwd("/hpc-home/osbourne/R_session_stuff")
#End R sessions using the image with
q("")
n

#2023-06-14
#Stacked bar charts at phylum level for motus in response to latest whinge from falk
View(`2023.06.14_transposed_relative_abundances_pilot_samples_summed_phyla_motus`)
`2023.06.14_melted_transposed_relative_abundances_pilot_samples_summed_phyla_motus` <- reshape2::melt(`2023.06.14_transposed_relative_abundances_pilot_samples_summed_phyla_motus`, id = c("Phylum", "Host", "Status"))
View(`2023.06.14_melted_transposed_relative_abundances_pilot_samples_summed_phyla_motus`)

#Making the list of phyla by summed values
`pilot_phyla_motus_summed` <- data.frame(matrix(ncol = 2, nrow = 0, dimnames = list(NULL, c("Phylum", "Summed.value"))))
for (reference in as.list(unique(`2023.06.14_melted_transposed_relative_abundances_pilot_samples_summed_phyla_motus`$variable))) {
    phylum.zoot <- paste(reference)
    summed.zoot <- sum(`2023.06.14_melted_transposed_relative_abundances_pilot_samples_summed_phyla_motus`[`2023.06.14_melted_transposed_relative_abundances_pilot_samples_summed_phyla_motus`$variable == phylum.zoot,]$value)
    `pilot_phyla_motus_summed`[nrow(`pilot_phyla_motus_summed`) +1,] <- c(phylum.zoot, summed.zoot)
    `pilot_phyla_motus_summed`[,c(2)] <- sapply(`pilot_phyla_motus_summed`[,c(2)], as.numeric)
    rm(list=ls(pattern='*zoot'))
}

#Making processed and raw versions for ease of plotting each seperately for the pilot samples
`pilot_motus_phyla_processed` <- `2023.06.14_melted_transposed_relative_abundances_pilot_samples_summed_phyla_motus`[grepl("*PROCESSED", `2023.06.14_melted_transposed_relative_abundances_pilot_samples_summed_phyla_motus`$Phylum),] %>% mutate(Phylum = sub("_PROCESSED", "", Phylum, fixed=TRUE))

`pilot_motus_phyla_raw` <- `2023.06.14_melted_transposed_relative_abundances_pilot_samples_summed_phyla_motus`[grepl("*RAW", `2023.06.14_melted_transposed_relative_abundances_pilot_samples_summed_phyla_motus`$Phylum),] %>% mutate(Phylum = sub("_RAW", "", Phylum, fixed=TRUE))

#Processed figure 
`2023-06-14_motus_pilot_summed_phyla_rel_abundances_from_output_PROCESSED_files` <- ggplot(data = `pilot_motus_phyla_processed`[`pilot_motus_phyla_processed`$variable %in% head(`pilot_phyla_motus_summed` %>% filter(Summed.value != 0) %>% arrange(desc(Summed.value)), 10)$Phylum & ! grepl("Bacteria.phylum*", `pilot_motus_phyla_processed`$variable),], aes(x = Phylum, y = (100*value), fill = variable)) + geom_bar(position="stack", stat = "identity") + theme_classic() + theme(text = element_text(family = "Tex Gyre Heroes"), axis.text.x=element_text(angle = -90, hjust = 0)) + facet_wrap(~ Host, scales = "free_x") + scale_fill_manual(name = "Phylum",values=as.vector(kelly(15))) + xlab("Sample ID") + ylab("Summed relative abundance all phylum members * 100")

#Raw figure
`2023-06-14_motus_pilot_summed_phyla_rel_abundances_from_output_RAW_files` <- ggplot(data = `pilot_motus_phyla_raw`[`pilot_motus_phyla_raw`$variable %in% head(`pilot_phyla_motus_summed` %>% filter(Summed.value != 0) %>% arrange(desc(Summed.value)), 10)$Phylum & ! grepl("Bacteria.phylum*", `pilot_motus_phyla_raw`$variable),], aes(x = Phylum, y = (100*value), fill = variable)) + geom_bar(position="stack", stat = "identity") + theme_classic() + theme(text = element_text(family = "Tex Gyre Heroes"), axis.text.x=element_text(angle = -90, hjust = 0)) + facet_wrap(~ Host, scales = "free_x") + scale_fill_manual(name = "Phylum",values=as.vector(kelly(15))) + xlab("Sample ID") + ylab("")

`2023-06-14_combined_pilot_motus_summed_phyla_relative_abundances_A_is_processed_B_is_raw_files` <- `2023-06-14_motus_pilot_summed_phyla_rel_abundances_from_output_PROCESSED_files` + `2023-06-14_motus_pilot_summed_phyla_rel_abundances_from_output_RAW_files` + plot_layout(guides = "collect") + plot_annotation(tag_levels = 'A')

ggsave(filename = "2023-06-14_combined_pilot_motus_summed_phyla_relative_abundances_A_is_processed_B_is_raw_files.pdf", `2023-06-14_combined_pilot_motus_summed_phyla_relative_abundances_A_is_processed_B_is_raw_files`)

#Now the processed all samples results
`2023.06.14_transposed_summed_phylum_level_relative_abundances` <- read.csv("~/Google Drive/PhD/2023-06-14_transposed_summed_phylum_level_relative_abundances.csv")
`tempor_df` <- reshape2::melt(`2023.06.14_transposed_summed_phylum_level_relative_abundances`, id = c ("Phylum", "Host", "Season", "Host.and.season"))
`2023.06.14_melted_transposed_summed_phylum_level_relative_abundances` <- `tempor_df`[! grepl("Bacteria.phylum*", `tempor_df`$variable),]
`everything_phyla_motus_summed` <- data.frame(matrix(ncol = 2, nrow = 0, dimnames = list(NULL, c("Phylum", "Summed.value"))))
for (reference in as.list(unique(`2023.06.14_melted_transposed_summed_phylum_level_relative_abundances`$variable))) {
    phylum.zoot <- paste(reference)
    summed.zoot <- sum(`2023.06.14_melted_transposed_summed_phylum_level_relative_abundances`[`2023.06.14_melted_transposed_summed_phylum_level_relative_abundances`$variable == phylum.zoot,]$value)
    `everything_phyla_motus_summed`[nrow(`everything_phyla_motus_summed`) +1,] <- c(phylum.zoot, summed.zoot)
    `everything_phyla_motus_summed`[,c(2)] <- sapply(`everything_phyla_motus_summed`[,c(2)], as.numeric)
    rm(list=ls(pattern='*zoot'))
}
View(`everything_phyla_motus_summed`)
`2023-06-14_motus_all_samples_summed_phyla_rel_abundances_from_output` <- ggplot(data = `2023.06.14_melted_transposed_summed_phylum_level_relative_abundances`[`2023.06.14_melted_transposed_summed_phylum_level_relative_abundances`$variable %in% head(`everything_phyla_motus_summed` %>% filter(Summed.value != 0) %>% arrange(desc(Summed.value)), 10)$Phylum,], aes(x = Phylum, y = (100*value), fill = variable)) + geom_bar(position="stack", stat = "identity") + theme_classic() + theme(text = element_text(family = "Tex Gyre Heroes"), axis.text.x=element_text(angle = -90, hjust = 0)) + facet_wrap(~ Host.and.season, scales = "free_x") + scale_fill_manual(name = "Phylum",values=as.vector(kelly(10))) + xlab("Sample ID") + ylab("Summed relative abundance all phylum members * 100")

ggsave(filename = "2023-06-14_motus_all_samples_summed_phyla_rel_abundances_from_output.pdf", `2023-06-14_motus_all_samples_summed_phyla_rel_abundances_from_output`)

#Trying it with the genera summed results, full sample set first
`2023.06.14_transposed_summed_genus_level_relative_abundances` <- read.csv("~/Google Drive/PhD/2023-06-14_transposed_relative_abundances_all_processed_Acomys_summed_genus_relative_abundance_mOTUs.csv")
View(`2023.06.14_transposed_summed_genus_level_relative_abundances`)
temp_genus_melt <- reshape2::melt(`2023.06.14_transposed_summed_genus_level_relative_abundances`, id = c("Sample.ID", "Host", "Season", "Host.and.season"))
View(temp_genus_melt)
`2023.06.14_melted_transposed_summed_genus_level_relative_abundances` <- `temp_genus_melt`[! grepl("*sedis", `temp_genus_melt`$variable) & ! grepl("Clostridiales.gen..*", `temp_genus_melt`$variable),]
View(`2023.06.14_melted_transposed_summed_genus_level_relative_abundances`)

tic()
`everything_genus_motus_summed` <- data.frame(matrix(ncol = 2, nrow = 0, dimnames = list(NULL, c("Genus", "Summed.value"))))
for (reference in as.list(unique(`2023.06.14_melted_transposed_summed_genus_level_relative_abundances`$variable))) {
    phylum.zoot <- paste(reference)
    summed.zoot <- sum(`2023.06.14_melted_transposed_summed_genus_level_relative_abundances`[`2023.06.14_melted_transposed_summed_genus_level_relative_abundances`$variable == phylum.zoot,]$value)
    `everything_genus_motus_summed`[nrow(`everything_genus_motus_summed`) +1,] <- c(phylum.zoot, summed.zoot)
    `everything_genus_motus_summed`[,c(2)] <- sapply(`everything_genus_motus_summed`[,c(2)], as.numeric)
    rm(list=ls(pattern='*zoot'))
}
View(`everything_genus_motus_summed`)
toc()

`2023-06-14_motus_all_samples_summed_genera_rel_abundances_from_output` <- ggplot(data = `2023.06.14_melted_transposed_summed_genus_level_relative_abundances`[`2023.06.14_melted_transposed_summed_genus_level_relative_abundances`$variable %in% head(`everything_genus_motus_summed` %>% filter(Summed.value != 0) %>% arrange(desc(Summed.value)), 10)$Genus,], aes(x = Sample.ID, y = (100*value), fill = variable)) + geom_bar(position="stack", stat = "identity") + theme_classic() + theme(text = element_text(family = "Tex Gyre Heroes"), axis.text.x=element_text(angle = -90, hjust = 0)) + facet_wrap(~ Host.and.season, scales = "free_x") + scale_fill_manual(name = "Genus",values=as.vector(kelly(10))) + xlab("Sample ID") + ylab("Summed relative abundance all genus members * 100")

ggsave(filename = "2023-06-14_motus_all_samples_summed_genera_rel_abundances_from_output.pdf", `2023-06-14_motus_all_samples_summed_genera_rel_abundances_from_output`)

#Now some stuff for prose for the motus shit
median(`2023.06.14_melted_transposed_summed_phylum_level_relative_abundances`[`2023.06.14_melted_transposed_summed_phylum_level_relative_abundances`$variable == "Bacteroidetes" & `2023.06.14_melted_transposed_summed_phylum_level_relative_abundances`$Host == "AC",]$value)

as.numeric(nrow(as.data.frame(unique(`2023.06.14_melted_transposed_summed_genus_level_relative_abundances`[`2023.06.14_melted_transposed_summed_genus_level_relative_abundances`$variable == "Lactobacillus" & `2023.06.14_melted_transposed_summed_genus_level_relative_abundances`$value >= 0.5,]$Sample.ID))))

as.numeric(nrow(as.data.frame(`everything_phyla_motus_summed`[`everything_phyla_motus_summed`$Summed.value != 0,])))

#Maybe a figure to show the genera with the greatest host x seasonal differences?
ggboxplot(`2023.06.14_melted_transposed_summed_genus_level_relative_abundances`[`2023.06.14_melted_transposed_summed_genus_level_relative_abundances`$variable %in% head(`everything_genus_motus_summed` %>% filter(Summed.value != 0) %>% arrange(desc(Summed.value)), 10)$Genus,], x = "Host.and.season", y = "value", colour = "dose", palette = c("ACJ" = "#1ec8ff", "ACN" = "#006ad1", "ARJ" = "#ff551e", "ARN" = "#d16700"), add = "jitter", shape = "Host.and.season") + stat_compare_means

ggplot(data = `2023.06.14_melted_transposed_summed_genus_level_relative_abundances`[`2023.06.14_melted_transposed_summed_genus_level_relative_abundances`$variable %in% head(`everything_genus_motus_summed` %>% filter(Summed.value != 0) %>% arrange(desc(Summed.value)), 10)$Genus,], aes(x = Host.and.season, y = value, fill = Host.and.season)) + geom_boxplot() + theme_classic() + xlab("Host and collection month") + ylab("Relative abundance") + theme(text = element_text(family = "Tex Gyre Heroes")) + scale_fill_manual(name = "Host species and\ncollection month", values = c("ACJ" = "#1ec8ff", "ACN" = "#006ad1", "ARJ" = "#ff551e", "ARN" = "#d16700")) + facet_wrap(~ variable, scales = "free") + stat_compare_means(comparisons = `host_and_season_comparisons`, label = "p.signif", hide.ns = TRUE)

`host_and_season_comparisons` <- list( c("ACJ", "ACN"), c("ARJ", "ARN"), c("ACJ", "ARJ"), c("ACN", "ARN"), c("ACJ", "ARN"), c("ACN", "ARJ"))

`2023-06-15_motus_all_processed_samples_10_most_abundant_genera_box_plots_host_and_month` <- ggboxplot(`2023.06.14_melted_transposed_summed_genus_level_relative_abundances`[`2023.06.14_melted_transposed_summed_genus_level_relative_abundances`$variable %in% head(`everything_genus_motus_summed` %>% filter(Summed.value != 0) %>% arrange(desc(Summed.value)), 10)$Genus,], x = "Host.and.season", y = "value", fill = "Host.and.season", palette = c("#1ec8ff", "#006ad1", "#ff551e", "#d16700"), xlab = "Host and sampling month", ylab = "Relative abundance", font.family = "Tex Gyre Heroes", legend.title = "Host species and sampling month")  + facet_wrap(~ variable, scales = "free")

ggsave(filename = "2023-06-15_motus_all_processed_samples_10_most_abundant_genera_box_plots_host_and_month.pdf", `2023-06-15_motus_all_processed_samples_10_most_abundant_genera_box_plots_host_and_month`)

kruskal.test(value ~ Host.and.season, data = `2023.06.14_melted_transposed_summed_genus_level_relative_abundances`[`2023.06.14_melted_transposed_summed_genus_level_relative_abundances`$variable == "Bifidobacterium" & `2023.06.14_melted_transposed_summed_genus_level_relative_abundances`$Host == "AC",])

kruskal.test(value ~ Host.and.season, data = `2023.06.14_melted_transposed_summed_genus_level_relative_abundances`[`2023.06.14_melted_transposed_summed_genus_level_relative_abundances`$variable == "Lachnospira" & `2023.06.14_melted_transposed_summed_genus_level_relative_abundances`$Host == "AC",])

ggboxplot(`2023.06.14_melted_transposed_summed_genus_level_relative_abundances`[`2023.06.14_melted_transposed_summed_genus_level_relative_abundances`$variable %in% head(`everything_genus_motus_summed` %>% filter(Summed.value != 0) %>% arrange(desc(Summed.value)), 10)$Genus,], x = "Host", y = "value", fill = "Host", palette = c("#1e90ff", "#ff8d1e"), xlab = "Host species", ylab = "Relative abundance", font.family = "Tex Gyre Heroes", legend.title = "Host species") + geom_pwc(label = "{p.signif}", p.adjust.method = "BH", p.adjust.by = "panel", hide.ns = TRUE, step.increase = 0.1) + facet_wrap(~ variable, scales = "free")

#Some bits copied over from the old R scrapbook which you had used for some of the corrections stuff for some reason, or copied over because the figure it made was used in the corrected thesis
`2023-02-28_combined_COGs_prokka_hypergeometric_plots_figure` <- `2023-02-27_Prokka_COGS_all_assemblies_exS125_hypergeometric_results_figure` + `2023-02-27_Prokka_COGs_halotolerance_tested_assemblies_hypergeometric_test_BH_corrected_Pvalues_plot` + plot_annotation(tag_levels = 'A')
ggsave(filename = "/Users/osbourne/Google Drive/PhD/2022-03-26_Paper_3_Chapter_4-Culture_isolates_based_work/2023-02-28_combined_COGs_prokka_hypergeometric_plots_figure.pdf", `2023-02-28_combined_COGs_prokka_hypergeometric_plots_figure`)
`2023-02-28_combined_genes_prokka_hypergeometric_plots_figure` <- `2023-02-27_Prokka_genes_all_assemblies_exS125_hypergeometric_results_figure` + `2023-02-27_Prokka_genes_halotolerance_tested_assemblies_hypergeometric_test_BH_corrected_Pvalues_plot` + plot_annotation(tag_levels = 'A')
ggsave(filename = "/Users/osbourne/Google Drive/PhD/2022-03-26_Paper_3_Chapter_4-Culture_isolates_based_work/2023-02-28_combined_genes_prokka_hypergeometric_plots_figure.pdf", `2023-02-28_combined_genes_prokka_hypergeometric_plots_figure`)

`2022.11.27.all_isolates_500bp_min_contig_size_SPADES_assemblies_number_contigs_box_and_violin_plot_facet_by_host_species_or_genus` <- ggplot(data = `2022.11.27.Melted_all_isolates_some_checkm_results_plus_host_species`[`2022.11.27.Melted_all_isolates_some_checkm_results_plus_host_species`$variable == "Number.contigs",], aes(x = Host.species, y = value, fill = Host.species)) + xlab("Host species or genus") + ylab ("Number of contigs in assembly") + geom_violin() + geom_boxplot(fill = "#e4e6e8", alpha = 0.6, width = 0.35) + scale_fill_manual(values = c("#1e90ff", "#8d1eff", "#ff8d1e"), name = "Host species/genus") + theme_classic() + theme(text = element_text(family = "Tex Gyre Heroes", size = 22)) + facet_wrap(~ Host.species, scales = "free_x")
ggsave(filename = "2022.11.27.all_isolates_500bp_min_contig_size_SPADES_assemblies_number_contigs_box_and_violin_plot_facet_by_host_species_or_genus.pdf", `2022.11.27.all_isolates_500bp_min_contig_size_SPADES_assemblies_number_contigs_box_and_violin_plot_facet_by_host_species_or_genus`)
