#!/bin/bash

# Renkli mesajlar için değişkenler
PURPLE='\033[0;35m'
NC='\033[0m' # Renk yok

# Java sürüm değişkeni
JAVA_PACKAGE="openjdk-17-jdk"
JENKINS_URL="https://pkg.jenkins.io"

# Scriptin root olarak çalışıp çalışmadığını kontrol et
if [[ "$(id -u)" != "0" ]]; then
    echo -e "${PURPLE}Bu script root olarak çalıştırılmalıdır.${NC}"
    exit 1
fi

# Gerekli paketleri kur
echo -e "${PURPLE}Gerekli paketleri kuruyor...${NC}"
sudo apt update
sudo apt install -y software-properties-common curl gnupg2
sudo apt install -y $JAVA_PACKAGE maven git

# Jenkins GPG anahtarını indir
echo -e "${PURPLE}Jenkins GPG anahtarını indiriyor...${NC}"
curl -fsSL "${JENKINS_URL}/debian-stable/jenkins.io.key" | gpg --dearmor | sudo tee /usr/share/keyrings/jenkins-archive-keyring.gpg > /dev/null

# Jenkins deposunu ekle
echo -e "${PURPLE}Jenkins deposunu ekliyor...${NC}"
echo "deb [signed-by=/usr/share/keyrings/jenkins-archive-keyring.gpg] ${JENKINS_URL}/debian-stable binary/" | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null

# Paket dizinini güncelle
echo -e "${PURPLE}Paket dizinini güncelliyor...${NC}"
sudo apt update

# Jenkins'i kur
echo -e "${PURPLE}Jenkins'i kuruyor...${NC}"
sudo apt install -y jenkins

# Jenkins servisini başlat
echo -e "${PURPLE}Jenkins servisini başlatıyor...${NC}"
sudo systemctl start jenkins

# Başlangıç admin parolasını al
INITIAL_PASSWORD=$(sudo cat /var/lib/jenkins/secrets/initialAdminPassword)

# Giriş bilgilerini göster
clear
cat << EOF
===============================
Jenkins Kurulumu Tamamlandı!
===============================

Jenkins Dashboard'a erişmek için:

    http://$(curl -s ifconfig.me):8080

Giriş bilgileri:

Parola: ${INITIAL_PASSWORD}

EOF
