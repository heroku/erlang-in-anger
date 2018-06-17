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
