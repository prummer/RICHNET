In the file RICHNET\_ms.Rmd, in chapter "Automatic annotation of gene set clusters", replace the current method with a call to gemini, asking to give a 5 word label to each gene set cluster that best describes their common biological theme, and using this label in the same way as previously with the wordcount output. Make a copy of the RMD file and rename it to "RICHNET\_gemini.Rmd", delete the obsolete part and add a description of your plan before executing it.  



Using this package https://github.com/tidyverse/ellmer, write a stand-alone r-script that prompts gemini with a comma separated list of gene set names and gets a 5 word label in return that best describes their common biological theme. An example of that list is "KEGG\_GLYCOLYSIS\_GLUCONEOGENESIS, KEGG\_PENTOSE\_AND\_GLUCURONATE\_INTERCONVERSIONS, KEGG\_FATTY\_ACID\_METABOLISM, KEGG\_VALINE\_LEUCINE\_AND\_ISOLEUCINE\_DEGRADATION, KEGG\_HISTIDINE\_METABOLISM, KEGG\_TYROSINE\_METABOLISM, KEGG\_PHENYLALANINE\_METABOLISM, KEGG\_BETA\_ALANINE\_METABOLISM, KEGG\_GLUTATHIONE\_METABOLISM, KEGG\_STARCH\_AND\_SUCROSE\_METABOLISM".

