#See https://aka.ms/customizecontainer to learn how to customize your debug container and how Visual Studio uses this Dockerfile to build your images for faster debugging.

FROM mcr.microsoft.com/dotnet/runtime:7.0 AS base
WORKDIR /app

FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build
WORKDIR /src
COPY ["src/Demo.Identity.RegisterApiResource/Demo.Identity.RegisterApiResource.csproj", "src/Demo.Identity.RegisterApiResource/"]
RUN dotnet restore "src/Demo.Identity.RegisterApiResource/Demo.Identity.RegisterApiResource.csproj"
COPY . .
WORKDIR "/src/src/Demo.Identity.RegisterApiResource"
RUN dotnet build "Demo.Identity.RegisterApiResource.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "Demo.Identity.RegisterApiResource.csproj" -c Release -o /app/publish /p:UseAppHost=false

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "Demo.Identity.RegisterApiResource.dll"]