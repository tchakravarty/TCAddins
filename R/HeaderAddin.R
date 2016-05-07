#====================================================================
# purpose: define a new addin that creates the header format that
#   is to be used for R scripts
# author: tirthankar chakravarty
# created: 6th may 2016
# revised:
# comments:
#====================================================================

library(miniUI)
library(shiny)
library(addinexamples)

headerAddin = function() {
  # get the currently active document
  current_document = rstudioapi::getActiveDocumentContext()

  #==============================================
  # UI
  #==============================================
  ui = miniPage(
    gadgetTitleBar("R Script Header"),
    miniContentPanel(
      addinexamples:::stableColumnLayout(
        textInput(inputId = "purpose", label = "Purpose:", value = "", width = "100%"),
        textInput(inputId = "author", label = "Author:", value = "", width = "100%"),
        dateInput(inputId = "created_date", label = "Created date: ", value = Sys.Date(),  width = "100%"),
        dateInput(inputId = "revised_date", label = "Revised date: ", value = Sys.Date(), width = "100%"),
        textInput(inputId = "comments", label = "Comments", value = "", width = "100%")
      )
    )
  )

  #==============================================
  # server
  #==============================================
  server = function(input, output, session) {
    # when the user clicks OK, then do this
    observeEvent(input$done, {
      header = paste(
        "#=====================================================================\n",
        "# Purpose: ", input$purpose, "\n",
        "# Author: ", input$author, "\n",
        "# Created date: ", input$created_date, "\n",
        "# Revised date: ", input$revised_date, "\n",
        "# Comments: ", input$comments, "\n",
        "#=====================================================================\n",
        collapse = ""
      )

      rstudioapi::insertText(text = header, id = current_document$id, location = c(1, 1))
      invisible(stopApp())
    })
  }

  # run the app
  header_viewer = dialogViewer("Script Header", width = 1000, height = 800)
  runGadget(ui, server, viewer = header_viewer)
}


