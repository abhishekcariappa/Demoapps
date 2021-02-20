FROM mcr.microsoft.com/dotnet/aspnet:5.0 AS base
WORKDIR /app
EXPOSE 80

FROM mcr.microsoft.com/dotnet/sdk:5.0 AS build
WORKDIR /src
COPY ["ACwebapi.csproj", "./"]
RUN dotnet restore "ACwebapi.csproj"
COPY . .
WORKDIR "/src/."
RUN dotnet build "ACwebapi.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "ACwebapi.csproj" -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "ACwebapi.dll"]
