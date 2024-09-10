# Go base image
FROM golang:1.19

# Uygulama dizinine geç
WORKDIR /usr/src/app

# Go mod dosyalarını kopyala ve bağımlılıkları yükle
COPY go.mod ./
RUN go mod download

# Uygulama kodunu kopyala
COPY . .

# Go binary oluştur
RUN go build -o myapp

# Uygulamayı çalıştır
CMD ["./myapp"]

