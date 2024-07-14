#Responsável por constuir uma imagem do docker
FROM golang:1.22.4-alpine as builder
#Definindo diretorio de trabalho
WORKDIR /app
#Copiando informações
COPY go.mod go.sum ./
#Baixando as libs e preparando
RUN go mod download && go mod verify
#Copia da interface para o container
COPY . .
#Executando e buildando a aplicação
RUN go build -o /bin/journey ./cmd/journey/journey.go

FROM scratch
WORKDIR /app
#Copia do builder 
COPY --from=builder /bin/journey .

#Definindo a porta
EXPOSE 8080
#Ponto de entrada de execução do nosso container
ENTRYPOINT [ "./journey" ]