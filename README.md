# 🚀 ROBLOX AUTO REJOIN PRO v2.2.0 (CLOUDPHONE & TERMUX EDITION)

Công cụ menu tự động hóa chuyên nghiệp viết bằng **Lua 5.3** dành riêng cho **Cloudphone (UgPhone, LDCloud, Redfinger, VMOS...)** và **Termux Android**. Hỗ trợ tự động mở lại game khi văng (Anti-Crash), chống AFK 20 phút, nạp Cookie `.ROBLOSECURITY` trực tiếp vào app, chụp màn hình và gửi báo cáo phần cứng qua Discord Webhook.

---

## 🖥️ Giao Diện Dashboard Mới (v2.2.0)

Bảng điều khiển 2 cột đối xứng với thanh tiến trình trực quan:

```text
  ╭─────────────────────────────────────┬────────────────────────────────────╮
  │ 🎮 THÔNG TIN GAME & PHÒNG TREO      │ 👤 TÀI KHOẢN ROBLOX                │
  │  • Place ID : 1234567890            │  • Tên User: GamerProVN            │
  │  • Loại Phòng: [ SERVER VIP ]       │  • Số Dư   : 1,250 R$              │
  │  • Gói App  : com.roblox.client     │  • Cookie  : [ ĐÃ XÁC THỰC ✓ ]     │
  ├─────────────────────────────────────┼────────────────────────────────────┤
  │ 📱 CLOUDPHONE & PHẦN CỨNG           │ 🔔 HỆ THỐNG GIÁM SÁT & WEBHOOK     │
  │  • Tên Máy  : CloudPhone-01         │  • Webhook : [ ĐANG BẬT ● ]        │
  │  • Quyền Su : [ ROOT ACTIVE ✓ ]     │  • Chống AFK 20p: Mỗi 15p          │
  │  • Mức Pin  : [████████░░] 82% ⚡    │  • Quét Crash   : Mỗi 5s           │
  │  • Nhiệt Độ : 36.5°C [MÁT]          │  • Báo Cáo Định : Mỗi 30p          │
  │  • RAM Dùng : [█████░░░░░] 48%      │  • Thời Gian Chạy: 03h 45m         │
  ╰─────────────────────────────────────┴────────────────────────────────────╯
```

---

## 📦 CÁC CÁCH CÀI ĐẶT & KHỞI CHẠY TOOL

### 👉 Cách 1: Cài đặt tiêu chuẩn trên Cloudphone / Termux (Khuyên Dùng)

Mở ứng dụng Termux trên Cloudphone và chạy các lệnh sau:

```bash
# 1. Cài đặt git (nếu chưa có)
pkg install -y git

# 2. Tải mã nguồn về máy
git clone https://github.com/azka150104-hub/roblox-auto-rejoin.git

# 3. Vào thư mục và chạy cài đặt tự động
cd roblox-auto-rejoin
bash install.sh
```

---

### 👉 Cách 2: Khởi chạy siêu nhanh bằng lệnh tắt `rejoin`

Sau khi chạy xong `bash install.sh`, hệ thống đã tự động tạo một lệnh tắt toàn cục.  
Bất cứ khi nào mở Termux lên, bạn **chỉ cần gõ đúng 1 chữ**:

```bash
rejoin
```
*(Không cần phải mất công gõ `cd roblox-auto-rejoin` rồi `lua5.3 roblox-auto-rejoin.lua` nữa).*

---

### 👉 Cách 3: Treo ngầm 24/7 vĩnh viễn trên Cloudphone với `tmux`

Khi treo game trên Cloudphone (UgPhone, LDCloud...), nếu bạn thoát app ra ngoài hoặc tắt cửa sổ Termux, hệ điều hành Android đôi khi có thể tạm dừng (suspend) tiến trình. Để script chạy vĩnh viễn không bao giờ dừng:

1. **Cài đặt `tmux`:**
   ```bash
   pkg install -y tmux
   ```
2. **Tạo phiên treo ngầm:**
   ```bash
   tmux new -s auto
   ```
3. **Chạy tool bên trong tmux:**
   ```bash
   rejoin
   ```
4. **Bật chế độ giữ CPU (WakeLock):** Kéo thanh thông báo Cloudphone xuống $\rightarrow$ Chọn **Acquire WakeLock** của Termux.
5. Giờ bạn có thể yên tâm đóng cửa sổ Cloudphone, script sẽ chạy ngầm liên tục 24/7!
*(Muốn quay lại xem menu tmux: chỉ cần mở Termux gõ `tmux a -t auto`).*

---

### 👉 Cách 4: Tự động bật Tool mỗi khi mở Termux (Auto-Start)

Nếu bạn muốn mỗi khi mở ứng dụng Termux lên là script tự động chạy ngay:

```bash
echo "rejoin" >> ~/.bashrc
```

---

## 🍪 HƯỚNG DẪN NẠP COOKIE ROBLOX TRÊN CLOUDPHONE (ROOT)

1. Mở menu bằng lệnh `rejoin`, chọn mục **`[6] Quản Lý Tài Khoản Bằng Cookie`**.
2. Chọn **`1) Dán Cookie .ROBLOSECURITY mới`**:
   * Dán chuỗi cookie của tài khoản vào.
   * Script sẽ tự gọi API lấy Username, ID và số dư Robux hiển thị lên Dashboard.
3. Chọn tiếp **`3) Nạp Cookie trực tiếp vào ứng dụng Roblox`**:
   * Script sẽ dùng quyền Root (`su`) để ghi cookie vào database SQLite của Roblox.
   * **Điểm đặc biệt:** Script tự động phân tích và `chown` trả lại quyền sở hữu UID/GID chính xác cho app Roblox, giúp Roblox mở lên nhận phiên đăng nhập ngay lập tức mà không bị lỗi crash/permission denied.
4. Trở ra Menu chính, chọn **`[1] Bắt Đầu Giám Sát Crash`** để bắt đầu treo.

---

## 🔔 CẤU HÌNH DISCORD WEBHOOK & CHỤP MÀN HÌNH

1. Tạo một kênh Discord cá nhân $\rightarrow$ Cài đặt kênh $\rightarrow$ Tích hợp (Integrations) $\rightarrow$ Tạo Webhook $\rightarrow$ Sao chép URL Webhook.
2. Mở menu script, vào mục **`[8] Cài Đặt Discord Webhook`** $\rightarrow$ Dán URL vào.
3. Bật mục **`3) Báo cáo định kỳ`** (Ví dụ: `30` phút):
   * Cứ mỗi 30 phút, script sẽ tự động chụp màn hình Cloudphone.
   * Gửi kèm bảng thông số Pin, RAM, Nhiệt độ máy, Tên tài khoản, Số dư Robux về Discord.
4. Bất cứ khi nào Roblox bị văng hoặc mất mạng, script sẽ gửi cảnh báo khẩn và tự động mở lại game!
