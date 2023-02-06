#See https://aka.ms/containerfastmode to understand how Visual Studio uses this Dockerfile to build your images for faster debugging.

FROM mcr.microsoft.com/dotnet/aspnet:6.0 AS base
WORKDIR /app
EXPOSE 80
EXPOSE 443
ENV COMPlus_EnableDiagnostics=0

FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /src
COPY ["src/Demo.Api.First/Demo.Api.First.csproj", "src/Demo.Api.First/"]
RUN dotnet restore "src/Demo.Api.First/Demo.Api.First.csproj"
COPY . .
WORKDIR "/src/src/Demo.Api.First"
RUN dotnet build "Demo.Api.First.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "Demo.Api.First.csproj" -c Release -o /app/publish /p:UseAppHost=false

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "Demo.Api.First.dll"]