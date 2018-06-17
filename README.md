# README
Erlang in Angarの翻訳用レポジトリです。オリジナルのREADMEは[こちら](./README.en.md)を参照してください。

# Contribution
自分一人でやるのはしんどいのでpull-requestください。
翻訳するときはオリジナルのものをコメントアウトする形でやっていきます。

# Build

TeX Liveをとりあえずインストールしてビルド。オリジナルはpdfLaTeXを使って生成している。
Latexmkを使ってビルドできるようになっているので各々次のようにビルドする。

```console
$ make english   # -> text.pdf: original English version
$ make japanese  # -> text-ja.pdf: Japanese translation version
```

# 進捗
- [ ] 000: Copyright
- [ ] 001: Introduction
- [ ] 101: How to Dive into a Code Base
- [ ] 102: Building Open Source Erlang Software
- [ ] 103: Planning for Overload
- [ ] 104: Connecting to Remote Nodes
- [ ] 105: Runtime Metrics
- [ ] 106: Reading Crash Dumps
- [ ] 107: Memory Leaks
- [ ] 108: CPU and Scheduler Hogs
- [ ] 109: Tracing
- [ ] 201: Conclusion