# Issues from using ggmap

 `ggmap Error: GeomRasterAnn was built with an incompatible version of ggproto`

<hr/>

**So here is what I did:**

* [solution link](http://howtoprogram.eu/question/r-ggplot2-ggmap-error-geomrasterann-was-built-with-an-incompatible-version-of-ggproto,36623)

1. Using older version of ggplot2:

```
library(devtools)
install_version("ggplot2", version = "2.1.0", repos = "http://cran.us.r-project.org")
```

2. Installed the git version `ggmap`:

```
devtools::install_github("dkahle/ggmap")
```

3. Installed (_git versions_) `ggrepel`, `geforce`, and `ggraph`

4. Finally I reintalled the R, and after this step everything worked fine...

Conclution: I didn't find what's the issue, but hope this will be helpful if you encounter the same problem.

_by Jason You_