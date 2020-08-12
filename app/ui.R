library(shiny)
shinyUI(fluidPage(
    titlePanel("Course Project: Shiny Application and Reproducible Pitch"),
    sidebarLayout(
        sidebarPanel(
            em("1. Set the parameters for plotting."), br(),
            em("2. Enter your text for the Notes tab, if relevant"), br(),
            em("3. Push the Submit button."), br(),
            em("4. For more details see the Documentation tab."), p(),

            numericInput("numeric", "How many numbers you want to generate?",
                         value = 50000, min = 100, max = 500000, step = 100),
            sliderInput("mean", "Mean:", min = -15, max = 15, step = 0.2, value = 0),
            sliderInput("sd", "Standard deviation:", min = 0, max = 20, step = 0.5, value = 1),
            sliderInput("bin", "Number of bins:", min = 20, max = 100, value = 70),
            textInput("boxNote", "Notes:", value = " this is a simple project due to the short time frame"),
            checkboxInput("doc", "Show/hide explanation", value = TRUE),
            submitButton("Submit")
            ),
        mainPanel(
            tabsetPanel(type = "tabs",
                        tabPanel("Histogram",
                                 plotOutput("plot"),
                                 textOutput("expl")),
                        tabPanel("Documentation", br(),
                                 "This is a Shiny application that plots a normal distribution for a given number of random numbers with a specified mean and standard deviation.", p(),
                                 "You have to set the parameters and click the Submit button to get a new histogram in the Histogram tab.", p(),
                                 "If you want to add your thoughts, just enter text in the Notes field and it will appear in the Notes tab.",
                                 "For example: this is a simple project due to the short time frame.", p(),
                                 "The checkbox at the very end of the sidebar panel allows you to show or hide a short explanation in the Histogram tab.", p(),
                                 "The Code tab contains a small, simplified schematic snippet of code to show how the server of this application processes the data you entered.", p(),
                                 "The more numbers you set for generation and for intervals, the more your histogram will look like a bell. Try it!"),
                        tabPanel("Code", br(),
                                 "This is a 'schematic' piece of code for plotting a histogram and pdf curve for the given input parameters.", p(),
                                 em("## from input:", br(),
                                    "## n - the number of numbers you want to generate", br(),
                                    "## mean - your selected mean", br(),
                                    "## sd - your selected standard deviation", br(),
                                    "## bin - your number of intervals for a histogram", p(),
                                    "## generate vector of normally distributed random numbers", br()),
                                 code("x <- rnorm(n, mean, sd)", p()),
                                 em("## build a Gaussian (pdf curve):", br(),
                                    "## - construct an interval equal to four of our standard deviations", br(),
                                    "## - build on this interval the density for the normal distribution with a given mean and standard deviation", br()),
                                 code("range2x <- seq(-4, 4, length = n)*sd + mean", br(),
                                      "c <- dnorm(range2x, mean, sd)", p()),
                                 em("## split vector of random numbers into specified number of bins for histogram", br()),
                                 code("bins <- seq(min(x), max(x), length = bin + 1)", p()),
                                 em("## histogram and pdf curve", br()),
                                 code("hist(x, breaks = bins)", br(),
                                      "lines(range2x, c, type = 'l')")),
                        tabPanel("Notes",br(),textOutput("outNote"))
            )
        )
    )
))

