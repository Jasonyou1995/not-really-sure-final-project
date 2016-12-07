# INFO 201, Autumn 2016, Secton AB
# Team name: Not Really Sure
# Comtributors: Jason You
#
# returns the character form of the input

factorToCharOrNum <- function(input, type = "character") {
  if (is.factor(input)) {
    input <- as.character(input)
    if (type == "character") {
      return(input)
    } else if (type == "numeric") {
      return(as.numeric(input))
    }
  } else {
    return(input)
  }
}
