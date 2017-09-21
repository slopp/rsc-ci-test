library(rsconnect)
rsconnect::deployApp(
  appDir = ".",
  appFiles = c('app.R'),
  appName = "CI-Deployed",
  account = "sean",
  server = "colorado.rstudio.com",
  logLevel = 'verbose'
)