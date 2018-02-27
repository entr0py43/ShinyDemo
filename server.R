library(shiny)
library(ggplot2)
library(plotly)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
      
      output$slidePlot <- renderPlotly({
            
            # assign UI input parameters
            c <- input$c
            #power<-seq(-1,4,0.1)
            power<-seq(-1,5,0.1)
            x<-10^power    
            
            #y<-  (72.44 *(1-c)*x + (472.3*c*x) / (.647 * c*x +52.85))/(x-c*x + (6.52*c*x)/(.647*c*x+ 52.85) + 6.52)
            
            ############################# experimentation
            
            Eb = 120
            Cb = 10
            Ea = 40
            Ca = 50
            
            # #backup
            # Eb = 72.44
            # Cb = 6.52
            # Ea = 43.98
            # Ca = 32.09
            
            y<- (Eb*(x-c*x) +  (Eb*Cb*c*x)/ (((Eb-Ea)/Ea)*c*x+(Eb*Ca/Ea)  )) /
                  ( (x-c*x) +(Cb*c*x)/(((Eb-Ea)/Ea)*c*x+(Eb*Ca/Ea)) + Cb )
            
            
            
            #(1) this is so NOT RIGHT, but in an interesting way 
            #y<- (Eb*((1-c)*x) + ( (Eb*Cb*(c*x))/ ( ((Ea/Eb)*(c*x))+52.85)  ) ) / 
            #( ((1-c)*x) +  ( (Eb*Cb*(c*x))/ ( ((Ea/Eb)*(c*x))+52.85)  ) + Cb )
            
            #(2) STRIKE 2, another oddly spectacular failure
            #y<- (Eb*((1-c)*x) + ( (Eb*Cb*(c*x))/ ( ((Ea/Eb)*(c*x))+52.85)  ) ) / ( ((1-c)*x) + ((Ea/Eb)*(c*x)+52.85) + Cb )
            
            #(3) this works, but only with the Uro/Ang2 parameters, so i need to figure out the 52.85 mystery ###
            #y<- (Eb*(x-c*x) +  (Eb*Cb*c*x)/ (.647*c*x+52.85)  ) / ( (x-c*x) + (Cb*c*x)/(.647*c*x+52.85) + Cb )
            
            
            
            #################################################
            
            # drc <- function(x, ec50, Emax, h) {
            #       (Emax * x^h)/(x^h + ec50^h)}
            
            #x range .1 to 10,000 log scale
            
            # drugA<-read.csv("~/SHINY/drugA.csv", header = T) #solved for c=1
            # drugB<-read.csv("~/SHINY/drugB.csv", header = T) #solved for c=0
            
            #####################################
            #need to write functions for the parent curves instead of loading data
            
            
            ###########################
            
            # draw the histogram with the specified number of bins
            # ggplot2::qplot(x,y, log="x",)
            g<-ggplot(data=NULL, aes(x=x,y=y))+
                  #scale_x_log10(limits=c(.1,10000))+
                  scale_x_log10(limits=c(.1,100000))+
                  #scale_y_continuous(limits=c(0,80))+
                  scale_y_continuous(limits=c(0,130))+
                  geom_line(lwd=1.5, color="blue")+
                  geom_point(cex=1.5)+
                  geom_hline(yintercept = 0, lwd=1.5)+
                  geom_vline(xintercept = 0, lwd=1.5)+
                  ylab("Effect")+xlab("Dose in nM")
                  #geom_line(aes(x=drugB$x, y=drugB$y), lwd=1, lty=2, color="red")+
                  #geom_line(aes(x=drugA$x, y=drugA$y), lwd=1, lty=2, color="red")
            
            ggplotly(g)     
            #+geom_line(lwd=2, color="blue")
      })
      
})