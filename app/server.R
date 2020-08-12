library(shiny)
shinyServer(function(input, output) {
    output$plot <- renderPlot({
        n <- input$numeric
        mean <- input$mean
        sd <- input$sd
        x <- rnorm(n, mean, sd)
        bins <- seq(min(x), max(x), length.out = input$bin + 1)
        range2x <- seq(-4, 4, length = n)*sd + mean
        c <- dnorm(range2x, mean, sd)
        hist(x, breaks = bins, prob=TRUE, main = "Distribution of random numbers",
             xlab = "Numbers", ylab = "Frequency")
        abline(v = mean, col = "red", lwd = 3)
        abline(v = mean + c(-1,1)*sd, col = "blue", lwd = 3)
        lines(range2x, c, type = "l", col = "green", lwd = 2)
        colors <- c("red", "blue", "green")
        labels <- c("Mean", "Standard deviation", "Probability density function")
        legend("topright", inset=.05, labels, lwd=2, lty=c(1, 1), col=colors)
        })
    output$expl <- renderText({
        explanation <- ifelse(input$doc,
                           "This is a histogram of normally distributed random numbers
                           and a probability density function (pdf) of that normal distribution.
                           To generate a vector of normally distributed random numbers,
                           we used the rnorm function with a given number of numbers
                           and the mean and standard deviation selected on the sliders.
                           You can change the detail of the histogram by moving the number of bins on the slider.
                           Don't forget to use the Submit button having done your changes.",
                           "")
    })
    output$outNote <- renderText(input$boxNote)
})
