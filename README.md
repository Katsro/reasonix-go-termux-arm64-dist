# Reasonix Go — 编译产物

预编译的 Reasonix Go 版本 & 快速安装脚本。

源码: [serend11/reasonix_go](https://github.com/serend11/reasonix_go)

## 安装

```bash
curl -fsSL https://raw.githubusercontent.com/Katsro/reasonix-go-dist/main/install.sh | bash
```

## 卸载

```bash
curl -fsSL https://raw.githubusercontent.com/Katsro/reasonix-go-dist/main/install.sh | bash -s -- --uninstall
```

## 手动安装

从 [Releases](https://github.com/Katsro/reasonix-go-dist/releases) 下载对应平台的二进制，放到 `$PREFIX/bin/reasonixgo` 即可。

## ⚠️ 兼容性说明

当前仅在 **Termux (Android/arm64)** 上测试通过，其他平台暂未验证。

## 编译信息

- Go 版本: 1.26.3
- 平台: android/arm64
- 构建: CGO_ENABLED=0
- 源码版本: [`12425cf`](https://github.com/serend11/reasonix_go/commit/12425cf) (2026-06-08)
