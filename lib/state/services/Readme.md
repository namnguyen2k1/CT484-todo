## Workflow

- Ứng dụng có 3 nơi lưu trữ data

  - `Firebase`:

    - Dùng để lưu trữ thông tin tài khoản

  - `sqflite`: Dùng để lưu trữ dữ liệu thông tin Task, Category,... ở file cục bộ

    - Khi đồng bộ sẽ lưu dữ liệu lên Firebase

  - `shared_preferences`:
    - Lưu trữ thông tin tài khoản: token, email, password (Quick Login)
    - Thông tin các cài đặc của app: (theme, language,...)
