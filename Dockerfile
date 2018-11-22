FROM microsoft/dotnet:2.1-aspnetcore-runtime AS base
WORKDIR /app
EXPOSE 80

FROM microsoft/dotnet:2.1-sdk AS build
WORKDIR /src
COPY ["Docker-Api-Test2/Docker-Api-Test2.csproj", "Docker-Api-Test2/"]
RUN dotnet restore "Docker-Api-Test2/Docker-Api-Test2.csproj"
COPY . .
WORKDIR "/src/Docker-Api-Test2"
RUN dotnet build "Docker-Api-Test2.csproj" -c Release -o /app

FROM build AS publish
RUN dotnet publish "Docker-Api-Test2.csproj" -c Release -o /app

FROM base AS final
WORKDIR /app
COPY --from=publish /app .
ENTRYPOINT ["dotnet", "Docker-Api-Test2.dll"]