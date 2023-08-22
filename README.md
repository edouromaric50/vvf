# testproject

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

========================================================================================

#le keystore 

What is the two-letter country code for this unit?
  [Unknown]:
Is CN=Romaric, OU=Dev90, O=Dev9, L=Benin, ST=Benin, C=Unknown correct?
  [no]:  yes

Generating 2?048 bit RSA key pair and self-signed certificate (SHA256withRSA) with a validity of 10?000 days
        for: CN=Romaric, OU=Dev90, O=Dev9, L=Benin, ST=Benin, C=Unknown
[Storing mon_keystore.keystore]

==============================================================================================


*Le certificat de signature de débogage SHA-1 est utilisé pour signer les applications Android lors du développement et du débogage. Il s'agit d'un certificat généré automatiquement par le Kit de développement logiciel Android (SDK) lorsque vous créez un projet Android dans votre environnement de développement.*

Voici comment obtenir le certificat de signature de débogage SHA-1 :

1. **Ouvrez un terminal :** Lancez un terminal sur votre système.

2. **Accédez au répertoire de la clé de signature :** Par défaut, la clé de signature de débogage est stockée dans le répertoire `.android` dans votre dossier utilisateur. Utilisez la commande suivante pour accéder à ce répertoire :

   ```bash
   cd ~/.android
   ```

3. **Listez les fichiers :** Utilisez la commande suivante pour lister les fichiers dans le répertoire `.android` :

   ```bash
   ls
   ```

   Vous devriez voir un fichier nommé "debug.keystore".

4. **Obtenez le certificat SHA-1 :** Utilisez la commande suivante pour obtenir le certificat SHA-1 à partir du fichier de clé de débogage :

   ```bash
   keytool -list -v -keystore debug.keystore -alias androiddebugkey -storepass android -keypass android
   ```

   - `-list` indique que vous souhaitez afficher les informations de la clé.
   - `-v` affiche des informations détaillées.
   - `-keystore debug.keystore` spécifie le nom du fichier de la clé de débogage.
   - `-alias androiddebugkey` est l'alias de la clé de déb
============================================

Alias name: androiddebugkey
Creation date: 7 août 2023
Entry type: PrivateKeyEntry
Certificate chain length: 1
Certificate[1]:
Owner: C=US, O=Android, CN=Android Debug
Issuer: C=US, O=Android, CN=Android Debug
Serial number: 1
Valid from: Mon Aug 07 16:00:25 WAT 2023 until: Wed Jul 30 16:00:25 WAT 2053
Certificate fingerprints:
         SHA1: 54:8B:4D:F5:0B:77:79:EC:87:38:14:37:A6:41:63:0C:42:8C:A0:5D
         SHA256: A2:D5:87:20:27:66:20:C9:DE:65:60:1A:73:47:88:CA:50:99:37:6C:F1:D1:A1:BE:65:03:74:A2:6B:1C:1D:01
Signature algorithm name: SHA1withRSA (weak)
Subject Public Key Algorithm: 2048-bit RSA key
Version: 1

Warning:
The certificate uses the SHA1withRSA signature algorithm which is considered a security risk. This algorithm will be disabled in a future update.
The JKS keystore uses a proprietary format. It is recommended to migrate to PKCS12 which is an industry standard format using "keytool -importkeystore -srckeystore debug.keystore -destkeystore debug.keystore -deststoretype pkcs12".