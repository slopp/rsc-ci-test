# Continous Integration + Connect Deployment

This repository shows you how to setup travis to deploy content to RSC. 

You will need:

1. packrat & rsconnect packages 
2. Git repository with a working shiny app
3. A publisher account on a RStudio Connect server


Steps:


1. If you have not already, link the IDE to Connect via your publisher account. See the user guide for details.

2. Enter the command:
`rsconnect:::rsconnectConfigDir()`

3. Navigate to the resulting directory. It should look something like:

```
-> tree
.
├── accounts
│   └── colorado.rstudio.com
│       └── sean.dcf
└── servers
    └── colorado.rstudio.com.dcf
```

4. Copy the 2 dcf files into the repository. Note that one file has the name of the server (colorado.rstudio.com.dcf) and the other file has the name of the account (sean.dcf)

5. Open the account dcf file. (In my case, the file named sean.dcf). The file consists of key-value pairs in the form: `key: value`. For the keys `token` and `private_key`, carefully copy the values to safe location for later, and then remove them from the file. *DON'T* remove the key, at the end you should have a file like:

```
username: sean
accountId: 1
token: 
server: colorado.rstudio.com
private_key: 
```

6. Copy the `setup.R` file from this repo into your repo. At the top of the file, change the account and server values to match your account and server dcf files:

```
# parameters name
account <- 'sean'
server <- 'colorado.rstudio.com'
...
```

7. Copy the `deploy.R` file from this repo into your repo. Edit the file to properly setup your deployment:

```
library(rsconnect)
rsconnect::deployApp(
  appDir = ".",
  appFiles = c('app.R'),             # change this to include all the files your app needs!
  appPrimaryDoc = 'app.R',          
  appName = "CI-Deployed",           # this is the name your app will have on Connect
  account = "sean",                  # this is the same account name as your account dcf file
  server = "colorado.rstudio.com",   # this is the same server name as your server dcf file
  logLevel = 'verbose'
)
```

8. Run the command `packrat::.snapshotImpl(".", snapshot.sources = FALSE)`. This creates a packrat directory with a `packrat.lock` file.

9. Copy the `.travis.yml` file from this repo to yours. The only thing you might need to change is the version of R at the top:

```
dist: trust
language: r
sudo: false
r: 3.3.3     # <- change me!
...
```

10. Log into travis and enable builds for your app's repository. In the settings for the repo, add two environment variables:
  - `DEPLOY_KEY` : Copy the long private_key we saved earlier in step 5.
  - `DEPLOY_TOKEN` : Copy the token we saved earlier in step 5.
  
You're all set! The next time you push to this repository, travis will deploy your app to Connect!
