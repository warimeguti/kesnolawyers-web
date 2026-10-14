# Kesno Lawyers website

Static website for https://kesnolawyers.com, hosted on Namecheap.

## Source

Imported from the contents of the v6-3 folder in the user-supplied v7-1.zip, with the enclosing folder removed. Warime authorised all website content and photos for GitHub and automatic deployment on 14 October 2026. Original website files are preserved byte-for-byte. No other version archive is used.

## Automatic deployment

GitHub Actions deploys changes to main that affect HTML pages, css, js, images, deployment scripts or workflow configuration. Manual Run workflow is also supported. cPanel Git Version Control is not required.

In repository Settings > Secrets and variables > Actions, configure:

- Secret NAMECHEAP_SSH_KEY: the full dedicated private deployment key, pasted directly by the owner. Never commit it.
- Secret NAMECHEAP_KNOWN_HOSTS: the previously accepted SSH host-key record from the owner's local known_hosts file.
- Variable NAMECHEAP_HOST: the hosting server address.
- Variable NAMECHEAP_USER: the cPanel account username.

Namecheap shared-hosting SSH uses port 21098. The server script uses the connected account's public_html directory. Server addresses, account names and host-key records stay in repository settings.

The dedicated public key is authorised with the restrict option, preventing interactive terminal allocation and forwarding. Key login was confirmed by the owner. Git and rsync were found on the host. The workflow validates local links, stages only six HTML pages and their css/js/images folders, backs up the complete document root outside the public directory, then copies the website with rsync without deletion. Existing hosting rules and unrelated files are preserved. No documentation, workflow files, ZIP archives or secrets are deployed.

Backups accumulate in ~/kesno-backups; monitor disk usage. Staged releases are in ~/kesno-deploy. Copies happen in place and are not atomic. Existing extra assets remain. After copying, all six live HTML responses are compared with the repository. An HTTP verification failure can occur after files are already live: review the log before retrying or rolling back.

## Rollback

Using personal SSH access, inspect ~/kesno-backups and choose the desired backup. Restore that selected archive into ~/public_html. Restoration overwrites backed-up files but does not remove newly introduced files. Do not delete the document root. Each successful server copy records its release identifier in ~/kesno-deploy/last-successful-copy; HTTP verification runs separately.

## External services

Google Fonts, embedded Google Maps and the existing FormSubmit enquiry integration are preserved. No enquiry was sent during setup. DNS and Google Workspace mail settings are outside this deployment workflow.

## Status

Automatic deployment verified on 15 October 2026 (Papua New Guinea time). Run 38576050082, attempt 3, succeeded: site validation, SSH configuration, full pre-deployment backup, server copy, and byte-for-byte HTTP verification of all six HTML pages. First deployed site commit: accca2fc6ec37966e14d23b1d8d24287d5b4a743. Future main-branch changes to website files or deployment code trigger the same workflow. README-only edits do not deploy. Contact-form submission was not tested.
