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
end
