
# 2024crant

<!-- badges: start -->
<!-- badges: end -->

2024crant collects together R scripts and functions to work with the 
clonal raider ant brain (CRANTb) dataset. 
See https://github.com/flyconnectome/crantr for more details.

To use, install R + Rstudio and open the .Rproj file.

This repository includes an [renv lockfile](https://rstudio.github.io/renv/articles/renv.html) 
to manage dependencies. When you start R it should offer to install any packages
that you do not have. Although this can be a nice idea in general, there is
a specific reason in this case: Alex Bates' 
[crantr package](https://github.com/flyconnectome/crantr?tab=readme-ov-file) 
currently depends on
a development branch of the fafbseg package with some wrinkles in the authorisation
mechanisms.

Here is an R example of fishing upstream of a single Olfactory Projection Neuron (PN)
to find its olfactory receptor input neurons (ORNs) and then going downstream 
from the ORNs to find the other PNs in the glomerulus. It seems that there are
at least 3 in this case.

```r
library(dplyr)
source("R/crant-funs.R")
crant_partner_summary()

# PN defining a glomerulus
# make sure id is up to date
g1=crantr::crant_latestid("576460752752912786")

# find all the inputs onto this neuron
g1.in=crant_partner_summary(g1, partners = 'i')
# copy/paste ids to neuroglancer, review them and pick out ORNs

g1.in %>% filter(weight>2) %>% with(clipr::write_clip(pre_id))

g1.orns <- fafbseg::flywire_ids('576460752719726635, 576460752719881771, 576460752720182571, 576460752736400683, 576460752736409899')

# Find ORN outputs, 
g1.orns.o=crant_partner_summary(g1.orns, partners = 'o')
# review those, copy/paste ids to neuroglancer and then pick out additional PNs 
g1.orns.o %>% 
  filter(weight>5) %>% 
  with(clipr::write_clip(post_id))

```

Final [scene with ORNs and 3 PNs](https://spelunker.cave-explorer.org/#!middleauth+https://global.daf-apis.com/nglstate/api/v1/5050874507296768)


