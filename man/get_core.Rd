% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/get_core.R
\name{get_core}
\alias{get_core}
\title{Legislators core data.}
\format{Data frame with columns (might vary by legislature):
\itemize{
\item{pageid: Wikipedia page ID identifying a legislator's Wikipedia biography (of class \sQuote{integer}).}
\item{wikidataid: Wikidata ID identifying a legislator's Wikidata entry (of class \sQuote{character}).}
\item{wikititle: A legislator's undirected Wikipedia title. Append \sQuote{wikipedia.org/wiki/} in front for a working URL (of class \sQuote{character}).}
\item{name: A legislator's full name (of class \sQuote{character}).}
\item{sex: A legislator's sex (of class \sQuote{character}).}
\item{ethnicity: A legislator's ethnicity. Asian, black, hispanic, native, pacific islander, or white (of class \sQuote{character}).}
\item{religion: A legislator's religious denomination. (of class \sQuote{character}).}
\item{birth: A legislator's date of birth (of class \sQuote{POSIXct}).}
\item{death: A legislator's date of death (of class \sQuote{POSIXct}).}
\item{birthplace: Comma separated latitude and longitude of a legislator's place of birth (of class \sQuote{character}).}
\item{deathplace: Comma separated latitude and longitude of a legislator's place of death (of class \sQuote{character}).}
}}
\source{
Wikipedia, \url{https://wikipedia.org/} \cr
Wikipedia API, \url{https://wikipedia.org/w/api.php} \cr
Wikidata API, \url{https://www.wikidata.org/} \cr
Wikimedia Commons, \url{https://commons.wikimedia.org/} \cr
Face++ Cognitive Services API, \url{https://www.faceplusplus.com/}
}
\usage{
get_core(legislature)
}
\arguments{
\item{legislature}{A character string specifying the legislature for which data shall be fetched from the GitHub repository. Currently one of \sQuote{austria}, \sQuote{france}, \sQuote{germany}, \sQuote{ireland}, \sQuote{usah}, or \sQuote{usas}.}
}
\value{
A data frame with columns as specified above.
}
\description{
Fetches core sociodemographic data for legislators of the specified legislature from the GitHub repository. Requires a working Internet connection.
}
\examples{
\donttest{## assign entire core dataset into the environment
at_elites <- get_core(legislature = "austria")

## assign only data for the 12th legislative session into the environment
at_elites_subset <- dplyr::semi_join(x = get_core(legislature = "austria"),
                                     y = dplyr::filter(get_political(legislature = "austria"),
                                                                     session == 8),
                                     by = "pageid")

## join at_elites_subset with respective history dataset
at_history <- dplyr::left_join(x = at_elites_subset,
                               y = get_history(legislature = "austria"),
                               by = "pageid")

## assign only birthdate for members of the political party 'SdP' into the environment
at_birthdates_SdP <- dplyr::semi_join(x = dplyr::select(get_core(legislature = "austria"),
                                                        pageid, birth),
                                      y = dplyr::filter(get_political(legislature = "austria"),
                                                                      party == "SdP"),
                                      by = "pageid")$birth
}
}
