#' Legislators facial data.
#'
#' Fetches facial data on legislators for the specified legislature from the GitHub repository. Requires a working Internet connection. Facial data are Face++ estimates based on portraits from Wikipedia Biographies.
#'
#' @param legislature A character string specifying the legislature for which data shall be fetched from the GitHub repository. Currently one of \sQuote{austria}, \sQuote{france}, \sQuote{germany}, \sQuote{ireland}, \sQuote{usah}, or \sQuote{usas}.
#' @return A data frame with columns as specified above.
#' @format Data frame with columns (might vary by legislature):
#' \itemize{
#' \item{pageid: Wikipedia page ID identifying a legislator's Wikipedia biography (of class \sQuote{integer}).}
#' \item{image_url: URL linking to a legislator's portrait on Wikimedia Commons (of class \sQuote{character}).}
#' \item{smile_intensity: Smile intensity. A smiling face can be confirmed if this number goes beyond the threshold value of 30.1. (of class \sQuote{numeric}).}
#' \item{emo_sadness: Sadness expressed, a bigger value indicates greater confidence of the emotion. The sum of all emo variables is 100 (of class \sQuote{numeric}).}
#' \item{emo_neutral: Neutrality expressed, a bigger value indicates greater confidence of the emotion. The sum of all emo variables is 100 (of class \sQuote{numeric}).}
#' \item{emo_disgust: Disgust expressed, a bigger value indicates greater confidence of the emotion. The sum of all emo variables is 100 (of class \sQuote{numeric}).}
#' \item{emo_anger: Anger expressed, a bigger value indicates greater confidence of the emotion. The sum of all emo variables is 100 (of class \sQuote{numeric}).}
#' \item{emo_surprise: Surprise expressed, a bigger value indicates greater confidence of the emotion. The sum of all emo variables is 100 (of class \sQuote{numeric}).}
#' \item{emo_fear: Fear expressed, a bigger value indicates greater confidence of the emotion. The sum of all emo variables is 100 (of class \sQuote{numeric}).}
#' \item{emo_happiness: Happiness expressed, a bigger value indicates greater confidence of the emotion. The sum of all emo variables is 100 (of class \sQuote{numeric}).}
#' \item{beauty_female: A higher score indicates that the face is more beautiful from a female perspective (of class \sQuote{numeric}).}
#' \item{beauty_male: A higher score indicates that the face is more beautiful from a male perspective (of class \sQuote{numeric}).}
#' \item{skin_dark_circles: A higher score indicates greater confidence of dark circles. Highly dependent on proper image quality (of class \sQuote{numeric}).}
#' \item{skin_stain: A higher score indicates greater confidence of spots. Highly dependent on proper image quality (of class \sQuote{numeric}).}
#' \item{skin_acne: A higher score indicates greater confidence of acne. Highly dependent on proper image quality (of class \sQuote{numeric}).}
#' \item{skin_health: A higher score indicates greater confidence of a healthy skin. Highly dependent on proper image quality (of class \sQuote{numeric}).}
#' \item{image_quality: Suitability of the image quality for image comparison. Estimates are comparable if this number goes beyond the threshold value of 70.1 (of class \sQuote{numeric}).}
#' }
#' @examples
#' \donttest{## assign entire core dataset into the environment
#' at_elites <- get_core(legislature = "austria")
#'
#' ## assign only data for the 12th legislative session into the environment
#' at_elites_subset <- dplyr::semi_join(x = get_core(legislature = "austria"),
#'                                      y = dplyr::filter(get_political(legislature = "austria"),
#'                                                                      session == 8),
#'                                      by = "pageid")
#'
#' ## join at_elites_subset with respective history dataset
#' at_history <- dplyr::left_join(x = at_elites_subset,
#'                                y = get_history(legislature = "austria"),
#'                                by = "pageid")
#'
#' ## assign only birthdate for members of the political party 'SdP' into the environment
#' at_birthdates_SdP <- dplyr::semi_join(x = dplyr::select(get_core(legislature = "austria"),
#'                                                         pageid, birth),
#'                                       y = dplyr::filter(get_political(legislature = "austria"),
#'                                                                       party == "SdP"),
#'                                       by = "pageid")$birth
#' }
#' @source
#' Wikipedia API, \url{https://wikipedia.org/w/api.php} \cr
#' Wikimedia Commons, \url{https://commons.wikimedia.org/} \cr
#' Face++ Cognitive Services API, \url{https://www.faceplusplus.com/}
#' @export
#' @importFrom curl nslookup
#' @import dplyr
get_facial <- function(legislature) {
  if (!(legislature %in% c("austria", "france", "germany", "ireland", "usah", "usas")))
    stop ("legislatoR does not contain data for this legislature at the moment. Please try one of 'austria', 'france', 'germany', 'ireland', 'usah', or 'usas'.")
  if (is.null(curl::nslookup("www.github.com", error = FALSE)))
    stop ("legislatoR failed to establish a connection to GitHub. Please check your Internet connection and whether GitHub is online.")
  ghurl <- base::paste0("https://github.com/saschagobel/legislatoR-data/blob/master/data/", legislature, "_facial?raw=true")
  connect <- base::url(ghurl)
  on.exit(close(connect))
  dataset <- base::readRDS(connect)
  return(dataset)
}
