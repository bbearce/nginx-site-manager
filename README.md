# NGINX Site Manager

Manage multiple NGINX reverse proxy configurations across servers.

## Setup

Clone this repo on each server:
```bash
   git clone <repo-url> ./nginx-site-manager
   cd ./nginx-site-manager
```


## Usage

### Create a new site
```bash
./scripts/create-site.sh myapp myapp.example.com localhost 8080
```

This creates a config file in `sites/myapp.conf`.

### Edit the configuration
```bash
code sites/myapp.conf  # or vim, nano, etc.
```

### Deploy the site
```bash
./scripts/deploy-site.sh myapp
```

### Disable a site
```bash
./scripts/disable-site.sh myapp
```

### Remove a site
```bash
./scripts/remove-site.sh myapp
```


## Adding Templates

Add new templates to `templates/` directory. Common patterns:
- `site.conf.template` - Basic reverse proxy
- `static.conf.template` - Static file serving
- `websocket.conf.template` - WebSocket support

## Workflow

1. Create site config from template
2. Edit and commit to git
3. Deploy on server(s)
4. Changes? Edit, commit, pull on server, re-deploy
```

**6. A `.gitignore`**:
```
> Don't commit actual server-specific details if you want
> sites/*.conf

> But you probably DO want to commit your sites configs
> so remove the above line