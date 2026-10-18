# 🚀 WAPE HUB - REJOIN TERMUX TOOL v2.3.0 (CLOUDPHONE & GIẢ LẬP)

Công cụ menu tự động hóa chuyên nghiệp viết bằng **Lua 5.3** dành riêng cho **Cloudphone (UgPhone, LDCloud, Redfinger, VMOS...)** và **Termux Android / Giả lập (MuMu, LDPlayer)**. Hỗ trợ tự động mở lại game khi văng (Anti-Crash), chống AFK 20 phút, nạp Cookie `.ROBLOSECURITY` trực tiếp vào app, chụp màn hình, xả RAM định kỳ, ép đồ họa siêu nhẹ và gửi báo cáo phần cứng qua Discord Webhook.

---

## 🖥️ Giao Diện Wape Hub Dashboard (v2.3.0)

Bảng điều khiển 2 cột đối xứng hoàn hảo với thanh tiến trình trực quan:

```text
  ╭─────────────────────────────────────┬─────────────────────────────────────╮
  │ 🎮 GAME & PHÒNG TREO                │ 👤 TÀI KHOẢN & TRẠNG THÁI           │
  │  • Place ID   : 1234567890          │  • Tên User   : glosupisoran        │
  │  • Phòng Game : [ SERVER VIP ]      │  • Trạng Thái : [ ONLINE ● ]        │
  │  • Gói App    : com.roblox.client   │  • Cookie     : [ ĐÃ XÁC THỰC ✓ ]   │
  ├─────────────────────────────────────┼─────────────────────────────────────┤
  │ 📱 THIẾT BỊ & PHẦN CỨNG             │ 🔔 GIÁM SÁT & TỰ ĐỘNG HÓA           │
  │  • Tên Máy    : CloudPhone-01       │  • Webhook    : [ ĐANG BẬT ● ]      │
  │  • Quyền Root : [ ROOT ACTIVE ✓ ]   │  • Tự Xả RAM  : [ TỰ ĐỘNG XẢ ● ]    │
  │  • Bộ Nhớ RAM : [████░░░░]  48%     │  • Chống AFK  : Mỗi 15p             │
  │  • Mức Pin    : [████████] 100%     │  • Quét Crash : Mỗi 5s              │
  │  • Nhiệt Độ   : 36.5°C [MÁT]        │  • Treo Game  : 03h 45m             │
  ╰─────────────────────────────────────┴─────────────────────────────────────╯
```

---

## 📦 CÁC CÁCH CÀI ĐẶT & KHỞI CHẠY TOOL

### 👉 Cách 1: Cài đặt tiêu chuẩn trên Cloudphone / Termux (Khuyên Dùng)

Mở ứng dụng Termux trên Cloudphone và chạy lệnh 1 chạm duy nhất sau:

```bash
pkg install -y git && git clone https://github.com/Kazochim/Beta.git && cd Beta && bash install.sh
```

*(Hoặc chạy từng bước nếu muốn):*
```bash
pkg install -y git
git clone https://github.com/Kazochim/Beta.git
cd Beta
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

## 🍪 HƯỚNG DẪN NẠP COOKIE ROBLOX TRÊN CLOUDPHONE & GIẢ LẬP (ROOT)

1. Mở menu bằng lệnh `rejoin`, chọn mục **`[6] Quản Lý Tài Khoản Bằng Cookie`**.
2. **Chọn cách nạp Cookie:**
   * **Cách 1 - Dán trực tiếp:** Chọn `1) Dán Cookie .ROBLOSECURITY trực tiếp`.
   * **Cách 2 - Đọc từ file TXT:** Chọn `2) 📂 Đọc & Nạp Cookie từ file text (.txt)`:
     * Bạn chỉ cần tạo file `cookie.txt` (hoặc chép vào `/sdcard/Download/cookie.txt`).
     * Hỗ trợ lưu nhiều tài khoản (mỗi dòng 1 cookie), script sẽ liệt kê danh sách cho bạn chọn tài khoản muốn nạp!
3. Chọn tiếp **`4) Nạp Cookie trực tiếp vào ứng dụng Roblox (Dành cho Root)`**:
   * Script sẽ dùng quyền Root (`su`) để ghi cookie vào database SQLite của Roblox.
   * **Điểm đặc biệt:** Script tự động phân tích và `chown` trả lại quyền sở hữu UID/GID chính xác cho app Roblox, giúp Roblox mở lên nhận phiên đăng nhập ngay lập tức mà không bị lỗi crash/permission denied.
4. Trở ra Menu chính, chọn **`[1] Bắt Đầu Giám Sát Crash`** để bắt đầu treo.

---

## 🔔 CẤU HÌNH DISCORD WEBHOOK & CHỤP MÀN HÌNH

1. Tạo một kênh Discord cá nhân $\rightarrow$ Cài đặt kênh $\rightarrow$ Tích hợp (Integrations) $\rightarrow$ Tạo Webhook $\rightarrow$ Sao chép URL Webhook.
2. Mở menu script, vào mục **`[8] Cài Đặt Discord Webhook`** $\rightarrow$ Dán URL vào.
3. Bật mục **`3) Báo cáo định kỳ`** (Ví dụ: `30` phút):
   * Cứ mỗi 30 phút, script sẽ tự động chụp màn hình Cloudphone.
   * Gửi kèm bảng thông số Pin, RAM, Nhiệt độ máy, Tên tài khoản, Trạng thái Online/Offline về Discord.
4. Bất cứ khi nào Roblox bị văng hoặc mất mạng, script sẽ gửi cảnh báo khẩn và tự động mở lại game!

---

## 🧹 TỐI ƯU PHẦN CỨNG & XẢ RAM (CHO CLOUDPHONE YẾU)

Vào mục **`[10] Tối Ưu RAM & Ép Đồ Họa Mức 1`**:
* **Ép đồ họa Roblox về Mức 1:** Script tự động can thiệp file `GlobalBasicSettings_13.xml` của Roblox để khóa đồ họa ở mức thấp nhất (Manual Quality Level 1), giảm 50% tải GPU/CPU giúp máy luôn mát mẻ và không bị văng game.
* **Xả bộ nhớ đệm RAM (Drop Caches):** Giải phóng bộ nhớ đệm ngay lập tức.
* **Tự động xả RAM ngầm:** Khi bật, script sẽ tự động xả RAM mỗi 15 phút hoặc khi mức RAM vượt quá 82%.

---

## 🚀 CẬP NHẬT SCRIPT 1 CHẠM TỪ GITHUB

Vào mục **`[11] Cập Nhật Script Từ GitHub`**:
* Script tự động kiểm tra bản commit mới trên repository `Kazochim/Beta`.
* Tự động chạy `git pull` đồng bộ code mới nhất và hỏi bạn có muốn khởi động lại ngay không. Không cần gõ bất kỳ lệnh nào trong Termux!

