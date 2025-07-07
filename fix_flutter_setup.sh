#!/bin/bash

# Khắc phục lỗi flutter_tester không tìm thấy

# Xác định đường dẫn flutter
FLUTTER_PATH="$HOME/flutter"

echo "Đang kiểm tra cài đặt Flutter..."

# Kiểm tra xem thư mục flutter tồn tại
if [ ! -d "$FLUTTER_PATH" ]; then
  echo "Không tìm thấy thư mục Flutter tại $FLUTTER_PATH"
  exit 1
fi

# Khôi phục cache
echo "Đang khôi phục cache Flutter..."
"$FLUTTER_PATH/bin/flutter" precache

# Chạy doctor để kiểm tra
echo "Đang chạy Flutter doctor để kiểm tra cài đặt..."
"$FLUTTER_PATH/bin/flutter" doctor -v

# Hướng dẫn thêm
echo "\nNếu vẫn gặp lỗi, hãy thử các bước sau:\n"
echo "1. Chạy 'flutter clean' để xóa bộ nhớ cache hiện tại"
echo "2. Chạy 'flutter pub get' để tải lại các gói"
echo "3. Đảm bảo tên gói trong pubspec.yaml khớp với tên được sử dụng trong mã nguồn"
echo "4. Cập nhật Flutter lên phiên bản mới nhất với 'flutter upgrade'"

echo "\nHoàn thành!"
