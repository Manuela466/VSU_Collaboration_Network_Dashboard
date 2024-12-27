library(shiny)
library(shinydashboard)
library(igraph)
library(visNetwork)
library(tidyverse)

# Read in the network data
Faculty_1_2 <- read.csv("Faculty 1 and 2.csv")
net1 <- graph_from_data_frame(Faculty_1_2, directed = FALSE)

# Detect communities
comsW <- cluster_walktrap(net1)
V(net1)$community <- comsW$membership

# Calculate centrality and assign to net1
V(net1)$degree <- degree(net1)
V(net1)$betweenness <- betweenness(net1)
V(net1)$closeness <- closeness(net1)
V(net1)$eigenvector <- eigen_centrality(net1)$vector

# Create nodes data frame without college and department initially
nodes <- data.frame(
  id = V(net1)$name,
  label = V(net1)$name,
  group = V(net1)$community,
  degree = V(net1)$degree,
  betweenness = V(net1)$betweenness,
  closeness = V(net1)$closeness,
  eigenvector = V(net1)$eigenvector
)

# Read in college and department CSV file
faculty_dep_col <- read.csv("College_department_data.csv")

# Merge nodes data frame with faculty_dep_col based on node ID
nodes <- merge(nodes, faculty_dep_col, by.x = "id", by.y = "id", all.x = TRUE)

# Define a shape palette for colleges
college_shapes <- c("Other" = "dot", "CoB" = "star", "CoNHS" = "triangle",
                    "CoET" = "square", "CoAg" = "diamond", "CoEd" = "ellipse")

# Assign shapes to nodes based on their college
nodes$shape <- college_shapes[nodes$college]

# used to create hover text for nodes in a network visualization
nodes$title <- paste(
  "Name:", nodes$label, "<br>",
  "College:", nodes$college, "<br>",
  "Department:", nodes$department, "<br>",
  "Degree:", nodes$degree, "<br>",
  "Betweenness:", round(nodes$betweenness, 2), "<br>",
  "Closeness:", round(nodes$closeness, 2), "<br>",
  "Eigenvector:", round(nodes$eigenvector, 2)
)

# Create edges data frame
edges <- data.frame(from = ends(net1, E(net1))[, 1],
                    to = ends(net1, E(net1))[, 2])

# Define UI
ui <- dashboardPage(
  dashboardHeader(title = "Network Analysis"),
  dashboardSidebar(
    sidebarMenu(
      menuItem("Network Analysis Plot", tabName = "network_analysis", icon = icon("network-wired")),
      selectInput("college_filter", "Select College", choices = unique(nodes$college), selected = NULL, multiple = TRUE),
      selectInput("department_filter", "Select Department", choices = unique(nodes$department), selected = NULL, multiple = TRUE),
      menuItem("Shapes Legend", tabName = "shapes_legend", icon = icon("info-circle"))
    )
  ),
  dashboardBody(
    tabItems(
      tabItem(tabName = "network_analysis",
              fluidRow(
                visNetworkOutput("network", height = "700px")
              )
      ),
      tabItem(tabName = "shapes_legend",
              fluidRow(
                box(title = "Shapes Legend", status = "primary", solidHeader = TRUE,
                    p("The shapes represent the colleges as follows:"),
                    tags$ul(
                      tags$li("Dot: Other"),
                      tags$li("Star: CoB"),
                      tags$li("Triangle: CoNHS"),
                      tags$li("Square: CoET"),
                      tags$li("Diamond: CoAg"),
                      tags$li("Ellipse: CoEd")
                    )
                )
              )
      )
    )
  )
)

# Define server logic
server <- function(input, output) {
  filtered_nodes <- reactive({
    nodes_filtered <- nodes
    if (!is.null(input$college_filter)) {
      nodes_filtered <- nodes_filtered[nodes_filtered$college %in% input$college_filter, ]
    }
    if (!is.null(input$department_filter)) {
      nodes_filtered <- nodes_filtered[nodes_filtered$department %in% input$department_filter, ]
    }
    nodes_filtered
  })
 
# used to create an interactive network visualization using the visNetwork package
  output$network <- renderVisNetwork({
    visNetwork(filtered_nodes(), edges) %>%
      visNodes(shape = filtered_nodes()$shape) %>%
      visEdges(color = "blue", width = 3) %>%
      visOptions(highlightNearest = list(enabled = TRUE, degree = 1),
                 nodesIdSelection = TRUE) %>%
      visInteraction(navigationButtons = TRUE) %>%
      visEvents(selectNode = "function(nodes) {
                var node = nodes.nodes[0];
                Shiny.onInputChange('selected_node', node);
                }")
  })

# it takes the selected node's ID from the network visualization 
#and retrieves the corresponding node's data.
  observeEvent(input$selected_node, {
    node_id <- input$selected_node
    node_data <- filtered_nodes()[filtered_nodes()$id == node_id, ]

# displaying the information when a node is selected in the network visualization     
    showModal(modalDialog(
      title = paste("Node Information:", node_data$label),
      paste("College:", node_data$college),
      paste("Department:", node_data$department),
      paste("Degree:", node_data$degree),
      paste("Betweenness:", node_data$betweenness),
      paste("Closeness:", node_data$closeness),
      paste("Eigenvector:", node_data$eigenvector),
      easyClose = TRUE,
      footer = NULL
    ))
  })
}

# Run the shiny app
shinyApp(ui = ui, server = server)


