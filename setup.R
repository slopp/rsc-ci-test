# parameters name
account <- 'sean'
server <- 'colorado.rstudio.com'

# Do NOT Edit Below ----------
# create the config directory one step at a time
message('Attempting to create .config directory in travis home dir')
hm <- Sys.getenv('HOME')
message(paste0('Starting at: ', hm))
pth <- paste0(hm, '/.config')
dir.create(pth)
message(paste0(pth, ' created'))
pth <- paste0(pth, '/R')
dir.create(pth)
message(paste0(pth, ' created'))
pth <- paste0(pth, '/connect')
dir.create(pth)
message(paste0(pth, ' created'))

# servers
pths <- paste0(pth, '/servers')
dir.create(pths)
message(paste0(pths, ' created'))

# accounts
ptha <- paste0(pth, '/accounts')
dir.create(ptha)
message(paste0(ptha, ' created'))

# add the token and key to the DCF file
account.dcf <- read.dcf(paste0(account, '.dcf'), all = TRUE)
account.dcf$token = Sys.getenv('DEPLOY_TOKEN')
account.dcf$private_key = Sys.getenv('DEPLOY_KEY')

# write the account file to the proper location
message('Attempting to write account dcf...')

pthsa <- paste0(ptha, '/', server)
dir.create(pthsa)
message(paste0(pthsa, " created"))

f <- paste0(pthsa, '/', account, '.dcf')
write.dcf(account.dcf, file = f)
message(paste0(f, ' created'))

# write the server file to the proper location
orig <- paste0(Sys.getenv('TRAVIS_BUILD_DIR'), '/', server, '.dcf')
dest <- paste0(pths, '/', server, '.dcf')
message(paste0('Attempting to copy ', orig, ' to ', dest))
res <- file.copy(from = orig, to = dest)
if (!res)
  stop("Failed")
message('Copied')


