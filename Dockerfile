# escape=`

# microsoft/windowsservercore:10.0.14393.1593

# Use the latest Windows Server Core image with .NET Framework 4.8.
FROM mcr.microsoft.com/dotnet/framework/sdk:4.8-windowsservercore-ltsc2019

USER ContainerAdministrator

SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue'; $env:chocolateyUseWindowsCompression = 'true';"]

RUN Set-ExecutionPolicy Bypass -Scope Process -Force; 

RUN New-Item $env:ALLUSERSPROFILE\choco-cache -ItemType Directory -Force

RUN iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

SHELL ["cmd", "/S", "/C"]

RUN choco feature enable -n allowGlobalConfirmation

RUN cinst windows-sdk-10.1
RUN cinst chocolatey-windowsupdate.extension
RUN cinst chocolatey-visualstudio.extension
RUN cinst chocolatey-dotnetfx.extension

RUN cinst -y visualstudio2017buildtools

RUN cinst -y netfx-4.7.2-devpack

RUN cinst -y visualstudio2017-workload-universal

RUN cinst -y visualstudio2017-workload-manageddesktop

RUN cinst -y visualstudio2017-workload-netcorebuildtools

RUN cinst -y visualstudio2017-workload-universalbuildtools

RUN cinst nodejs-lts
RUN cinst -y git

RUN refreshenv

WORKDIR /code