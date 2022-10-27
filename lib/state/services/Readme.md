## Workflow

- Ứng dụng có 2 hướng lưu trữ data
  - `Firebase`: Dùng để lưu trữ thông tin tài khoản, dữ liệu backup file khi đồng bộ lên clound
  - `sqflite`: Dùng để lưu trữ dữ liệu thông tin Task, Category,... ở file cục bộ
  - `shared_preferences`: Lưu trữ thông tin tài khoản (token, email, password) và các cài đặc cho app (theme, language,...)
