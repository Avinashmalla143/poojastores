# Build stage
FROM mcr.microsoft.com/dotnet/core/sdk:3.1 as build
MAINTAINER "AVINASH"
WORKDIR /core

# Copy the project file and restore dependencies
COPY PoojaStores.csproj ./
RUN dotnet restore

# Copy and publish the app and libraries
COPY . ./
RUN dotnet publish -c release -o /app 

# Final stage/image
FROM mcr.microsoft.com/dotnet/core/aspnet:3.1
WORKDIR /app
COPY --from=build /app .
ENTRYPOINT ["dotnet", "PoojaStores.dll"]
