# 🔹 Etapa 1: Build de la aplicación
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /app

# Copiar archivos de proyecto y restaurar dependencias
COPY Tailspin.SpaceGame.Web/*.csproj ./Tailspin.SpaceGame.Web/
RUN dotnet restore Tailspin.SpaceGame.Web/Tailspin.SpaceGame.Web.csproj

# Copiar el código fuente y compilar en modo Release
COPY . .
WORKDIR /app/Tailspin.SpaceGame.Web
RUN dotnet publish -c Release -o /out

# 🔹 Etapa 2: Imagen final con runtime
FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /app

# Copiar la aplicación compilada desde la etapa anterior
COPY --from=build /out ./

# Exponer el puerto en el que corre la aplicación
EXPOSE 8080

# Comando para ejecutar la aplicación
ENTRYPOINT ["dotnet", "Tailspin.SpaceGame.Web.dll"]
