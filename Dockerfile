FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src

# Copiar arquivos .csproj e restaurar dependências
COPY ["BlazorWeatherApp/BlazorWeatherApp.csproj", "BlazorWeatherApp/"]
RUN dotnet restore "BlazorWeatherApp/BlazorWeatherApp.csproj"

# Copiar todo o projeto e realizar o build
COPY . .
WORKDIR "/src/BlazorWeatherApp"
RUN dotnet build "BlazorWeatherApp.csproj" -c Release -o /app/build

# Publicar a aplicação
FROM build AS publish
RUN dotnet publish "BlazorWeatherApp.csproj" -c Release -o /app/publish

# Build da imagem final
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS final
WORKDIR /app
COPY --from=publish /app/publish .
EXPOSE 10000
ENV ASPNETCORE_URLS=http://+:10000
ENTRYPOINT ["dotnet", "BlazorWeatherApp.dll"]