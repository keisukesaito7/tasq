# :pushpin: TasQ - Task & Questions

課題解決に特化したタスク管理アプリです。  
下記ページで公開中です。  

https://tasq-r.herokuapp.com/

<br>

## :pushpin: アプリケーション概要

日々の仕事に「目的意識」を持って取り組む。
これを実現できるよう設計されたタスク管理アプリです。

* 目的とゴールを設定してタスクを作成
* ゴール達成までの過程を記録できる機能を実装
* 自分が行っているタスクを、許可したユーザーにレビューしてもらえる機能を実装

Ruby on Railsで制作しました。

<br>

## :pushpin: 機能・利用方法

### :heavy_check_mark: かんたんログイン

1. トップページの「ゲスト１ログイン」もしくは「ゲスト２ログイン」ボタンをクリック
2. ログインされ、アプリの機能を利用できます
3. タスク閲覧許可はユーザーIDで行います。利用の際は下記のIDを指定して下さい。
    * guest1 : ID = 41
    * guest2 : ID = 51

### :heavy_check_mark: タスク作成 (かんたんログインご利用→手順3へ)

1. トップページの「新規登録」もしくは「ログイン」ボタンをクリック
2. フォームに必要事項を入力し、ログイン
3. タスク一覧ページで「新規登録」ボタンをクリック
4. タイトル、目的、ゴールを入力し「作成」ボタンをクリック

### :heavy_check_mark: 行動記録 (コミット)

1. タスク詳細画面の、コミットフォームに行動を入力
2. 「追加」ボタンでコミットログを追加


### :heavy_check_mark: タスク閲覧許可

1. タスク詳細画面の、「検索」ボタンをクリック
2. 閲覧を許可したいユーザーのIDを入力
3. 「許可」ボタンをクリックで閲覧を許可
* ゲストユーザーを指定する際は、下記のIDを指定して下さい
    * guest1 : ID = 41
    * guest2 : ID = 51

### :heavy_check_mark: チャット

1. タスク詳細画面の、チャットフォームにメッセージを入力
2. 「コメント」ボタンでメッセージを送信
    * 補足 : タスク閲覧許可されたユーザーはチャット利用可能です

<br>

## :pushpin: 目指した課題解決

**大学の研究室に所属する学生が、「自立」した研究を行えるようになること**を目指しています。

### :heavy_check_mark: 私が考える「自立」は以下の要件を満たした状態です
* 課題を特定することができる
* 課題を解決するために必要なことを考えられる
* 解決までの適切なルートを設計できる/修正できる
    
### :heavy_check_mark: この「自立」を妨げる障壁を以下のことと考えました
* 自分で行動指針を立てる習慣がない
* 行動指針を矯正してくれる環境がない
* そもそも何から考えていいかわからない
    
### :heavy_check_mark: これらの障壁を取り除くための環境を、本アプリで作ろうと考えました
* 必ず「目的」と「ゴール」を設定する環境
* 質問＆レビュー依頼をしやすい環境
* 先人たちがどう考え何を実行したのかを知れる環境

### :heavy_check_mark: 課題・着想

**私の大学院時代の挫折経験が基になっています。**

大学の研究室は、場所にもよりますが、基本的に先生や先輩から言われたタスクをこなしていきます。  
よって、**「なぜこの実験をするのか？」「なぜこの論文を読むのか？」を考えることが疎かになりがちです**。

この状態で研究を続ける学生は実は結構多くいます。  
そのためいざ研究発表をする時には「あれ、これってどうしてやっているんだっけ？」と今までの行動の理由を説明できないケースが多発します。  
**場合によってはこの経験がきっかけで挫折をする学生もいます。私と、私の友人がそうでした。**

「今まで何をやっていたんだ…」  
「何も考えてこなかった…全部無駄だった…」

そうやって過去の自分を責めました。しかし本当に本人だけが悪いのでしょうか？  
私はそうは思いません。**問題は「本人に考えさせずに研究が始まる構造」にもあると考えました。**

この構造を改革したい。  
**言われたままタスクをこなすのではなく、無理矢理にでも「それをする目的」を考える習慣をつける。**  
**そして課題の設定と解決までのアプローチを自分の言葉で説明できる。**  
この訓練を続けることで自立を促し、毎日楽しく、主体性を持って研究をする学生を増やしたい。

**そのために私ができることは、「研究者として自立できる場を提供すること」だと考えました。**

<br>

## :pushpin: 使用技術

* Ruby 2.6.5
* Ruby on Rails 6.0.3.4
* Rubocop (コード自動整形)
* RSpec (単体、結合テスト : 61件)
* MySQL 5.6
* Bootstrap 4.3.1
* Heroku (本番環境)

<br>

## :pushpin: 実装予定の機能

* ルーム作成機能 : タスク閲覧権限をルーム単位で管理できる機能です
* タグ付け機能 : 関連するタスクをまとめる機能です。ルーム作成機能実装後に実装します
* 検索機能 : タスクタイトル、タグ等で検索できる機能です

<br>

## :pushpin: ローカル環境へのインストール方法

```
% git clone https://github.com/keisukesaito7/tasq.git
% cd tasq
% bundle install
% yarn install
% rails db:create
% rails db:migrate
```

<br>

## :pushpin: データベース設計

* https://gyazo.com/bd1d61d7b9eca80383c4f3a96930b181
