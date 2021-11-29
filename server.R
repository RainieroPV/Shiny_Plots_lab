library(shiny)
library(tidyverse)
library(ggplot2)
library(dplyr)



data(mtcars, package="datasets")
df <- mtcars
plot <- ggplot(mtcars,aes(x=wt,y=mpg)) + geom_point(alpha = 1,size = 5, color = "blue",stroke = 0)+ theme(text = element_text(size=20))
flagClick <<- 1

shinyServer(function(input, output) {
    Clicked_Point2_Prev <- NULL
    output$mtcars_tbl <- DT::renderDataTable({
        if (!is.null(input$mouse_brush)){
            df <<- brushedPoints(mtcars, input$mouse_brush, xvar='wt', yvar = 'mpg')
        } else if (!is.null(input$clk)){
            df <<- nearPoints(mtcars, input$clk, xvar = "wt", yvar = "mpg")
        } else if (flagClick == 1 ){
            df <<- mtcars
        }
        df
    })
    
    
    output$plot_main2 <- renderPlot({
        if (!is.null(input$clk)){
            print(flagClick)
            flagClick <<- 0
            print(flagClick)
            Clicked_Point2 <- nearPoints(mtcars, input$clk, threshold = 10, maxpoints = 10, xvar='wt', yvar = 'mpg')
            plot <<- plot + geom_point(data=Clicked_Point2,
                                    color = 'green',
                                    alpha = 1,
                                     size = 5)
        
        } else if (!is.null(input$dclk)){
            Clicked_Point2 <- nearPoints(mtcars, input$dclk, threshold = 10, maxpoints = 10, xvar='wt', yvar = 'mpg')
            plot <<- plot + geom_point(data=Clicked_Point2,
                                       color = 'blue',
                                       alpha = 1,
                                       size = 5)
            
        } else if (!is.null(input$mouse_brush)){
            Clicked_Point2 <-  brushedPoints(mtcars, input$mouse_brush, xvar='wt', yvar = 'mpg')
            plot <<- plot + geom_point(data=Clicked_Point2,
                                       color = 'green',
                                       alpha = 1,
                                       size = 5)
        } else if (!is.null(input$mouse_hover)){
            print("hover!!")
            Clicked_Point2 <- nearPoints(mtcars, input$mouse_hover, threshold = 10, maxpoints = 10)
            plot <<- plot + geom_point(data=Clicked_Point2,
                                       color = 'gray',
                                       alpha = 1,
                                       size = 5)
        }
        else{
            plot
       }
        
    })
        

})
