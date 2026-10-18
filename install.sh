#!/data/data/com.termux/files/usr/bin/bash
# ================================================================
# Trình Cài Đặt Tự Động Roblox Auto Rejoin Pro Cho Cloudphone & Termux
# Cách chạy: bash install.sh
# ================================================================

set -euo pipefail

printf '\033[1;36m'
printf '============================================================\n'
printf '       CÀI ĐẶT MÔI TRƯỜNG WAPE HUB - REJOIN TERMUX TOOL     \n'
printf '        (Tối ưu hóa cho CloudPhone & Termux Android)       \n'
printf '============================================================\n'
printf '\033[0m'

printf '\n\033[1;33m[1/4] Yêu cầu cấp quyền bộ nhớ thiết bị Android...\033[0m\n'
termux-setup-storage || true

printf '\n\033[1;33m[2/4] Cập nhật danh sách gói Termux...\033[0m\n'
pkg update -y
pkg upgrade -y

printf '\n\033[1;33m[3/4] Cài đặt các gói phụ thuộc (Lua5.3, Curl, Git, Sqlite, Android-Tools)...\033[0m\n'
pkg install -y lua53 curl git android-tools sqlite

printf '\n\033[1;33m[4/4] Khởi tạo lệnh tắt toàn cục "rejoin" & Thiết lập liên kết Root...\033[0m\n'
BIN_DIR="/data/data/com.termux/files/usr/bin"
SCRIPT_DIR="$(pwd)"

# Thiết lập liên kết đến su của giả lập (MuMu, LDPlayer) nếu Termux chưa nhận
if [ ! -f "$BIN_DIR/su" ]; then
    if [ -f "/system/xbin/su" ]; then
        ln -sf "/system/xbin/su" "$BIN_DIR/su" 2>/dev/null || true
    elif [ -f "/system/bin/su" ]; then
        ln -sf "/system/bin/su" "$BIN_DIR/su" 2>/dev/null || true
    fi
fi

cat << 'EOF' > "$BIN_DIR/rejoin"
#!/bin/sh
SCRIPT_PATH="__REPLACE_DIR__"
cd "$SCRIPT_PATH" && lua5.3 roblox-auto-rejoin.lua "$@"
EOF

# Thay thế đường dẫn thực tế của script
sed -i "s|__REPLACE_DIR__|$SCRIPT_DIR|g" "$BIN_DIR/rejoin"
chmod +x "$BIN_DIR/rejoin"

printf '\n\033[1;32m============================================================\n'
printf '  [✓] CÀI ĐẶT THÀNH CÔNG 100%%!\n'
printf '  Đã tạo lệnh tắt toàn cục: \033[1;33mrejoin\033[1;32m\n\n'
printf '  Từ bây giờ, ở bất kỳ thư mục nào trên Termux, bạn chỉ cần gõ:\n\n'
printf '      \033[1;35mrejoin\033[1;32m\n\n'
printf '  (hoặc gõ: lua5.3 roblox-auto-rejoin.lua)\n'
printf '============================================================\n\033[0m\n'
