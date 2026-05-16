#!/usr/bin/env Rscript

# gene_set_labeler.R
# This script uses the 'ellmer' package to prompt Gemini with a list of gene sets
# and returns a concise 5-word biological theme label.

# 1. Setup and Dependencies
if (!requireNamespace("ellmer", quietly = TRUE)) {
  message("The 'ellmer' package is required.")
  message("You can install it using: devtools::install_github('tidyverse/ellmer')")
  quit(status = 1)
}

suppressPackageStartupMessages(library(ellmer))

# 2. Get Input
# Use command-line argument if provided, otherwise use the example list
args <- commandArgs(trailingOnly = TRUE)
if (length(args) > 0) {
  gene_sets_input <- args[1]
} else {
  # Example list provided by the user
  gene_sets_input <- "KEGG_GLYCOLYSIS_GLUCONEOGENESIS, KEGG_PENTOSE_AND_GLUCURONATE_INTERCONVERSIONS, KEGG_FATTY_ACID_METABOLISM, KEGG_VALINE_LEUCINE_AND_ISOLEUCINE_DEGRADATION, KEGG_HISTIDINE_METABOLISM, KEGG_TYROSINE_METABOLISM, KEGG_PHENYLALANINE_METABOLISM, KEGG_BETA_ALANINE_METABOLISM, KEGG_GLUTATHIONE_METABOLISM, KEGG_STARCH_AND_SUCROSE_METABOLISM"
  message("No input provided. Using default example list...")
}

# 3. Initialize Gemini Chat
# Note: Ensure GOOGLE_API_KEY is set in your environment or .Renviron
tryCatch({
  chat <- chat_google_gemini(
    system_prompt = "You are a bioinformatics expert. Your task is to provide a concise 5-word label that summarizes the common biological theme of a list of gene sets. Respond ONLY with the 5-word label.",
    model = "gemini-1.5-flash", # High-speed model, suitable for short tasks
    api_key = Sys.getenv("GOOGLE_API_KEY")
  )
}, error = function(e) {
  message("Error initializing Gemini chat: ", e$message)
  message("Make sure the GOOGLE_API_KEY environment variable is set.")
  quit(status = 1)
})

# 4. Construct Prompt and Get Label
prompt_text <- sprintf(
  "Below is a list of gene set names. Identify their common biological theme and provide a label of exactly 5 words.\n\nList: %s",
  gene_sets_input
)

message("Querying Gemini...")

tryCatch({
  # We use echo = FALSE to avoid streaming the output if we want to capture it cleanly
  label <- chat$chat(prompt_text, echo = FALSE)

  # Clean up any potential leading/trailing whitespace or quotes
  label <- trimws(gsub('^["\']|["\']$', '', label))

  # 5. Output Result
  cat("\n========================================\n")
  cat("Common Biological Theme (5-word label):\n")
  cat(label, "\n")
  cat("========================================\n")

}, error = function(e) {
  message("Error during Gemini query: ", e$message)
  quit(status = 1)
})
