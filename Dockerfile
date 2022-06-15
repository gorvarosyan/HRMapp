# Build stage	
FROM mcr.microsoft.com/dotnet/sdk:6.0-focal AS build
WORKDIR /source
COPY . . 
RUN dotnet restore ".\HRM.API\HRM.API.csproj" --disable-parallel
RUN dotnet publish ".\HRM.API\HRM.API.csproj" -c release -o /app --no-restore

#Serve stage
FROM mcr.microsoft.com/dotnet/sdk:6.0-focal 
WORKDIR /app
COPY --from=build /app ./

EXPOSE 8012	

ENTRYPOINT ["dotnet", "HRM.API.dll"]
