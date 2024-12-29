# Virginia State University Faculty Collaboration Network Dashboard

### Access the Presentation
- [Download the PowerPoint Presentation](Faculty_VSU_dashbored_powerpoint.pdf)

#### Live Demo
- [Live Demo of Dashboard](https://manuela123.shinyapps.io/vsu_network_dashbored/)

### Author:
**Manuela Deigh, B.S.**  
Presented as part of the Data Science For The Public Good (DSPG) Program  
Date: August 2024  

---

## Overview
This project analyzes research collaborations among Virginia State University (VSU) faculty using network analysis techniques. The aim is to provide an interactive dashboard that visualizes these collaborations, offering insights into patterns and connections to enhance faculty engagement and strategic initiatives.

---

## Table of Contents
1. **Project Objective**
2. **Background**
3. **Data Sources**
4. **Data Analysis**
5. **Key Insights**
6. **Interpretation and implications**
7. **Challenges and Future Directions**

---

## Project Objective
- **Goal**: Develop a dynamic dashboard to analyze and visualize research collaborations among VSU faculty.
- **Purpose**: Enable faculty and administrators to uncover key patterns and trends in collaborative networks.

---

## Background
- **What is Network Analysis?**
  - Studies complex networks of interconnected entities.
  - **Nodes**: Represent faculty members.
  - **Edges**: Represent collaborations between faculty members.
  - **Centrality**: Measures node importance (e.g., degree, closeness).
  - **Community Detection**: Identifies clusters or groups of closely connected nodes.

- **Why Network Analysis?**
  - Visualize and understand the structure of research collaborations.
  - Uncover key patterns and insights within the collaborative network.

---

## Data Sources
The dataset includes the following information:
- **Request Amount**: Funding or resource amount requested.
- **Submission Date**: Date of submission.
- **Collaboration Type**: Nature of the collaboration (e.g., interdepartmental).
- **Team**: Team involved in the collaboration.
- **Faculty Members**: Names of participating faculty members.
- **Department**: Department affiliations.
- **Project Title**: Title of the collaborative project.

---

## Data Analysis
### Tools Used:
- **R and RStudio**: For data manipulation, visualization, and dashboard development.
- **Shiny**: For building an interactive web application.
- **Data Manipulation**: Using `dplyr`, `tidyr`, and `readr`.
- **Visualization**: Using `ggplot2`, `visNetwork`, and `igraph`.

### Techniques:
1. **Data Collection and Preparation**:
   - Import, clean, and prepare data for analysis.
2. **Network Analysis**:
   - Visualize collaborations using tools like `igraph`.
3. **Dashboard Design**:
   - **UI**: Designed using `fluidPage` and `sidebarLayout`.
   - **Server Logic**: Implemented with reactive expressions and rendering outputs.

---

## Key Insights
 -Most collaborations occur within the same department. This suggests strong internal networks within departments.
![image](https://github.com/user-attachments/assets/54820698-484d-46f9-8515-0e8e18707a05)

 

### Interpretation and implications:
**Interpretation:**
- The dashboard provides a clear and intuitive visual representation of how faculty members collaborate, making it easier to identify trends and key members in the network graph.
- The dashboard also gives the viewer information about each nodes such as degree, betweenness, closeness, eigenvector, college, and department

  **Implications:**
  - Faculty members can use the insights from the dashboard to make informed decisions about funding opportunities and strategic initiatives to promote further collaboration.

---

## Challenges and Future Directions
### Challenges:
- **Data Limitations**:
  - Existing records may be incomplete or outdated.
  - Informal collaborations might not be captured.

### Future Directions:
- Enhance the dashboard’s user interface for better accessibility.
- Conduct longitudinal studies to track changes in collaboration patterns over time.


