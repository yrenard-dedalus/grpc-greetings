FROM mcr.microsoft.com/dotnet/core/sdk:3.0-buster AS build
WORKDIR /src
COPY GrpcGreeterClient/GrpcGreeterClient.csproj ./
RUN dotnet restore "GrpcGreeterClient.csproj"
COPY GrpcGreeterClient/* .
RUN dotnet build "GrpcGreeterClient.csproj" -c Release -o /app/build
RUN dotnet publish "GrpcGreeterClient.csproj" -c Release -o /app/publish

FROM mcr.microsoft.com/dotnet/core/aspnet:3.0-buster-slim AS final
WORKDIR /app
COPY --from=build /app/publish .
ENTRYPOINT ["dotnet", "GrpcGreeterClient.dll"]