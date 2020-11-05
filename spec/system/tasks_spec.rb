require 'rails_helper'

RSpec.describe "タスク新規投稿", type: :system do
  before do
    @user = FactoryBot.create(:user)
    @task = FactoryBot.build(:task)
  end

  context 'タスク新規投稿ができるとき' do
    it '正しい情報が入力されれば投稿されトップページへ移動' do
      # ログイン
      sign_in(@user)
      # 新規作成をクリック
      find_link("新規作成", href: new_task_path).click
      # フォームに値を入力
      fill_in 'task_title', with: @task.title
      fill_in 'task_purpose', with: @task.purpose
      fill_in 'task_goal', with: @task.goal
      # 作成をクリック
      expect{ find("input[name='commit']").click }.to change{ Task.count }.by(1)
      # 保存したタスクを取得
      task = @user.tasks.find_by(title: @task.title)
      # タスク詳細ページへ遷移
      expect(current_path).to eq task_path(task)
      # 投稿したタスクがあることを確認
      expect(page).to have_content(@task.title)
      expect(page).to have_content(@task.purpose)
      expect(page).to have_content(@task.goal)
    end
  end

  context 'タスク新規投稿ができないとき' do
    it '誤った情報ではタスク新規投稿できずに新規投稿ページへ戻ってくる' do
      # ログイン
      sign_in(@user)
      # 新規作成をクリック
      find_link("新規作成", href: new_task_path).click
      # フォームに値を入力
      fill_in 'task_title', with: ""
      fill_in 'task_purpose', with: ""
      fill_in 'task_goal', with: ""
      # 作成をクリック
      expect{ find("input[name='commit']").click }.to change{ Task.count }.by(0)
      # ページ遷移せず新規投稿ページに戻される
      expect(current_path).to eq '/tasks'
    end
  end
end
