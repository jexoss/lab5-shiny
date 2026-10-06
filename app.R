# This app requires the lab package.
if (!requireNamespace("lab5", quietly = TRUE)) {
  if (!requireNamespace("remotes", quietly = TRUE)) install.packages("remotes")
  remotes::install_github("jexoss/lab5")
}

library(shiny)
library(lab5)

categories <- c(
  "Any Category" = "",
  "General Knowledge" = "9",
  "Entertainment: Books" = "10",
  "Entertainment: Film" = "11",
  "Entertainment: Music" = "12",
  "Entertainment: Musicals & Theatres" = "13",
  "Entertainment: Television" = "14",
  "Entertainment: Video Games" = "15",
  "Entertainment: Board Games" = "16",
  "Science & Nature" = "17",
  "Science: Computers" = "18",
  "Science: Mathematics" = "19",
  "Mythology" = "20",
  "Sports" = "21",
  "Geography" = "22",
  "History" = "23",
  "Politics" = "24",
  "Art" = "25",
  "Celebrities" = "26",
  "Animals" = "27",
  "Vehicles" = "28",
  "Entertainment: Comics" = "29",
  "Science: Gadgets" = "30",
  "Entertainment: Japanese Anime & Manga" = "31",
  "Entertainment: Cartoon & Animations" = "32"
)

ui <- fluidPage(
  titlePanel("Trivia Explorer"),
  sidebarLayout(
    sidebarPanel(
      selectInput("category", "Category", choices = categories),
      selectInput("difficulty", "Difficulty",
                  choices = c("Any" = "", "Easy" = "easy", "Medium" = "medium",
                              "Hard" = "hard")),
      numericInput("amount", "Number of questions", value = 10, min = 1,
                   max = 50),
      actionButton("fetch", "Fetch questions")
    ),
    mainPanel(
      plotOutput("plot"),
      tableOutput("table")
    )
  )
)

server <- function(input, output, session){
  questions <- eventReactive(input$fetch, {
    withProgress(message = "Fetching questions...", {
      get_questions(
        amount = input$amount,
        difficulty = if (input$difficulty == "") NULL else input$difficulty,
        category = if (input$category == "") NULL else as.numeric(input$category)
      )
    })
  })

  output$plot <- renderPlot({
    req(questions())
    plot_questions(questions())
  })

  output$table <- renderTable({
    req(questions())
    questions()[, c("category", "difficulty", "type", "question", "correct_answer")]
  })
}

shinyApp(ui, server)
