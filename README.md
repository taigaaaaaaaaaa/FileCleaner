# very strong tuyotuyo 

名前は気にしないでください。名前のわりに使えます。いい名前が思いつかなかったんです。
Windows の不要ファイル・キャッシュ・古い更新データを安全に削除し、  
システムを軽量化するためのバッチスクリプトです。  
Chrome / Edge / Discord のキャッシュにも対応し、  
Windows Update の残骸やログファイルもまとめて掃除します。
自分用に作ったのでアプリは限定的です。

---

## ✨ 主な機能

- 管理者権限の自動昇格  
- Chrome / Edge / Discord のプロセス強制終了  
- Temp フォルダ（ユーザー / Windows）の削除  
- Windows Update のキャッシュ削除  
  - SoftwareDistribution\Download  
  - DeliveryOptimization  
- Installer フォルダの安全な掃除（tmp / bak のみ）  
- AppData 深層キャッシュ削除  
  - INetCache  
  - Chrome（Cache / Code Cache / GPUCache）  
  - Edge（Cache / Code Cache / GPUCache）  
  - Discord（Cache / Code Cache / GPUCache）  
- Windows ログファイル削除  
- WinSxS のコンポーネントクリーンアップ（/resetbase）  
- 容量を GB 単位で表示

---

## 🖥 対応アプリ,ファイル（自分用なので限定的です）

- Google Chrome  
- Microsoft Edge  
- Discord  
- Windows Update  
- Windows Temp / Logs  
- WinSxS（DISM）

---

## 📌 動作環境

- Windows 10 / Windows 11  
- 管理者権限が必要  
- バッチファイルは **Shift-JIS（ANSI）で保存推奨**  
  - UTF-8 だと日本語が文字化けします

---

## 🚀 使い方

1. `very strong tuyotuyo.bat` を Shift-JIS で保存  
2. 右クリック → **管理者として実行**  
3. 完了後、空き容量が GB 単位で表示されます

---

## ⚠ 注意事項

- WinSxS の `/resetbase` を使用しているため、  
  **古い Windows 更新プログラムをアンインストールできなくなります。**
- 実行中は Chrome / Edge / Discord が強制終了されます。
- システムファイルは削除していませんが、  
  Windows Update のキャッシュ削除は環境によって時間がかかる場合があります。

---

## 📄 ライセンス

個人利用・改変自由。  
再配布する場合は作者名を残してください。

---

## 👤 Author

**code by *たいが*
