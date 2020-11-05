require 'rails_helper'

RSpec.describe "コミット新規投稿", type: :system do
  before do
    @task = FactoryBot.create(:task)
    @commit = FactoryBot.build(:commit)
  end

  context 'コミット新規投稿ができるとき' do
    it '正しい情報が入力されれば投稿されログが更新される' do
      # ログイン
      sign_in(@task.user)
      # マイページのタスクをクリック
      find_link(href: "/tasks/#{@task.id}").click
      # フォームにコミットを入力
      fill_in "commit_content", with: @commit.content
      # 追加ボタンをクリック
      expect{ find("button[id='submit-commit']").click }.to change{ Commit.count }.by(1)
      # ページがリロードされる
      expect(current_path).to eq task_path(@task)
      # 投稿したコミットがあるか確認
      expect(page).to have_content(@commit.content)
    end
  end

  context 'コミット新規投稿ができないとき' do
    it '誤った情報では投稿できずにタスク詳細ページに戻ってくる' do
      # ログイン
      sign_in(@task.user)
      # マイページのタスクをクリック
      find_link(href: "/tasks/#{@task.id}").click
      # フォームにコミットを入力
      fill_in "commit_content", with: ""
      # 追加ボタンをクリック。保存されない。
      expect{ find("button[id='submit-commit']").click }.to change{ Commit.count }.by(0)
      # コミットログが更新されない
      expect(current_path).to eq "/tasks/#{@task.id}/commits"
      expect(page).to have_no_content(@commit.content)
    end
  end
end

RSpec.describe "コミット編集", type: :system do
  before do
    @commit = FactoryBot.create(:commit)
    @new_commit = FactoryBot.build(:commit)
  end

  context 'コミット編集ができるとき' do
    it '正しい情報が入力されれば更新されログが更新される' do
      # ログイン
      sign_in(@commit.task.user)
      # マイページのタスクをクリック
      find_link(href: "/tasks/#{@commit.task.id}").click
      # コミット編集ボタンをクリック
      find("svg[data-linkId='commit-edit']").click
      # 新しい内容をフォームに入力
      fill_in "commit_content", with: @new_commit.content
      # 更新をクリック。レコード数が変動しないことを確認
      expect{ find("button[id='submit-commit']").click }.to change{ Commit.count }.by(0)
      # タスク詳細ページへの遷移を確認
      expect(current_path).to eq task_path(@commit.task)
      # コミット内容の更新を確認
      expect(page).to have_content(@new_commit.content)
    end
  end

  context 'コミット編集ができないとき' do
    it '誤った情報が入力されれば更新されず編集ページに戻ってくる' do
      # ログイン
      sign_in(@commit.task.user)
      # マイページのタスクをクリック
      find_link(href: "/tasks/#{@commit.task.id}").click
      # コミット編集ボタンをクリック
      find("svg[data-linkId='commit-edit']").click
      # フォームに値を入力
      fill_in "commit_content", with: ""
      # 更新をクリック。レコード数が変動しないことを確認
      expect{ find("button[id='submit-commit']").click }.to change{ Commit.count }.by(0)
      # ページ遷移せず編集ページに戻ってくる
      expect(current_path).to eq "/tasks/#{@commit.task.id}/commits/#{@commit.id}"
    end
  end
end
