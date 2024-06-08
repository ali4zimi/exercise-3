FROM golang:1.22

WORKDIR /app

ENV DATABASE_URI=${DATABASE_URI}

COPY go.mod go.sum ./

COPY . .

RUN go mod tidy

RUN go build -o main ./cmd/main.go

EXPOSE 8080

CMD ["/app/main"]



