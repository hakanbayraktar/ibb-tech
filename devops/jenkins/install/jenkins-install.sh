#!/bin/bash

# Renkli mesajlar için değişkenler
PURPLE='\033[0;35m'
NC='\033[0m' # Renk yok

# Paket dizinini güncelle ve gerekli paketleri kur
echo -e "${PURPLE}Paket dizini güncelleniyor ve gerekli paketler kuruluyor...${NC}"
sudo apt update
sudo apt install -y openjdk-11-jdk maven

# Jenkins depo anahtarını indir
echo -e "${PURPLE}Jenkins depo anahtarı indiriliyor...${NC}"
sudo wget -O /usr/share/keyrings/jenkins-keyring.asc \
  https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key

# Jenkins deposunu ekle
echo -e "${PURPLE}Jenkins deposu ekleniyor...${NC}"
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
  https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null

# Paket dizinini tekrar güncelle
echo -e "${PURPLE}Paket dizini güncelleniyor...${NC}"
sudo apt update

# Jenkins'i kur
echo -e "${PURPLE}Jenkins kuruluyor...${NC}"
sudo apt install -y jenkins

# Jenkins servisini başlat
echo -e "${PURPLE}Jenkins servisi başlatılıyor...${NC}"
sudo systemctl start jenkins

# Servisin başlaması için bekle
sleep 10

# Başlangıç admin parolasını al
if [ -f /var/lib/jenkins/secrets/initialAdminPassword ]; then
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
else
    echo -e "${PURPLE}initialAdminPassword dosyası bulunamadı. Jenkins düzgün bir şekilde başlatılmamış olabilir.${NC}"
fi

