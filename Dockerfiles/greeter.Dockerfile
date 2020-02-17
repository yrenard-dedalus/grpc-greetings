FROM mcr.microsoft.com/dotnet/core/sdk:3.0-buster AS build
WORKDIR /src
COPY GrpcGreeter/GrpcGreeter.csproj ./
RUN dotnet restore "GrpcGreeter.csproj"
COPY GrpcGreeter/* .
RUN dotnet build "GrpcGreeter.csproj" -c Release -o /app/build
RUN dotnet publish "GrpcGreeter.csproj" -c Release -o /app/publish

FROM mcr.microsoft.com/dotnet/core/aspnet:3.0-buster-slim AS final
WORKDIR /app
COPY --from=build /app/publish .
ENTRYPOINT ["dotnet", "GrpcGreeter.dll"]