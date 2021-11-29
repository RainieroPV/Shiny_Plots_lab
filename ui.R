
library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
            fluidRow(
                tabPanel(
                    "2 columns",
                    fluidRow(
                        column(width = 6,
                               plotOutput("plot_main2", 
                                          click = "clk",
                                          brush = 'mouse_brush',
                                          dblclick = 'dclk',
                                          hover =  hoverOpts(id ='mouse_hover', delay = 500),
                                          height = 500,
                                          width = 500
                               )
                        )),
                    fluidRow(
                        column(width = 6,
                               DT::dataTableOutput("mtcars_tbl")
                        )
                    )
                )
            )
))
               

