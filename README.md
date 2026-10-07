
# lab5-shiny

<!-- badges: start -->
<!-- badges: end -->

A shiny app for interactively exploring trivia questions from
the [Open Trivia Database](https://opentdb.com), built on top of
the [lab5](htps://github.com/jexoss/lab5) package.

Choose a category, difficulty and number of questions, and the app 
fetches the questions and shows both a table of the quesitons and a plot of how
the difficulty is distributed across categories

## Running the app 

``` r
# install.packages("shiny")
shiny::runGithub("lab5-shiny", jexoss)
```

The app automatically installs the `lab5` package if it isnt already installed
