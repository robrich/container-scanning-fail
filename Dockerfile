FROM microsoft/dotnet:2.2-sdk-alpine

WORKDIR /src

RUN apk update && apk add curl nodejs nodejs-npm

RUN npm init -y && npm install jquery@1.5.1 @toast-ui/editor@2.0.0 serve@0.0.1

COPY ./ContainerScanning.csproj .
RUN dotnet restore

COPY . .
RUN dotnet build -c Release
RUN dotnet publish -c Release -o /dist

WORKDIR /dist
ENV ASPNETCORE_ENVIRONMENT Production
ENV ASPNETCORE_URLS http://+:80
EXPOSE 22 80

CMD ["dotnet", "ContainerScanning.dll"]
