Bin_c14_bin_name <- "Bin_c14"
Bin_c14_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c14", ])
Bin_c14_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c14", ])
Bin_c14_host_pvalue <- Bin_c14_host_kruskal$p.value
Bin_c14_season_pvalue <- Bin_c14_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_c14_bin_name, Bin_c14_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_c14_bin_name, Bin_c14_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_c14_bin_name)
rm(Bin_c14_host_kruskal)
rm(Bin_c14_season_kruskal)
rm(Bin_c14_host_pvalue)
rm(Bin_c14_season_pvalue)

Bin_c17_bin_name <- "Bin_c17"
Bin_c17_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c17", ])
Bin_c17_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c17", ])
Bin_c17_host_pvalue <- Bin_c17_host_kruskal$p.value
Bin_c17_season_pvalue <- Bin_c17_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_c17_bin_name, Bin_c17_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_c17_bin_name, Bin_c17_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_c17_bin_name)
rm(Bin_c17_host_kruskal)
rm(Bin_c17_season_kruskal)
rm(Bin_c17_host_pvalue)
rm(Bin_c17_season_pvalue)

Bin_c24_bin_name <- "Bin_c24"
Bin_c24_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c24", ])
Bin_c24_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c24", ])
Bin_c24_host_pvalue <- Bin_c24_host_kruskal$p.value
Bin_c24_season_pvalue <- Bin_c24_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_c24_bin_name, Bin_c24_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_c24_bin_name, Bin_c24_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_c24_bin_name)
rm(Bin_c24_host_kruskal)
rm(Bin_c24_season_kruskal)
rm(Bin_c24_host_pvalue)
rm(Bin_c24_season_pvalue)

Bin_c31_bin_name <- "Bin_c31"
Bin_c31_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c31", ])
Bin_c31_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c31", ])
Bin_c31_host_pvalue <- Bin_c31_host_kruskal$p.value
Bin_c31_season_pvalue <- Bin_c31_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_c31_bin_name, Bin_c31_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_c31_bin_name, Bin_c31_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_c31_bin_name)
rm(Bin_c31_host_kruskal)
rm(Bin_c31_season_kruskal)
rm(Bin_c31_host_pvalue)
rm(Bin_c31_season_pvalue)

Bin_c36_bin_name <- "Bin_c36"
Bin_c36_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c36", ])
Bin_c36_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c36", ])
Bin_c36_host_pvalue <- Bin_c36_host_kruskal$p.value
Bin_c36_season_pvalue <- Bin_c36_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_c36_bin_name, Bin_c36_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_c36_bin_name, Bin_c36_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_c36_bin_name)
rm(Bin_c36_host_kruskal)
rm(Bin_c36_season_kruskal)
rm(Bin_c36_host_pvalue)
rm(Bin_c36_season_pvalue)

Bin_c40_bin_name <- "Bin_c40"
Bin_c40_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c40", ])
Bin_c40_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c40", ])
Bin_c40_host_pvalue <- Bin_c40_host_kruskal$p.value
Bin_c40_season_pvalue <- Bin_c40_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_c40_bin_name, Bin_c40_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_c40_bin_name, Bin_c40_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_c40_bin_name)
rm(Bin_c40_host_kruskal)
rm(Bin_c40_season_kruskal)
rm(Bin_c40_host_pvalue)
rm(Bin_c40_season_pvalue)

Bin_c41_bin_name <- "Bin_c41"
Bin_c41_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c41", ])
Bin_c41_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c41", ])
Bin_c41_host_pvalue <- Bin_c41_host_kruskal$p.value
Bin_c41_season_pvalue <- Bin_c41_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_c41_bin_name, Bin_c41_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_c41_bin_name, Bin_c41_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_c41_bin_name)
rm(Bin_c41_host_kruskal)
rm(Bin_c41_season_kruskal)
rm(Bin_c41_host_pvalue)
rm(Bin_c41_season_pvalue)

Bin_c43_bin_name <- "Bin_c43"
Bin_c43_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c43", ])
Bin_c43_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c43", ])
Bin_c43_host_pvalue <- Bin_c43_host_kruskal$p.value
Bin_c43_season_pvalue <- Bin_c43_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_c43_bin_name, Bin_c43_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_c43_bin_name, Bin_c43_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_c43_bin_name)
rm(Bin_c43_host_kruskal)
rm(Bin_c43_season_kruskal)
rm(Bin_c43_host_pvalue)
rm(Bin_c43_season_pvalue)

Bin_c51_bin_name <- "Bin_c51"
Bin_c51_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c51", ])
Bin_c51_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c51", ])
Bin_c51_host_pvalue <- Bin_c51_host_kruskal$p.value
Bin_c51_season_pvalue <- Bin_c51_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_c51_bin_name, Bin_c51_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_c51_bin_name, Bin_c51_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_c51_bin_name)
rm(Bin_c51_host_kruskal)
rm(Bin_c51_season_kruskal)
rm(Bin_c51_host_pvalue)
rm(Bin_c51_season_pvalue)

Bin_c52_bin_name <- "Bin_c52"
Bin_c52_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c52", ])
Bin_c52_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c52", ])
Bin_c52_host_pvalue <- Bin_c52_host_kruskal$p.value
Bin_c52_season_pvalue <- Bin_c52_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_c52_bin_name, Bin_c52_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_c52_bin_name, Bin_c52_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_c52_bin_name)
rm(Bin_c52_host_kruskal)
rm(Bin_c52_season_kruskal)
rm(Bin_c52_host_pvalue)
rm(Bin_c52_season_pvalue)

Bin_c55_bin_name <- "Bin_c55"
Bin_c55_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c55", ])
Bin_c55_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c55", ])
Bin_c55_host_pvalue <- Bin_c55_host_kruskal$p.value
Bin_c55_season_pvalue <- Bin_c55_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_c55_bin_name, Bin_c55_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_c55_bin_name, Bin_c55_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_c55_bin_name)
rm(Bin_c55_host_kruskal)
rm(Bin_c55_season_kruskal)
rm(Bin_c55_host_pvalue)
rm(Bin_c55_season_pvalue)

Bin_c58_bin_name <- "Bin_c58"
Bin_c58_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c58", ])
Bin_c58_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c58", ])
Bin_c58_host_pvalue <- Bin_c58_host_kruskal$p.value
Bin_c58_season_pvalue <- Bin_c58_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_c58_bin_name, Bin_c58_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_c58_bin_name, Bin_c58_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_c58_bin_name)
rm(Bin_c58_host_kruskal)
rm(Bin_c58_season_kruskal)
rm(Bin_c58_host_pvalue)
rm(Bin_c58_season_pvalue)

Bin_c59_bin_name <- "Bin_c59"
Bin_c59_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c59", ])
Bin_c59_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c59", ])
Bin_c59_host_pvalue <- Bin_c59_host_kruskal$p.value
Bin_c59_season_pvalue <- Bin_c59_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_c59_bin_name, Bin_c59_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_c59_bin_name, Bin_c59_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_c59_bin_name)
rm(Bin_c59_host_kruskal)
rm(Bin_c59_season_kruskal)
rm(Bin_c59_host_pvalue)
rm(Bin_c59_season_pvalue)

Bin_c72_bin_name <- "Bin_c72"
Bin_c72_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c72", ])
Bin_c72_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c72", ])
Bin_c72_host_pvalue <- Bin_c72_host_kruskal$p.value
Bin_c72_season_pvalue <- Bin_c72_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_c72_bin_name, Bin_c72_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_c72_bin_name, Bin_c72_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_c72_bin_name)
rm(Bin_c72_host_kruskal)
rm(Bin_c72_season_kruskal)
rm(Bin_c72_host_pvalue)
rm(Bin_c72_season_pvalue)

Bin_c78_bin_name <- "Bin_c78"
Bin_c78_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c78", ])
Bin_c78_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c78", ])
Bin_c78_host_pvalue <- Bin_c78_host_kruskal$p.value
Bin_c78_season_pvalue <- Bin_c78_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_c78_bin_name, Bin_c78_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_c78_bin_name, Bin_c78_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_c78_bin_name)
rm(Bin_c78_host_kruskal)
rm(Bin_c78_season_kruskal)
rm(Bin_c78_host_pvalue)
rm(Bin_c78_season_pvalue)

Bin_c82_bin_name <- "Bin_c82"
Bin_c82_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c82", ])
Bin_c82_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c82", ])
Bin_c82_host_pvalue <- Bin_c82_host_kruskal$p.value
Bin_c82_season_pvalue <- Bin_c82_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_c82_bin_name, Bin_c82_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_c82_bin_name, Bin_c82_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_c82_bin_name)
rm(Bin_c82_host_kruskal)
rm(Bin_c82_season_kruskal)
rm(Bin_c82_host_pvalue)
rm(Bin_c82_season_pvalue)

Bin_c83_bin_name <- "Bin_c83"
Bin_c83_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c83", ])
Bin_c83_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c83", ])
Bin_c83_host_pvalue <- Bin_c83_host_kruskal$p.value
Bin_c83_season_pvalue <- Bin_c83_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_c83_bin_name, Bin_c83_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_c83_bin_name, Bin_c83_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_c83_bin_name)
rm(Bin_c83_host_kruskal)
rm(Bin_c83_season_kruskal)
rm(Bin_c83_host_pvalue)
rm(Bin_c83_season_pvalue)

Bin_c89_bin_name <- "Bin_c89"
Bin_c89_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c89", ])
Bin_c89_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c89", ])
Bin_c89_host_pvalue <- Bin_c89_host_kruskal$p.value
Bin_c89_season_pvalue <- Bin_c89_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_c89_bin_name, Bin_c89_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_c89_bin_name, Bin_c89_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_c89_bin_name)
rm(Bin_c89_host_kruskal)
rm(Bin_c89_season_kruskal)
rm(Bin_c89_host_pvalue)
rm(Bin_c89_season_pvalue)

Bin_c90_bin_name <- "Bin_c90"
Bin_c90_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c90", ])
Bin_c90_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c90", ])
Bin_c90_host_pvalue <- Bin_c90_host_kruskal$p.value
Bin_c90_season_pvalue <- Bin_c90_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_c90_bin_name, Bin_c90_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_c90_bin_name, Bin_c90_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_c90_bin_name)
rm(Bin_c90_host_kruskal)
rm(Bin_c90_season_kruskal)
rm(Bin_c90_host_pvalue)
rm(Bin_c90_season_pvalue)

Bin_c94_bin_name <- "Bin_c94"
Bin_c94_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c94", ])
Bin_c94_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c94", ])
Bin_c94_host_pvalue <- Bin_c94_host_kruskal$p.value
Bin_c94_season_pvalue <- Bin_c94_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_c94_bin_name, Bin_c94_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_c94_bin_name, Bin_c94_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_c94_bin_name)
rm(Bin_c94_host_kruskal)
rm(Bin_c94_season_kruskal)
rm(Bin_c94_host_pvalue)
rm(Bin_c94_season_pvalue)

Bin_c99_bin_name <- "Bin_c99"
Bin_c99_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c99", ])
Bin_c99_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c99", ])
Bin_c99_host_pvalue <- Bin_c99_host_kruskal$p.value
Bin_c99_season_pvalue <- Bin_c99_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_c99_bin_name, Bin_c99_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_c99_bin_name, Bin_c99_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_c99_bin_name)
rm(Bin_c99_host_kruskal)
rm(Bin_c99_season_kruskal)
rm(Bin_c99_host_pvalue)
rm(Bin_c99_season_pvalue)

Bin_c101_bin_name <- "Bin_c101"
Bin_c101_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c101", ])
Bin_c101_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c101", ])
Bin_c101_host_pvalue <- Bin_c101_host_kruskal$p.value
Bin_c101_season_pvalue <- Bin_c101_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_c101_bin_name, Bin_c101_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_c101_bin_name, Bin_c101_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_c101_bin_name)
rm(Bin_c101_host_kruskal)
rm(Bin_c101_season_kruskal)
rm(Bin_c101_host_pvalue)
rm(Bin_c101_season_pvalue)

Bin_c112_bin_name <- "Bin_c112"
Bin_c112_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c112", ])
Bin_c112_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c112", ])
Bin_c112_host_pvalue <- Bin_c112_host_kruskal$p.value
Bin_c112_season_pvalue <- Bin_c112_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_c112_bin_name, Bin_c112_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_c112_bin_name, Bin_c112_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_c112_bin_name)
rm(Bin_c112_host_kruskal)
rm(Bin_c112_season_kruskal)
rm(Bin_c112_host_pvalue)
rm(Bin_c112_season_pvalue)

Bin_c113_bin_name <- "Bin_c113"
Bin_c113_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c113", ])
Bin_c113_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c113", ])
Bin_c113_host_pvalue <- Bin_c113_host_kruskal$p.value
Bin_c113_season_pvalue <- Bin_c113_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_c113_bin_name, Bin_c113_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_c113_bin_name, Bin_c113_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_c113_bin_name)
rm(Bin_c113_host_kruskal)
rm(Bin_c113_season_kruskal)
rm(Bin_c113_host_pvalue)
rm(Bin_c113_season_pvalue)

Bin_c115_bin_name <- "Bin_c115"
Bin_c115_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c115", ])
Bin_c115_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c115", ])
Bin_c115_host_pvalue <- Bin_c115_host_kruskal$p.value
Bin_c115_season_pvalue <- Bin_c115_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_c115_bin_name, Bin_c115_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_c115_bin_name, Bin_c115_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_c115_bin_name)
rm(Bin_c115_host_kruskal)
rm(Bin_c115_season_kruskal)
rm(Bin_c115_host_pvalue)
rm(Bin_c115_season_pvalue)

Bin_c116_bin_name <- "Bin_c116"
Bin_c116_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c116", ])
Bin_c116_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c116", ])
Bin_c116_host_pvalue <- Bin_c116_host_kruskal$p.value
Bin_c116_season_pvalue <- Bin_c116_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_c116_bin_name, Bin_c116_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_c116_bin_name, Bin_c116_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_c116_bin_name)
rm(Bin_c116_host_kruskal)
rm(Bin_c116_season_kruskal)
rm(Bin_c116_host_pvalue)
rm(Bin_c116_season_pvalue)

Bin_c120_bin_name <- "Bin_c120"
Bin_c120_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c120", ])
Bin_c120_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c120", ])
Bin_c120_host_pvalue <- Bin_c120_host_kruskal$p.value
Bin_c120_season_pvalue <- Bin_c120_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_c120_bin_name, Bin_c120_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_c120_bin_name, Bin_c120_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_c120_bin_name)
rm(Bin_c120_host_kruskal)
rm(Bin_c120_season_kruskal)
rm(Bin_c120_host_pvalue)
rm(Bin_c120_season_pvalue)

Bin_c121_bin_name <- "Bin_c121"
Bin_c121_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c121", ])
Bin_c121_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c121", ])
Bin_c121_host_pvalue <- Bin_c121_host_kruskal$p.value
Bin_c121_season_pvalue <- Bin_c121_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_c121_bin_name, Bin_c121_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_c121_bin_name, Bin_c121_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_c121_bin_name)
rm(Bin_c121_host_kruskal)
rm(Bin_c121_season_kruskal)
rm(Bin_c121_host_pvalue)
rm(Bin_c121_season_pvalue)

Bin_c141_bin_name <- "Bin_c141"
Bin_c141_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c141", ])
Bin_c141_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c141", ])
Bin_c141_host_pvalue <- Bin_c141_host_kruskal$p.value
Bin_c141_season_pvalue <- Bin_c141_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_c141_bin_name, Bin_c141_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_c141_bin_name, Bin_c141_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_c141_bin_name)
rm(Bin_c141_host_kruskal)
rm(Bin_c141_season_kruskal)
rm(Bin_c141_host_pvalue)
rm(Bin_c141_season_pvalue)

Bin_c153_bin_name <- "Bin_c153"
Bin_c153_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c153", ])
Bin_c153_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c153", ])
Bin_c153_host_pvalue <- Bin_c153_host_kruskal$p.value
Bin_c153_season_pvalue <- Bin_c153_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_c153_bin_name, Bin_c153_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_c153_bin_name, Bin_c153_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_c153_bin_name)
rm(Bin_c153_host_kruskal)
rm(Bin_c153_season_kruskal)
rm(Bin_c153_host_pvalue)
rm(Bin_c153_season_pvalue)

Bin_c156_bin_name <- "Bin_c156"
Bin_c156_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c156", ])
Bin_c156_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c156", ])
Bin_c156_host_pvalue <- Bin_c156_host_kruskal$p.value
Bin_c156_season_pvalue <- Bin_c156_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_c156_bin_name, Bin_c156_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_c156_bin_name, Bin_c156_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_c156_bin_name)
rm(Bin_c156_host_kruskal)
rm(Bin_c156_season_kruskal)
rm(Bin_c156_host_pvalue)
rm(Bin_c156_season_pvalue)

Bin_c159_bin_name <- "Bin_c159"
Bin_c159_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c159", ])
Bin_c159_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c159", ])
Bin_c159_host_pvalue <- Bin_c159_host_kruskal$p.value
Bin_c159_season_pvalue <- Bin_c159_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_c159_bin_name, Bin_c159_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_c159_bin_name, Bin_c159_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_c159_bin_name)
rm(Bin_c159_host_kruskal)
rm(Bin_c159_season_kruskal)
rm(Bin_c159_host_pvalue)
rm(Bin_c159_season_pvalue)

Bin_c168_bin_name <- "Bin_c168"
Bin_c168_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c168", ])
Bin_c168_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c168", ])
Bin_c168_host_pvalue <- Bin_c168_host_kruskal$p.value
Bin_c168_season_pvalue <- Bin_c168_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_c168_bin_name, Bin_c168_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_c168_bin_name, Bin_c168_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_c168_bin_name)
rm(Bin_c168_host_kruskal)
rm(Bin_c168_season_kruskal)
rm(Bin_c168_host_pvalue)
rm(Bin_c168_season_pvalue)

Bin_c174_bin_name <- "Bin_c174"
Bin_c174_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c174", ])
Bin_c174_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c174", ])
Bin_c174_host_pvalue <- Bin_c174_host_kruskal$p.value
Bin_c174_season_pvalue <- Bin_c174_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_c174_bin_name, Bin_c174_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_c174_bin_name, Bin_c174_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_c174_bin_name)
rm(Bin_c174_host_kruskal)
rm(Bin_c174_season_kruskal)
rm(Bin_c174_host_pvalue)
rm(Bin_c174_season_pvalue)

Bin_c186_bin_name <- "Bin_c186"
Bin_c186_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c186", ])
Bin_c186_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c186", ])
Bin_c186_host_pvalue <- Bin_c186_host_kruskal$p.value
Bin_c186_season_pvalue <- Bin_c186_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_c186_bin_name, Bin_c186_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_c186_bin_name, Bin_c186_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_c186_bin_name)
rm(Bin_c186_host_kruskal)
rm(Bin_c186_season_kruskal)
rm(Bin_c186_host_pvalue)
rm(Bin_c186_season_pvalue)

Bin_c211_bin_name <- "Bin_c211"
Bin_c211_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c211", ])
Bin_c211_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c211", ])
Bin_c211_host_pvalue <- Bin_c211_host_kruskal$p.value
Bin_c211_season_pvalue <- Bin_c211_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_c211_bin_name, Bin_c211_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_c211_bin_name, Bin_c211_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_c211_bin_name)
rm(Bin_c211_host_kruskal)
rm(Bin_c211_season_kruskal)
rm(Bin_c211_host_pvalue)
rm(Bin_c211_season_pvalue)

Bin_c215_bin_name <- "Bin_c215"
Bin_c215_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c215", ])
Bin_c215_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c215", ])
Bin_c215_host_pvalue <- Bin_c215_host_kruskal$p.value
Bin_c215_season_pvalue <- Bin_c215_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_c215_bin_name, Bin_c215_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_c215_bin_name, Bin_c215_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_c215_bin_name)
rm(Bin_c215_host_kruskal)
rm(Bin_c215_season_kruskal)
rm(Bin_c215_host_pvalue)
rm(Bin_c215_season_pvalue)

Bin_c217_bin_name <- "Bin_c217"
Bin_c217_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c217", ])
Bin_c217_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c217", ])
Bin_c217_host_pvalue <- Bin_c217_host_kruskal$p.value
Bin_c217_season_pvalue <- Bin_c217_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_c217_bin_name, Bin_c217_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_c217_bin_name, Bin_c217_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_c217_bin_name)
rm(Bin_c217_host_kruskal)
rm(Bin_c217_season_kruskal)
rm(Bin_c217_host_pvalue)
rm(Bin_c217_season_pvalue)

Bin_c227_bin_name <- "Bin_c227"
Bin_c227_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c227", ])
Bin_c227_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c227", ])
Bin_c227_host_pvalue <- Bin_c227_host_kruskal$p.value
Bin_c227_season_pvalue <- Bin_c227_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_c227_bin_name, Bin_c227_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_c227_bin_name, Bin_c227_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_c227_bin_name)
rm(Bin_c227_host_kruskal)
rm(Bin_c227_season_kruskal)
rm(Bin_c227_host_pvalue)
rm(Bin_c227_season_pvalue)

Bin_c228_bin_name <- "Bin_c228"
Bin_c228_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c228", ])
Bin_c228_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c228", ])
Bin_c228_host_pvalue <- Bin_c228_host_kruskal$p.value
Bin_c228_season_pvalue <- Bin_c228_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_c228_bin_name, Bin_c228_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_c228_bin_name, Bin_c228_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_c228_bin_name)
rm(Bin_c228_host_kruskal)
rm(Bin_c228_season_kruskal)
rm(Bin_c228_host_pvalue)
rm(Bin_c228_season_pvalue)

Bin_c241_bin_name <- "Bin_c241"
Bin_c241_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c241", ])
Bin_c241_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c241", ])
Bin_c241_host_pvalue <- Bin_c241_host_kruskal$p.value
Bin_c241_season_pvalue <- Bin_c241_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_c241_bin_name, Bin_c241_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_c241_bin_name, Bin_c241_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_c241_bin_name)
rm(Bin_c241_host_kruskal)
rm(Bin_c241_season_kruskal)
rm(Bin_c241_host_pvalue)
rm(Bin_c241_season_pvalue)

Bin_c248_bin_name <- "Bin_c248"
Bin_c248_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c248", ])
Bin_c248_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c248", ])
Bin_c248_host_pvalue <- Bin_c248_host_kruskal$p.value
Bin_c248_season_pvalue <- Bin_c248_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_c248_bin_name, Bin_c248_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_c248_bin_name, Bin_c248_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_c248_bin_name)
rm(Bin_c248_host_kruskal)
rm(Bin_c248_season_kruskal)
rm(Bin_c248_host_pvalue)
rm(Bin_c248_season_pvalue)

Bin_c251_bin_name <- "Bin_c251"
Bin_c251_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c251", ])
Bin_c251_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c251", ])
Bin_c251_host_pvalue <- Bin_c251_host_kruskal$p.value
Bin_c251_season_pvalue <- Bin_c251_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_c251_bin_name, Bin_c251_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_c251_bin_name, Bin_c251_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_c251_bin_name)
rm(Bin_c251_host_kruskal)
rm(Bin_c251_season_kruskal)
rm(Bin_c251_host_pvalue)
rm(Bin_c251_season_pvalue)

Bin_c262_bin_name <- "Bin_c262"
Bin_c262_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c262", ])
Bin_c262_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c262", ])
Bin_c262_host_pvalue <- Bin_c262_host_kruskal$p.value
Bin_c262_season_pvalue <- Bin_c262_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_c262_bin_name, Bin_c262_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_c262_bin_name, Bin_c262_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_c262_bin_name)
rm(Bin_c262_host_kruskal)
rm(Bin_c262_season_kruskal)
rm(Bin_c262_host_pvalue)
rm(Bin_c262_season_pvalue)

Bin_c279_bin_name <- "Bin_c279"
Bin_c279_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c279", ])
Bin_c279_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c279", ])
Bin_c279_host_pvalue <- Bin_c279_host_kruskal$p.value
Bin_c279_season_pvalue <- Bin_c279_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_c279_bin_name, Bin_c279_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_c279_bin_name, Bin_c279_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_c279_bin_name)
rm(Bin_c279_host_kruskal)
rm(Bin_c279_season_kruskal)
rm(Bin_c279_host_pvalue)
rm(Bin_c279_season_pvalue)

Bin_c294_bin_name <- "Bin_c294"
Bin_c294_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c294", ])
Bin_c294_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c294", ])
Bin_c294_host_pvalue <- Bin_c294_host_kruskal$p.value
Bin_c294_season_pvalue <- Bin_c294_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_c294_bin_name, Bin_c294_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_c294_bin_name, Bin_c294_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_c294_bin_name)
rm(Bin_c294_host_kruskal)
rm(Bin_c294_season_kruskal)
rm(Bin_c294_host_pvalue)
rm(Bin_c294_season_pvalue)

Bin_c297_bin_name <- "Bin_c297"
Bin_c297_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c297", ])
Bin_c297_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c297", ])
Bin_c297_host_pvalue <- Bin_c297_host_kruskal$p.value
Bin_c297_season_pvalue <- Bin_c297_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_c297_bin_name, Bin_c297_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_c297_bin_name, Bin_c297_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_c297_bin_name)
rm(Bin_c297_host_kruskal)
rm(Bin_c297_season_kruskal)
rm(Bin_c297_host_pvalue)
rm(Bin_c297_season_pvalue)

Bin_c298_bin_name <- "Bin_c298"
Bin_c298_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c298", ])
Bin_c298_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c298", ])
Bin_c298_host_pvalue <- Bin_c298_host_kruskal$p.value
Bin_c298_season_pvalue <- Bin_c298_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_c298_bin_name, Bin_c298_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_c298_bin_name, Bin_c298_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_c298_bin_name)
rm(Bin_c298_host_kruskal)
rm(Bin_c298_season_kruskal)
rm(Bin_c298_host_pvalue)
rm(Bin_c298_season_pvalue)

Bin_c299_bin_name <- "Bin_c299"
Bin_c299_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c299", ])
Bin_c299_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c299", ])
Bin_c299_host_pvalue <- Bin_c299_host_kruskal$p.value
Bin_c299_season_pvalue <- Bin_c299_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_c299_bin_name, Bin_c299_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_c299_bin_name, Bin_c299_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_c299_bin_name)
rm(Bin_c299_host_kruskal)
rm(Bin_c299_season_kruskal)
rm(Bin_c299_host_pvalue)
rm(Bin_c299_season_pvalue)

Bin_c300_bin_name <- "Bin_c300"
Bin_c300_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c300", ])
Bin_c300_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c300", ])
Bin_c300_host_pvalue <- Bin_c300_host_kruskal$p.value
Bin_c300_season_pvalue <- Bin_c300_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_c300_bin_name, Bin_c300_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_c300_bin_name, Bin_c300_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_c300_bin_name)
rm(Bin_c300_host_kruskal)
rm(Bin_c300_season_kruskal)
rm(Bin_c300_host_pvalue)
rm(Bin_c300_season_pvalue)

Bin_c308_bin_name <- "Bin_c308"
Bin_c308_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c308", ])
Bin_c308_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c308", ])
Bin_c308_host_pvalue <- Bin_c308_host_kruskal$p.value
Bin_c308_season_pvalue <- Bin_c308_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_c308_bin_name, Bin_c308_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_c308_bin_name, Bin_c308_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_c308_bin_name)
rm(Bin_c308_host_kruskal)
rm(Bin_c308_season_kruskal)
rm(Bin_c308_host_pvalue)
rm(Bin_c308_season_pvalue)

Bin_c329_bin_name <- "Bin_c329"
Bin_c329_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c329", ])
Bin_c329_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c329", ])
Bin_c329_host_pvalue <- Bin_c329_host_kruskal$p.value
Bin_c329_season_pvalue <- Bin_c329_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_c329_bin_name, Bin_c329_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_c329_bin_name, Bin_c329_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_c329_bin_name)
rm(Bin_c329_host_kruskal)
rm(Bin_c329_season_kruskal)
rm(Bin_c329_host_pvalue)
rm(Bin_c329_season_pvalue)

Bin_c338_bin_name <- "Bin_c338"
Bin_c338_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c338", ])
Bin_c338_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c338", ])
Bin_c338_host_pvalue <- Bin_c338_host_kruskal$p.value
Bin_c338_season_pvalue <- Bin_c338_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_c338_bin_name, Bin_c338_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_c338_bin_name, Bin_c338_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_c338_bin_name)
rm(Bin_c338_host_kruskal)
rm(Bin_c338_season_kruskal)
rm(Bin_c338_host_pvalue)
rm(Bin_c338_season_pvalue)

Bin_c341_bin_name <- "Bin_c341"
Bin_c341_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c341", ])
Bin_c341_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c341", ])
Bin_c341_host_pvalue <- Bin_c341_host_kruskal$p.value
Bin_c341_season_pvalue <- Bin_c341_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_c341_bin_name, Bin_c341_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_c341_bin_name, Bin_c341_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_c341_bin_name)
rm(Bin_c341_host_kruskal)
rm(Bin_c341_season_kruskal)
rm(Bin_c341_host_pvalue)
rm(Bin_c341_season_pvalue)

Bin_c345_bin_name <- "Bin_c345"
Bin_c345_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c345", ])
Bin_c345_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c345", ])
Bin_c345_host_pvalue <- Bin_c345_host_kruskal$p.value
Bin_c345_season_pvalue <- Bin_c345_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_c345_bin_name, Bin_c345_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_c345_bin_name, Bin_c345_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_c345_bin_name)
rm(Bin_c345_host_kruskal)
rm(Bin_c345_season_kruskal)
rm(Bin_c345_host_pvalue)
rm(Bin_c345_season_pvalue)

Bin_c352_bin_name <- "Bin_c352"
Bin_c352_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c352", ])
Bin_c352_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c352", ])
Bin_c352_host_pvalue <- Bin_c352_host_kruskal$p.value
Bin_c352_season_pvalue <- Bin_c352_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_c352_bin_name, Bin_c352_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_c352_bin_name, Bin_c352_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_c352_bin_name)
rm(Bin_c352_host_kruskal)
rm(Bin_c352_season_kruskal)
rm(Bin_c352_host_pvalue)
rm(Bin_c352_season_pvalue)

Bin_c354_bin_name <- "Bin_c354"
Bin_c354_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c354", ])
Bin_c354_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c354", ])
Bin_c354_host_pvalue <- Bin_c354_host_kruskal$p.value
Bin_c354_season_pvalue <- Bin_c354_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_c354_bin_name, Bin_c354_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_c354_bin_name, Bin_c354_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_c354_bin_name)
rm(Bin_c354_host_kruskal)
rm(Bin_c354_season_kruskal)
rm(Bin_c354_host_pvalue)
rm(Bin_c354_season_pvalue)

Bin_c355_bin_name <- "Bin_c355"
Bin_c355_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c355", ])
Bin_c355_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c355", ])
Bin_c355_host_pvalue <- Bin_c355_host_kruskal$p.value
Bin_c355_season_pvalue <- Bin_c355_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_c355_bin_name, Bin_c355_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_c355_bin_name, Bin_c355_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_c355_bin_name)
rm(Bin_c355_host_kruskal)
rm(Bin_c355_season_kruskal)
rm(Bin_c355_host_pvalue)
rm(Bin_c355_season_pvalue)

Bin_c362_bin_name <- "Bin_c362"
Bin_c362_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c362", ])
Bin_c362_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c362", ])
Bin_c362_host_pvalue <- Bin_c362_host_kruskal$p.value
Bin_c362_season_pvalue <- Bin_c362_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_c362_bin_name, Bin_c362_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_c362_bin_name, Bin_c362_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_c362_bin_name)
rm(Bin_c362_host_kruskal)
rm(Bin_c362_season_kruskal)
rm(Bin_c362_host_pvalue)
rm(Bin_c362_season_pvalue)

Bin_c370_bin_name <- "Bin_c370"
Bin_c370_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c370", ])
Bin_c370_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c370", ])
Bin_c370_host_pvalue <- Bin_c370_host_kruskal$p.value
Bin_c370_season_pvalue <- Bin_c370_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_c370_bin_name, Bin_c370_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_c370_bin_name, Bin_c370_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_c370_bin_name)
rm(Bin_c370_host_kruskal)
rm(Bin_c370_season_kruskal)
rm(Bin_c370_host_pvalue)
rm(Bin_c370_season_pvalue)

Bin_c375_bin_name <- "Bin_c375"
Bin_c375_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c375", ])
Bin_c375_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c375", ])
Bin_c375_host_pvalue <- Bin_c375_host_kruskal$p.value
Bin_c375_season_pvalue <- Bin_c375_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_c375_bin_name, Bin_c375_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_c375_bin_name, Bin_c375_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_c375_bin_name)
rm(Bin_c375_host_kruskal)
rm(Bin_c375_season_kruskal)
rm(Bin_c375_host_pvalue)
rm(Bin_c375_season_pvalue)

Bin_c380_bin_name <- "Bin_c380"
Bin_c380_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c380", ])
Bin_c380_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c380", ])
Bin_c380_host_pvalue <- Bin_c380_host_kruskal$p.value
Bin_c380_season_pvalue <- Bin_c380_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_c380_bin_name, Bin_c380_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_c380_bin_name, Bin_c380_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_c380_bin_name)
rm(Bin_c380_host_kruskal)
rm(Bin_c380_season_kruskal)
rm(Bin_c380_host_pvalue)
rm(Bin_c380_season_pvalue)

Bin_c386_bin_name <- "Bin_c386"
Bin_c386_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c386", ])
Bin_c386_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c386", ])
Bin_c386_host_pvalue <- Bin_c386_host_kruskal$p.value
Bin_c386_season_pvalue <- Bin_c386_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_c386_bin_name, Bin_c386_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_c386_bin_name, Bin_c386_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_c386_bin_name)
rm(Bin_c386_host_kruskal)
rm(Bin_c386_season_kruskal)
rm(Bin_c386_host_pvalue)
rm(Bin_c386_season_pvalue)

Bin_c393_bin_name <- "Bin_c393"
Bin_c393_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c393", ])
Bin_c393_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c393", ])
Bin_c393_host_pvalue <- Bin_c393_host_kruskal$p.value
Bin_c393_season_pvalue <- Bin_c393_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_c393_bin_name, Bin_c393_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_c393_bin_name, Bin_c393_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_c393_bin_name)
rm(Bin_c393_host_kruskal)
rm(Bin_c393_season_kruskal)
rm(Bin_c393_host_pvalue)
rm(Bin_c393_season_pvalue)

Bin_c397_bin_name <- "Bin_c397"
Bin_c397_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c397", ])
Bin_c397_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c397", ])
Bin_c397_host_pvalue <- Bin_c397_host_kruskal$p.value
Bin_c397_season_pvalue <- Bin_c397_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_c397_bin_name, Bin_c397_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_c397_bin_name, Bin_c397_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_c397_bin_name)
rm(Bin_c397_host_kruskal)
rm(Bin_c397_season_kruskal)
rm(Bin_c397_host_pvalue)
rm(Bin_c397_season_pvalue)

Bin_c399_bin_name <- "Bin_c399"
Bin_c399_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c399", ])
Bin_c399_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c399", ])
Bin_c399_host_pvalue <- Bin_c399_host_kruskal$p.value
Bin_c399_season_pvalue <- Bin_c399_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_c399_bin_name, Bin_c399_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_c399_bin_name, Bin_c399_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_c399_bin_name)
rm(Bin_c399_host_kruskal)
rm(Bin_c399_season_kruskal)
rm(Bin_c399_host_pvalue)
rm(Bin_c399_season_pvalue)

Bin_c409_bin_name <- "Bin_c409"
Bin_c409_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c409", ])
Bin_c409_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c409", ])
Bin_c409_host_pvalue <- Bin_c409_host_kruskal$p.value
Bin_c409_season_pvalue <- Bin_c409_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_c409_bin_name, Bin_c409_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_c409_bin_name, Bin_c409_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_c409_bin_name)
rm(Bin_c409_host_kruskal)
rm(Bin_c409_season_kruskal)
rm(Bin_c409_host_pvalue)
rm(Bin_c409_season_pvalue)

Bin_c413_bin_name <- "Bin_c413"
Bin_c413_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c413", ])
Bin_c413_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c413", ])
Bin_c413_host_pvalue <- Bin_c413_host_kruskal$p.value
Bin_c413_season_pvalue <- Bin_c413_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_c413_bin_name, Bin_c413_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_c413_bin_name, Bin_c413_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_c413_bin_name)
rm(Bin_c413_host_kruskal)
rm(Bin_c413_season_kruskal)
rm(Bin_c413_host_pvalue)
rm(Bin_c413_season_pvalue)

Bin_c416_bin_name <- "Bin_c416"
Bin_c416_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c416", ])
Bin_c416_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c416", ])
Bin_c416_host_pvalue <- Bin_c416_host_kruskal$p.value
Bin_c416_season_pvalue <- Bin_c416_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_c416_bin_name, Bin_c416_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_c416_bin_name, Bin_c416_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_c416_bin_name)
rm(Bin_c416_host_kruskal)
rm(Bin_c416_season_kruskal)
rm(Bin_c416_host_pvalue)
rm(Bin_c416_season_pvalue)

Bin_c420_bin_name <- "Bin_c420"
Bin_c420_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c420", ])
Bin_c420_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c420", ])
Bin_c420_host_pvalue <- Bin_c420_host_kruskal$p.value
Bin_c420_season_pvalue <- Bin_c420_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_c420_bin_name, Bin_c420_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_c420_bin_name, Bin_c420_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_c420_bin_name)
rm(Bin_c420_host_kruskal)
rm(Bin_c420_season_kruskal)
rm(Bin_c420_host_pvalue)
rm(Bin_c420_season_pvalue)

Bin_c422_bin_name <- "Bin_c422"
Bin_c422_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c422", ])
Bin_c422_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c422", ])
Bin_c422_host_pvalue <- Bin_c422_host_kruskal$p.value
Bin_c422_season_pvalue <- Bin_c422_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_c422_bin_name, Bin_c422_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_c422_bin_name, Bin_c422_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_c422_bin_name)
rm(Bin_c422_host_kruskal)
rm(Bin_c422_season_kruskal)
rm(Bin_c422_host_pvalue)
rm(Bin_c422_season_pvalue)

Bin_c438_bin_name <- "Bin_c438"
Bin_c438_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c438", ])
Bin_c438_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c438", ])
Bin_c438_host_pvalue <- Bin_c438_host_kruskal$p.value
Bin_c438_season_pvalue <- Bin_c438_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_c438_bin_name, Bin_c438_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_c438_bin_name, Bin_c438_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_c438_bin_name)
rm(Bin_c438_host_kruskal)
rm(Bin_c438_season_kruskal)
rm(Bin_c438_host_pvalue)
rm(Bin_c438_season_pvalue)

Bin_c448_bin_name <- "Bin_c448"
Bin_c448_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c448", ])
Bin_c448_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c448", ])
Bin_c448_host_pvalue <- Bin_c448_host_kruskal$p.value
Bin_c448_season_pvalue <- Bin_c448_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_c448_bin_name, Bin_c448_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_c448_bin_name, Bin_c448_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_c448_bin_name)
rm(Bin_c448_host_kruskal)
rm(Bin_c448_season_kruskal)
rm(Bin_c448_host_pvalue)
rm(Bin_c448_season_pvalue)

Bin_c454_bin_name <- "Bin_c454"
Bin_c454_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c454", ])
Bin_c454_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c454", ])
Bin_c454_host_pvalue <- Bin_c454_host_kruskal$p.value
Bin_c454_season_pvalue <- Bin_c454_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_c454_bin_name, Bin_c454_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_c454_bin_name, Bin_c454_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_c454_bin_name)
rm(Bin_c454_host_kruskal)
rm(Bin_c454_season_kruskal)
rm(Bin_c454_host_pvalue)
rm(Bin_c454_season_pvalue)

Bin_c471_bin_name <- "Bin_c471"
Bin_c471_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c471", ])
Bin_c471_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c471", ])
Bin_c471_host_pvalue <- Bin_c471_host_kruskal$p.value
Bin_c471_season_pvalue <- Bin_c471_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_c471_bin_name, Bin_c471_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_c471_bin_name, Bin_c471_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_c471_bin_name)
rm(Bin_c471_host_kruskal)
rm(Bin_c471_season_kruskal)
rm(Bin_c471_host_pvalue)
rm(Bin_c471_season_pvalue)

Bin_c473_bin_name <- "Bin_c473"
Bin_c473_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c473", ])
Bin_c473_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c473", ])
Bin_c473_host_pvalue <- Bin_c473_host_kruskal$p.value
Bin_c473_season_pvalue <- Bin_c473_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_c473_bin_name, Bin_c473_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_c473_bin_name, Bin_c473_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_c473_bin_name)
rm(Bin_c473_host_kruskal)
rm(Bin_c473_season_kruskal)
rm(Bin_c473_host_pvalue)
rm(Bin_c473_season_pvalue)

Bin_c475_bin_name <- "Bin_c475"
Bin_c475_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c475", ])
Bin_c475_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c475", ])
Bin_c475_host_pvalue <- Bin_c475_host_kruskal$p.value
Bin_c475_season_pvalue <- Bin_c475_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_c475_bin_name, Bin_c475_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_c475_bin_name, Bin_c475_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_c475_bin_name)
rm(Bin_c475_host_kruskal)
rm(Bin_c475_season_kruskal)
rm(Bin_c475_host_pvalue)
rm(Bin_c475_season_pvalue)

Bin_c480_bin_name <- "Bin_c480"
Bin_c480_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c480", ])
Bin_c480_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c480", ])
Bin_c480_host_pvalue <- Bin_c480_host_kruskal$p.value
Bin_c480_season_pvalue <- Bin_c480_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_c480_bin_name, Bin_c480_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_c480_bin_name, Bin_c480_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_c480_bin_name)
rm(Bin_c480_host_kruskal)
rm(Bin_c480_season_kruskal)
rm(Bin_c480_host_pvalue)
rm(Bin_c480_season_pvalue)

Bin_c493_bin_name <- "Bin_c493"
Bin_c493_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c493", ])
Bin_c493_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c493", ])
Bin_c493_host_pvalue <- Bin_c493_host_kruskal$p.value
Bin_c493_season_pvalue <- Bin_c493_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_c493_bin_name, Bin_c493_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_c493_bin_name, Bin_c493_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_c493_bin_name)
rm(Bin_c493_host_kruskal)
rm(Bin_c493_season_kruskal)
rm(Bin_c493_host_pvalue)
rm(Bin_c493_season_pvalue)

Bin_c497_bin_name <- "Bin_c497"
Bin_c497_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c497", ])
Bin_c497_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c497", ])
Bin_c497_host_pvalue <- Bin_c497_host_kruskal$p.value
Bin_c497_season_pvalue <- Bin_c497_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_c497_bin_name, Bin_c497_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_c497_bin_name, Bin_c497_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_c497_bin_name)
rm(Bin_c497_host_kruskal)
rm(Bin_c497_season_kruskal)
rm(Bin_c497_host_pvalue)
rm(Bin_c497_season_pvalue)

Bin_c498_bin_name <- "Bin_c498"
Bin_c498_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c498", ])
Bin_c498_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c498", ])
Bin_c498_host_pvalue <- Bin_c498_host_kruskal$p.value
Bin_c498_season_pvalue <- Bin_c498_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_c498_bin_name, Bin_c498_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_c498_bin_name, Bin_c498_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_c498_bin_name)
rm(Bin_c498_host_kruskal)
rm(Bin_c498_season_kruskal)
rm(Bin_c498_host_pvalue)
rm(Bin_c498_season_pvalue)

Bin_c499_bin_name <- "Bin_c499"
Bin_c499_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c499", ])
Bin_c499_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c499", ])
Bin_c499_host_pvalue <- Bin_c499_host_kruskal$p.value
Bin_c499_season_pvalue <- Bin_c499_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_c499_bin_name, Bin_c499_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_c499_bin_name, Bin_c499_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_c499_bin_name)
rm(Bin_c499_host_kruskal)
rm(Bin_c499_season_kruskal)
rm(Bin_c499_host_pvalue)
rm(Bin_c499_season_pvalue)

Bin_c503_bin_name <- "Bin_c503"
Bin_c503_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c503", ])
Bin_c503_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c503", ])
Bin_c503_host_pvalue <- Bin_c503_host_kruskal$p.value
Bin_c503_season_pvalue <- Bin_c503_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_c503_bin_name, Bin_c503_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_c503_bin_name, Bin_c503_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_c503_bin_name)
rm(Bin_c503_host_kruskal)
rm(Bin_c503_season_kruskal)
rm(Bin_c503_host_pvalue)
rm(Bin_c503_season_pvalue)

Bin_c513_bin_name <- "Bin_c513"
Bin_c513_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c513", ])
Bin_c513_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c513", ])
Bin_c513_host_pvalue <- Bin_c513_host_kruskal$p.value
Bin_c513_season_pvalue <- Bin_c513_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_c513_bin_name, Bin_c513_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_c513_bin_name, Bin_c513_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_c513_bin_name)
rm(Bin_c513_host_kruskal)
rm(Bin_c513_season_kruskal)
rm(Bin_c513_host_pvalue)
rm(Bin_c513_season_pvalue)

Bin_c524_bin_name <- "Bin_c524"
Bin_c524_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c524", ])
Bin_c524_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c524", ])
Bin_c524_host_pvalue <- Bin_c524_host_kruskal$p.value
Bin_c524_season_pvalue <- Bin_c524_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_c524_bin_name, Bin_c524_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_c524_bin_name, Bin_c524_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_c524_bin_name)
rm(Bin_c524_host_kruskal)
rm(Bin_c524_season_kruskal)
rm(Bin_c524_host_pvalue)
rm(Bin_c524_season_pvalue)

Bin_c534_bin_name <- "Bin_c534"
Bin_c534_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c534", ])
Bin_c534_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c534", ])
Bin_c534_host_pvalue <- Bin_c534_host_kruskal$p.value
Bin_c534_season_pvalue <- Bin_c534_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_c534_bin_name, Bin_c534_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_c534_bin_name, Bin_c534_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_c534_bin_name)
rm(Bin_c534_host_kruskal)
rm(Bin_c534_season_kruskal)
rm(Bin_c534_host_pvalue)
rm(Bin_c534_season_pvalue)

Bin_c539_bin_name <- "Bin_c539"
Bin_c539_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c539", ])
Bin_c539_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c539", ])
Bin_c539_host_pvalue <- Bin_c539_host_kruskal$p.value
Bin_c539_season_pvalue <- Bin_c539_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_c539_bin_name, Bin_c539_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_c539_bin_name, Bin_c539_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_c539_bin_name)
rm(Bin_c539_host_kruskal)
rm(Bin_c539_season_kruskal)
rm(Bin_c539_host_pvalue)
rm(Bin_c539_season_pvalue)

Bin_c544_bin_name <- "Bin_c544"
Bin_c544_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c544", ])
Bin_c544_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c544", ])
Bin_c544_host_pvalue <- Bin_c544_host_kruskal$p.value
Bin_c544_season_pvalue <- Bin_c544_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_c544_bin_name, Bin_c544_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_c544_bin_name, Bin_c544_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_c544_bin_name)
rm(Bin_c544_host_kruskal)
rm(Bin_c544_season_kruskal)
rm(Bin_c544_host_pvalue)
rm(Bin_c544_season_pvalue)

Bin_c552_bin_name <- "Bin_c552"
Bin_c552_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c552", ])
Bin_c552_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c552", ])
Bin_c552_host_pvalue <- Bin_c552_host_kruskal$p.value
Bin_c552_season_pvalue <- Bin_c552_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_c552_bin_name, Bin_c552_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_c552_bin_name, Bin_c552_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_c552_bin_name)
rm(Bin_c552_host_kruskal)
rm(Bin_c552_season_kruskal)
rm(Bin_c552_host_pvalue)
rm(Bin_c552_season_pvalue)

Bin_c554_bin_name <- "Bin_c554"
Bin_c554_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c554", ])
Bin_c554_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c554", ])
Bin_c554_host_pvalue <- Bin_c554_host_kruskal$p.value
Bin_c554_season_pvalue <- Bin_c554_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_c554_bin_name, Bin_c554_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_c554_bin_name, Bin_c554_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_c554_bin_name)
rm(Bin_c554_host_kruskal)
rm(Bin_c554_season_kruskal)
rm(Bin_c554_host_pvalue)
rm(Bin_c554_season_pvalue)

Bin_c557_bin_name <- "Bin_c557"
Bin_c557_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c557", ])
Bin_c557_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c557", ])
Bin_c557_host_pvalue <- Bin_c557_host_kruskal$p.value
Bin_c557_season_pvalue <- Bin_c557_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_c557_bin_name, Bin_c557_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_c557_bin_name, Bin_c557_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_c557_bin_name)
rm(Bin_c557_host_kruskal)
rm(Bin_c557_season_kruskal)
rm(Bin_c557_host_pvalue)
rm(Bin_c557_season_pvalue)

Bin_c568_bin_name <- "Bin_c568"
Bin_c568_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c568", ])
Bin_c568_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c568", ])
Bin_c568_host_pvalue <- Bin_c568_host_kruskal$p.value
Bin_c568_season_pvalue <- Bin_c568_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_c568_bin_name, Bin_c568_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_c568_bin_name, Bin_c568_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_c568_bin_name)
rm(Bin_c568_host_kruskal)
rm(Bin_c568_season_kruskal)
rm(Bin_c568_host_pvalue)
rm(Bin_c568_season_pvalue)

Bin_c570_bin_name <- "Bin_c570"
Bin_c570_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c570", ])
Bin_c570_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c570", ])
Bin_c570_host_pvalue <- Bin_c570_host_kruskal$p.value
Bin_c570_season_pvalue <- Bin_c570_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_c570_bin_name, Bin_c570_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_c570_bin_name, Bin_c570_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_c570_bin_name)
rm(Bin_c570_host_kruskal)
rm(Bin_c570_season_kruskal)
rm(Bin_c570_host_pvalue)
rm(Bin_c570_season_pvalue)

Bin_c571_bin_name <- "Bin_c571"
Bin_c571_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c571", ])
Bin_c571_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c571", ])
Bin_c571_host_pvalue <- Bin_c571_host_kruskal$p.value
Bin_c571_season_pvalue <- Bin_c571_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_c571_bin_name, Bin_c571_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_c571_bin_name, Bin_c571_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_c571_bin_name)
rm(Bin_c571_host_kruskal)
rm(Bin_c571_season_kruskal)
rm(Bin_c571_host_pvalue)
rm(Bin_c571_season_pvalue)

Bin_c572_bin_name <- "Bin_c572"
Bin_c572_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c572", ])
Bin_c572_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c572", ])
Bin_c572_host_pvalue <- Bin_c572_host_kruskal$p.value
Bin_c572_season_pvalue <- Bin_c572_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_c572_bin_name, Bin_c572_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_c572_bin_name, Bin_c572_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_c572_bin_name)
rm(Bin_c572_host_kruskal)
rm(Bin_c572_season_kruskal)
rm(Bin_c572_host_pvalue)
rm(Bin_c572_season_pvalue)

Bin_c578_bin_name <- "Bin_c578"
Bin_c578_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c578", ])
Bin_c578_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c578", ])
Bin_c578_host_pvalue <- Bin_c578_host_kruskal$p.value
Bin_c578_season_pvalue <- Bin_c578_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_c578_bin_name, Bin_c578_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_c578_bin_name, Bin_c578_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_c578_bin_name)
rm(Bin_c578_host_kruskal)
rm(Bin_c578_season_kruskal)
rm(Bin_c578_host_pvalue)
rm(Bin_c578_season_pvalue)

Bin_c583_bin_name <- "Bin_c583"
Bin_c583_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c583", ])
Bin_c583_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c583", ])
Bin_c583_host_pvalue <- Bin_c583_host_kruskal$p.value
Bin_c583_season_pvalue <- Bin_c583_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_c583_bin_name, Bin_c583_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_c583_bin_name, Bin_c583_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_c583_bin_name)
rm(Bin_c583_host_kruskal)
rm(Bin_c583_season_kruskal)
rm(Bin_c583_host_pvalue)
rm(Bin_c583_season_pvalue)

Bin_c590_bin_name <- "Bin_c590"
Bin_c590_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c590", ])
Bin_c590_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c590", ])
Bin_c590_host_pvalue <- Bin_c590_host_kruskal$p.value
Bin_c590_season_pvalue <- Bin_c590_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_c590_bin_name, Bin_c590_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_c590_bin_name, Bin_c590_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_c590_bin_name)
rm(Bin_c590_host_kruskal)
rm(Bin_c590_season_kruskal)
rm(Bin_c590_host_pvalue)
rm(Bin_c590_season_pvalue)

Bin_c607_bin_name <- "Bin_c607"
Bin_c607_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c607", ])
Bin_c607_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c607", ])
Bin_c607_host_pvalue <- Bin_c607_host_kruskal$p.value
Bin_c607_season_pvalue <- Bin_c607_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_c607_bin_name, Bin_c607_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_c607_bin_name, Bin_c607_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_c607_bin_name)
rm(Bin_c607_host_kruskal)
rm(Bin_c607_season_kruskal)
rm(Bin_c607_host_pvalue)
rm(Bin_c607_season_pvalue)

Bin_c610_bin_name <- "Bin_c610"
Bin_c610_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c610", ])
Bin_c610_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c610", ])
Bin_c610_host_pvalue <- Bin_c610_host_kruskal$p.value
Bin_c610_season_pvalue <- Bin_c610_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_c610_bin_name, Bin_c610_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_c610_bin_name, Bin_c610_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_c610_bin_name)
rm(Bin_c610_host_kruskal)
rm(Bin_c610_season_kruskal)
rm(Bin_c610_host_pvalue)
rm(Bin_c610_season_pvalue)

Bin_c617_bin_name <- "Bin_c617"
Bin_c617_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c617", ])
Bin_c617_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c617", ])
Bin_c617_host_pvalue <- Bin_c617_host_kruskal$p.value
Bin_c617_season_pvalue <- Bin_c617_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_c617_bin_name, Bin_c617_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_c617_bin_name, Bin_c617_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_c617_bin_name)
rm(Bin_c617_host_kruskal)
rm(Bin_c617_season_kruskal)
rm(Bin_c617_host_pvalue)
rm(Bin_c617_season_pvalue)

Bin_c622_bin_name <- "Bin_c622"
Bin_c622_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c622", ])
Bin_c622_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c622", ])
Bin_c622_host_pvalue <- Bin_c622_host_kruskal$p.value
Bin_c622_season_pvalue <- Bin_c622_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_c622_bin_name, Bin_c622_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_c622_bin_name, Bin_c622_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_c622_bin_name)
rm(Bin_c622_host_kruskal)
rm(Bin_c622_season_kruskal)
rm(Bin_c622_host_pvalue)
rm(Bin_c622_season_pvalue)

Bin_c631_bin_name <- "Bin_c631"
Bin_c631_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c631", ])
Bin_c631_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c631", ])
Bin_c631_host_pvalue <- Bin_c631_host_kruskal$p.value
Bin_c631_season_pvalue <- Bin_c631_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_c631_bin_name, Bin_c631_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_c631_bin_name, Bin_c631_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_c631_bin_name)
rm(Bin_c631_host_kruskal)
rm(Bin_c631_season_kruskal)
rm(Bin_c631_host_pvalue)
rm(Bin_c631_season_pvalue)

Bin_c633_bin_name <- "Bin_c633"
Bin_c633_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c633", ])
Bin_c633_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c633", ])
Bin_c633_host_pvalue <- Bin_c633_host_kruskal$p.value
Bin_c633_season_pvalue <- Bin_c633_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_c633_bin_name, Bin_c633_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_c633_bin_name, Bin_c633_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_c633_bin_name)
rm(Bin_c633_host_kruskal)
rm(Bin_c633_season_kruskal)
rm(Bin_c633_host_pvalue)
rm(Bin_c633_season_pvalue)

Bin_c657_bin_name <- "Bin_c657"
Bin_c657_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c657", ])
Bin_c657_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c657", ])
Bin_c657_host_pvalue <- Bin_c657_host_kruskal$p.value
Bin_c657_season_pvalue <- Bin_c657_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_c657_bin_name, Bin_c657_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_c657_bin_name, Bin_c657_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_c657_bin_name)
rm(Bin_c657_host_kruskal)
rm(Bin_c657_season_kruskal)
rm(Bin_c657_host_pvalue)
rm(Bin_c657_season_pvalue)

Bin_c665_bin_name <- "Bin_c665"
Bin_c665_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c665", ])
Bin_c665_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c665", ])
Bin_c665_host_pvalue <- Bin_c665_host_kruskal$p.value
Bin_c665_season_pvalue <- Bin_c665_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_c665_bin_name, Bin_c665_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_c665_bin_name, Bin_c665_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_c665_bin_name)
rm(Bin_c665_host_kruskal)
rm(Bin_c665_season_kruskal)
rm(Bin_c665_host_pvalue)
rm(Bin_c665_season_pvalue)

Bin_c674_bin_name <- "Bin_c674"
Bin_c674_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c674", ])
Bin_c674_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c674", ])
Bin_c674_host_pvalue <- Bin_c674_host_kruskal$p.value
Bin_c674_season_pvalue <- Bin_c674_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_c674_bin_name, Bin_c674_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_c674_bin_name, Bin_c674_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_c674_bin_name)
rm(Bin_c674_host_kruskal)
rm(Bin_c674_season_kruskal)
rm(Bin_c674_host_pvalue)
rm(Bin_c674_season_pvalue)

Bin_c688_bin_name <- "Bin_c688"
Bin_c688_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c688", ])
Bin_c688_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c688", ])
Bin_c688_host_pvalue <- Bin_c688_host_kruskal$p.value
Bin_c688_season_pvalue <- Bin_c688_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_c688_bin_name, Bin_c688_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_c688_bin_name, Bin_c688_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_c688_bin_name)
rm(Bin_c688_host_kruskal)
rm(Bin_c688_season_kruskal)
rm(Bin_c688_host_pvalue)
rm(Bin_c688_season_pvalue)

Bin_c689_bin_name <- "Bin_c689"
Bin_c689_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c689", ])
Bin_c689_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c689", ])
Bin_c689_host_pvalue <- Bin_c689_host_kruskal$p.value
Bin_c689_season_pvalue <- Bin_c689_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_c689_bin_name, Bin_c689_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_c689_bin_name, Bin_c689_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_c689_bin_name)
rm(Bin_c689_host_kruskal)
rm(Bin_c689_season_kruskal)
rm(Bin_c689_host_pvalue)
rm(Bin_c689_season_pvalue)

Bin_c712_bin_name <- "Bin_c712"
Bin_c712_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c712", ])
Bin_c712_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c712", ])
Bin_c712_host_pvalue <- Bin_c712_host_kruskal$p.value
Bin_c712_season_pvalue <- Bin_c712_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_c712_bin_name, Bin_c712_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_c712_bin_name, Bin_c712_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_c712_bin_name)
rm(Bin_c712_host_kruskal)
rm(Bin_c712_season_kruskal)
rm(Bin_c712_host_pvalue)
rm(Bin_c712_season_pvalue)

Bin_c719_bin_name <- "Bin_c719"
Bin_c719_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c719", ])
Bin_c719_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c719", ])
Bin_c719_host_pvalue <- Bin_c719_host_kruskal$p.value
Bin_c719_season_pvalue <- Bin_c719_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_c719_bin_name, Bin_c719_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_c719_bin_name, Bin_c719_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_c719_bin_name)
rm(Bin_c719_host_kruskal)
rm(Bin_c719_season_kruskal)
rm(Bin_c719_host_pvalue)
rm(Bin_c719_season_pvalue)

Bin_c720_bin_name <- "Bin_c720"
Bin_c720_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c720", ])
Bin_c720_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c720", ])
Bin_c720_host_pvalue <- Bin_c720_host_kruskal$p.value
Bin_c720_season_pvalue <- Bin_c720_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_c720_bin_name, Bin_c720_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_c720_bin_name, Bin_c720_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_c720_bin_name)
rm(Bin_c720_host_kruskal)
rm(Bin_c720_season_kruskal)
rm(Bin_c720_host_pvalue)
rm(Bin_c720_season_pvalue)

Bin_c723_bin_name <- "Bin_c723"
Bin_c723_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c723", ])
Bin_c723_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c723", ])
Bin_c723_host_pvalue <- Bin_c723_host_kruskal$p.value
Bin_c723_season_pvalue <- Bin_c723_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_c723_bin_name, Bin_c723_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_c723_bin_name, Bin_c723_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_c723_bin_name)
rm(Bin_c723_host_kruskal)
rm(Bin_c723_season_kruskal)
rm(Bin_c723_host_pvalue)
rm(Bin_c723_season_pvalue)

Bin_c730_bin_name <- "Bin_c730"
Bin_c730_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c730", ])
Bin_c730_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c730", ])
Bin_c730_host_pvalue <- Bin_c730_host_kruskal$p.value
Bin_c730_season_pvalue <- Bin_c730_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_c730_bin_name, Bin_c730_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_c730_bin_name, Bin_c730_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_c730_bin_name)
rm(Bin_c730_host_kruskal)
rm(Bin_c730_season_kruskal)
rm(Bin_c730_host_pvalue)
rm(Bin_c730_season_pvalue)

Bin_c732_bin_name <- "Bin_c732"
Bin_c732_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c732", ])
Bin_c732_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c732", ])
Bin_c732_host_pvalue <- Bin_c732_host_kruskal$p.value
Bin_c732_season_pvalue <- Bin_c732_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_c732_bin_name, Bin_c732_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_c732_bin_name, Bin_c732_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_c732_bin_name)
rm(Bin_c732_host_kruskal)
rm(Bin_c732_season_kruskal)
rm(Bin_c732_host_pvalue)
rm(Bin_c732_season_pvalue)

Bin_c735_bin_name <- "Bin_c735"
Bin_c735_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c735", ])
Bin_c735_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c735", ])
Bin_c735_host_pvalue <- Bin_c735_host_kruskal$p.value
Bin_c735_season_pvalue <- Bin_c735_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_c735_bin_name, Bin_c735_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_c735_bin_name, Bin_c735_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_c735_bin_name)
rm(Bin_c735_host_kruskal)
rm(Bin_c735_season_kruskal)
rm(Bin_c735_host_pvalue)
rm(Bin_c735_season_pvalue)

Bin_c742_bin_name <- "Bin_c742"
Bin_c742_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c742", ])
Bin_c742_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c742", ])
Bin_c742_host_pvalue <- Bin_c742_host_kruskal$p.value
Bin_c742_season_pvalue <- Bin_c742_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_c742_bin_name, Bin_c742_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_c742_bin_name, Bin_c742_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_c742_bin_name)
rm(Bin_c742_host_kruskal)
rm(Bin_c742_season_kruskal)
rm(Bin_c742_host_pvalue)
rm(Bin_c742_season_pvalue)

Bin_c745_bin_name <- "Bin_c745"
Bin_c745_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c745", ])
Bin_c745_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c745", ])
Bin_c745_host_pvalue <- Bin_c745_host_kruskal$p.value
Bin_c745_season_pvalue <- Bin_c745_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_c745_bin_name, Bin_c745_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_c745_bin_name, Bin_c745_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_c745_bin_name)
rm(Bin_c745_host_kruskal)
rm(Bin_c745_season_kruskal)
rm(Bin_c745_host_pvalue)
rm(Bin_c745_season_pvalue)

Bin_c748_bin_name <- "Bin_c748"
Bin_c748_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c748", ])
Bin_c748_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c748", ])
Bin_c748_host_pvalue <- Bin_c748_host_kruskal$p.value
Bin_c748_season_pvalue <- Bin_c748_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_c748_bin_name, Bin_c748_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_c748_bin_name, Bin_c748_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_c748_bin_name)
rm(Bin_c748_host_kruskal)
rm(Bin_c748_season_kruskal)
rm(Bin_c748_host_pvalue)
rm(Bin_c748_season_pvalue)

Bin_c750_bin_name <- "Bin_c750"
Bin_c750_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c750", ])
Bin_c750_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c750", ])
Bin_c750_host_pvalue <- Bin_c750_host_kruskal$p.value
Bin_c750_season_pvalue <- Bin_c750_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_c750_bin_name, Bin_c750_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_c750_bin_name, Bin_c750_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_c750_bin_name)
rm(Bin_c750_host_kruskal)
rm(Bin_c750_season_kruskal)
rm(Bin_c750_host_pvalue)
rm(Bin_c750_season_pvalue)

Bin_c752_bin_name <- "Bin_c752"
Bin_c752_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c752", ])
Bin_c752_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c752", ])
Bin_c752_host_pvalue <- Bin_c752_host_kruskal$p.value
Bin_c752_season_pvalue <- Bin_c752_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_c752_bin_name, Bin_c752_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_c752_bin_name, Bin_c752_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_c752_bin_name)
rm(Bin_c752_host_kruskal)
rm(Bin_c752_season_kruskal)
rm(Bin_c752_host_pvalue)
rm(Bin_c752_season_pvalue)

Bin_c762_bin_name <- "Bin_c762"
Bin_c762_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c762", ])
Bin_c762_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c762", ])
Bin_c762_host_pvalue <- Bin_c762_host_kruskal$p.value
Bin_c762_season_pvalue <- Bin_c762_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_c762_bin_name, Bin_c762_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_c762_bin_name, Bin_c762_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_c762_bin_name)
rm(Bin_c762_host_kruskal)
rm(Bin_c762_season_kruskal)
rm(Bin_c762_host_pvalue)
rm(Bin_c762_season_pvalue)

Bin_c765_bin_name <- "Bin_c765"
Bin_c765_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c765", ])
Bin_c765_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c765", ])
Bin_c765_host_pvalue <- Bin_c765_host_kruskal$p.value
Bin_c765_season_pvalue <- Bin_c765_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_c765_bin_name, Bin_c765_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_c765_bin_name, Bin_c765_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_c765_bin_name)
rm(Bin_c765_host_kruskal)
rm(Bin_c765_season_kruskal)
rm(Bin_c765_host_pvalue)
rm(Bin_c765_season_pvalue)

Bin_c770_bin_name <- "Bin_c770"
Bin_c770_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c770", ])
Bin_c770_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c770", ])
Bin_c770_host_pvalue <- Bin_c770_host_kruskal$p.value
Bin_c770_season_pvalue <- Bin_c770_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_c770_bin_name, Bin_c770_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_c770_bin_name, Bin_c770_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_c770_bin_name)
rm(Bin_c770_host_kruskal)
rm(Bin_c770_season_kruskal)
rm(Bin_c770_host_pvalue)
rm(Bin_c770_season_pvalue)

Bin_c771_bin_name <- "Bin_c771"
Bin_c771_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c771", ])
Bin_c771_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c771", ])
Bin_c771_host_pvalue <- Bin_c771_host_kruskal$p.value
Bin_c771_season_pvalue <- Bin_c771_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_c771_bin_name, Bin_c771_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_c771_bin_name, Bin_c771_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_c771_bin_name)
rm(Bin_c771_host_kruskal)
rm(Bin_c771_season_kruskal)
rm(Bin_c771_host_pvalue)
rm(Bin_c771_season_pvalue)

Bin_c774_bin_name <- "Bin_c774"
Bin_c774_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c774", ])
Bin_c774_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c774", ])
Bin_c774_host_pvalue <- Bin_c774_host_kruskal$p.value
Bin_c774_season_pvalue <- Bin_c774_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_c774_bin_name, Bin_c774_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_c774_bin_name, Bin_c774_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_c774_bin_name)
rm(Bin_c774_host_kruskal)
rm(Bin_c774_season_kruskal)
rm(Bin_c774_host_pvalue)
rm(Bin_c774_season_pvalue)

Bin_c793_bin_name <- "Bin_c793"
Bin_c793_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c793", ])
Bin_c793_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c793", ])
Bin_c793_host_pvalue <- Bin_c793_host_kruskal$p.value
Bin_c793_season_pvalue <- Bin_c793_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_c793_bin_name, Bin_c793_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_c793_bin_name, Bin_c793_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_c793_bin_name)
rm(Bin_c793_host_kruskal)
rm(Bin_c793_season_kruskal)
rm(Bin_c793_host_pvalue)
rm(Bin_c793_season_pvalue)

Bin_c796_bin_name <- "Bin_c796"
Bin_c796_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c796", ])
Bin_c796_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c796", ])
Bin_c796_host_pvalue <- Bin_c796_host_kruskal$p.value
Bin_c796_season_pvalue <- Bin_c796_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_c796_bin_name, Bin_c796_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_c796_bin_name, Bin_c796_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_c796_bin_name)
rm(Bin_c796_host_kruskal)
rm(Bin_c796_season_kruskal)
rm(Bin_c796_host_pvalue)
rm(Bin_c796_season_pvalue)

Bin_c801_bin_name <- "Bin_c801"
Bin_c801_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c801", ])
Bin_c801_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c801", ])
Bin_c801_host_pvalue <- Bin_c801_host_kruskal$p.value
Bin_c801_season_pvalue <- Bin_c801_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_c801_bin_name, Bin_c801_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_c801_bin_name, Bin_c801_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_c801_bin_name)
rm(Bin_c801_host_kruskal)
rm(Bin_c801_season_kruskal)
rm(Bin_c801_host_pvalue)
rm(Bin_c801_season_pvalue)

Bin_c806_bin_name <- "Bin_c806"
Bin_c806_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c806", ])
Bin_c806_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c806", ])
Bin_c806_host_pvalue <- Bin_c806_host_kruskal$p.value
Bin_c806_season_pvalue <- Bin_c806_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_c806_bin_name, Bin_c806_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_c806_bin_name, Bin_c806_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_c806_bin_name)
rm(Bin_c806_host_kruskal)
rm(Bin_c806_season_kruskal)
rm(Bin_c806_host_pvalue)
rm(Bin_c806_season_pvalue)

Bin_c813_bin_name <- "Bin_c813"
Bin_c813_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c813", ])
Bin_c813_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c813", ])
Bin_c813_host_pvalue <- Bin_c813_host_kruskal$p.value
Bin_c813_season_pvalue <- Bin_c813_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_c813_bin_name, Bin_c813_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_c813_bin_name, Bin_c813_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_c813_bin_name)
rm(Bin_c813_host_kruskal)
rm(Bin_c813_season_kruskal)
rm(Bin_c813_host_pvalue)
rm(Bin_c813_season_pvalue)

Bin_c819_bin_name <- "Bin_c819"
Bin_c819_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c819", ])
Bin_c819_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c819", ])
Bin_c819_host_pvalue <- Bin_c819_host_kruskal$p.value
Bin_c819_season_pvalue <- Bin_c819_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_c819_bin_name, Bin_c819_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_c819_bin_name, Bin_c819_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_c819_bin_name)
rm(Bin_c819_host_kruskal)
rm(Bin_c819_season_kruskal)
rm(Bin_c819_host_pvalue)
rm(Bin_c819_season_pvalue)

Bin_c825_bin_name <- "Bin_c825"
Bin_c825_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c825", ])
Bin_c825_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c825", ])
Bin_c825_host_pvalue <- Bin_c825_host_kruskal$p.value
Bin_c825_season_pvalue <- Bin_c825_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_c825_bin_name, Bin_c825_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_c825_bin_name, Bin_c825_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_c825_bin_name)
rm(Bin_c825_host_kruskal)
rm(Bin_c825_season_kruskal)
rm(Bin_c825_host_pvalue)
rm(Bin_c825_season_pvalue)

Bin_c827_bin_name <- "Bin_c827"
Bin_c827_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c827", ])
Bin_c827_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c827", ])
Bin_c827_host_pvalue <- Bin_c827_host_kruskal$p.value
Bin_c827_season_pvalue <- Bin_c827_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_c827_bin_name, Bin_c827_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_c827_bin_name, Bin_c827_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_c827_bin_name)
rm(Bin_c827_host_kruskal)
rm(Bin_c827_season_kruskal)
rm(Bin_c827_host_pvalue)
rm(Bin_c827_season_pvalue)

Bin_c828_bin_name <- "Bin_c828"
Bin_c828_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c828", ])
Bin_c828_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c828", ])
Bin_c828_host_pvalue <- Bin_c828_host_kruskal$p.value
Bin_c828_season_pvalue <- Bin_c828_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_c828_bin_name, Bin_c828_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_c828_bin_name, Bin_c828_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_c828_bin_name)
rm(Bin_c828_host_kruskal)
rm(Bin_c828_season_kruskal)
rm(Bin_c828_host_pvalue)
rm(Bin_c828_season_pvalue)

Bin_c832_bin_name <- "Bin_c832"
Bin_c832_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c832", ])
Bin_c832_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c832", ])
Bin_c832_host_pvalue <- Bin_c832_host_kruskal$p.value
Bin_c832_season_pvalue <- Bin_c832_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_c832_bin_name, Bin_c832_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_c832_bin_name, Bin_c832_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_c832_bin_name)
rm(Bin_c832_host_kruskal)
rm(Bin_c832_season_kruskal)
rm(Bin_c832_host_pvalue)
rm(Bin_c832_season_pvalue)

Bin_c856_bin_name <- "Bin_c856"
Bin_c856_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c856", ])
Bin_c856_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c856", ])
Bin_c856_host_pvalue <- Bin_c856_host_kruskal$p.value
Bin_c856_season_pvalue <- Bin_c856_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_c856_bin_name, Bin_c856_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_c856_bin_name, Bin_c856_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_c856_bin_name)
rm(Bin_c856_host_kruskal)
rm(Bin_c856_season_kruskal)
rm(Bin_c856_host_pvalue)
rm(Bin_c856_season_pvalue)

Bin_c860_bin_name <- "Bin_c860"
Bin_c860_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c860", ])
Bin_c860_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c860", ])
Bin_c860_host_pvalue <- Bin_c860_host_kruskal$p.value
Bin_c860_season_pvalue <- Bin_c860_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_c860_bin_name, Bin_c860_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_c860_bin_name, Bin_c860_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_c860_bin_name)
rm(Bin_c860_host_kruskal)
rm(Bin_c860_season_kruskal)
rm(Bin_c860_host_pvalue)
rm(Bin_c860_season_pvalue)

Bin_c867_bin_name <- "Bin_c867"
Bin_c867_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c867", ])
Bin_c867_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c867", ])
Bin_c867_host_pvalue <- Bin_c867_host_kruskal$p.value
Bin_c867_season_pvalue <- Bin_c867_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_c867_bin_name, Bin_c867_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_c867_bin_name, Bin_c867_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_c867_bin_name)
rm(Bin_c867_host_kruskal)
rm(Bin_c867_season_kruskal)
rm(Bin_c867_host_pvalue)
rm(Bin_c867_season_pvalue)

Bin_c890_bin_name <- "Bin_c890"
Bin_c890_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c890", ])
Bin_c890_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c890", ])
Bin_c890_host_pvalue <- Bin_c890_host_kruskal$p.value
Bin_c890_season_pvalue <- Bin_c890_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_c890_bin_name, Bin_c890_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_c890_bin_name, Bin_c890_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_c890_bin_name)
rm(Bin_c890_host_kruskal)
rm(Bin_c890_season_kruskal)
rm(Bin_c890_host_pvalue)
rm(Bin_c890_season_pvalue)

Bin_c892_bin_name <- "Bin_c892"
Bin_c892_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c892", ])
Bin_c892_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c892", ])
Bin_c892_host_pvalue <- Bin_c892_host_kruskal$p.value
Bin_c892_season_pvalue <- Bin_c892_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_c892_bin_name, Bin_c892_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_c892_bin_name, Bin_c892_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_c892_bin_name)
rm(Bin_c892_host_kruskal)
rm(Bin_c892_season_kruskal)
rm(Bin_c892_host_pvalue)
rm(Bin_c892_season_pvalue)

Bin_c894_bin_name <- "Bin_c894"
Bin_c894_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c894", ])
Bin_c894_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c894", ])
Bin_c894_host_pvalue <- Bin_c894_host_kruskal$p.value
Bin_c894_season_pvalue <- Bin_c894_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_c894_bin_name, Bin_c894_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_c894_bin_name, Bin_c894_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_c894_bin_name)
rm(Bin_c894_host_kruskal)
rm(Bin_c894_season_kruskal)
rm(Bin_c894_host_pvalue)
rm(Bin_c894_season_pvalue)

Bin_c897_bin_name <- "Bin_c897"
Bin_c897_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c897", ])
Bin_c897_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c897", ])
Bin_c897_host_pvalue <- Bin_c897_host_kruskal$p.value
Bin_c897_season_pvalue <- Bin_c897_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_c897_bin_name, Bin_c897_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_c897_bin_name, Bin_c897_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_c897_bin_name)
rm(Bin_c897_host_kruskal)
rm(Bin_c897_season_kruskal)
rm(Bin_c897_host_pvalue)
rm(Bin_c897_season_pvalue)

Bin_c901_bin_name <- "Bin_c901"
Bin_c901_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c901", ])
Bin_c901_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c901", ])
Bin_c901_host_pvalue <- Bin_c901_host_kruskal$p.value
Bin_c901_season_pvalue <- Bin_c901_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_c901_bin_name, Bin_c901_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_c901_bin_name, Bin_c901_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_c901_bin_name)
rm(Bin_c901_host_kruskal)
rm(Bin_c901_season_kruskal)
rm(Bin_c901_host_pvalue)
rm(Bin_c901_season_pvalue)

Bin_c908_bin_name <- "Bin_c908"
Bin_c908_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c908", ])
Bin_c908_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c908", ])
Bin_c908_host_pvalue <- Bin_c908_host_kruskal$p.value
Bin_c908_season_pvalue <- Bin_c908_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_c908_bin_name, Bin_c908_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_c908_bin_name, Bin_c908_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_c908_bin_name)
rm(Bin_c908_host_kruskal)
rm(Bin_c908_season_kruskal)
rm(Bin_c908_host_pvalue)
rm(Bin_c908_season_pvalue)

Bin_c912_bin_name <- "Bin_c912"
Bin_c912_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c912", ])
Bin_c912_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c912", ])
Bin_c912_host_pvalue <- Bin_c912_host_kruskal$p.value
Bin_c912_season_pvalue <- Bin_c912_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_c912_bin_name, Bin_c912_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_c912_bin_name, Bin_c912_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_c912_bin_name)
rm(Bin_c912_host_kruskal)
rm(Bin_c912_season_kruskal)
rm(Bin_c912_host_pvalue)
rm(Bin_c912_season_pvalue)

Bin_c918_bin_name <- "Bin_c918"
Bin_c918_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c918", ])
Bin_c918_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c918", ])
Bin_c918_host_pvalue <- Bin_c918_host_kruskal$p.value
Bin_c918_season_pvalue <- Bin_c918_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_c918_bin_name, Bin_c918_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_c918_bin_name, Bin_c918_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_c918_bin_name)
rm(Bin_c918_host_kruskal)
rm(Bin_c918_season_kruskal)
rm(Bin_c918_host_pvalue)
rm(Bin_c918_season_pvalue)

Bin_c932_bin_name <- "Bin_c932"
Bin_c932_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c932", ])
Bin_c932_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c932", ])
Bin_c932_host_pvalue <- Bin_c932_host_kruskal$p.value
Bin_c932_season_pvalue <- Bin_c932_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_c932_bin_name, Bin_c932_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_c932_bin_name, Bin_c932_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_c932_bin_name)
rm(Bin_c932_host_kruskal)
rm(Bin_c932_season_kruskal)
rm(Bin_c932_host_pvalue)
rm(Bin_c932_season_pvalue)

Bin_c943_bin_name <- "Bin_c943"
Bin_c943_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c943", ])
Bin_c943_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c943", ])
Bin_c943_host_pvalue <- Bin_c943_host_kruskal$p.value
Bin_c943_season_pvalue <- Bin_c943_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_c943_bin_name, Bin_c943_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_c943_bin_name, Bin_c943_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_c943_bin_name)
rm(Bin_c943_host_kruskal)
rm(Bin_c943_season_kruskal)
rm(Bin_c943_host_pvalue)
rm(Bin_c943_season_pvalue)

Bin_c956_bin_name <- "Bin_c956"
Bin_c956_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c956", ])
Bin_c956_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c956", ])
Bin_c956_host_pvalue <- Bin_c956_host_kruskal$p.value
Bin_c956_season_pvalue <- Bin_c956_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_c956_bin_name, Bin_c956_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_c956_bin_name, Bin_c956_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_c956_bin_name)
rm(Bin_c956_host_kruskal)
rm(Bin_c956_season_kruskal)
rm(Bin_c956_host_pvalue)
rm(Bin_c956_season_pvalue)

Bin_c962_bin_name <- "Bin_c962"
Bin_c962_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c962", ])
Bin_c962_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c962", ])
Bin_c962_host_pvalue <- Bin_c962_host_kruskal$p.value
Bin_c962_season_pvalue <- Bin_c962_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_c962_bin_name, Bin_c962_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_c962_bin_name, Bin_c962_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_c962_bin_name)
rm(Bin_c962_host_kruskal)
rm(Bin_c962_season_kruskal)
rm(Bin_c962_host_pvalue)
rm(Bin_c962_season_pvalue)

Bin_c976_bin_name <- "Bin_c976"
Bin_c976_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c976", ])
Bin_c976_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c976", ])
Bin_c976_host_pvalue <- Bin_c976_host_kruskal$p.value
Bin_c976_season_pvalue <- Bin_c976_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_c976_bin_name, Bin_c976_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_c976_bin_name, Bin_c976_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_c976_bin_name)
rm(Bin_c976_host_kruskal)
rm(Bin_c976_season_kruskal)
rm(Bin_c976_host_pvalue)
rm(Bin_c976_season_pvalue)

Bin_c981_bin_name <- "Bin_c981"
Bin_c981_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c981", ])
Bin_c981_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c981", ])
Bin_c981_host_pvalue <- Bin_c981_host_kruskal$p.value
Bin_c981_season_pvalue <- Bin_c981_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_c981_bin_name, Bin_c981_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_c981_bin_name, Bin_c981_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_c981_bin_name)
rm(Bin_c981_host_kruskal)
rm(Bin_c981_season_kruskal)
rm(Bin_c981_host_pvalue)
rm(Bin_c981_season_pvalue)

Bin_c991_bin_name <- "Bin_c991"
Bin_c991_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c991", ])
Bin_c991_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c991", ])
Bin_c991_host_pvalue <- Bin_c991_host_kruskal$p.value
Bin_c991_season_pvalue <- Bin_c991_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_c991_bin_name, Bin_c991_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_c991_bin_name, Bin_c991_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_c991_bin_name)
rm(Bin_c991_host_kruskal)
rm(Bin_c991_season_kruskal)
rm(Bin_c991_host_pvalue)
rm(Bin_c991_season_pvalue)

Bin_c998_bin_name <- "Bin_c998"
Bin_c998_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c998", ])
Bin_c998_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c998", ])
Bin_c998_host_pvalue <- Bin_c998_host_kruskal$p.value
Bin_c998_season_pvalue <- Bin_c998_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_c998_bin_name, Bin_c998_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_c998_bin_name, Bin_c998_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_c998_bin_name)
rm(Bin_c998_host_kruskal)
rm(Bin_c998_season_kruskal)
rm(Bin_c998_host_pvalue)
rm(Bin_c998_season_pvalue)

Bin_c1000_bin_name <- "Bin_c1000"
Bin_c1000_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c1000", ])
Bin_c1000_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c1000", ])
Bin_c1000_host_pvalue <- Bin_c1000_host_kruskal$p.value
Bin_c1000_season_pvalue <- Bin_c1000_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_c1000_bin_name, Bin_c1000_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_c1000_bin_name, Bin_c1000_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_c1000_bin_name)
rm(Bin_c1000_host_kruskal)
rm(Bin_c1000_season_kruskal)
rm(Bin_c1000_host_pvalue)
rm(Bin_c1000_season_pvalue)

Bin_c1005_bin_name <- "Bin_c1005"
Bin_c1005_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c1005", ])
Bin_c1005_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c1005", ])
Bin_c1005_host_pvalue <- Bin_c1005_host_kruskal$p.value
Bin_c1005_season_pvalue <- Bin_c1005_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_c1005_bin_name, Bin_c1005_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_c1005_bin_name, Bin_c1005_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_c1005_bin_name)
rm(Bin_c1005_host_kruskal)
rm(Bin_c1005_season_kruskal)
rm(Bin_c1005_host_pvalue)
rm(Bin_c1005_season_pvalue)

Bin_c1007_bin_name <- "Bin_c1007"
Bin_c1007_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c1007", ])
Bin_c1007_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c1007", ])
Bin_c1007_host_pvalue <- Bin_c1007_host_kruskal$p.value
Bin_c1007_season_pvalue <- Bin_c1007_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_c1007_bin_name, Bin_c1007_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_c1007_bin_name, Bin_c1007_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_c1007_bin_name)
rm(Bin_c1007_host_kruskal)
rm(Bin_c1007_season_kruskal)
rm(Bin_c1007_host_pvalue)
rm(Bin_c1007_season_pvalue)

Bin_c1023_bin_name <- "Bin_c1023"
Bin_c1023_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c1023", ])
Bin_c1023_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c1023", ])
Bin_c1023_host_pvalue <- Bin_c1023_host_kruskal$p.value
Bin_c1023_season_pvalue <- Bin_c1023_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_c1023_bin_name, Bin_c1023_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_c1023_bin_name, Bin_c1023_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_c1023_bin_name)
rm(Bin_c1023_host_kruskal)
rm(Bin_c1023_season_kruskal)
rm(Bin_c1023_host_pvalue)
rm(Bin_c1023_season_pvalue)

Bin_c1036_bin_name <- "Bin_c1036"
Bin_c1036_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c1036", ])
Bin_c1036_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c1036", ])
Bin_c1036_host_pvalue <- Bin_c1036_host_kruskal$p.value
Bin_c1036_season_pvalue <- Bin_c1036_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_c1036_bin_name, Bin_c1036_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_c1036_bin_name, Bin_c1036_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_c1036_bin_name)
rm(Bin_c1036_host_kruskal)
rm(Bin_c1036_season_kruskal)
rm(Bin_c1036_host_pvalue)
rm(Bin_c1036_season_pvalue)

Bin_c1043_bin_name <- "Bin_c1043"
Bin_c1043_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c1043", ])
Bin_c1043_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c1043", ])
Bin_c1043_host_pvalue <- Bin_c1043_host_kruskal$p.value
Bin_c1043_season_pvalue <- Bin_c1043_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_c1043_bin_name, Bin_c1043_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_c1043_bin_name, Bin_c1043_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_c1043_bin_name)
rm(Bin_c1043_host_kruskal)
rm(Bin_c1043_season_kruskal)
rm(Bin_c1043_host_pvalue)
rm(Bin_c1043_season_pvalue)

Bin_c1047_bin_name <- "Bin_c1047"
Bin_c1047_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c1047", ])
Bin_c1047_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c1047", ])
Bin_c1047_host_pvalue <- Bin_c1047_host_kruskal$p.value
Bin_c1047_season_pvalue <- Bin_c1047_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_c1047_bin_name, Bin_c1047_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_c1047_bin_name, Bin_c1047_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_c1047_bin_name)
rm(Bin_c1047_host_kruskal)
rm(Bin_c1047_season_kruskal)
rm(Bin_c1047_host_pvalue)
rm(Bin_c1047_season_pvalue)

Bin_c1052_bin_name <- "Bin_c1052"
Bin_c1052_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c1052", ])
Bin_c1052_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c1052", ])
Bin_c1052_host_pvalue <- Bin_c1052_host_kruskal$p.value
Bin_c1052_season_pvalue <- Bin_c1052_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_c1052_bin_name, Bin_c1052_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_c1052_bin_name, Bin_c1052_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_c1052_bin_name)
rm(Bin_c1052_host_kruskal)
rm(Bin_c1052_season_kruskal)
rm(Bin_c1052_host_pvalue)
rm(Bin_c1052_season_pvalue)

Bin_c1055_bin_name <- "Bin_c1055"
Bin_c1055_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c1055", ])
Bin_c1055_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c1055", ])
Bin_c1055_host_pvalue <- Bin_c1055_host_kruskal$p.value
Bin_c1055_season_pvalue <- Bin_c1055_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_c1055_bin_name, Bin_c1055_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_c1055_bin_name, Bin_c1055_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_c1055_bin_name)
rm(Bin_c1055_host_kruskal)
rm(Bin_c1055_season_kruskal)
rm(Bin_c1055_host_pvalue)
rm(Bin_c1055_season_pvalue)

Bin_c1070_bin_name <- "Bin_c1070"
Bin_c1070_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c1070", ])
Bin_c1070_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c1070", ])
Bin_c1070_host_pvalue <- Bin_c1070_host_kruskal$p.value
Bin_c1070_season_pvalue <- Bin_c1070_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_c1070_bin_name, Bin_c1070_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_c1070_bin_name, Bin_c1070_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_c1070_bin_name)
rm(Bin_c1070_host_kruskal)
rm(Bin_c1070_season_kruskal)
rm(Bin_c1070_host_pvalue)
rm(Bin_c1070_season_pvalue)

Bin_c1081_bin_name <- "Bin_c1081"
Bin_c1081_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c1081", ])
Bin_c1081_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c1081", ])
Bin_c1081_host_pvalue <- Bin_c1081_host_kruskal$p.value
Bin_c1081_season_pvalue <- Bin_c1081_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_c1081_bin_name, Bin_c1081_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_c1081_bin_name, Bin_c1081_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_c1081_bin_name)
rm(Bin_c1081_host_kruskal)
rm(Bin_c1081_season_kruskal)
rm(Bin_c1081_host_pvalue)
rm(Bin_c1081_season_pvalue)

Bin_c1082_bin_name <- "Bin_c1082"
Bin_c1082_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c1082", ])
Bin_c1082_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c1082", ])
Bin_c1082_host_pvalue <- Bin_c1082_host_kruskal$p.value
Bin_c1082_season_pvalue <- Bin_c1082_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_c1082_bin_name, Bin_c1082_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_c1082_bin_name, Bin_c1082_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_c1082_bin_name)
rm(Bin_c1082_host_kruskal)
rm(Bin_c1082_season_kruskal)
rm(Bin_c1082_host_pvalue)
rm(Bin_c1082_season_pvalue)

Bin_c1084_bin_name <- "Bin_c1084"
Bin_c1084_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c1084", ])
Bin_c1084_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c1084", ])
Bin_c1084_host_pvalue <- Bin_c1084_host_kruskal$p.value
Bin_c1084_season_pvalue <- Bin_c1084_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_c1084_bin_name, Bin_c1084_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_c1084_bin_name, Bin_c1084_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_c1084_bin_name)
rm(Bin_c1084_host_kruskal)
rm(Bin_c1084_season_kruskal)
rm(Bin_c1084_host_pvalue)
rm(Bin_c1084_season_pvalue)

Bin_c1108_bin_name <- "Bin_c1108"
Bin_c1108_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c1108", ])
Bin_c1108_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c1108", ])
Bin_c1108_host_pvalue <- Bin_c1108_host_kruskal$p.value
Bin_c1108_season_pvalue <- Bin_c1108_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_c1108_bin_name, Bin_c1108_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_c1108_bin_name, Bin_c1108_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_c1108_bin_name)
rm(Bin_c1108_host_kruskal)
rm(Bin_c1108_season_kruskal)
rm(Bin_c1108_host_pvalue)
rm(Bin_c1108_season_pvalue)

Bin_c1111_bin_name <- "Bin_c1111"
Bin_c1111_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c1111", ])
Bin_c1111_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c1111", ])
Bin_c1111_host_pvalue <- Bin_c1111_host_kruskal$p.value
Bin_c1111_season_pvalue <- Bin_c1111_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_c1111_bin_name, Bin_c1111_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_c1111_bin_name, Bin_c1111_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_c1111_bin_name)
rm(Bin_c1111_host_kruskal)
rm(Bin_c1111_season_kruskal)
rm(Bin_c1111_host_pvalue)
rm(Bin_c1111_season_pvalue)

Bin_c1113_bin_name <- "Bin_c1113"
Bin_c1113_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c1113", ])
Bin_c1113_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c1113", ])
Bin_c1113_host_pvalue <- Bin_c1113_host_kruskal$p.value
Bin_c1113_season_pvalue <- Bin_c1113_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_c1113_bin_name, Bin_c1113_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_c1113_bin_name, Bin_c1113_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_c1113_bin_name)
rm(Bin_c1113_host_kruskal)
rm(Bin_c1113_season_kruskal)
rm(Bin_c1113_host_pvalue)
rm(Bin_c1113_season_pvalue)

Bin_c1119_bin_name <- "Bin_c1119"
Bin_c1119_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c1119", ])
Bin_c1119_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c1119", ])
Bin_c1119_host_pvalue <- Bin_c1119_host_kruskal$p.value
Bin_c1119_season_pvalue <- Bin_c1119_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_c1119_bin_name, Bin_c1119_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_c1119_bin_name, Bin_c1119_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_c1119_bin_name)
rm(Bin_c1119_host_kruskal)
rm(Bin_c1119_season_kruskal)
rm(Bin_c1119_host_pvalue)
rm(Bin_c1119_season_pvalue)

Bin_c1138_bin_name <- "Bin_c1138"
Bin_c1138_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c1138", ])
Bin_c1138_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c1138", ])
Bin_c1138_host_pvalue <- Bin_c1138_host_kruskal$p.value
Bin_c1138_season_pvalue <- Bin_c1138_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_c1138_bin_name, Bin_c1138_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_c1138_bin_name, Bin_c1138_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_c1138_bin_name)
rm(Bin_c1138_host_kruskal)
rm(Bin_c1138_season_kruskal)
rm(Bin_c1138_host_pvalue)
rm(Bin_c1138_season_pvalue)

Bin_c1148_bin_name <- "Bin_c1148"
Bin_c1148_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c1148", ])
Bin_c1148_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c1148", ])
Bin_c1148_host_pvalue <- Bin_c1148_host_kruskal$p.value
Bin_c1148_season_pvalue <- Bin_c1148_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_c1148_bin_name, Bin_c1148_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_c1148_bin_name, Bin_c1148_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_c1148_bin_name)
rm(Bin_c1148_host_kruskal)
rm(Bin_c1148_season_kruskal)
rm(Bin_c1148_host_pvalue)
rm(Bin_c1148_season_pvalue)

Bin_c1158_bin_name <- "Bin_c1158"
Bin_c1158_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c1158", ])
Bin_c1158_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c1158", ])
Bin_c1158_host_pvalue <- Bin_c1158_host_kruskal$p.value
Bin_c1158_season_pvalue <- Bin_c1158_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_c1158_bin_name, Bin_c1158_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_c1158_bin_name, Bin_c1158_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_c1158_bin_name)
rm(Bin_c1158_host_kruskal)
rm(Bin_c1158_season_kruskal)
rm(Bin_c1158_host_pvalue)
rm(Bin_c1158_season_pvalue)

Bin_c1165_bin_name <- "Bin_c1165"
Bin_c1165_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c1165", ])
Bin_c1165_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c1165", ])
Bin_c1165_host_pvalue <- Bin_c1165_host_kruskal$p.value
Bin_c1165_season_pvalue <- Bin_c1165_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_c1165_bin_name, Bin_c1165_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_c1165_bin_name, Bin_c1165_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_c1165_bin_name)
rm(Bin_c1165_host_kruskal)
rm(Bin_c1165_season_kruskal)
rm(Bin_c1165_host_pvalue)
rm(Bin_c1165_season_pvalue)

Bin_c1167_bin_name <- "Bin_c1167"
Bin_c1167_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c1167", ])
Bin_c1167_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c1167", ])
Bin_c1167_host_pvalue <- Bin_c1167_host_kruskal$p.value
Bin_c1167_season_pvalue <- Bin_c1167_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_c1167_bin_name, Bin_c1167_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_c1167_bin_name, Bin_c1167_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_c1167_bin_name)
rm(Bin_c1167_host_kruskal)
rm(Bin_c1167_season_kruskal)
rm(Bin_c1167_host_pvalue)
rm(Bin_c1167_season_pvalue)

Bin_c1173_bin_name <- "Bin_c1173"
Bin_c1173_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c1173", ])
Bin_c1173_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c1173", ])
Bin_c1173_host_pvalue <- Bin_c1173_host_kruskal$p.value
Bin_c1173_season_pvalue <- Bin_c1173_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_c1173_bin_name, Bin_c1173_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_c1173_bin_name, Bin_c1173_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_c1173_bin_name)
rm(Bin_c1173_host_kruskal)
rm(Bin_c1173_season_kruskal)
rm(Bin_c1173_host_pvalue)
rm(Bin_c1173_season_pvalue)

Bin_c1180_bin_name <- "Bin_c1180"
Bin_c1180_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c1180", ])
Bin_c1180_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c1180", ])
Bin_c1180_host_pvalue <- Bin_c1180_host_kruskal$p.value
Bin_c1180_season_pvalue <- Bin_c1180_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_c1180_bin_name, Bin_c1180_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_c1180_bin_name, Bin_c1180_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_c1180_bin_name)
rm(Bin_c1180_host_kruskal)
rm(Bin_c1180_season_kruskal)
rm(Bin_c1180_host_pvalue)
rm(Bin_c1180_season_pvalue)

Bin_c1183_bin_name <- "Bin_c1183"
Bin_c1183_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c1183", ])
Bin_c1183_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c1183", ])
Bin_c1183_host_pvalue <- Bin_c1183_host_kruskal$p.value
Bin_c1183_season_pvalue <- Bin_c1183_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_c1183_bin_name, Bin_c1183_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_c1183_bin_name, Bin_c1183_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_c1183_bin_name)
rm(Bin_c1183_host_kruskal)
rm(Bin_c1183_season_kruskal)
rm(Bin_c1183_host_pvalue)
rm(Bin_c1183_season_pvalue)

Bin_c1188_bin_name <- "Bin_c1188"
Bin_c1188_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c1188", ])
Bin_c1188_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c1188", ])
Bin_c1188_host_pvalue <- Bin_c1188_host_kruskal$p.value
Bin_c1188_season_pvalue <- Bin_c1188_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_c1188_bin_name, Bin_c1188_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_c1188_bin_name, Bin_c1188_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_c1188_bin_name)
rm(Bin_c1188_host_kruskal)
rm(Bin_c1188_season_kruskal)
rm(Bin_c1188_host_pvalue)
rm(Bin_c1188_season_pvalue)

Bin_c1194_bin_name <- "Bin_c1194"
Bin_c1194_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c1194", ])
Bin_c1194_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c1194", ])
Bin_c1194_host_pvalue <- Bin_c1194_host_kruskal$p.value
Bin_c1194_season_pvalue <- Bin_c1194_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_c1194_bin_name, Bin_c1194_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_c1194_bin_name, Bin_c1194_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_c1194_bin_name)
rm(Bin_c1194_host_kruskal)
rm(Bin_c1194_season_kruskal)
rm(Bin_c1194_host_pvalue)
rm(Bin_c1194_season_pvalue)

Bin_c1199_bin_name <- "Bin_c1199"
Bin_c1199_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c1199", ])
Bin_c1199_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c1199", ])
Bin_c1199_host_pvalue <- Bin_c1199_host_kruskal$p.value
Bin_c1199_season_pvalue <- Bin_c1199_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_c1199_bin_name, Bin_c1199_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_c1199_bin_name, Bin_c1199_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_c1199_bin_name)
rm(Bin_c1199_host_kruskal)
rm(Bin_c1199_season_kruskal)
rm(Bin_c1199_host_pvalue)
rm(Bin_c1199_season_pvalue)

Bin_c1212_bin_name <- "Bin_c1212"
Bin_c1212_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c1212", ])
Bin_c1212_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c1212", ])
Bin_c1212_host_pvalue <- Bin_c1212_host_kruskal$p.value
Bin_c1212_season_pvalue <- Bin_c1212_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_c1212_bin_name, Bin_c1212_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_c1212_bin_name, Bin_c1212_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_c1212_bin_name)
rm(Bin_c1212_host_kruskal)
rm(Bin_c1212_season_kruskal)
rm(Bin_c1212_host_pvalue)
rm(Bin_c1212_season_pvalue)

Bin_c1216_bin_name <- "Bin_c1216"
Bin_c1216_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c1216", ])
Bin_c1216_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c1216", ])
Bin_c1216_host_pvalue <- Bin_c1216_host_kruskal$p.value
Bin_c1216_season_pvalue <- Bin_c1216_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_c1216_bin_name, Bin_c1216_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_c1216_bin_name, Bin_c1216_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_c1216_bin_name)
rm(Bin_c1216_host_kruskal)
rm(Bin_c1216_season_kruskal)
rm(Bin_c1216_host_pvalue)
rm(Bin_c1216_season_pvalue)

Bin_c1225_bin_name <- "Bin_c1225"
Bin_c1225_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c1225", ])
Bin_c1225_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c1225", ])
Bin_c1225_host_pvalue <- Bin_c1225_host_kruskal$p.value
Bin_c1225_season_pvalue <- Bin_c1225_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_c1225_bin_name, Bin_c1225_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_c1225_bin_name, Bin_c1225_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_c1225_bin_name)
rm(Bin_c1225_host_kruskal)
rm(Bin_c1225_season_kruskal)
rm(Bin_c1225_host_pvalue)
rm(Bin_c1225_season_pvalue)

Bin_c1226_bin_name <- "Bin_c1226"
Bin_c1226_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c1226", ])
Bin_c1226_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c1226", ])
Bin_c1226_host_pvalue <- Bin_c1226_host_kruskal$p.value
Bin_c1226_season_pvalue <- Bin_c1226_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_c1226_bin_name, Bin_c1226_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_c1226_bin_name, Bin_c1226_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_c1226_bin_name)
rm(Bin_c1226_host_kruskal)
rm(Bin_c1226_season_kruskal)
rm(Bin_c1226_host_pvalue)
rm(Bin_c1226_season_pvalue)

Bin_c1229_bin_name <- "Bin_c1229"
Bin_c1229_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c1229", ])
Bin_c1229_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c1229", ])
Bin_c1229_host_pvalue <- Bin_c1229_host_kruskal$p.value
Bin_c1229_season_pvalue <- Bin_c1229_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_c1229_bin_name, Bin_c1229_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_c1229_bin_name, Bin_c1229_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_c1229_bin_name)
rm(Bin_c1229_host_kruskal)
rm(Bin_c1229_season_kruskal)
rm(Bin_c1229_host_pvalue)
rm(Bin_c1229_season_pvalue)

Bin_c1233_bin_name <- "Bin_c1233"
Bin_c1233_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c1233", ])
Bin_c1233_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c1233", ])
Bin_c1233_host_pvalue <- Bin_c1233_host_kruskal$p.value
Bin_c1233_season_pvalue <- Bin_c1233_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_c1233_bin_name, Bin_c1233_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_c1233_bin_name, Bin_c1233_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_c1233_bin_name)
rm(Bin_c1233_host_kruskal)
rm(Bin_c1233_season_kruskal)
rm(Bin_c1233_host_pvalue)
rm(Bin_c1233_season_pvalue)

Bin_c1235_bin_name <- "Bin_c1235"
Bin_c1235_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c1235", ])
Bin_c1235_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c1235", ])
Bin_c1235_host_pvalue <- Bin_c1235_host_kruskal$p.value
Bin_c1235_season_pvalue <- Bin_c1235_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_c1235_bin_name, Bin_c1235_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_c1235_bin_name, Bin_c1235_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_c1235_bin_name)
rm(Bin_c1235_host_kruskal)
rm(Bin_c1235_season_kruskal)
rm(Bin_c1235_host_pvalue)
rm(Bin_c1235_season_pvalue)

Bin_c1243_bin_name <- "Bin_c1243"
Bin_c1243_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c1243", ])
Bin_c1243_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c1243", ])
Bin_c1243_host_pvalue <- Bin_c1243_host_kruskal$p.value
Bin_c1243_season_pvalue <- Bin_c1243_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_c1243_bin_name, Bin_c1243_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_c1243_bin_name, Bin_c1243_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_c1243_bin_name)
rm(Bin_c1243_host_kruskal)
rm(Bin_c1243_season_kruskal)
rm(Bin_c1243_host_pvalue)
rm(Bin_c1243_season_pvalue)

Bin_c1245_bin_name <- "Bin_c1245"
Bin_c1245_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c1245", ])
Bin_c1245_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c1245", ])
Bin_c1245_host_pvalue <- Bin_c1245_host_kruskal$p.value
Bin_c1245_season_pvalue <- Bin_c1245_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_c1245_bin_name, Bin_c1245_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_c1245_bin_name, Bin_c1245_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_c1245_bin_name)
rm(Bin_c1245_host_kruskal)
rm(Bin_c1245_season_kruskal)
rm(Bin_c1245_host_pvalue)
rm(Bin_c1245_season_pvalue)

Bin_c1256_bin_name <- "Bin_c1256"
Bin_c1256_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c1256", ])
Bin_c1256_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c1256", ])
Bin_c1256_host_pvalue <- Bin_c1256_host_kruskal$p.value
Bin_c1256_season_pvalue <- Bin_c1256_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_c1256_bin_name, Bin_c1256_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_c1256_bin_name, Bin_c1256_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_c1256_bin_name)
rm(Bin_c1256_host_kruskal)
rm(Bin_c1256_season_kruskal)
rm(Bin_c1256_host_pvalue)
rm(Bin_c1256_season_pvalue)

Bin_c1264_bin_name <- "Bin_c1264"
Bin_c1264_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c1264", ])
Bin_c1264_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c1264", ])
Bin_c1264_host_pvalue <- Bin_c1264_host_kruskal$p.value
Bin_c1264_season_pvalue <- Bin_c1264_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_c1264_bin_name, Bin_c1264_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_c1264_bin_name, Bin_c1264_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_c1264_bin_name)
rm(Bin_c1264_host_kruskal)
rm(Bin_c1264_season_kruskal)
rm(Bin_c1264_host_pvalue)
rm(Bin_c1264_season_pvalue)

Bin_c1268_bin_name <- "Bin_c1268"
Bin_c1268_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c1268", ])
Bin_c1268_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c1268", ])
Bin_c1268_host_pvalue <- Bin_c1268_host_kruskal$p.value
Bin_c1268_season_pvalue <- Bin_c1268_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_c1268_bin_name, Bin_c1268_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_c1268_bin_name, Bin_c1268_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_c1268_bin_name)
rm(Bin_c1268_host_kruskal)
rm(Bin_c1268_season_kruskal)
rm(Bin_c1268_host_pvalue)
rm(Bin_c1268_season_pvalue)

Bin_c1272_bin_name <- "Bin_c1272"
Bin_c1272_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c1272", ])
Bin_c1272_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c1272", ])
Bin_c1272_host_pvalue <- Bin_c1272_host_kruskal$p.value
Bin_c1272_season_pvalue <- Bin_c1272_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_c1272_bin_name, Bin_c1272_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_c1272_bin_name, Bin_c1272_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_c1272_bin_name)
rm(Bin_c1272_host_kruskal)
rm(Bin_c1272_season_kruskal)
rm(Bin_c1272_host_pvalue)
rm(Bin_c1272_season_pvalue)

Bin_c1275_bin_name <- "Bin_c1275"
Bin_c1275_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c1275", ])
Bin_c1275_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c1275", ])
Bin_c1275_host_pvalue <- Bin_c1275_host_kruskal$p.value
Bin_c1275_season_pvalue <- Bin_c1275_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_c1275_bin_name, Bin_c1275_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_c1275_bin_name, Bin_c1275_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_c1275_bin_name)
rm(Bin_c1275_host_kruskal)
rm(Bin_c1275_season_kruskal)
rm(Bin_c1275_host_pvalue)
rm(Bin_c1275_season_pvalue)

Bin_c1281_bin_name <- "Bin_c1281"
Bin_c1281_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c1281", ])
Bin_c1281_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c1281", ])
Bin_c1281_host_pvalue <- Bin_c1281_host_kruskal$p.value
Bin_c1281_season_pvalue <- Bin_c1281_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_c1281_bin_name, Bin_c1281_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_c1281_bin_name, Bin_c1281_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_c1281_bin_name)
rm(Bin_c1281_host_kruskal)
rm(Bin_c1281_season_kruskal)
rm(Bin_c1281_host_pvalue)
rm(Bin_c1281_season_pvalue)

Bin_c1294_bin_name <- "Bin_c1294"
Bin_c1294_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c1294", ])
Bin_c1294_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c1294", ])
Bin_c1294_host_pvalue <- Bin_c1294_host_kruskal$p.value
Bin_c1294_season_pvalue <- Bin_c1294_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_c1294_bin_name, Bin_c1294_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_c1294_bin_name, Bin_c1294_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_c1294_bin_name)
rm(Bin_c1294_host_kruskal)
rm(Bin_c1294_season_kruskal)
rm(Bin_c1294_host_pvalue)
rm(Bin_c1294_season_pvalue)

Bin_c1296_bin_name <- "Bin_c1296"
Bin_c1296_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c1296", ])
Bin_c1296_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c1296", ])
Bin_c1296_host_pvalue <- Bin_c1296_host_kruskal$p.value
Bin_c1296_season_pvalue <- Bin_c1296_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_c1296_bin_name, Bin_c1296_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_c1296_bin_name, Bin_c1296_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_c1296_bin_name)
rm(Bin_c1296_host_kruskal)
rm(Bin_c1296_season_kruskal)
rm(Bin_c1296_host_pvalue)
rm(Bin_c1296_season_pvalue)

Bin_c1297_bin_name <- "Bin_c1297"
Bin_c1297_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c1297", ])
Bin_c1297_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c1297", ])
Bin_c1297_host_pvalue <- Bin_c1297_host_kruskal$p.value
Bin_c1297_season_pvalue <- Bin_c1297_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_c1297_bin_name, Bin_c1297_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_c1297_bin_name, Bin_c1297_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_c1297_bin_name)
rm(Bin_c1297_host_kruskal)
rm(Bin_c1297_season_kruskal)
rm(Bin_c1297_host_pvalue)
rm(Bin_c1297_season_pvalue)

Bin_c1309_bin_name <- "Bin_c1309"
Bin_c1309_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c1309", ])
Bin_c1309_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c1309", ])
Bin_c1309_host_pvalue <- Bin_c1309_host_kruskal$p.value
Bin_c1309_season_pvalue <- Bin_c1309_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_c1309_bin_name, Bin_c1309_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_c1309_bin_name, Bin_c1309_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_c1309_bin_name)
rm(Bin_c1309_host_kruskal)
rm(Bin_c1309_season_kruskal)
rm(Bin_c1309_host_pvalue)
rm(Bin_c1309_season_pvalue)

Bin_c1325_bin_name <- "Bin_c1325"
Bin_c1325_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c1325", ])
Bin_c1325_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c1325", ])
Bin_c1325_host_pvalue <- Bin_c1325_host_kruskal$p.value
Bin_c1325_season_pvalue <- Bin_c1325_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_c1325_bin_name, Bin_c1325_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_c1325_bin_name, Bin_c1325_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_c1325_bin_name)
rm(Bin_c1325_host_kruskal)
rm(Bin_c1325_season_kruskal)
rm(Bin_c1325_host_pvalue)
rm(Bin_c1325_season_pvalue)

Bin_c1326_bin_name <- "Bin_c1326"
Bin_c1326_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c1326", ])
Bin_c1326_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c1326", ])
Bin_c1326_host_pvalue <- Bin_c1326_host_kruskal$p.value
Bin_c1326_season_pvalue <- Bin_c1326_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_c1326_bin_name, Bin_c1326_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_c1326_bin_name, Bin_c1326_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_c1326_bin_name)
rm(Bin_c1326_host_kruskal)
rm(Bin_c1326_season_kruskal)
rm(Bin_c1326_host_pvalue)
rm(Bin_c1326_season_pvalue)

Bin_c1328_bin_name <- "Bin_c1328"
Bin_c1328_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c1328", ])
Bin_c1328_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c1328", ])
Bin_c1328_host_pvalue <- Bin_c1328_host_kruskal$p.value
Bin_c1328_season_pvalue <- Bin_c1328_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_c1328_bin_name, Bin_c1328_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_c1328_bin_name, Bin_c1328_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_c1328_bin_name)
rm(Bin_c1328_host_kruskal)
rm(Bin_c1328_season_kruskal)
rm(Bin_c1328_host_pvalue)
rm(Bin_c1328_season_pvalue)

Bin_c1337_bin_name <- "Bin_c1337"
Bin_c1337_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c1337", ])
Bin_c1337_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c1337", ])
Bin_c1337_host_pvalue <- Bin_c1337_host_kruskal$p.value
Bin_c1337_season_pvalue <- Bin_c1337_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_c1337_bin_name, Bin_c1337_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_c1337_bin_name, Bin_c1337_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_c1337_bin_name)
rm(Bin_c1337_host_kruskal)
rm(Bin_c1337_season_kruskal)
rm(Bin_c1337_host_pvalue)
rm(Bin_c1337_season_pvalue)

Bin_c1357_bin_name <- "Bin_c1357"
Bin_c1357_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c1357", ])
Bin_c1357_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c1357", ])
Bin_c1357_host_pvalue <- Bin_c1357_host_kruskal$p.value
Bin_c1357_season_pvalue <- Bin_c1357_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_c1357_bin_name, Bin_c1357_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_c1357_bin_name, Bin_c1357_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_c1357_bin_name)
rm(Bin_c1357_host_kruskal)
rm(Bin_c1357_season_kruskal)
rm(Bin_c1357_host_pvalue)
rm(Bin_c1357_season_pvalue)

Bin_c1372_bin_name <- "Bin_c1372"
Bin_c1372_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c1372", ])
Bin_c1372_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c1372", ])
Bin_c1372_host_pvalue <- Bin_c1372_host_kruskal$p.value
Bin_c1372_season_pvalue <- Bin_c1372_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_c1372_bin_name, Bin_c1372_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_c1372_bin_name, Bin_c1372_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_c1372_bin_name)
rm(Bin_c1372_host_kruskal)
rm(Bin_c1372_season_kruskal)
rm(Bin_c1372_host_pvalue)
rm(Bin_c1372_season_pvalue)

Bin_c1378_bin_name <- "Bin_c1378"
Bin_c1378_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c1378", ])
Bin_c1378_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c1378", ])
Bin_c1378_host_pvalue <- Bin_c1378_host_kruskal$p.value
Bin_c1378_season_pvalue <- Bin_c1378_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_c1378_bin_name, Bin_c1378_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_c1378_bin_name, Bin_c1378_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_c1378_bin_name)
rm(Bin_c1378_host_kruskal)
rm(Bin_c1378_season_kruskal)
rm(Bin_c1378_host_pvalue)
rm(Bin_c1378_season_pvalue)

Bin_c1379_bin_name <- "Bin_c1379"
Bin_c1379_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c1379", ])
Bin_c1379_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c1379", ])
Bin_c1379_host_pvalue <- Bin_c1379_host_kruskal$p.value
Bin_c1379_season_pvalue <- Bin_c1379_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_c1379_bin_name, Bin_c1379_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_c1379_bin_name, Bin_c1379_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_c1379_bin_name)
rm(Bin_c1379_host_kruskal)
rm(Bin_c1379_season_kruskal)
rm(Bin_c1379_host_pvalue)
rm(Bin_c1379_season_pvalue)

Bin_c1384_bin_name <- "Bin_c1384"
Bin_c1384_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c1384", ])
Bin_c1384_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c1384", ])
Bin_c1384_host_pvalue <- Bin_c1384_host_kruskal$p.value
Bin_c1384_season_pvalue <- Bin_c1384_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_c1384_bin_name, Bin_c1384_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_c1384_bin_name, Bin_c1384_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_c1384_bin_name)
rm(Bin_c1384_host_kruskal)
rm(Bin_c1384_season_kruskal)
rm(Bin_c1384_host_pvalue)
rm(Bin_c1384_season_pvalue)

Bin_c1391_bin_name <- "Bin_c1391"
Bin_c1391_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c1391", ])
Bin_c1391_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c1391", ])
Bin_c1391_host_pvalue <- Bin_c1391_host_kruskal$p.value
Bin_c1391_season_pvalue <- Bin_c1391_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_c1391_bin_name, Bin_c1391_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_c1391_bin_name, Bin_c1391_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_c1391_bin_name)
rm(Bin_c1391_host_kruskal)
rm(Bin_c1391_season_kruskal)
rm(Bin_c1391_host_pvalue)
rm(Bin_c1391_season_pvalue)

Bin_c1401_bin_name <- "Bin_c1401"
Bin_c1401_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c1401", ])
Bin_c1401_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c1401", ])
Bin_c1401_host_pvalue <- Bin_c1401_host_kruskal$p.value
Bin_c1401_season_pvalue <- Bin_c1401_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_c1401_bin_name, Bin_c1401_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_c1401_bin_name, Bin_c1401_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_c1401_bin_name)
rm(Bin_c1401_host_kruskal)
rm(Bin_c1401_season_kruskal)
rm(Bin_c1401_host_pvalue)
rm(Bin_c1401_season_pvalue)

Bin_c1412_bin_name <- "Bin_c1412"
Bin_c1412_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c1412", ])
Bin_c1412_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c1412", ])
Bin_c1412_host_pvalue <- Bin_c1412_host_kruskal$p.value
Bin_c1412_season_pvalue <- Bin_c1412_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_c1412_bin_name, Bin_c1412_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_c1412_bin_name, Bin_c1412_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_c1412_bin_name)
rm(Bin_c1412_host_kruskal)
rm(Bin_c1412_season_kruskal)
rm(Bin_c1412_host_pvalue)
rm(Bin_c1412_season_pvalue)

Bin_c1415_bin_name <- "Bin_c1415"
Bin_c1415_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c1415", ])
Bin_c1415_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c1415", ])
Bin_c1415_host_pvalue <- Bin_c1415_host_kruskal$p.value
Bin_c1415_season_pvalue <- Bin_c1415_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_c1415_bin_name, Bin_c1415_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_c1415_bin_name, Bin_c1415_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_c1415_bin_name)
rm(Bin_c1415_host_kruskal)
rm(Bin_c1415_season_kruskal)
rm(Bin_c1415_host_pvalue)
rm(Bin_c1415_season_pvalue)

Bin_c1431_bin_name <- "Bin_c1431"
Bin_c1431_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c1431", ])
Bin_c1431_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c1431", ])
Bin_c1431_host_pvalue <- Bin_c1431_host_kruskal$p.value
Bin_c1431_season_pvalue <- Bin_c1431_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_c1431_bin_name, Bin_c1431_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_c1431_bin_name, Bin_c1431_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_c1431_bin_name)
rm(Bin_c1431_host_kruskal)
rm(Bin_c1431_season_kruskal)
rm(Bin_c1431_host_pvalue)
rm(Bin_c1431_season_pvalue)

Bin_c1435_bin_name <- "Bin_c1435"
Bin_c1435_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c1435", ])
Bin_c1435_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c1435", ])
Bin_c1435_host_pvalue <- Bin_c1435_host_kruskal$p.value
Bin_c1435_season_pvalue <- Bin_c1435_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_c1435_bin_name, Bin_c1435_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_c1435_bin_name, Bin_c1435_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_c1435_bin_name)
rm(Bin_c1435_host_kruskal)
rm(Bin_c1435_season_kruskal)
rm(Bin_c1435_host_pvalue)
rm(Bin_c1435_season_pvalue)

Bin_c1476_bin_name <- "Bin_c1476"
Bin_c1476_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c1476", ])
Bin_c1476_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c1476", ])
Bin_c1476_host_pvalue <- Bin_c1476_host_kruskal$p.value
Bin_c1476_season_pvalue <- Bin_c1476_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_c1476_bin_name, Bin_c1476_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_c1476_bin_name, Bin_c1476_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_c1476_bin_name)
rm(Bin_c1476_host_kruskal)
rm(Bin_c1476_season_kruskal)
rm(Bin_c1476_host_pvalue)
rm(Bin_c1476_season_pvalue)

Bin_c1488_bin_name <- "Bin_c1488"
Bin_c1488_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c1488", ])
Bin_c1488_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c1488", ])
Bin_c1488_host_pvalue <- Bin_c1488_host_kruskal$p.value
Bin_c1488_season_pvalue <- Bin_c1488_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_c1488_bin_name, Bin_c1488_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_c1488_bin_name, Bin_c1488_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_c1488_bin_name)
rm(Bin_c1488_host_kruskal)
rm(Bin_c1488_season_kruskal)
rm(Bin_c1488_host_pvalue)
rm(Bin_c1488_season_pvalue)

Bin_c1490_bin_name <- "Bin_c1490"
Bin_c1490_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c1490", ])
Bin_c1490_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c1490", ])
Bin_c1490_host_pvalue <- Bin_c1490_host_kruskal$p.value
Bin_c1490_season_pvalue <- Bin_c1490_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_c1490_bin_name, Bin_c1490_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_c1490_bin_name, Bin_c1490_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_c1490_bin_name)
rm(Bin_c1490_host_kruskal)
rm(Bin_c1490_season_kruskal)
rm(Bin_c1490_host_pvalue)
rm(Bin_c1490_season_pvalue)

Bin_c1492_bin_name <- "Bin_c1492"
Bin_c1492_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c1492", ])
Bin_c1492_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c1492", ])
Bin_c1492_host_pvalue <- Bin_c1492_host_kruskal$p.value
Bin_c1492_season_pvalue <- Bin_c1492_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_c1492_bin_name, Bin_c1492_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_c1492_bin_name, Bin_c1492_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_c1492_bin_name)
rm(Bin_c1492_host_kruskal)
rm(Bin_c1492_season_kruskal)
rm(Bin_c1492_host_pvalue)
rm(Bin_c1492_season_pvalue)

Bin_c1496_bin_name <- "Bin_c1496"
Bin_c1496_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c1496", ])
Bin_c1496_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c1496", ])
Bin_c1496_host_pvalue <- Bin_c1496_host_kruskal$p.value
Bin_c1496_season_pvalue <- Bin_c1496_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_c1496_bin_name, Bin_c1496_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_c1496_bin_name, Bin_c1496_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_c1496_bin_name)
rm(Bin_c1496_host_kruskal)
rm(Bin_c1496_season_kruskal)
rm(Bin_c1496_host_pvalue)
rm(Bin_c1496_season_pvalue)

Bin_c1500_bin_name <- "Bin_c1500"
Bin_c1500_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c1500", ])
Bin_c1500_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c1500", ])
Bin_c1500_host_pvalue <- Bin_c1500_host_kruskal$p.value
Bin_c1500_season_pvalue <- Bin_c1500_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_c1500_bin_name, Bin_c1500_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_c1500_bin_name, Bin_c1500_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_c1500_bin_name)
rm(Bin_c1500_host_kruskal)
rm(Bin_c1500_season_kruskal)
rm(Bin_c1500_host_pvalue)
rm(Bin_c1500_season_pvalue)

Bin_c1516_bin_name <- "Bin_c1516"
Bin_c1516_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c1516", ])
Bin_c1516_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c1516", ])
Bin_c1516_host_pvalue <- Bin_c1516_host_kruskal$p.value
Bin_c1516_season_pvalue <- Bin_c1516_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_c1516_bin_name, Bin_c1516_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_c1516_bin_name, Bin_c1516_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_c1516_bin_name)
rm(Bin_c1516_host_kruskal)
rm(Bin_c1516_season_kruskal)
rm(Bin_c1516_host_pvalue)
rm(Bin_c1516_season_pvalue)

Bin_c1526_bin_name <- "Bin_c1526"
Bin_c1526_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c1526", ])
Bin_c1526_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c1526", ])
Bin_c1526_host_pvalue <- Bin_c1526_host_kruskal$p.value
Bin_c1526_season_pvalue <- Bin_c1526_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_c1526_bin_name, Bin_c1526_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_c1526_bin_name, Bin_c1526_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_c1526_bin_name)
rm(Bin_c1526_host_kruskal)
rm(Bin_c1526_season_kruskal)
rm(Bin_c1526_host_pvalue)
rm(Bin_c1526_season_pvalue)

Bin_c1531_bin_name <- "Bin_c1531"
Bin_c1531_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c1531", ])
Bin_c1531_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c1531", ])
Bin_c1531_host_pvalue <- Bin_c1531_host_kruskal$p.value
Bin_c1531_season_pvalue <- Bin_c1531_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_c1531_bin_name, Bin_c1531_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_c1531_bin_name, Bin_c1531_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_c1531_bin_name)
rm(Bin_c1531_host_kruskal)
rm(Bin_c1531_season_kruskal)
rm(Bin_c1531_host_pvalue)
rm(Bin_c1531_season_pvalue)

Bin_c1549_bin_name <- "Bin_c1549"
Bin_c1549_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c1549", ])
Bin_c1549_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c1549", ])
Bin_c1549_host_pvalue <- Bin_c1549_host_kruskal$p.value
Bin_c1549_season_pvalue <- Bin_c1549_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_c1549_bin_name, Bin_c1549_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_c1549_bin_name, Bin_c1549_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_c1549_bin_name)
rm(Bin_c1549_host_kruskal)
rm(Bin_c1549_season_kruskal)
rm(Bin_c1549_host_pvalue)
rm(Bin_c1549_season_pvalue)

Bin_c1555_bin_name <- "Bin_c1555"
Bin_c1555_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c1555", ])
Bin_c1555_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c1555", ])
Bin_c1555_host_pvalue <- Bin_c1555_host_kruskal$p.value
Bin_c1555_season_pvalue <- Bin_c1555_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_c1555_bin_name, Bin_c1555_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_c1555_bin_name, Bin_c1555_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_c1555_bin_name)
rm(Bin_c1555_host_kruskal)
rm(Bin_c1555_season_kruskal)
rm(Bin_c1555_host_pvalue)
rm(Bin_c1555_season_pvalue)

Bin_c1562_bin_name <- "Bin_c1562"
Bin_c1562_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c1562", ])
Bin_c1562_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c1562", ])
Bin_c1562_host_pvalue <- Bin_c1562_host_kruskal$p.value
Bin_c1562_season_pvalue <- Bin_c1562_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_c1562_bin_name, Bin_c1562_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_c1562_bin_name, Bin_c1562_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_c1562_bin_name)
rm(Bin_c1562_host_kruskal)
rm(Bin_c1562_season_kruskal)
rm(Bin_c1562_host_pvalue)
rm(Bin_c1562_season_pvalue)

Bin_c1570_bin_name <- "Bin_c1570"
Bin_c1570_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c1570", ])
Bin_c1570_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c1570", ])
Bin_c1570_host_pvalue <- Bin_c1570_host_kruskal$p.value
Bin_c1570_season_pvalue <- Bin_c1570_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_c1570_bin_name, Bin_c1570_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_c1570_bin_name, Bin_c1570_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_c1570_bin_name)
rm(Bin_c1570_host_kruskal)
rm(Bin_c1570_season_kruskal)
rm(Bin_c1570_host_pvalue)
rm(Bin_c1570_season_pvalue)

Bin_c1606_bin_name <- "Bin_c1606"
Bin_c1606_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c1606", ])
Bin_c1606_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c1606", ])
Bin_c1606_host_pvalue <- Bin_c1606_host_kruskal$p.value
Bin_c1606_season_pvalue <- Bin_c1606_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_c1606_bin_name, Bin_c1606_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_c1606_bin_name, Bin_c1606_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_c1606_bin_name)
rm(Bin_c1606_host_kruskal)
rm(Bin_c1606_season_kruskal)
rm(Bin_c1606_host_pvalue)
rm(Bin_c1606_season_pvalue)

Bin_c1617_bin_name <- "Bin_c1617"
Bin_c1617_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c1617", ])
Bin_c1617_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c1617", ])
Bin_c1617_host_pvalue <- Bin_c1617_host_kruskal$p.value
Bin_c1617_season_pvalue <- Bin_c1617_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_c1617_bin_name, Bin_c1617_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_c1617_bin_name, Bin_c1617_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_c1617_bin_name)
rm(Bin_c1617_host_kruskal)
rm(Bin_c1617_season_kruskal)
rm(Bin_c1617_host_pvalue)
rm(Bin_c1617_season_pvalue)

Bin_c1638_bin_name <- "Bin_c1638"
Bin_c1638_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c1638", ])
Bin_c1638_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c1638", ])
Bin_c1638_host_pvalue <- Bin_c1638_host_kruskal$p.value
Bin_c1638_season_pvalue <- Bin_c1638_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_c1638_bin_name, Bin_c1638_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_c1638_bin_name, Bin_c1638_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_c1638_bin_name)
rm(Bin_c1638_host_kruskal)
rm(Bin_c1638_season_kruskal)
rm(Bin_c1638_host_pvalue)
rm(Bin_c1638_season_pvalue)

Bin_c1640_bin_name <- "Bin_c1640"
Bin_c1640_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c1640", ])
Bin_c1640_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c1640", ])
Bin_c1640_host_pvalue <- Bin_c1640_host_kruskal$p.value
Bin_c1640_season_pvalue <- Bin_c1640_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_c1640_bin_name, Bin_c1640_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_c1640_bin_name, Bin_c1640_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_c1640_bin_name)
rm(Bin_c1640_host_kruskal)
rm(Bin_c1640_season_kruskal)
rm(Bin_c1640_host_pvalue)
rm(Bin_c1640_season_pvalue)

Bin_c1673_bin_name <- "Bin_c1673"
Bin_c1673_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c1673", ])
Bin_c1673_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c1673", ])
Bin_c1673_host_pvalue <- Bin_c1673_host_kruskal$p.value
Bin_c1673_season_pvalue <- Bin_c1673_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_c1673_bin_name, Bin_c1673_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_c1673_bin_name, Bin_c1673_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_c1673_bin_name)
rm(Bin_c1673_host_kruskal)
rm(Bin_c1673_season_kruskal)
rm(Bin_c1673_host_pvalue)
rm(Bin_c1673_season_pvalue)

Bin_c1683_bin_name <- "Bin_c1683"
Bin_c1683_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c1683", ])
Bin_c1683_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c1683", ])
Bin_c1683_host_pvalue <- Bin_c1683_host_kruskal$p.value
Bin_c1683_season_pvalue <- Bin_c1683_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_c1683_bin_name, Bin_c1683_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_c1683_bin_name, Bin_c1683_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_c1683_bin_name)
rm(Bin_c1683_host_kruskal)
rm(Bin_c1683_season_kruskal)
rm(Bin_c1683_host_pvalue)
rm(Bin_c1683_season_pvalue)

Bin_c1686_bin_name <- "Bin_c1686"
Bin_c1686_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c1686", ])
Bin_c1686_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c1686", ])
Bin_c1686_host_pvalue <- Bin_c1686_host_kruskal$p.value
Bin_c1686_season_pvalue <- Bin_c1686_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_c1686_bin_name, Bin_c1686_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_c1686_bin_name, Bin_c1686_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_c1686_bin_name)
rm(Bin_c1686_host_kruskal)
rm(Bin_c1686_season_kruskal)
rm(Bin_c1686_host_pvalue)
rm(Bin_c1686_season_pvalue)

Bin_c1687_bin_name <- "Bin_c1687"
Bin_c1687_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c1687", ])
Bin_c1687_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c1687", ])
Bin_c1687_host_pvalue <- Bin_c1687_host_kruskal$p.value
Bin_c1687_season_pvalue <- Bin_c1687_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_c1687_bin_name, Bin_c1687_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_c1687_bin_name, Bin_c1687_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_c1687_bin_name)
rm(Bin_c1687_host_kruskal)
rm(Bin_c1687_season_kruskal)
rm(Bin_c1687_host_pvalue)
rm(Bin_c1687_season_pvalue)

Bin_c1693_bin_name <- "Bin_c1693"
Bin_c1693_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c1693", ])
Bin_c1693_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c1693", ])
Bin_c1693_host_pvalue <- Bin_c1693_host_kruskal$p.value
Bin_c1693_season_pvalue <- Bin_c1693_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_c1693_bin_name, Bin_c1693_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_c1693_bin_name, Bin_c1693_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_c1693_bin_name)
rm(Bin_c1693_host_kruskal)
rm(Bin_c1693_season_kruskal)
rm(Bin_c1693_host_pvalue)
rm(Bin_c1693_season_pvalue)

Bin_c1750_bin_name <- "Bin_c1750"
Bin_c1750_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c1750", ])
Bin_c1750_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_c1750", ])
Bin_c1750_host_pvalue <- Bin_c1750_host_kruskal$p.value
Bin_c1750_season_pvalue <- Bin_c1750_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_c1750_bin_name, Bin_c1750_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_c1750_bin_name, Bin_c1750_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_c1750_bin_name)
rm(Bin_c1750_host_kruskal)
rm(Bin_c1750_season_kruskal)
rm(Bin_c1750_host_pvalue)
rm(Bin_c1750_season_pvalue)

Bin_m7_bin_name <- "Bin_m7"
Bin_m7_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_m7", ])
Bin_m7_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_m7", ])
Bin_m7_host_pvalue <- Bin_m7_host_kruskal$p.value
Bin_m7_season_pvalue <- Bin_m7_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_m7_bin_name, Bin_m7_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_m7_bin_name, Bin_m7_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_m7_bin_name)
rm(Bin_m7_host_kruskal)
rm(Bin_m7_season_kruskal)
rm(Bin_m7_host_pvalue)
rm(Bin_m7_season_pvalue)

Bin_m14_bin_name <- "Bin_m14"
Bin_m14_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_m14", ])
Bin_m14_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_m14", ])
Bin_m14_host_pvalue <- Bin_m14_host_kruskal$p.value
Bin_m14_season_pvalue <- Bin_m14_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_m14_bin_name, Bin_m14_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_m14_bin_name, Bin_m14_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_m14_bin_name)
rm(Bin_m14_host_kruskal)
rm(Bin_m14_season_kruskal)
rm(Bin_m14_host_pvalue)
rm(Bin_m14_season_pvalue)

Bin_m21_bin_name <- "Bin_m21"
Bin_m21_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_m21", ])
Bin_m21_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_m21", ])
Bin_m21_host_pvalue <- Bin_m21_host_kruskal$p.value
Bin_m21_season_pvalue <- Bin_m21_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_m21_bin_name, Bin_m21_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_m21_bin_name, Bin_m21_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_m21_bin_name)
rm(Bin_m21_host_kruskal)
rm(Bin_m21_season_kruskal)
rm(Bin_m21_host_pvalue)
rm(Bin_m21_season_pvalue)

Bin_m28_bin_name <- "Bin_m28"
Bin_m28_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_m28", ])
Bin_m28_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_m28", ])
Bin_m28_host_pvalue <- Bin_m28_host_kruskal$p.value
Bin_m28_season_pvalue <- Bin_m28_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_m28_bin_name, Bin_m28_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_m28_bin_name, Bin_m28_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_m28_bin_name)
rm(Bin_m28_host_kruskal)
rm(Bin_m28_season_kruskal)
rm(Bin_m28_host_pvalue)
rm(Bin_m28_season_pvalue)

Bin_m49_bin_name <- "Bin_m49"
Bin_m49_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_m49", ])
Bin_m49_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_m49", ])
Bin_m49_host_pvalue <- Bin_m49_host_kruskal$p.value
Bin_m49_season_pvalue <- Bin_m49_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_m49_bin_name, Bin_m49_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_m49_bin_name, Bin_m49_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_m49_bin_name)
rm(Bin_m49_host_kruskal)
rm(Bin_m49_season_kruskal)
rm(Bin_m49_host_pvalue)
rm(Bin_m49_season_pvalue)

Bin_m89_bin_name <- "Bin_m89"
Bin_m89_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_m89", ])
Bin_m89_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_m89", ])
Bin_m89_host_pvalue <- Bin_m89_host_kruskal$p.value
Bin_m89_season_pvalue <- Bin_m89_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_m89_bin_name, Bin_m89_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_m89_bin_name, Bin_m89_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_m89_bin_name)
rm(Bin_m89_host_kruskal)
rm(Bin_m89_season_kruskal)
rm(Bin_m89_host_pvalue)
rm(Bin_m89_season_pvalue)

Bin_m127_bin_name <- "Bin_m127"
Bin_m127_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_m127", ])
Bin_m127_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_m127", ])
Bin_m127_host_pvalue <- Bin_m127_host_kruskal$p.value
Bin_m127_season_pvalue <- Bin_m127_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_m127_bin_name, Bin_m127_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_m127_bin_name, Bin_m127_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_m127_bin_name)
rm(Bin_m127_host_kruskal)
rm(Bin_m127_season_kruskal)
rm(Bin_m127_host_pvalue)
rm(Bin_m127_season_pvalue)

Bin_m137_bin_name <- "Bin_m137"
Bin_m137_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_m137", ])
Bin_m137_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_m137", ])
Bin_m137_host_pvalue <- Bin_m137_host_kruskal$p.value
Bin_m137_season_pvalue <- Bin_m137_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_m137_bin_name, Bin_m137_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_m137_bin_name, Bin_m137_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_m137_bin_name)
rm(Bin_m137_host_kruskal)
rm(Bin_m137_season_kruskal)
rm(Bin_m137_host_pvalue)
rm(Bin_m137_season_pvalue)

Bin_m142_bin_name <- "Bin_m142"
Bin_m142_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_m142", ])
Bin_m142_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_m142", ])
Bin_m142_host_pvalue <- Bin_m142_host_kruskal$p.value
Bin_m142_season_pvalue <- Bin_m142_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_m142_bin_name, Bin_m142_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_m142_bin_name, Bin_m142_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_m142_bin_name)
rm(Bin_m142_host_kruskal)
rm(Bin_m142_season_kruskal)
rm(Bin_m142_host_pvalue)
rm(Bin_m142_season_pvalue)

Bin_m158_bin_name <- "Bin_m158"
Bin_m158_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_m158", ])
Bin_m158_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_m158", ])
Bin_m158_host_pvalue <- Bin_m158_host_kruskal$p.value
Bin_m158_season_pvalue <- Bin_m158_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_m158_bin_name, Bin_m158_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_m158_bin_name, Bin_m158_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_m158_bin_name)
rm(Bin_m158_host_kruskal)
rm(Bin_m158_season_kruskal)
rm(Bin_m158_host_pvalue)
rm(Bin_m158_season_pvalue)

Bin_m216_bin_name <- "Bin_m216"
Bin_m216_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_m216", ])
Bin_m216_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_m216", ])
Bin_m216_host_pvalue <- Bin_m216_host_kruskal$p.value
Bin_m216_season_pvalue <- Bin_m216_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_m216_bin_name, Bin_m216_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_m216_bin_name, Bin_m216_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_m216_bin_name)
rm(Bin_m216_host_kruskal)
rm(Bin_m216_season_kruskal)
rm(Bin_m216_host_pvalue)
rm(Bin_m216_season_pvalue)

Bin_m228_bin_name <- "Bin_m228"
Bin_m228_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_m228", ])
Bin_m228_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_m228", ])
Bin_m228_host_pvalue <- Bin_m228_host_kruskal$p.value
Bin_m228_season_pvalue <- Bin_m228_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_m228_bin_name, Bin_m228_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_m228_bin_name, Bin_m228_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_m228_bin_name)
rm(Bin_m228_host_kruskal)
rm(Bin_m228_season_kruskal)
rm(Bin_m228_host_pvalue)
rm(Bin_m228_season_pvalue)

Bin_m273_bin_name <- "Bin_m273"
Bin_m273_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_m273", ])
Bin_m273_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_m273", ])
Bin_m273_host_pvalue <- Bin_m273_host_kruskal$p.value
Bin_m273_season_pvalue <- Bin_m273_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_m273_bin_name, Bin_m273_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_m273_bin_name, Bin_m273_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_m273_bin_name)
rm(Bin_m273_host_kruskal)
rm(Bin_m273_season_kruskal)
rm(Bin_m273_host_pvalue)
rm(Bin_m273_season_pvalue)

Bin_m293_bin_name <- "Bin_m293"
Bin_m293_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_m293", ])
Bin_m293_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_m293", ])
Bin_m293_host_pvalue <- Bin_m293_host_kruskal$p.value
Bin_m293_season_pvalue <- Bin_m293_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_m293_bin_name, Bin_m293_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_m293_bin_name, Bin_m293_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_m293_bin_name)
rm(Bin_m293_host_kruskal)
rm(Bin_m293_season_kruskal)
rm(Bin_m293_host_pvalue)
rm(Bin_m293_season_pvalue)

Bin_m334_bin_name <- "Bin_m334"
Bin_m334_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_m334", ])
Bin_m334_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_m334", ])
Bin_m334_host_pvalue <- Bin_m334_host_kruskal$p.value
Bin_m334_season_pvalue <- Bin_m334_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_m334_bin_name, Bin_m334_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_m334_bin_name, Bin_m334_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_m334_bin_name)
rm(Bin_m334_host_kruskal)
rm(Bin_m334_season_kruskal)
rm(Bin_m334_host_pvalue)
rm(Bin_m334_season_pvalue)

Bin_m419_bin_name <- "Bin_m419"
Bin_m419_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_m419", ])
Bin_m419_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_m419", ])
Bin_m419_host_pvalue <- Bin_m419_host_kruskal$p.value
Bin_m419_season_pvalue <- Bin_m419_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_m419_bin_name, Bin_m419_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_m419_bin_name, Bin_m419_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_m419_bin_name)
rm(Bin_m419_host_kruskal)
rm(Bin_m419_season_kruskal)
rm(Bin_m419_host_pvalue)
rm(Bin_m419_season_pvalue)

Bin_m454_bin_name <- "Bin_m454"
Bin_m454_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_m454", ])
Bin_m454_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_m454", ])
Bin_m454_host_pvalue <- Bin_m454_host_kruskal$p.value
Bin_m454_season_pvalue <- Bin_m454_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_m454_bin_name, Bin_m454_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_m454_bin_name, Bin_m454_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_m454_bin_name)
rm(Bin_m454_host_kruskal)
rm(Bin_m454_season_kruskal)
rm(Bin_m454_host_pvalue)
rm(Bin_m454_season_pvalue)

Bin_m494_bin_name <- "Bin_m494"
Bin_m494_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_m494", ])
Bin_m494_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_m494", ])
Bin_m494_host_pvalue <- Bin_m494_host_kruskal$p.value
Bin_m494_season_pvalue <- Bin_m494_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_m494_bin_name, Bin_m494_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_m494_bin_name, Bin_m494_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_m494_bin_name)
rm(Bin_m494_host_kruskal)
rm(Bin_m494_season_kruskal)
rm(Bin_m494_host_pvalue)
rm(Bin_m494_season_pvalue)

Bin_m498_bin_name <- "Bin_m498"
Bin_m498_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_m498", ])
Bin_m498_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_m498", ])
Bin_m498_host_pvalue <- Bin_m498_host_kruskal$p.value
Bin_m498_season_pvalue <- Bin_m498_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_m498_bin_name, Bin_m498_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_m498_bin_name, Bin_m498_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_m498_bin_name)
rm(Bin_m498_host_kruskal)
rm(Bin_m498_season_kruskal)
rm(Bin_m498_host_pvalue)
rm(Bin_m498_season_pvalue)

Bin_m522_bin_name <- "Bin_m522"
Bin_m522_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_m522", ])
Bin_m522_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_m522", ])
Bin_m522_host_pvalue <- Bin_m522_host_kruskal$p.value
Bin_m522_season_pvalue <- Bin_m522_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_m522_bin_name, Bin_m522_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_m522_bin_name, Bin_m522_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_m522_bin_name)
rm(Bin_m522_host_kruskal)
rm(Bin_m522_season_kruskal)
rm(Bin_m522_host_pvalue)
rm(Bin_m522_season_pvalue)

Bin_m527_bin_name <- "Bin_m527"
Bin_m527_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_m527", ])
Bin_m527_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_m527", ])
Bin_m527_host_pvalue <- Bin_m527_host_kruskal$p.value
Bin_m527_season_pvalue <- Bin_m527_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_m527_bin_name, Bin_m527_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_m527_bin_name, Bin_m527_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_m527_bin_name)
rm(Bin_m527_host_kruskal)
rm(Bin_m527_season_kruskal)
rm(Bin_m527_host_pvalue)
rm(Bin_m527_season_pvalue)

Bin_m530_bin_name <- "Bin_m530"
Bin_m530_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_m530", ])
Bin_m530_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_m530", ])
Bin_m530_host_pvalue <- Bin_m530_host_kruskal$p.value
Bin_m530_season_pvalue <- Bin_m530_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_m530_bin_name, Bin_m530_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_m530_bin_name, Bin_m530_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_m530_bin_name)
rm(Bin_m530_host_kruskal)
rm(Bin_m530_season_kruskal)
rm(Bin_m530_host_pvalue)
rm(Bin_m530_season_pvalue)

Bin_m544_bin_name <- "Bin_m544"
Bin_m544_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_m544", ])
Bin_m544_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_m544", ])
Bin_m544_host_pvalue <- Bin_m544_host_kruskal$p.value
Bin_m544_season_pvalue <- Bin_m544_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_m544_bin_name, Bin_m544_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_m544_bin_name, Bin_m544_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_m544_bin_name)
rm(Bin_m544_host_kruskal)
rm(Bin_m544_season_kruskal)
rm(Bin_m544_host_pvalue)
rm(Bin_m544_season_pvalue)

Bin_m569_bin_name <- "Bin_m569"
Bin_m569_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_m569", ])
Bin_m569_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_m569", ])
Bin_m569_host_pvalue <- Bin_m569_host_kruskal$p.value
Bin_m569_season_pvalue <- Bin_m569_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_m569_bin_name, Bin_m569_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_m569_bin_name, Bin_m569_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_m569_bin_name)
rm(Bin_m569_host_kruskal)
rm(Bin_m569_season_kruskal)
rm(Bin_m569_host_pvalue)
rm(Bin_m569_season_pvalue)

Bin_m583_bin_name <- "Bin_m583"
Bin_m583_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_m583", ])
Bin_m583_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_m583", ])
Bin_m583_host_pvalue <- Bin_m583_host_kruskal$p.value
Bin_m583_season_pvalue <- Bin_m583_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_m583_bin_name, Bin_m583_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_m583_bin_name, Bin_m583_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_m583_bin_name)
rm(Bin_m583_host_kruskal)
rm(Bin_m583_season_kruskal)
rm(Bin_m583_host_pvalue)
rm(Bin_m583_season_pvalue)

Bin_m584_bin_name <- "Bin_m584"
Bin_m584_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_m584", ])
Bin_m584_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_m584", ])
Bin_m584_host_pvalue <- Bin_m584_host_kruskal$p.value
Bin_m584_season_pvalue <- Bin_m584_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_m584_bin_name, Bin_m584_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_m584_bin_name, Bin_m584_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_m584_bin_name)
rm(Bin_m584_host_kruskal)
rm(Bin_m584_season_kruskal)
rm(Bin_m584_host_pvalue)
rm(Bin_m584_season_pvalue)

Bin_m586_bin_name <- "Bin_m586"
Bin_m586_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_m586", ])
Bin_m586_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_m586", ])
Bin_m586_host_pvalue <- Bin_m586_host_kruskal$p.value
Bin_m586_season_pvalue <- Bin_m586_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_m586_bin_name, Bin_m586_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_m586_bin_name, Bin_m586_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_m586_bin_name)
rm(Bin_m586_host_kruskal)
rm(Bin_m586_season_kruskal)
rm(Bin_m586_host_pvalue)
rm(Bin_m586_season_pvalue)

Bin_m595_bin_name <- "Bin_m595"
Bin_m595_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_m595", ])
Bin_m595_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_m595", ])
Bin_m595_host_pvalue <- Bin_m595_host_kruskal$p.value
Bin_m595_season_pvalue <- Bin_m595_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_m595_bin_name, Bin_m595_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_m595_bin_name, Bin_m595_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_m595_bin_name)
rm(Bin_m595_host_kruskal)
rm(Bin_m595_season_kruskal)
rm(Bin_m595_host_pvalue)
rm(Bin_m595_season_pvalue)

Bin_m621_bin_name <- "Bin_m621"
Bin_m621_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_m621", ])
Bin_m621_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_m621", ])
Bin_m621_host_pvalue <- Bin_m621_host_kruskal$p.value
Bin_m621_season_pvalue <- Bin_m621_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_m621_bin_name, Bin_m621_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_m621_bin_name, Bin_m621_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_m621_bin_name)
rm(Bin_m621_host_kruskal)
rm(Bin_m621_season_kruskal)
rm(Bin_m621_host_pvalue)
rm(Bin_m621_season_pvalue)

Bin_m638_bin_name <- "Bin_m638"
Bin_m638_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_m638", ])
Bin_m638_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_m638", ])
Bin_m638_host_pvalue <- Bin_m638_host_kruskal$p.value
Bin_m638_season_pvalue <- Bin_m638_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_m638_bin_name, Bin_m638_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_m638_bin_name, Bin_m638_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_m638_bin_name)
rm(Bin_m638_host_kruskal)
rm(Bin_m638_season_kruskal)
rm(Bin_m638_host_pvalue)
rm(Bin_m638_season_pvalue)

Bin_m691_bin_name <- "Bin_m691"
Bin_m691_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_m691", ])
Bin_m691_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_m691", ])
Bin_m691_host_pvalue <- Bin_m691_host_kruskal$p.value
Bin_m691_season_pvalue <- Bin_m691_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_m691_bin_name, Bin_m691_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_m691_bin_name, Bin_m691_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_m691_bin_name)
rm(Bin_m691_host_kruskal)
rm(Bin_m691_season_kruskal)
rm(Bin_m691_host_pvalue)
rm(Bin_m691_season_pvalue)

Bin_m708_bin_name <- "Bin_m708"
Bin_m708_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_m708", ])
Bin_m708_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_m708", ])
Bin_m708_host_pvalue <- Bin_m708_host_kruskal$p.value
Bin_m708_season_pvalue <- Bin_m708_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_m708_bin_name, Bin_m708_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_m708_bin_name, Bin_m708_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_m708_bin_name)
rm(Bin_m708_host_kruskal)
rm(Bin_m708_season_kruskal)
rm(Bin_m708_host_pvalue)
rm(Bin_m708_season_pvalue)

Bin_m725_bin_name <- "Bin_m725"
Bin_m725_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_m725", ])
Bin_m725_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_m725", ])
Bin_m725_host_pvalue <- Bin_m725_host_kruskal$p.value
Bin_m725_season_pvalue <- Bin_m725_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_m725_bin_name, Bin_m725_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_m725_bin_name, Bin_m725_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_m725_bin_name)
rm(Bin_m725_host_kruskal)
rm(Bin_m725_season_kruskal)
rm(Bin_m725_host_pvalue)
rm(Bin_m725_season_pvalue)

Bin_m731_bin_name <- "Bin_m731"
Bin_m731_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_m731", ])
Bin_m731_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_m731", ])
Bin_m731_host_pvalue <- Bin_m731_host_kruskal$p.value
Bin_m731_season_pvalue <- Bin_m731_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_m731_bin_name, Bin_m731_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_m731_bin_name, Bin_m731_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_m731_bin_name)
rm(Bin_m731_host_kruskal)
rm(Bin_m731_season_kruskal)
rm(Bin_m731_host_pvalue)
rm(Bin_m731_season_pvalue)

Bin_m737_bin_name <- "Bin_m737"
Bin_m737_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_m737", ])
Bin_m737_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_m737", ])
Bin_m737_host_pvalue <- Bin_m737_host_kruskal$p.value
Bin_m737_season_pvalue <- Bin_m737_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_m737_bin_name, Bin_m737_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_m737_bin_name, Bin_m737_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_m737_bin_name)
rm(Bin_m737_host_kruskal)
rm(Bin_m737_season_kruskal)
rm(Bin_m737_host_pvalue)
rm(Bin_m737_season_pvalue)

Bin_m748_bin_name <- "Bin_m748"
Bin_m748_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_m748", ])
Bin_m748_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_m748", ])
Bin_m748_host_pvalue <- Bin_m748_host_kruskal$p.value
Bin_m748_season_pvalue <- Bin_m748_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_m748_bin_name, Bin_m748_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_m748_bin_name, Bin_m748_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_m748_bin_name)
rm(Bin_m748_host_kruskal)
rm(Bin_m748_season_kruskal)
rm(Bin_m748_host_pvalue)
rm(Bin_m748_season_pvalue)

Bin_m761_bin_name <- "Bin_m761"
Bin_m761_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_m761", ])
Bin_m761_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_m761", ])
Bin_m761_host_pvalue <- Bin_m761_host_kruskal$p.value
Bin_m761_season_pvalue <- Bin_m761_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_m761_bin_name, Bin_m761_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_m761_bin_name, Bin_m761_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_m761_bin_name)
rm(Bin_m761_host_kruskal)
rm(Bin_m761_season_kruskal)
rm(Bin_m761_host_pvalue)
rm(Bin_m761_season_pvalue)

Bin_m766_bin_name <- "Bin_m766"
Bin_m766_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_m766", ])
Bin_m766_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_m766", ])
Bin_m766_host_pvalue <- Bin_m766_host_kruskal$p.value
Bin_m766_season_pvalue <- Bin_m766_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_m766_bin_name, Bin_m766_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_m766_bin_name, Bin_m766_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_m766_bin_name)
rm(Bin_m766_host_kruskal)
rm(Bin_m766_season_kruskal)
rm(Bin_m766_host_pvalue)
rm(Bin_m766_season_pvalue)

Bin_m780_bin_name <- "Bin_m780"
Bin_m780_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_m780", ])
Bin_m780_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_m780", ])
Bin_m780_host_pvalue <- Bin_m780_host_kruskal$p.value
Bin_m780_season_pvalue <- Bin_m780_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_m780_bin_name, Bin_m780_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_m780_bin_name, Bin_m780_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_m780_bin_name)
rm(Bin_m780_host_kruskal)
rm(Bin_m780_season_kruskal)
rm(Bin_m780_host_pvalue)
rm(Bin_m780_season_pvalue)

Bin_m798_bin_name <- "Bin_m798"
Bin_m798_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_m798", ])
Bin_m798_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_m798", ])
Bin_m798_host_pvalue <- Bin_m798_host_kruskal$p.value
Bin_m798_season_pvalue <- Bin_m798_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_m798_bin_name, Bin_m798_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_m798_bin_name, Bin_m798_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_m798_bin_name)
rm(Bin_m798_host_kruskal)
rm(Bin_m798_season_kruskal)
rm(Bin_m798_host_pvalue)
rm(Bin_m798_season_pvalue)

Bin_m811_bin_name <- "Bin_m811"
Bin_m811_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_m811", ])
Bin_m811_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_m811", ])
Bin_m811_host_pvalue <- Bin_m811_host_kruskal$p.value
Bin_m811_season_pvalue <- Bin_m811_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_m811_bin_name, Bin_m811_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_m811_bin_name, Bin_m811_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_m811_bin_name)
rm(Bin_m811_host_kruskal)
rm(Bin_m811_season_kruskal)
rm(Bin_m811_host_pvalue)
rm(Bin_m811_season_pvalue)

Bin_m851_bin_name <- "Bin_m851"
Bin_m851_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_m851", ])
Bin_m851_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_m851", ])
Bin_m851_host_pvalue <- Bin_m851_host_kruskal$p.value
Bin_m851_season_pvalue <- Bin_m851_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_m851_bin_name, Bin_m851_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_m851_bin_name, Bin_m851_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_m851_bin_name)
rm(Bin_m851_host_kruskal)
rm(Bin_m851_season_kruskal)
rm(Bin_m851_host_pvalue)
rm(Bin_m851_season_pvalue)

Bin_m870_bin_name <- "Bin_m870"
Bin_m870_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_m870", ])
Bin_m870_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_m870", ])
Bin_m870_host_pvalue <- Bin_m870_host_kruskal$p.value
Bin_m870_season_pvalue <- Bin_m870_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_m870_bin_name, Bin_m870_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_m870_bin_name, Bin_m870_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_m870_bin_name)
rm(Bin_m870_host_kruskal)
rm(Bin_m870_season_kruskal)
rm(Bin_m870_host_pvalue)
rm(Bin_m870_season_pvalue)

Bin_m881_bin_name <- "Bin_m881"
Bin_m881_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_m881", ])
Bin_m881_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_m881", ])
Bin_m881_host_pvalue <- Bin_m881_host_kruskal$p.value
Bin_m881_season_pvalue <- Bin_m881_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_m881_bin_name, Bin_m881_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_m881_bin_name, Bin_m881_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_m881_bin_name)
rm(Bin_m881_host_kruskal)
rm(Bin_m881_season_kruskal)
rm(Bin_m881_host_pvalue)
rm(Bin_m881_season_pvalue)

Bin_m920_bin_name <- "Bin_m920"
Bin_m920_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_m920", ])
Bin_m920_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_m920", ])
Bin_m920_host_pvalue <- Bin_m920_host_kruskal$p.value
Bin_m920_season_pvalue <- Bin_m920_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_m920_bin_name, Bin_m920_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_m920_bin_name, Bin_m920_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_m920_bin_name)
rm(Bin_m920_host_kruskal)
rm(Bin_m920_season_kruskal)
rm(Bin_m920_host_pvalue)
rm(Bin_m920_season_pvalue)

Bin_m935_bin_name <- "Bin_m935"
Bin_m935_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_m935", ])
Bin_m935_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_m935", ])
Bin_m935_host_pvalue <- Bin_m935_host_kruskal$p.value
Bin_m935_season_pvalue <- Bin_m935_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_m935_bin_name, Bin_m935_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_m935_bin_name, Bin_m935_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_m935_bin_name)
rm(Bin_m935_host_kruskal)
rm(Bin_m935_season_kruskal)
rm(Bin_m935_host_pvalue)
rm(Bin_m935_season_pvalue)

Bin_m936_bin_name <- "Bin_m936"
Bin_m936_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_m936", ])
Bin_m936_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_m936", ])
Bin_m936_host_pvalue <- Bin_m936_host_kruskal$p.value
Bin_m936_season_pvalue <- Bin_m936_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_m936_bin_name, Bin_m936_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_m936_bin_name, Bin_m936_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_m936_bin_name)
rm(Bin_m936_host_kruskal)
rm(Bin_m936_season_kruskal)
rm(Bin_m936_host_pvalue)
rm(Bin_m936_season_pvalue)

Bin_m957_bin_name <- "Bin_m957"
Bin_m957_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_m957", ])
Bin_m957_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_m957", ])
Bin_m957_host_pvalue <- Bin_m957_host_kruskal$p.value
Bin_m957_season_pvalue <- Bin_m957_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_m957_bin_name, Bin_m957_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_m957_bin_name, Bin_m957_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_m957_bin_name)
rm(Bin_m957_host_kruskal)
rm(Bin_m957_season_kruskal)
rm(Bin_m957_host_pvalue)
rm(Bin_m957_season_pvalue)

Bin_m959_bin_name <- "Bin_m959"
Bin_m959_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_m959", ])
Bin_m959_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_m959", ])
Bin_m959_host_pvalue <- Bin_m959_host_kruskal$p.value
Bin_m959_season_pvalue <- Bin_m959_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_m959_bin_name, Bin_m959_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_m959_bin_name, Bin_m959_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_m959_bin_name)
rm(Bin_m959_host_kruskal)
rm(Bin_m959_season_kruskal)
rm(Bin_m959_host_pvalue)
rm(Bin_m959_season_pvalue)

Bin_m965_bin_name <- "Bin_m965"
Bin_m965_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_m965", ])
Bin_m965_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_m965", ])
Bin_m965_host_pvalue <- Bin_m965_host_kruskal$p.value
Bin_m965_season_pvalue <- Bin_m965_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_m965_bin_name, Bin_m965_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_m965_bin_name, Bin_m965_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_m965_bin_name)
rm(Bin_m965_host_kruskal)
rm(Bin_m965_season_kruskal)
rm(Bin_m965_host_pvalue)
rm(Bin_m965_season_pvalue)

Bin_m980_bin_name <- "Bin_m980"
Bin_m980_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_m980", ])
Bin_m980_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_m980", ])
Bin_m980_host_pvalue <- Bin_m980_host_kruskal$p.value
Bin_m980_season_pvalue <- Bin_m980_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_m980_bin_name, Bin_m980_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_m980_bin_name, Bin_m980_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_m980_bin_name)
rm(Bin_m980_host_kruskal)
rm(Bin_m980_season_kruskal)
rm(Bin_m980_host_pvalue)
rm(Bin_m980_season_pvalue)

Bin_m994_bin_name <- "Bin_m994"
Bin_m994_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_m994", ])
Bin_m994_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_m994", ])
Bin_m994_host_pvalue <- Bin_m994_host_kruskal$p.value
Bin_m994_season_pvalue <- Bin_m994_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_m994_bin_name, Bin_m994_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_m994_bin_name, Bin_m994_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_m994_bin_name)
rm(Bin_m994_host_kruskal)
rm(Bin_m994_season_kruskal)
rm(Bin_m994_host_pvalue)
rm(Bin_m994_season_pvalue)

Bin_m1009_bin_name <- "Bin_m1009"
Bin_m1009_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_m1009", ])
Bin_m1009_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_m1009", ])
Bin_m1009_host_pvalue <- Bin_m1009_host_kruskal$p.value
Bin_m1009_season_pvalue <- Bin_m1009_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_m1009_bin_name, Bin_m1009_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_m1009_bin_name, Bin_m1009_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_m1009_bin_name)
rm(Bin_m1009_host_kruskal)
rm(Bin_m1009_season_kruskal)
rm(Bin_m1009_host_pvalue)
rm(Bin_m1009_season_pvalue)

Bin_m1040_bin_name <- "Bin_m1040"
Bin_m1040_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_m1040", ])
Bin_m1040_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_m1040", ])
Bin_m1040_host_pvalue <- Bin_m1040_host_kruskal$p.value
Bin_m1040_season_pvalue <- Bin_m1040_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_m1040_bin_name, Bin_m1040_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_m1040_bin_name, Bin_m1040_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_m1040_bin_name)
rm(Bin_m1040_host_kruskal)
rm(Bin_m1040_season_kruskal)
rm(Bin_m1040_host_pvalue)
rm(Bin_m1040_season_pvalue)

Bin_m1062_bin_name <- "Bin_m1062"
Bin_m1062_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_m1062", ])
Bin_m1062_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_m1062", ])
Bin_m1062_host_pvalue <- Bin_m1062_host_kruskal$p.value
Bin_m1062_season_pvalue <- Bin_m1062_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_m1062_bin_name, Bin_m1062_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_m1062_bin_name, Bin_m1062_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_m1062_bin_name)
rm(Bin_m1062_host_kruskal)
rm(Bin_m1062_season_kruskal)
rm(Bin_m1062_host_pvalue)
rm(Bin_m1062_season_pvalue)

Bin_m1066_bin_name <- "Bin_m1066"
Bin_m1066_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_m1066", ])
Bin_m1066_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_m1066", ])
Bin_m1066_host_pvalue <- Bin_m1066_host_kruskal$p.value
Bin_m1066_season_pvalue <- Bin_m1066_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_m1066_bin_name, Bin_m1066_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_m1066_bin_name, Bin_m1066_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_m1066_bin_name)
rm(Bin_m1066_host_kruskal)
rm(Bin_m1066_season_kruskal)
rm(Bin_m1066_host_pvalue)
rm(Bin_m1066_season_pvalue)

Bin_m1075_bin_name <- "Bin_m1075"
Bin_m1075_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_m1075", ])
Bin_m1075_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_m1075", ])
Bin_m1075_host_pvalue <- Bin_m1075_host_kruskal$p.value
Bin_m1075_season_pvalue <- Bin_m1075_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_m1075_bin_name, Bin_m1075_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_m1075_bin_name, Bin_m1075_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_m1075_bin_name)
rm(Bin_m1075_host_kruskal)
rm(Bin_m1075_season_kruskal)
rm(Bin_m1075_host_pvalue)
rm(Bin_m1075_season_pvalue)

Bin_m1093_bin_name <- "Bin_m1093"
Bin_m1093_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_m1093", ])
Bin_m1093_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_m1093", ])
Bin_m1093_host_pvalue <- Bin_m1093_host_kruskal$p.value
Bin_m1093_season_pvalue <- Bin_m1093_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_m1093_bin_name, Bin_m1093_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_m1093_bin_name, Bin_m1093_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_m1093_bin_name)
rm(Bin_m1093_host_kruskal)
rm(Bin_m1093_season_kruskal)
rm(Bin_m1093_host_pvalue)
rm(Bin_m1093_season_pvalue)

Bin_m1099_bin_name <- "Bin_m1099"
Bin_m1099_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_m1099", ])
Bin_m1099_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_m1099", ])
Bin_m1099_host_pvalue <- Bin_m1099_host_kruskal$p.value
Bin_m1099_season_pvalue <- Bin_m1099_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_m1099_bin_name, Bin_m1099_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_m1099_bin_name, Bin_m1099_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_m1099_bin_name)
rm(Bin_m1099_host_kruskal)
rm(Bin_m1099_season_kruskal)
rm(Bin_m1099_host_pvalue)
rm(Bin_m1099_season_pvalue)

Bin_m1122_bin_name <- "Bin_m1122"
Bin_m1122_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_m1122", ])
Bin_m1122_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_m1122", ])
Bin_m1122_host_pvalue <- Bin_m1122_host_kruskal$p.value
Bin_m1122_season_pvalue <- Bin_m1122_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_m1122_bin_name, Bin_m1122_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_m1122_bin_name, Bin_m1122_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_m1122_bin_name)
rm(Bin_m1122_host_kruskal)
rm(Bin_m1122_season_kruskal)
rm(Bin_m1122_host_pvalue)
rm(Bin_m1122_season_pvalue)

Bin_m1133_bin_name <- "Bin_m1133"
Bin_m1133_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_m1133", ])
Bin_m1133_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_m1133", ])
Bin_m1133_host_pvalue <- Bin_m1133_host_kruskal$p.value
Bin_m1133_season_pvalue <- Bin_m1133_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_m1133_bin_name, Bin_m1133_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_m1133_bin_name, Bin_m1133_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_m1133_bin_name)
rm(Bin_m1133_host_kruskal)
rm(Bin_m1133_season_kruskal)
rm(Bin_m1133_host_pvalue)
rm(Bin_m1133_season_pvalue)

Bin_m1135_bin_name <- "Bin_m1135"
Bin_m1135_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_m1135", ])
Bin_m1135_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_m1135", ])
Bin_m1135_host_pvalue <- Bin_m1135_host_kruskal$p.value
Bin_m1135_season_pvalue <- Bin_m1135_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_m1135_bin_name, Bin_m1135_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_m1135_bin_name, Bin_m1135_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_m1135_bin_name)
rm(Bin_m1135_host_kruskal)
rm(Bin_m1135_season_kruskal)
rm(Bin_m1135_host_pvalue)
rm(Bin_m1135_season_pvalue)

Bin_m1167_bin_name <- "Bin_m1167"
Bin_m1167_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_m1167", ])
Bin_m1167_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_m1167", ])
Bin_m1167_host_pvalue <- Bin_m1167_host_kruskal$p.value
Bin_m1167_season_pvalue <- Bin_m1167_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_m1167_bin_name, Bin_m1167_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_m1167_bin_name, Bin_m1167_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_m1167_bin_name)
rm(Bin_m1167_host_kruskal)
rm(Bin_m1167_season_kruskal)
rm(Bin_m1167_host_pvalue)
rm(Bin_m1167_season_pvalue)

Bin_m1179_bin_name <- "Bin_m1179"
Bin_m1179_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_m1179", ])
Bin_m1179_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_m1179", ])
Bin_m1179_host_pvalue <- Bin_m1179_host_kruskal$p.value
Bin_m1179_season_pvalue <- Bin_m1179_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_m1179_bin_name, Bin_m1179_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_m1179_bin_name, Bin_m1179_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_m1179_bin_name)
rm(Bin_m1179_host_kruskal)
rm(Bin_m1179_season_kruskal)
rm(Bin_m1179_host_pvalue)
rm(Bin_m1179_season_pvalue)

Bin_m1197_bin_name <- "Bin_m1197"
Bin_m1197_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_m1197", ])
Bin_m1197_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_m1197", ])
Bin_m1197_host_pvalue <- Bin_m1197_host_kruskal$p.value
Bin_m1197_season_pvalue <- Bin_m1197_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_m1197_bin_name, Bin_m1197_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_m1197_bin_name, Bin_m1197_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_m1197_bin_name)
rm(Bin_m1197_host_kruskal)
rm(Bin_m1197_season_kruskal)
rm(Bin_m1197_host_pvalue)
rm(Bin_m1197_season_pvalue)

Bin_m1202_bin_name <- "Bin_m1202"
Bin_m1202_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_m1202", ])
Bin_m1202_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_m1202", ])
Bin_m1202_host_pvalue <- Bin_m1202_host_kruskal$p.value
Bin_m1202_season_pvalue <- Bin_m1202_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_m1202_bin_name, Bin_m1202_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_m1202_bin_name, Bin_m1202_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_m1202_bin_name)
rm(Bin_m1202_host_kruskal)
rm(Bin_m1202_season_kruskal)
rm(Bin_m1202_host_pvalue)
rm(Bin_m1202_season_pvalue)

Bin_m1215_bin_name <- "Bin_m1215"
Bin_m1215_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_m1215", ])
Bin_m1215_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_m1215", ])
Bin_m1215_host_pvalue <- Bin_m1215_host_kruskal$p.value
Bin_m1215_season_pvalue <- Bin_m1215_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_m1215_bin_name, Bin_m1215_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_m1215_bin_name, Bin_m1215_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_m1215_bin_name)
rm(Bin_m1215_host_kruskal)
rm(Bin_m1215_season_kruskal)
rm(Bin_m1215_host_pvalue)
rm(Bin_m1215_season_pvalue)

Bin_m1226_bin_name <- "Bin_m1226"
Bin_m1226_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_m1226", ])
Bin_m1226_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_m1226", ])
Bin_m1226_host_pvalue <- Bin_m1226_host_kruskal$p.value
Bin_m1226_season_pvalue <- Bin_m1226_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_m1226_bin_name, Bin_m1226_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_m1226_bin_name, Bin_m1226_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_m1226_bin_name)
rm(Bin_m1226_host_kruskal)
rm(Bin_m1226_season_kruskal)
rm(Bin_m1226_host_pvalue)
rm(Bin_m1226_season_pvalue)

Bin_m1246_bin_name <- "Bin_m1246"
Bin_m1246_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_m1246", ])
Bin_m1246_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_m1246", ])
Bin_m1246_host_pvalue <- Bin_m1246_host_kruskal$p.value
Bin_m1246_season_pvalue <- Bin_m1246_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_m1246_bin_name, Bin_m1246_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_m1246_bin_name, Bin_m1246_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_m1246_bin_name)
rm(Bin_m1246_host_kruskal)
rm(Bin_m1246_season_kruskal)
rm(Bin_m1246_host_pvalue)
rm(Bin_m1246_season_pvalue)

Bin_m1252_bin_name <- "Bin_m1252"
Bin_m1252_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_m1252", ])
Bin_m1252_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_m1252", ])
Bin_m1252_host_pvalue <- Bin_m1252_host_kruskal$p.value
Bin_m1252_season_pvalue <- Bin_m1252_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_m1252_bin_name, Bin_m1252_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_m1252_bin_name, Bin_m1252_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_m1252_bin_name)
rm(Bin_m1252_host_kruskal)
rm(Bin_m1252_season_kruskal)
rm(Bin_m1252_host_pvalue)
rm(Bin_m1252_season_pvalue)

Bin_m1254_bin_name <- "Bin_m1254"
Bin_m1254_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_m1254", ])
Bin_m1254_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_m1254", ])
Bin_m1254_host_pvalue <- Bin_m1254_host_kruskal$p.value
Bin_m1254_season_pvalue <- Bin_m1254_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_m1254_bin_name, Bin_m1254_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_m1254_bin_name, Bin_m1254_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_m1254_bin_name)
rm(Bin_m1254_host_kruskal)
rm(Bin_m1254_season_kruskal)
rm(Bin_m1254_host_pvalue)
rm(Bin_m1254_season_pvalue)

Bin_m1265_bin_name <- "Bin_m1265"
Bin_m1265_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_m1265", ])
Bin_m1265_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_m1265", ])
Bin_m1265_host_pvalue <- Bin_m1265_host_kruskal$p.value
Bin_m1265_season_pvalue <- Bin_m1265_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_m1265_bin_name, Bin_m1265_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_m1265_bin_name, Bin_m1265_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_m1265_bin_name)
rm(Bin_m1265_host_kruskal)
rm(Bin_m1265_season_kruskal)
rm(Bin_m1265_host_pvalue)
rm(Bin_m1265_season_pvalue)

Bin_m1269_bin_name <- "Bin_m1269"
Bin_m1269_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_m1269", ])
Bin_m1269_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_m1269", ])
Bin_m1269_host_pvalue <- Bin_m1269_host_kruskal$p.value
Bin_m1269_season_pvalue <- Bin_m1269_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_m1269_bin_name, Bin_m1269_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_m1269_bin_name, Bin_m1269_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_m1269_bin_name)
rm(Bin_m1269_host_kruskal)
rm(Bin_m1269_season_kruskal)
rm(Bin_m1269_host_pvalue)
rm(Bin_m1269_season_pvalue)

Bin_m1275_bin_name <- "Bin_m1275"
Bin_m1275_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_m1275", ])
Bin_m1275_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_m1275", ])
Bin_m1275_host_pvalue <- Bin_m1275_host_kruskal$p.value
Bin_m1275_season_pvalue <- Bin_m1275_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_m1275_bin_name, Bin_m1275_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_m1275_bin_name, Bin_m1275_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_m1275_bin_name)
rm(Bin_m1275_host_kruskal)
rm(Bin_m1275_season_kruskal)
rm(Bin_m1275_host_pvalue)
rm(Bin_m1275_season_pvalue)

Bin_m1301_bin_name <- "Bin_m1301"
Bin_m1301_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_m1301", ])
Bin_m1301_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_m1301", ])
Bin_m1301_host_pvalue <- Bin_m1301_host_kruskal$p.value
Bin_m1301_season_pvalue <- Bin_m1301_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_m1301_bin_name, Bin_m1301_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_m1301_bin_name, Bin_m1301_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_m1301_bin_name)
rm(Bin_m1301_host_kruskal)
rm(Bin_m1301_season_kruskal)
rm(Bin_m1301_host_pvalue)
rm(Bin_m1301_season_pvalue)

Bin_m1352_bin_name <- "Bin_m1352"
Bin_m1352_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_m1352", ])
Bin_m1352_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_m1352", ])
Bin_m1352_host_pvalue <- Bin_m1352_host_kruskal$p.value
Bin_m1352_season_pvalue <- Bin_m1352_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_m1352_bin_name, Bin_m1352_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_m1352_bin_name, Bin_m1352_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_m1352_bin_name)
rm(Bin_m1352_host_kruskal)
rm(Bin_m1352_season_kruskal)
rm(Bin_m1352_host_pvalue)
rm(Bin_m1352_season_pvalue)

Bin_m1367_bin_name <- "Bin_m1367"
Bin_m1367_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_m1367", ])
Bin_m1367_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_m1367", ])
Bin_m1367_host_pvalue <- Bin_m1367_host_kruskal$p.value
Bin_m1367_season_pvalue <- Bin_m1367_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_m1367_bin_name, Bin_m1367_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_m1367_bin_name, Bin_m1367_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_m1367_bin_name)
rm(Bin_m1367_host_kruskal)
rm(Bin_m1367_season_kruskal)
rm(Bin_m1367_host_pvalue)
rm(Bin_m1367_season_pvalue)

Bin_m1413_bin_name <- "Bin_m1413"
Bin_m1413_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_m1413", ])
Bin_m1413_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_m1413", ])
Bin_m1413_host_pvalue <- Bin_m1413_host_kruskal$p.value
Bin_m1413_season_pvalue <- Bin_m1413_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_m1413_bin_name, Bin_m1413_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_m1413_bin_name, Bin_m1413_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_m1413_bin_name)
rm(Bin_m1413_host_kruskal)
rm(Bin_m1413_season_kruskal)
rm(Bin_m1413_host_pvalue)
rm(Bin_m1413_season_pvalue)

Bin_m1424_bin_name <- "Bin_m1424"
Bin_m1424_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_m1424", ])
Bin_m1424_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_m1424", ])
Bin_m1424_host_pvalue <- Bin_m1424_host_kruskal$p.value
Bin_m1424_season_pvalue <- Bin_m1424_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_m1424_bin_name, Bin_m1424_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_m1424_bin_name, Bin_m1424_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_m1424_bin_name)
rm(Bin_m1424_host_kruskal)
rm(Bin_m1424_season_kruskal)
rm(Bin_m1424_host_pvalue)
rm(Bin_m1424_season_pvalue)

Bin_m1425_bin_name <- "Bin_m1425"
Bin_m1425_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_m1425", ])
Bin_m1425_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_m1425", ])
Bin_m1425_host_pvalue <- Bin_m1425_host_kruskal$p.value
Bin_m1425_season_pvalue <- Bin_m1425_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_m1425_bin_name, Bin_m1425_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_m1425_bin_name, Bin_m1425_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_m1425_bin_name)
rm(Bin_m1425_host_kruskal)
rm(Bin_m1425_season_kruskal)
rm(Bin_m1425_host_pvalue)
rm(Bin_m1425_season_pvalue)

Bin_m1432_bin_name <- "Bin_m1432"
Bin_m1432_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_m1432", ])
Bin_m1432_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_m1432", ])
Bin_m1432_host_pvalue <- Bin_m1432_host_kruskal$p.value
Bin_m1432_season_pvalue <- Bin_m1432_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_m1432_bin_name, Bin_m1432_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_m1432_bin_name, Bin_m1432_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_m1432_bin_name)
rm(Bin_m1432_host_kruskal)
rm(Bin_m1432_season_kruskal)
rm(Bin_m1432_host_pvalue)
rm(Bin_m1432_season_pvalue)

Bin_m1448_bin_name <- "Bin_m1448"
Bin_m1448_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_m1448", ])
Bin_m1448_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_m1448", ])
Bin_m1448_host_pvalue <- Bin_m1448_host_kruskal$p.value
Bin_m1448_season_pvalue <- Bin_m1448_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_m1448_bin_name, Bin_m1448_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_m1448_bin_name, Bin_m1448_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_m1448_bin_name)
rm(Bin_m1448_host_kruskal)
rm(Bin_m1448_season_kruskal)
rm(Bin_m1448_host_pvalue)
rm(Bin_m1448_season_pvalue)

Bin_m1454_bin_name <- "Bin_m1454"
Bin_m1454_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_m1454", ])
Bin_m1454_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_m1454", ])
Bin_m1454_host_pvalue <- Bin_m1454_host_kruskal$p.value
Bin_m1454_season_pvalue <- Bin_m1454_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_m1454_bin_name, Bin_m1454_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_m1454_bin_name, Bin_m1454_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_m1454_bin_name)
rm(Bin_m1454_host_kruskal)
rm(Bin_m1454_season_kruskal)
rm(Bin_m1454_host_pvalue)
rm(Bin_m1454_season_pvalue)

Bin_m1461_bin_name <- "Bin_m1461"
Bin_m1461_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_m1461", ])
Bin_m1461_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_m1461", ])
Bin_m1461_host_pvalue <- Bin_m1461_host_kruskal$p.value
Bin_m1461_season_pvalue <- Bin_m1461_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_m1461_bin_name, Bin_m1461_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_m1461_bin_name, Bin_m1461_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_m1461_bin_name)
rm(Bin_m1461_host_kruskal)
rm(Bin_m1461_season_kruskal)
rm(Bin_m1461_host_pvalue)
rm(Bin_m1461_season_pvalue)

Bin_m1474_bin_name <- "Bin_m1474"
Bin_m1474_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_m1474", ])
Bin_m1474_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_m1474", ])
Bin_m1474_host_pvalue <- Bin_m1474_host_kruskal$p.value
Bin_m1474_season_pvalue <- Bin_m1474_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_m1474_bin_name, Bin_m1474_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_m1474_bin_name, Bin_m1474_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_m1474_bin_name)
rm(Bin_m1474_host_kruskal)
rm(Bin_m1474_season_kruskal)
rm(Bin_m1474_host_pvalue)
rm(Bin_m1474_season_pvalue)

Bin_m1477_bin_name <- "Bin_m1477"
Bin_m1477_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_m1477", ])
Bin_m1477_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_m1477", ])
Bin_m1477_host_pvalue <- Bin_m1477_host_kruskal$p.value
Bin_m1477_season_pvalue <- Bin_m1477_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_m1477_bin_name, Bin_m1477_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_m1477_bin_name, Bin_m1477_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_m1477_bin_name)
rm(Bin_m1477_host_kruskal)
rm(Bin_m1477_season_kruskal)
rm(Bin_m1477_host_pvalue)
rm(Bin_m1477_season_pvalue)

Bin_m1485_bin_name <- "Bin_m1485"
Bin_m1485_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_m1485", ])
Bin_m1485_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_m1485", ])
Bin_m1485_host_pvalue <- Bin_m1485_host_kruskal$p.value
Bin_m1485_season_pvalue <- Bin_m1485_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_m1485_bin_name, Bin_m1485_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_m1485_bin_name, Bin_m1485_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_m1485_bin_name)
rm(Bin_m1485_host_kruskal)
rm(Bin_m1485_season_kruskal)
rm(Bin_m1485_host_pvalue)
rm(Bin_m1485_season_pvalue)

Bin_m1500_bin_name <- "Bin_m1500"
Bin_m1500_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_m1500", ])
Bin_m1500_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_m1500", ])
Bin_m1500_host_pvalue <- Bin_m1500_host_kruskal$p.value
Bin_m1500_season_pvalue <- Bin_m1500_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_m1500_bin_name, Bin_m1500_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_m1500_bin_name, Bin_m1500_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_m1500_bin_name)
rm(Bin_m1500_host_kruskal)
rm(Bin_m1500_season_kruskal)
rm(Bin_m1500_host_pvalue)
rm(Bin_m1500_season_pvalue)

Bin_m1503_bin_name <- "Bin_m1503"
Bin_m1503_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_m1503", ])
Bin_m1503_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_m1503", ])
Bin_m1503_host_pvalue <- Bin_m1503_host_kruskal$p.value
Bin_m1503_season_pvalue <- Bin_m1503_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_m1503_bin_name, Bin_m1503_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_m1503_bin_name, Bin_m1503_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_m1503_bin_name)
rm(Bin_m1503_host_kruskal)
rm(Bin_m1503_season_kruskal)
rm(Bin_m1503_host_pvalue)
rm(Bin_m1503_season_pvalue)

Bin_m1545_bin_name <- "Bin_m1545"
Bin_m1545_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_m1545", ])
Bin_m1545_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_m1545", ])
Bin_m1545_host_pvalue <- Bin_m1545_host_kruskal$p.value
Bin_m1545_season_pvalue <- Bin_m1545_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_m1545_bin_name, Bin_m1545_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_m1545_bin_name, Bin_m1545_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_m1545_bin_name)
rm(Bin_m1545_host_kruskal)
rm(Bin_m1545_season_kruskal)
rm(Bin_m1545_host_pvalue)
rm(Bin_m1545_season_pvalue)

Bin_m1549_bin_name <- "Bin_m1549"
Bin_m1549_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_m1549", ])
Bin_m1549_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_m1549", ])
Bin_m1549_host_pvalue <- Bin_m1549_host_kruskal$p.value
Bin_m1549_season_pvalue <- Bin_m1549_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_m1549_bin_name, Bin_m1549_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_m1549_bin_name, Bin_m1549_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_m1549_bin_name)
rm(Bin_m1549_host_kruskal)
rm(Bin_m1549_season_kruskal)
rm(Bin_m1549_host_pvalue)
rm(Bin_m1549_season_pvalue)

Bin_m1569_bin_name <- "Bin_m1569"
Bin_m1569_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_m1569", ])
Bin_m1569_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_m1569", ])
Bin_m1569_host_pvalue <- Bin_m1569_host_kruskal$p.value
Bin_m1569_season_pvalue <- Bin_m1569_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_m1569_bin_name, Bin_m1569_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_m1569_bin_name, Bin_m1569_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_m1569_bin_name)
rm(Bin_m1569_host_kruskal)
rm(Bin_m1569_season_kruskal)
rm(Bin_m1569_host_pvalue)
rm(Bin_m1569_season_pvalue)

Bin_m1590_bin_name <- "Bin_m1590"
Bin_m1590_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_m1590", ])
Bin_m1590_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_m1590", ])
Bin_m1590_host_pvalue <- Bin_m1590_host_kruskal$p.value
Bin_m1590_season_pvalue <- Bin_m1590_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_m1590_bin_name, Bin_m1590_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_m1590_bin_name, Bin_m1590_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_m1590_bin_name)
rm(Bin_m1590_host_kruskal)
rm(Bin_m1590_season_kruskal)
rm(Bin_m1590_host_pvalue)
rm(Bin_m1590_season_pvalue)

Bin_m1597_bin_name <- "Bin_m1597"
Bin_m1597_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_m1597", ])
Bin_m1597_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_m1597", ])
Bin_m1597_host_pvalue <- Bin_m1597_host_kruskal$p.value
Bin_m1597_season_pvalue <- Bin_m1597_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_m1597_bin_name, Bin_m1597_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_m1597_bin_name, Bin_m1597_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_m1597_bin_name)
rm(Bin_m1597_host_kruskal)
rm(Bin_m1597_season_kruskal)
rm(Bin_m1597_host_pvalue)
rm(Bin_m1597_season_pvalue)

Bin_m1631_bin_name <- "Bin_m1631"
Bin_m1631_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_m1631", ])
Bin_m1631_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_m1631", ])
Bin_m1631_host_pvalue <- Bin_m1631_host_kruskal$p.value
Bin_m1631_season_pvalue <- Bin_m1631_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_m1631_bin_name, Bin_m1631_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_m1631_bin_name, Bin_m1631_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_m1631_bin_name)
rm(Bin_m1631_host_kruskal)
rm(Bin_m1631_season_kruskal)
rm(Bin_m1631_host_pvalue)
rm(Bin_m1631_season_pvalue)

Bin_m1648_bin_name <- "Bin_m1648"
Bin_m1648_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_m1648", ])
Bin_m1648_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_m1648", ])
Bin_m1648_host_pvalue <- Bin_m1648_host_kruskal$p.value
Bin_m1648_season_pvalue <- Bin_m1648_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_m1648_bin_name, Bin_m1648_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_m1648_bin_name, Bin_m1648_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_m1648_bin_name)
rm(Bin_m1648_host_kruskal)
rm(Bin_m1648_season_kruskal)
rm(Bin_m1648_host_pvalue)
rm(Bin_m1648_season_pvalue)

Bin_m1657_bin_name <- "Bin_m1657"
Bin_m1657_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_m1657", ])
Bin_m1657_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_m1657", ])
Bin_m1657_host_pvalue <- Bin_m1657_host_kruskal$p.value
Bin_m1657_season_pvalue <- Bin_m1657_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_m1657_bin_name, Bin_m1657_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_m1657_bin_name, Bin_m1657_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_m1657_bin_name)
rm(Bin_m1657_host_kruskal)
rm(Bin_m1657_season_kruskal)
rm(Bin_m1657_host_pvalue)
rm(Bin_m1657_season_pvalue)

Bin_m1662_bin_name <- "Bin_m1662"
Bin_m1662_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_m1662", ])
Bin_m1662_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_m1662", ])
Bin_m1662_host_pvalue <- Bin_m1662_host_kruskal$p.value
Bin_m1662_season_pvalue <- Bin_m1662_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_m1662_bin_name, Bin_m1662_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_m1662_bin_name, Bin_m1662_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_m1662_bin_name)
rm(Bin_m1662_host_kruskal)
rm(Bin_m1662_season_kruskal)
rm(Bin_m1662_host_pvalue)
rm(Bin_m1662_season_pvalue)

Bin_m1711_bin_name <- "Bin_m1711"
Bin_m1711_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_m1711", ])
Bin_m1711_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_m1711", ])
Bin_m1711_host_pvalue <- Bin_m1711_host_kruskal$p.value
Bin_m1711_season_pvalue <- Bin_m1711_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_m1711_bin_name, Bin_m1711_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_m1711_bin_name, Bin_m1711_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_m1711_bin_name)
rm(Bin_m1711_host_kruskal)
rm(Bin_m1711_season_kruskal)
rm(Bin_m1711_host_pvalue)
rm(Bin_m1711_season_pvalue)

Bin_m1739_bin_name <- "Bin_m1739"
Bin_m1739_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_m1739", ])
Bin_m1739_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_m1739", ])
Bin_m1739_host_pvalue <- Bin_m1739_host_kruskal$p.value
Bin_m1739_season_pvalue <- Bin_m1739_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_m1739_bin_name, Bin_m1739_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_m1739_bin_name, Bin_m1739_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_m1739_bin_name)
rm(Bin_m1739_host_kruskal)
rm(Bin_m1739_season_kruskal)
rm(Bin_m1739_host_pvalue)
rm(Bin_m1739_season_pvalue)

Bin_m1752_bin_name <- "Bin_m1752"
Bin_m1752_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_m1752", ])
Bin_m1752_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_m1752", ])
Bin_m1752_host_pvalue <- Bin_m1752_host_kruskal$p.value
Bin_m1752_season_pvalue <- Bin_m1752_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_m1752_bin_name, Bin_m1752_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_m1752_bin_name, Bin_m1752_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_m1752_bin_name)
rm(Bin_m1752_host_kruskal)
rm(Bin_m1752_season_kruskal)
rm(Bin_m1752_host_pvalue)
rm(Bin_m1752_season_pvalue)

Bin_m1768_bin_name <- "Bin_m1768"
Bin_m1768_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_m1768", ])
Bin_m1768_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_m1768", ])
Bin_m1768_host_pvalue <- Bin_m1768_host_kruskal$p.value
Bin_m1768_season_pvalue <- Bin_m1768_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_m1768_bin_name, Bin_m1768_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_m1768_bin_name, Bin_m1768_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_m1768_bin_name)
rm(Bin_m1768_host_kruskal)
rm(Bin_m1768_season_kruskal)
rm(Bin_m1768_host_pvalue)
rm(Bin_m1768_season_pvalue)

Bin_m1794_bin_name <- "Bin_m1794"
Bin_m1794_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_m1794", ])
Bin_m1794_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_m1794", ])
Bin_m1794_host_pvalue <- Bin_m1794_host_kruskal$p.value
Bin_m1794_season_pvalue <- Bin_m1794_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_m1794_bin_name, Bin_m1794_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_m1794_bin_name, Bin_m1794_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_m1794_bin_name)
rm(Bin_m1794_host_kruskal)
rm(Bin_m1794_season_kruskal)
rm(Bin_m1794_host_pvalue)
rm(Bin_m1794_season_pvalue)

Bin_m1813_bin_name <- "Bin_m1813"
Bin_m1813_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_m1813", ])
Bin_m1813_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_m1813", ])
Bin_m1813_host_pvalue <- Bin_m1813_host_kruskal$p.value
Bin_m1813_season_pvalue <- Bin_m1813_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_m1813_bin_name, Bin_m1813_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_m1813_bin_name, Bin_m1813_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_m1813_bin_name)
rm(Bin_m1813_host_kruskal)
rm(Bin_m1813_season_kruskal)
rm(Bin_m1813_host_pvalue)
rm(Bin_m1813_season_pvalue)

Bin_m1863_bin_name <- "Bin_m1863"
Bin_m1863_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_m1863", ])
Bin_m1863_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_m1863", ])
Bin_m1863_host_pvalue <- Bin_m1863_host_kruskal$p.value
Bin_m1863_season_pvalue <- Bin_m1863_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_m1863_bin_name, Bin_m1863_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_m1863_bin_name, Bin_m1863_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_m1863_bin_name)
rm(Bin_m1863_host_kruskal)
rm(Bin_m1863_season_kruskal)
rm(Bin_m1863_host_pvalue)
rm(Bin_m1863_season_pvalue)

Bin_m1941_bin_name <- "Bin_m1941"
Bin_m1941_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_m1941", ])
Bin_m1941_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_m1941", ])
Bin_m1941_host_pvalue <- Bin_m1941_host_kruskal$p.value
Bin_m1941_season_pvalue <- Bin_m1941_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_m1941_bin_name, Bin_m1941_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_m1941_bin_name, Bin_m1941_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_m1941_bin_name)
rm(Bin_m1941_host_kruskal)
rm(Bin_m1941_season_kruskal)
rm(Bin_m1941_host_pvalue)
rm(Bin_m1941_season_pvalue)

Bin_m1952_bin_name <- "Bin_m1952"
Bin_m1952_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_m1952", ])
Bin_m1952_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_m1952", ])
Bin_m1952_host_pvalue <- Bin_m1952_host_kruskal$p.value
Bin_m1952_season_pvalue <- Bin_m1952_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_m1952_bin_name, Bin_m1952_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_m1952_bin_name, Bin_m1952_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_m1952_bin_name)
rm(Bin_m1952_host_kruskal)
rm(Bin_m1952_season_kruskal)
rm(Bin_m1952_host_pvalue)
rm(Bin_m1952_season_pvalue)

Bin_m1981_bin_name <- "Bin_m1981"
Bin_m1981_host_kruskal <- kruskal.test(value ~ Species, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_m1981", ])
Bin_m1981_season_kruskal <- kruskal.test(value ~ Season, data = `2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`[`2022_06_29_melted_transposed_summed_lib_cont_adjusted_all_samples`$variable == "Bin_m1981", ])
Bin_m1981_host_pvalue <- Bin_m1981_host_kruskal$p.value
Bin_m1981_season_pvalue <- Bin_m1981_season_kruskal$p.value
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`)+1,] <- c(Bin_m1981_bin_name, Bin_m1981_host_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_host_species`[, c(2)], as.numeric)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[nrow(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`)+1,] <- c(Bin_m1981_bin_name, Bin_m1981_season_pvalue)
`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)] <- sapply(`2022_06_29_lib_cont_adjusted_no_transformation_summed_to_bins_kruskal_test_P_values_sample_season`[, c(2)], as.numeric)
rm(Bin_m1981_bin_name)
rm(Bin_m1981_host_kruskal)
rm(Bin_m1981_season_kruskal)
rm(Bin_m1981_host_pvalue)
rm(Bin_m1981_season_pvalue)

