# EuroPay automation testing fixtures

[[_TOC_]]

## Install

- install WSL 2 - [Microsoft guide](https://learn.microsoft.com/en-us/windows/wsl/install-manual) + [Docker guide](https://docs.docker.com/desktop/wsl/)
    - Open PowerShell as Administrator (Start menu > PowerShell > right-click > Run as Administrator)
    - `dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart`
    - wait to restart
    - `dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart`
    - restart
    - Open PowerShell as Administrator (Start menu > PowerShell > right-click > Run as Administrator)
    - `wsl --set-default-version 2`
    - `wsl --install -d Ubuntu`
    - `wsl --set-version Ubuntu 2` (for safety)

- install Docker Desktop
    - (download)[https://www.docker.com/products/docker-desktop/] and install Docker Desktop

    - Settings > Resources > WSL Integration -> select WSL 2

- install ODBC v17
    - from (here)[https://learn.microsoft.com/en-us/sql/connect/odbc/download-odbc-driver-for-sql-server?view=sql-server-ver16#version-17]