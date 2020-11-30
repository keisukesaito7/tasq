# :pushpin: TasQ - Task and Questions

課題解決に特化したタスク管理アプリです。  
下記ページで公開中です。

https://www.tasq.site/

[![Image from Gyazo](https://i.gyazo.com/9b59673b50980d9de48725c42dd8cc39.jpg)](https://gyazo.com/9b59673b50980d9de48725c42dd8cc39)



<br>

## :pushpin: アプリケーション概要

日々の仕事に「目的意識」を持って取り組む。
これを実現できるよう設計されたタスク管理アプリです。

* 目的とゴールを設定してタスクを作成
* ゴール達成までの過程を記録できる機能を実装
* 自分が行っているタスクを、許可したユーザーにレビューしてもらえる機能を実装

Ruby on Railsで制作しました。

<br>

## :pushpin: 利用方法

### :heavy_check_mark: かんたんログイン

1. トップページの「ゲスト１ログイン」もしくは「ゲスト２ログイン」ボタンをクリック
2. ログインされ、アプリの機能を利用できます
3. タスク閲覧許可はユーザーIDで行います。利用の際は下記のIDを指定して下さい。

| ユーザー名 | ユーザーID |
| :---: | :---: |
| guest1 | 1 |
| guest2 | 2 |

### :heavy_check_mark: タスク作成 (かんたんログインご利用→手順3へ)

1. トップページの「新規登録」もしくは「ログイン」ボタンをクリック
2. フォームに必要事項を入力し、ログイン
3. タスク一覧ページで「新規作成」ボタンをクリック
4. タイトル、目的、ゴールを入力し「作成」ボタンをクリック

### :heavy_check_mark: 行動記録 (コミット)

1. タスク詳細画面の、コミットフォームに行動を入力
2. 「追加」ボタンでコミットログを追加


### :heavy_check_mark: タスク閲覧許可

1. タスク詳細画面の、「検索」ボタンをクリック
2. 閲覧を許可したいユーザーのIDを入力
3. 「許可」ボタンをクリックで閲覧を許可

ゲストユーザーを指定する際は、下記のIDを指定して下さい

| ユーザー名 | ユーザーID |
| :---: | :---: |
| guest1 | 1 |
| guest2 | 2 |

### :heavy_check_mark: チャット

1. タスク詳細画面の、チャットフォームにメッセージを入力
2. 「コメント」ボタンでメッセージを送信
    * 補足 : タスク閲覧許可されたユーザーはチャット利用可能です

<br>

## :pushpin: 実装機能

* ユーザー管理機能
  * 新規登録/ログイン/ログアウト/情報編集/退会
* タスク管理機能
  * 新規作成/編集/削除
* コミット管理機能
  * 新規作成/編集/削除
* メッセージ管理機能
  * 新規作成/削除
* タスク閲覧許可機能
  * 新規作成/削除
* かんたんログイン機能
* エラーメッセージ日本語化
* レスポンシブWebデザイン(※PCでの利用を想定しています)

<br>

## :pushpin: 目指した課題解決

**大学の研究室に所属する学生が、「自立」した研究を行えるようになること**を目指しています。

大学の研究は、非常に専門性が高いため、まずは言われたことをこなすところからスタートします。
しかし、ある一定水準まで達したところで、自立した研究をするよう求められます。

その際「いきなり自分で問題を考えるなんて難しい…」と悩む学生は多くいます。私もそうでした。

そこで「研究室に入りたての早い段階から、自分で考える癖をつけるにはどうしたらいいだろうか」と考えました。  
結果、研究が始まるまでのフローに問題があると考え、それをシステムで解決しようと試みました。

#### :heavy_check_mark: 私が考える「自立」は以下の要件を満たした状態です
1. 課題を特定することができる
2. 課題を解決するために必要なことを考えられる
3. 解決までの適切なルートを設計できる/修正できる
    
#### :heavy_check_mark: この「自立」を妨げる障壁を以下のことと考えました
1. 自分で行動指針を立てる習慣がない
2. 行動指針を矯正してくれる環境がない
3. そもそも何から考えていいかわからない
    
#### :heavy_check_mark: これらの障壁を取り除くための環境を、本アプリで作ろうと考えました
1. 必ず「目的」と「ゴール」を設定する環境
2. 質問＆レビュー依頼をしやすい環境
3. 先人たちがどう考え何を実行したのかを知れる環境

<br>

## :pushpin: 使用技術

* HTML/CSS
* JavaScript
* Ruby 2.6.5
* Ruby on Rails 6.0.3.4
* Rubocop (コード自動整形)
* RSpec (単体、結合テスト : 61件)
* MySQL 5.6
* Bootstrap 4.3.1

### インフラ・本番環境

* AWS (VPC, EC2, Route53, ALB, ACM)
* Nginx (Webサーバー)
* Unicorn (アプリケーションサーバー)
* MariaDB (データベース)
* Capistrano 3.14.1 (自動デプロイ)

### ソースコード管理

* Git/GitHub
   * 可能な限り現場での利用を想定して管理
   * Milestone、Issueを設定
   * Branch、Pull request、Merge、Pullを使用

<br>

## :pushpin: インフラ構成図

[![Image from Gyazo](https://i.gyazo.com/37e3aacfd0106a640ad8f07e758511c3.png)](https://gyazo.com/37e3aacfd0106a640ad8f07e758511c3)

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

[![Image from Gyazo](https://i.gyazo.com/3216179ab8c2b6bb96e40913a7712356.png)](https://gyazo.com/3216179ab8c2b6bb96e40913a7712356)
