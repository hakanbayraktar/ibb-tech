# Yeni Repository Oluşturma
## GitHub'da yeni bir repository oluşturun.

GitHub hesabınıza giriş yapın.
Sağ üstteki "+" simgesine tıklayın ve "New repository" seçeneğini seçin.
Repository adını ve açıklamasını girin, "Create repository" butonuna tıklayın.
## Yerel makinenizde repository'yi oluşturun.

```bash 
mkdir yeni-repo
cd yeni-repo
git init
``` 
# Remote bağlantıyı ekleyin.
```bash 
git remote add origin https://github.com/kullaniciadi/yeni-repo.git
```
# Ana Branch Oluşturup Projeyi GitHub'a Gönderme
## Ana branch'ta bir dosya oluşturun.

```bash 
echo "# Projem" > README.md
``` 
## Değişiklikleri ekleyin ve commit yapın.

```bash 
git add README.md
git commit -m "İlk commit: README dosyası eklendi"
```
## Ana branch'ı GitHub'a gönderin.
```bash 
git push -u origin main
```
# Alt Branch Aç ve Ana Branch'tan Klonla
## Ana branch'tan yeni bir branch oluşturun ve bu branch'a geçin.
```bash 
git checkout -b yeni-branch
```
# Yeni Branch'ta Eklemeler Yap ve Ana Branch ile Eşitle
## Yeni branch'ta bir dosya oluşturun.

```bash 
echo "Bu yeni branch'taki değişiklikler." > yeni_dosya.txt
```
## Değişiklikleri ekleyin ve commit yapın.
```bash 
git add yeni_dosya.txt
git commit -m "Yeni branch'ta yeni dosya eklendi"
```
## Ana branch'tan yeni değişiklikleri çekin.

```bash 
gigit checkout main
git pull origin main
```
## Yeni branch ile ana branch'ı birleştirin.
```bash 
git checkout yeni-branch
git merge main
```
# Çatışmaları Yönetme ve Merge Etme
## Ana branch'ta başka biri değişiklik yapmış olsun. Ana branch'a geçin ve değişiklikleri çekin.
```bash 
git checkout main
git pull origin main
```
## Yeni branch'a geri dönün ve değişiklik yapın.
```bash 
git checkout yeni-branch
echo "Yeni değişiklik yapıldı." >> yeni_dosya.txt
git add yeni_dosya.txt
git commit -m "Yeni branch'ta değişiklik yapıldı"
```
## Ana branch ile yeni branch'ı birleştirin.
```bash 
git checkout main
git merge yeni-branch
```
## Çatışmalar varsa çözün.

Çatışma olan dosyayı açın, işaretleri çözün ve kaydedin.
Çatışma çözümlemesini tamamladıktan sonra, dosyayı ekleyin ve commit 

```bash 
git add yeni_dosya.txt
git commit -m "Çatışma çözüldü ve birleştirildi"
```
## Değişiklikleri GitHub'a gönderin.
```bash 
git push origin main
```