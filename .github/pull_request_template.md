Thanks for making a pull request to broom! A few things to keep in mind that will probably help this PR be merged more quickly:  

* Have you documented the change in `NEWS.md`?  
* If this is your first time PRing to broom, have you added yourself as a contributor in the `DESCRIPTION`?
* Have you added any new vocabulary to `inst/WORDLIST`? (New vocabulary will be noted in the R-CMD-check from GitHub Actions.)
* Does R-CMD-check pass on GitHub Actions? (Sometimes, checks may not be passing on the main branch already—if that's the case, just try to make sure your changes don't add any additional errors/warnings.) 

If your PR fixes a bug, a [reprex](https://github.com/tidyverse/reprex) of the bug would be much appreciated!

If your PR adds new tidiers for external model objects, please link to prior attempts to add these tidiers to the model-exporting package, and include a reprex of the new tidiers' functionality! You can learn more about writing tidiers for model-exporting packages [here](https://www.tidymodels.org/learn/develop/broom/).

If you're having trouble making any of these requests happen, let us know and we can lend a hand!
