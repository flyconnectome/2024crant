library(crantr)
library(fafbseg)

mALT_right=ngl_decode_scene("https://spelunker.cave-explorer.org/#!middleauth+https://global.daf-apis.com/nglstate/api/v1/5372667474477056")
mALT_left=ngl_decode_scene("https://spelunker.cave-explorer.org/#!middleauth+https://global.daf-apis.com/nglstate/api/v1/5826249172713472")

mALT_left.ann=fafbseg::ngl_annotations(mALT_left)
mALT_right.ann=fafbseg::ngl_annotations(mALT_right)

mALT.ann=dplyr::bind_rows(list(mALT_left=mALT_left.ann, mALT_right=mALT_right.ann), .id = 'tract')


points3d(crantr:::crant_raw2nm(mALT.ann$point))

mALT.ann$root_id=crantr::crant_xyz2id(mALT.ann$point, rawcoords = T)

library(dplyr)
mALT.ann |>
  filter(layer=='malt seed') |>
  count(root_id, sort = T)

mALT.ann |>
  filter(layer=='malt seed') |>
  group_by(root_id) |>
  summarise(n=n(), sides=n_distinct(tract)) |>
  arrange(desc(sides), desc(n))

mALT.ann |>
  filter(layer=='malt seed') |>
  filter(root_id==0) |>
  as.data.frame()
