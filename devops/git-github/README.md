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
## Değişiklikleri ekleyin ve commit yapın.ve push edin
```bash 
git add yeni_dosya.txt
git commit -m "Yeni branch'ta yeni dosya eklendi"
git push origin yeni-branch
```
## Ana branch'tan yeni değişiklikleri çekin.

```bash 
git checkout main
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
*****************************************
# Git Global Kullanıcı Bilgilerini Ayarlama
## Git Kullanıcı Adı ve E-posta Bilgilerini Ayarlama
İlk olarak, Git'e kim olduğunuzu tanıtmanız gerekir. Bu bilgi, Git commit'lerine yansır ve her commit'te görünen e-posta adresinizi ve kullanıcı adınızı belirtir.

Kullanıcı adı ayarlamak:

```bash
git config --global user.name "Adınız Soyadınız"
```
Buradaki "Adınız Soyadınız" kısmına, GitHub kullanıcı adınızı veya kendi isminizi yazabilirsiniz. Bu bilgi, commit'lerde yer alacak "author" (yazar) bilgisini içerir.

E-posta adresini ayarlamak:

```bash
git config --global user.email "you@example.com"
```
"you@example.com" kısmına GitHub hesabınızla ilişkilendirilmiş e-posta adresinizi yazın. Bu, commit'lerde yer alacak e-posta bilgisi olacaktır.

Global Ayarları Kontrol Etme
Global olarak ayarladığınız kullanıcı adı ve e-posta bilgilerini doğrulamak için şu komutu kullanabilirsiniz:

```bash
git config --global --list
```
Bu komut, Git'e daha önce girdiğiniz global ayarların bir listesini verir. Örneğin:
user.name=Adınız Soyadınız
user.email=you@example.com

## Git Global Ayarlarının Anlamı
Global Ayarlar: Bu ayarlar, bilgisayarınızdaki tüm Git repository'leri için geçerlidir. Yani, bu ayarlar bir kez yapıldığında, her Git projesinde bu bilgiler kullanılacaktır.

Yerel (Local) Ayarlar: Her Git repository'si için farklı kullanıcı adı veya e-posta ayarları yapabilirsiniz. Örneğin, iş projeleri ve kişisel projelerde farklı e-posta adresleri kullanmak istiyorsanız, belirli bir repository için yerel ayarlar yapabilirsiniz. Yerel ayarları yapmak için şu komutu kullanabilirsiniz:

```bash
git config user.name "Yerel Ad"
git config user.email "yerel@example.com"
```
Bu komutlar, sadece içinde bulunduğunuz repository için geçerli olur.
# Git Credential Helper Kullanma
Git, kimlik bilgilerinizi kaydedebilir. Bu, kullanıcı adı ve şifre sorulmasını önler. Aşağıdaki komutları terminalde çalıştırarak bunu ayarlayabilirsiniz:

```bash 
git config --global credential.helper cache
```
Bu komut, kimlik bilgilerinizi bir süre (genellikle 15 dakika) önbelleğe alır.

Eğer kalıcı olarak saklamak isterseniz, şu komutu kullanabilirsiniz:

```bash 
git config --global credential.helper store
```
Bu, kimlik bilgilerinizi düz metin dosyasında saklar, bu yüzden dikkatli olmalısınız.

## SSH Anahtarları Kullanma
SSH ile GitHub'a bağlanmak, her seferinde kullanıcı adı ve şifre girmenizi engeller. Aşağıdaki adımları izleyerek SSH anahtarı oluşturabilirsiniz:

## SSH anahtarınızı oluşturun (eğer yoksa):

ssh-keygen -t rsa -b 4096 -C "you@example.com"
## Oluşturulan anahtarı ekleyin:
```bash 
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_rsa
```
## SSH anahtarını kopyalayın:
```bash 
cat ~/.ssh/id_rsa.pub
```
## GitHub hesabınıza gidin, "Settings" > "SSH and GPG keys" kısmına gelin ve yeni bir SSH anahtarı ekleyin. Kopyaladığınız anahtar burada olacak.

# Repository'yi SSH ile klonlayın:

```bash 
git clone git@github.com:kullaniciadi/repo-adi.git
```
# GitHub Personal Access Token (PAT) Kullanma
Eğer iki faktörlü kimlik doğrulama (2FA) kullanıyorsanız, şifre yerine kişisel erişim belirteci (PAT) kullanmalısınız. Bunu oluşturmak için:

## GitHub hesabınıza gidin ve "Settings" > "Developer settings" > "Personal access tokens" kısmına gidin.

## Yeni bir token oluşturun ve gerekli izinleri ayarlayın.

## Token'ı bir şifre yerine kullanarak Git işlemlerinizi gerçekleştirin.

Bu yöntemlerden birini uygulayarak, her seferinde kullanıcı adı ve şifre sorma sorununu çözebilirsiniz.

***********************************
# Kayıtlı SSH Anahtarlarını Temizleme (Eğer SSH Kullanılıyorsa)
GitHub erişimi için SSH anahtarları kullanıyorsanız, sunucuda kayıtlı SSH anahtarlarını temizlemek gerekebilir.

SSH anahtarlarını kontrol etmek için:

```bash 
cat ~/.ssh/id_rsa.pub
``` 
Eğer bir SSH anahtarı varsa ve bu anahtarı silmek isterseniz, ~/.ssh/ dizinindeki dosyaları silebilirsiniz:

```bash 
rm ~/.ssh/id_rsa*
```
Bu komut, id_rsa ve id_rsa.pub dosyalarını siler.

#  Kayıtlı GitHub Kimlik Bilgilerini (HTTP Basic Auth) Temizleme
Git, HTTPS üzerinden her oturum açışınızda GitHub kimlik bilgilerinizi kaydedebilir. Eğer bu bilgileri git credential helper ile kaydettiyseniz, şunları yapabilirsiniz:

Kayıtlı Kimlik Bilgilerini Temizleme (Cache'den):
```bash 
git credential-cache exit
```
Kayıtlı Kimlik Bilgilerini (Credential Store) Temizleme: Eğer kimlik bilgileri disk üzerinde saklanıyorsa, ilgili dosyayı temizleyin. Kayıtlı kimlik bilgilerini görmek için:
```bash
git config --global credential.helper
```
Eğer store kullanılıyorsa, kimlik bilgilerinin saklandığı dosya genellikle ~/.git-credentials dosyasında olur. Bu dosyayı temizleyin veya tamamen silin:
```bash 
rm ~/.git-credentials
```
# Global Git Kullanıcı Bilgilerini Temizleme
Git kullanıcı adı ve e-posta bilgileri de git config ayarlarında kayıtlı olabilir. Bu bilgileri temizlemek için:

Global Kullanıcı Bilgilerini Silme:

```bash 
git config --global --unset user.name
git config --global --unset user.email
```
Eğer bu bilgilerin silinip silinmediğini kontrol etmek isterseniz:
```bash 
git config --global --list
```


# Credential Helper'ı Devre Dışı Bırakmak
Eğer kimlik bilgileri hiç kaydedilmesin istiyorsanız, credential helper'ı tamamen devre dışı bırakabilirsiniz:
```bash
git config --global --unset credential.helper
```
Bu komut, credential.helper ayarını global düzeyde kaldırır, böylece Git her seferinde kullanıcı adı ve şifre sorar.
## Cache'deki Kimlik Bilgilerini Hemen Silmek
Eğer kimlik bilgilerini hemen silmek istiyorsanız, Git'in cache belleğini temizleyebilirsiniz:
```bash
git credential-cache exit
```
Bu komut, mevcut tüm kimlik bilgilerini bellekte temizler, bir sonraki işlemde tekrar şifre ve kullanıcı adı girmeniz gerekir.

