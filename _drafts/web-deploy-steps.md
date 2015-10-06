Steps to get web platform installer to work and backup and shit:

Server: Install web platform
===

http://www.microsoft.com/web/downloads/platform.aspx

Server: Web deploy
===

Open Web Platform Installer 4.6 (just installed)

Search for "Web Deploy"

Web Deploy 3.5 for Hosting Providers -> Add -> Install

Server: Configure Web Deploy publishing
===

- Open IIS Manager
- Right click on your site -> Deploy -> Configure Web Deploy Publishing
- Note down the username (e.g. MY_COMPANY\username) and the URL specified (e.g. https://MYSERVER:8172/msdeploy.axd)
- Click "Setup" -> Close

Workstation: 
===

- Open your site project in VS2010
- Select the correct solution configuration (e.g.: Release)
- Next to "Publish", select "<New...>"
- Give the profile a name (like "production")
- In "Service URL", paste the URL you noted from the server (e.g. https://MYSERVER:8172/msdeploy.axd)
  > NB: You may have to change the domain (MYSERVER) to a domain name your machine can resolve (e.g. myserver.mycompany.co.uk or 192.168.10.12)
- In the "Site/application" enter the site name from the IIS server
- Under "Credentials", add the username and password for logging on to the server
- You may well need to tick "Allow untrusted certificate", depending how your server is setup

Server: Enable backups
===

- Open IIS Manager
- Select Server (NOT website) -> Management -> Configuration Editor
- Section: system.webServer/wdeploy/backup
- Right column: "Unlock section"
- turnedOn -> True
- Enabled -> True
- Apply
