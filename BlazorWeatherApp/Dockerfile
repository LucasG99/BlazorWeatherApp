FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src


# Caminho correto para o arquivo .csproj
COPY ["BlazorWeatherApp/BlazorWeatherApp/BlazorWeatherApp.csproj", "BlazorWeatherApp/BlazorWeatherApp/"]
RUN dotnet restore "BlazorWeatherApp/BlazorWeatherApp/BlazorWeatherApp.csproj"

# Copiar todo o projeto
COPY . .
WORKDIR "/src/BlazorWeatherApp/BlazorWeatherApp"
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