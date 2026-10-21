# Architecture Diagram — Azure Static Web App + Key Vault

## Lucid diagram

- **Master Lucid document (all 30 diagrams, icon style):** https://lucid.app/lucidchart/3da75ce3-ea66-4296-81b3-00d20a60435b/edit
- This project is **page 17** of that document.

## Lucid prompt (reusable)

```
Create an Azure architecture diagram titled "Azure Static Web App + Key Vault".
A User connects over HTTPS to an Azure Static Web App (global CDN). The app reads a
secret (app-api-key) from Azure Key Vault using RBAC. Label the arrows. Clean,
professional Azure colors.
```

## Mermaid source

```mermaid
flowchart LR
    User([User])
    SWA[Azure Static Web App]
    KV[Azure Key Vault]
    Secret[app-api-key]
    User -->|HTTPS| SWA
    SWA -.reads secret.-> KV
    KV --> Secret
```
