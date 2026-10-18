# ================================================================
# Trình Mã Hóa & Đóng Gói Mã Nguồn Roblox Auto Rejoin Pro Cho GitHub
# ================================================================

$SourceFile = "roblox-auto-rejoin.src.lua"
$OutputFile = "roblox-auto-rejoin.lua"

if (-not (Test-Path $SourceFile)) {
    Write-Host "[X] Loi: Khong tim thay file $SourceFile!" -ForegroundColor Red
    exit 1
}

Write-Host "============================================================" -ForegroundColor Cyan
Write-Host "    TIEN TRINH MA HOA MA NGUON ROBLOX AUTO REJOIN PRO      " -ForegroundColor Yellow
Write-Host "============================================================" -ForegroundColor Cyan

Write-Host ""
Write-Host "[1/4] Dang doc ma nguon tu $SourceFile..." -ForegroundColor Gray
$rawContent = [System.IO.File]::ReadAllText($SourceFile, [System.Text.Encoding]::UTF8)
$rawBytes = [System.Text.Encoding]::UTF8.GetBytes($rawContent)
Write-Host "      Kich thuoc ma nguon goc: $($rawBytes.Length) bytes" -ForegroundColor Green

# 1. Tinh checksum Adler-32 don gian (Anti-Tamper)
$a = 1
$b = 0
for ($i = 0; $i -lt $rawBytes.Length; $i++) {
    $a = ($a + $rawBytes[$i]) % 65521
    $b = ($b + $a) % 65521
}
$checksum = ($b -shl 16) -bor $a

# 2. Tao mang key ngau nhien (16 bytes)
$rand = New-Object System.Random
$keyLength = 16
$keys = New-Object byte[] $keyLength
for ($i = 0; $i -lt $keyLength; $i++) {
    $keys[$i] = [byte]($rand.Next(32, 250))
}

Write-Host ""
Write-Host "[2/4] Dang thuc hien ma hoa da tang (Multi-key XOR)..." -ForegroundColor Gray
$encBytes = New-Object byte[] $rawBytes.Length
for ($i = 0; $i -lt $rawBytes.Length; $i++) {
    $k = $keys[$i % $keyLength]
    $encBytes[$i] = [byte]($rawBytes[$i] -bxor $k)
}

Write-Host ""
Write-Host "[3/4] Dang dong goi thanh chuoi Hex & Loader Lua 5.3..." -ForegroundColor Gray
$chunkSize = 1024
$chunks = [System.Collections.Generic.List[string]]::new()
$sb = [System.Text.StringBuilder]::new()

for ($i = 0; $i -lt $encBytes.Length; $i++) {
    [void]$sb.AppendFormat('\x{0:X2}', $encBytes[$i])
    if (($i + 1) % $chunkSize -eq 0 -or ($i + 1) -eq $encBytes.Length) {
        $chunks.Add($sb.ToString())
        $sb.Clear()
    }
}

$keysLua = ($keys | ForEach-Object { '0x{0:X2}' -f $_ }) -join ', '

$loaderCode = [System.Text.StringBuilder]::new()
[void]$loaderCode.AppendLine('#!/data/data/com.termux/files/usr/bin/lua')
[void]$loaderCode.AppendLine('-- ====================================================================')
[void]$loaderCode.AppendLine('-- ROBLOX AUTO REJOIN PRO v2.2.0 • PROTECTED RELEASE')
[void]$loaderCode.AppendLine('-- (C) ALL RIGHTS RESERVED. CODE IS PROTECTED & OBFUSCATED.')
[void]$loaderCode.AppendLine('-- ====================================================================')
[void]$loaderCode.AppendLine('')
[void]$loaderCode.AppendLine('local _0x1a = string.char')
[void]$loaderCode.AppendLine('local _0x2b = string.byte')
[void]$loaderCode.AppendLine('local _0x3c = table.concat')
[void]$loaderCode.AppendLine('')
[void]$loaderCode.AppendLine("local _0xKEYS = { $keysLua }")
[void]$loaderCode.AppendLine('local _0xCHUNKS = {')

foreach ($c in $chunks) {
    [void]$loaderCode.Append('  "').Append($c).AppendLine('",')
}

[void]$loaderCode.AppendLine('}')
[void]$loaderCode.AppendLine('')

$footer = @'
local _0xOUT = {}
local _0xIDX = 0

for _0xS = 1, #_0xCHUNKS do
  local _0xSTR = _0xCHUNKS[_0xS]
  for _0xI = 1, #_0xSTR do
    _0xIDX = _0xIDX + 1
    local _0xBYT = _0x2b(_0xSTR, _0xI)
    local _0xK = _0xKEYS[((_0xIDX - 1) % #_0xKEYS) + 1]
    _0xOUT[_0xIDX] = _0x1a((_0xBYT ~ _0xK) & 0xFF)
  end
end

local _0xRUN, _0xERR = load(_0x3c(_0xOUT), "=(core)", "t")
if not _0xRUN then
  error("[Runtime Error] Failed to load protected module: " .. tostring(_0xERR))
end

return _0xRUN(...)
'@
[void]$loaderCode.AppendLine($footer)

Write-Host ""
Write-Host "[4/4] Dang ghi file ma hoa ra $OutputFile..." -ForegroundColor Gray
[System.IO.File]::WriteAllText($OutputFile, $loaderCode.ToString(), [System.Text.Encoding]::UTF8)

Write-Host ""
Write-Host "============================================================" -ForegroundColor Green
Write-Host "  [OK] MA HOA THANH CONG 100%!" -ForegroundColor Green
Write-Host "  - File goc duoc giu lai tai : $SourceFile" -ForegroundColor Yellow
Write-Host "  - File ma hoa de up GitHub  : $OutputFile" -ForegroundColor Yellow
Write-Host "============================================================" -ForegroundColor Green
Write-Host ""
