# README
[![Build Status](https://travis-ci.org/ymotongpoo/erlang-in-anger.svg?branch=japanese)](https://travis-ci.org/ymotongpoo/erlang-in-anger)

Erlang in Angerの翻訳用レポジトリです。オリジナルのREADMEは[こちら](./README.en.md)を参照してください。

# 最新版
* https://ymotongpoo.github.io/erlang-in-anger/text-ja.pdf
* https://github.com/ymotongpoo/erlang-in-anger/blob/gh-pages/text-ja.pdf

# Contribution
## 雰囲気
自分一人でやるのはしんどいのでpull-requestください。
翻訳するときはオリジナルのものをコメントアウトする形でやっていきます。
詳しくは `NNN-foobar-ja.tex` で翻訳済みになっているファイルを参照してください。

## 手順
**注意** メインブランチは `japanese` です。 `master` はupstreamの追従用です。

1. 参加する旨を @ymotongpoo に言う (Collaboratorsに追加します)
2. [割り振り表](https://docs.google.com/spreadsheets/d/1jsGGbftXZmtHGe8J7nKy-xAsFErWUpHksGEn2Oolwvw/edit?usp=sharing)の「担当」のカラムで自分がやりたいところに記名する。(節単位で担当するのが望ましい。)
3. featureブランチ(`japanese` 以外に適当にブランチ)を切ってそこで作業する。(自分のアカウントにフォークしてから作業してもらっても構いません)
4. 担当部分が終わったら `japanese` ブランチにmerge。心配ならpull-requestを出してください。(みんなでレビューしましょう)
5. 以下2-4の繰り返し。

また、pull-requestを出してCIに通った場合は次のリポジトリにPDFがアップロードされます。

- https://github.com/y-yu/erlang-in-anger-pr

## レビュー
訳がおかしいなと思ったら適宜Issueを立ててください。(TODO: Issueテンプレートの作成)

# Build
TeX Liveをとりあえずインストールしてビルド。オリジナルはpdfLaTeXを使って生成しています。
Latexmkを使ってビルドできるようになっているので各々次のようにビルドします。

```console
$ make english   # -> text.pdf: original English version
$ make japanese  # -> text-ja.pdf: Japanese translation version
```

また、Docker環境がある場合は次のコマンドでコンパイルすることもできます。

```console
$ docker-compose up
```

ビルドに成功すると、`text-ja.pdf` が作成されているはずです。

## ビルド対象の追加

どの tex ファイルを読み込むかは `text-ja.tex` ファイルの `\include` 行で指定します。例えば 109-tracing-ja.tex を追加する場合、下記のように記載します。

```
\include{109-tracing-ja}
```


# 進捗
- [x] 000: Copyright
- [x] 001: Introduction
- [x] 101: How to Dive into a Code Base
- [x] 102: Building Open Source Erlang Software
- [ ] 103: Planning for Overload
- [ ] 104: Connecting to Remote Nodes
- [ ] 105: Runtime Metrics
- [ ] 106: Reading Crash Dumps
- [ ] 107: Memory Leaks
- [ ] 108: CPU and Scheduler Hogs
- [x] 109: Tracing
- [x] 201: Conclusion


# Tips
* ダッシュ(―)は `---` (ハイフン3つ)とすると表示が崩れない
