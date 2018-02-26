library(shiny)
library(ggplot2)


# Define server logic required to draw a histogram
shinyServer(function(input, output) {
      
      output$slidePlot <- renderPlot({
            
            # assign UI input parameters
            c <- input$c
            power<-seq(-1,4,0.1)
            x<-10^power    
            
            y<-  (72.44 *(1-c)*x + (427.3*c*x) / (.647 * c*x +52.85))/(x-c*x + (6.52*c*x)/(.647*c*x+ 52.85) + 6.52)
            
            
            
            # drc <- function(x, ec50, Emax, h) {
            #       (Emax * x^h)/(x^h + ec50^h)}
            
            #x range .1 to 10,000 log scale
            
            drugA<-read.csv("~/SHINY/drugA.csv", header = T)
            drugB<-read.csv("~/SHINY/drugB.csv", header = T)
            
            # draw the histogram with the specified number of bins
            # ggplot2::qplot(x,y, log="x",)
            ggplot(data=NULL, aes(x=x,y=y))+
                  scale_x_log10(limits=c(.1,10000))+
                  scale_y_continuous(limits=c(0,80))+
                  geom_line(lwd=1.5, color="blue")+
                  geom_point(cex=2)+
                  geom_hline(yintercept = 0, lwd=1.5)+
                  geom_vline(xintercept = 0, lwd=1.5)+
                  ylab("Effect")+xlab("Dose in nM")+
                  geom_line(aes(x=drugB$x, y=drugB$y), lwd=1, lty=2, color="red")+
                  geom_line(aes(x=drugA$x, y=drugA$y), lwd=1, lty=2, color="red")
            
                 
            #+geom_line(lwd=2, color="blue")
      })
      
})