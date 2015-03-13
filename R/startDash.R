startDash = function(){
  ui = dashboardPage(
    dashboardHeader(title = "tferDash"),
    
    dashboardSidebar(
      sidebarMenu(
        menuItem("Probabilities", tabName = "probabilities", icon = icon("dashboard")),
        menuItem("Inputs", tabName = "inputs", icon = icon("th"))
      )
    ),
    
    dashboardBody(
      tabItems(
        # First tab content
        tabItem(tabName = "probabilities",
            # Boxes need to be put in a row (or column)
          fluidRow(
            box(plotOutput("plot1", height = 250)),
            
            box(
              title = "Controls",
              sliderInput("slider", "Number of observations:", 1, 100, 50)
            )
          )
        ),
        
        tabItem(tabName = "inputs",
          h2("Inputs tab content"),
          fluidRow(
            column(3,
                   h3("Buttons"),
                   actionButton("action", label = "Action"),
                   br(),
                   br(), 
                   submitButton("Submit")),
            column(3,
                   h3("Settings"),
                   numericInput("distance", label = "Estimated distance from window", value = 0.5,
                                min = 0, max = 10, step = 0.1),
                   checkboxInput('distEff', 'Distance effect'), 
                   numericInput("aveNumFrags", label = "Mean number of fragments transfered", 
                                value = 120, min = 1, max = 1000, step = 1),
                   h4("Estimated time between commission and arrest (hrs)"),
                   numericInput("timeLL", label = "Lower limit", value= 0, min = 0, max = 72),
                   numericInput("timeUL", label = "Upper limit", value = 1, min = 1, max = 72)),
            box(
              title = "Controls",
              sliderInput("slider", "Number of observations:", 1, 100, 50)
            )
          )
        )
      )
    )
  )

  server = function(input, output){
    set.seed(122)
    y = transfer()
    
    output$plot1 = renderPlot({
      plot(y)
    })
  }

  shinyApp(ui, server)
}