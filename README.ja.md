# README
Erlang in Angarの翻訳用レポジトリです。オリジナルのREADMEは[こちら](./README.en.md)を参照してください。

# Contribution
自分一人でやるのはしんどいのでpull-requestください。
翻訳するときはオリジナルのものをコメントアウトする形でやっていきます。

# Build

TeX Liveをとりあえずインストールしてビルド。オリジナルはpdfLaTeXを使って生成している。

```console
$ pdflatex text.tex
$ xdg-open text.pdf
```

日本語のほうはupLaTeXでとりあえず生成する。

```console
$ uplatex text-ja.tex
$ dvipdfmx text-ja
$ xdg-open text-ja.pdf
```
