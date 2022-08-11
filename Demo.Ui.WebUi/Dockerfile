#See https://aka.ms/containerfastmode to understand how Visual Studio uses this Dockerfile to build your images for faster debugging.

FROM mcr.microsoft.com/dotnet/aspnet:6.0 AS base
WORKDIR /app
EXPOSE 80
EXPOSE 443

FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /src
COPY ["Demo.Ui.WebUi/Demo.Ui.WebUi.fsproj", "Demo.Ui.WebUi/"]
RUN dotnet restore "Demo.Ui.WebUi/Demo.Ui.WebUi.fsproj"
COPY . .
WORKDIR "/src/Demo.Ui.WebUi"
RUN dotnet build "Demo.Ui.WebUi.fsproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "Demo.Ui.WebUi.fsproj" -c Release -o /app/publish /p:UseAppHost=false

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "Demo.Ui.WebUi.dll"]