# Incubator for functions that could be added to the crantr package


#' Title
#'
#' @param rootids Which neurons to query
#' @param partners Input or output partners
#' @param aggregate Whether to aggregate the results for multiple query neurons
#' @param ... Additional arguments passed to fafbseg::flywire_partner_summary
#'
#' @returns
#' @export
#'
#' @examples
crant_partner_summary <- function(rootids, partners=c("in", "out"), aggregate=TRUE, ...) {
  partners=match.arg(partners)
  res=crantr::with_crant(fafbseg::flywire_partner_summary(rootids, partners = partners, synapse_table='synapses'), ...)
  if(aggregate) {
    if(partners=='in')
      res %>%
      count(pre_id, wt = weight, sort = T, name = 'weight')
    else
      res %>%
      count(post_id, wt = weight, sort = T, name = 'weight')
  } else res
}
