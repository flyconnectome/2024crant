backbone_proofread=crantr::crant_cave_query('backbone_proofread')

rr=crantr::with_crant(fafbseg::flywire_partner_summary('576460752730971347', partners = 'in', synapse_table='synapses'))

rr %>% filter(weight>1) %>% with(clipr::write_clip(pre_id))

pn <- "576460752730971347"
orns <- fafbseg::flywire_ids("576460752715801387, 576460752735867355, 576460752739003435, 576460752775906450, 576460752775936146, 576460752775937170, 576460752775938962, 576460752775941522, 576460752776501138, 576460752776638610")

orn_targets=crantr::with_crant(fafbseg::flywire_partner_summary(orns, partners = 'out', synapse_table='synapses'))

# https://spelunker.cave-explorer.org/#!middleauth+https://global.daf-apis.com/nglstate/api/v1/5638083878846464

orn_targets %>%
  count(post_id, wt = weight, sort = T, name = 'weight') %>%
  filter(weight>=5) %>%
  with(clipr::write_clip(post_id))

# identifies some targets including another PN

# 576460752775934610

# But that PN is incomplete (dendrite and cell body fibre), so I looked for a place where its axon might join update. Sure enough

# https://spelunker.cave-explorer.org/#!middleauth+https://global.daf-apis.com/nglstate/api/v1/6198601974808576


# An LHN
# 576460752708305732

source("R/crant-funs.R")

crant_partner_summary(orns, partners = 'out')


lhn.in=crant_partner_summary('576460752708305732', partners = 'in')
lhn.in %>%
  filter(n>=5) %>%
  with(clipr::write_clip(pre_id))

db=crantr::crant_table_query('select * from CRANTb_meta')
db2 <- db %>%
  mutate(islatest=crantr::crant_islatest(root_id))
db2u=crantr::crant_updateids(db2)
db2 %>% add_count(root_id, name = 'nroot') ->db2
db2 %>% filter(nroot>1) %>%
  arrange(root_id)


# looking for big PNs


db2 %>%
  count(cell_class)

db2 %>%
  count(proofreader_notes, sort = T) %>%
  head()

db2 %>%
  filter(grepl("potentially a PN", proofreader_notes)) %>%
  count(nroot)


db2 %>%
  filter(grepl("potentially a PN", proofreader_notes)) %>%
  filter(nroot>1) %>%
  group_by(root_id) %>%
  mutate(nside=n_distinct(side)) %>%
  filter(nside>1) %>%
  with(clipr::write_clip(root_id))

bilat_pn <- '576460752712780548'
bilat_pn.in <- crant_partner_summary(bilat_pn, partners = 'in')

bilat_pn.in %>%
  filter(weight>=5) %>%
  with(clipr::write_clip(pre_id))


orn2bilatpn <- fafbseg::flywire_ids('576460752738841425, 576460752738841681, 576460752738842193, 576460752738842705')

orn2bilatpn.o=crant_partner_summary(orn2bilatpn, partners = 'o')
orn2bilatpn.o

contrabilat='576460752740351375'
contrabilat.i=crant_partner_summary(contrabilat, partners = 'i')

contrabilat.i %>%
  filter(weight>1)


bilat_pn.in %>% filter(pre_id %in% contrabilat.i$pre_id) %>%
  filter(weight>1) %>%
  with(clipr::write_clip(pre_id))


bilatpn.lorns=fafbseg::flywire_ids("576460752712140692, 576460752763637138")

crant_partner_summary(bilatpn.lorns, partners = 'o')

vp3typevpn='576460752710144060'



# https://spelunker.cave-explorer.org/#!middleauth+https://global.daf-apis.com/nglstate/api/v1/5494172141223936
#
#   https://spelunker.cave-explorer.org/#!middleauth+https://global.daf-apis.com/nglstate/api/v1/5494172141223936
#
#   https://spelunker.cave-explorer.org/#!middleauth+https://global.daf-apis.com/nglstate/api/v1/5494172141223936

# Some glomeruli near the left antennal nerve root
# https://spelunker.cave-explorer.org/#!middleauth+https://global.daf-apis.com/nglstate/api/v1/5985747053051904
g1="576460752752912786"
g1.in=crant_partner_summary(g1, partners = 'i')

g1.orns <- fafbseg::flywire_ids('576460752719726635, 576460752719881771, 576460752720182571, 576460752736400683, 576460752736409899')

g1.orns.o=crant_partner_summary(g1.orns, partners = 'o')
