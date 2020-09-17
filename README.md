# phoenix-todo-tutorial

- 技術書典7「Phoenix入門 〜API構築からLiveViewまで〜」の開発環境構築用Dockerファイル
- 詳細な手順は書籍「p.8 環境構築」をご参照ください

## バージョン

- Elixir  :1.8.1
- Phoenix :1.4.9

## 正誤表

書籍に下記の通り、誤りがございました。お詫びして訂正いたします。

ページ | 誤 | 正
:-- | :-- | :--
p.41 | mountではassing(socket, key: value)の形でテンプレートに渡す変数を書き、{:ok, socket}のタプルを返す | mountでは**assign**(socket, key: value)の形でテンプレートに渡す変数を書き、{:ok, socket}のタプルを返す
