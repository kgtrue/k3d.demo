#See https://aka.ms/customizecontainer to learn how to customize your debug container and how Visual Studio uses this Dockerfile to build your images for faster debugging.

FROM mcr.microsoft.com/dotnet/runtime:7.0 AS base
WORKDIR /app

FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build
WORKDIR /src
COPY ["src/Demo.Identity.RegisterAppResource/Demo.Identity.RegisterAppResource.csproj", "src/Demo.Identity.RegisterAppResource/"]
RUN dotnet restore "src/Demo.Identity.RegisterAppResource/Demo.Identity.RegisterAppResource.csproj"
COPY . .
WORKDIR "/src/src/Demo.Identity.RegisterAppResource"
RUN dotnet build "Demo.Identity.RegisterAppResource.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "Demo.Identity.RegisterAppResource.csproj" -c Release -o /app/publish /p:UseAppHost=false

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "Demo.Identity.RegisterAppResource.dll"]