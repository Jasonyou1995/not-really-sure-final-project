# INFO 201, Autumn 2016, Secton AB
# Team name: Not Really Sure
# Comtributors: Jason You


# Install and load all the given packages
# Input: a character vector contains the packages need to install
installPackage <- function(packages) {
  try(if (!is.character(packages)) {
    stop("Error: invalid input. \"packages\" must be a character vector")
  })
  
  new.pkg <- packages[!(packages %in% installed.packages()[, "Package"])]
  if (length(new.pkg))
    install.packages(new.pkg, dependencies = TRUE)
  sapply(packages, require, character.only = TRUE)
}
