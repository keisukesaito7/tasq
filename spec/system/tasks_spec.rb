require 'rails_helper'

RSpec.describe 'タスク新規投稿', type: :system do
  before do
    @user = FactoryBot.create(:user)
    @task = FactoryBot.build(:task)
  end

  context 'タスク新規投稿ができるとき' do
    it '正しい情報が入力されれば投稿されタスク詳細ページへ移動' do
      # ログイン
      sign_in(@user)
      # 新規作成をクリック
      find_link('新規作成', href: new_task_path).click
      # フォームに値を入力
      fill_in 'task_title', with: @task.title
      fill_in 'task_purpose', with: @task.purpose
      fill_in 'task_goal', with: @task.goal
      # 作成をクリック
      expect { find("input[name='commit']").click }.to change { Task.count }.by(1)
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
      find_link('新規作成', href: new_task_path).click
      # フォームに値を入力
      fill_in 'task_title', with: ''
      fill_in 'task_purpose', with: ''
      fill_in 'task_goal', with: ''
      # 作成をクリック
      expect { find("input[name='commit']").click }.to change { Task.count }.by(0)
      # ページ遷移せず新規投稿ページに戻される
      expect(current_path).to eq '/tasks'
    end
  end
end

RSpec.describe 'タスク編集', type: :system do
  before do
    @task = FactoryBot.create(:task)
    @new_task_info = FactoryBot.build(:task)
  end

  context 'タスク編集ができるとき' do
    it '正しい情報が入力されれば編集されタスク詳細ページへ移動' do
      # ログイン
      sign_in(@task.user)
      # マイページのタスクをクリック
      find_link(href: "/tasks/#{@task.id}").click
      # タスク編集ボタンをクリック
      find_link(href: "/tasks/#{@task.id}/edit").click
      # フォームに値を入力
      fill_in 'task_title', with: @new_task_info.title
      fill_in 'task_purpose', with: @new_task_info.purpose
      fill_in 'task_goal', with: @new_task_info.goal
      # 更新をクリック
      expect { find("input[name='commit']").click }.to change { Task.count }.by(0)
      # タスク詳細ページへ遷移
      expect(current_path).to eq task_path(@task)
      # タスク内容の更新を確認
      expect(page).to have_content(@new_task_info.title)
      expect(page).to have_content(@new_task_info.purpose)
      expect(page).to have_content(@new_task_info.goal)
    end
  end

  context 'タスク編集ができないとき' do
    it '誤った情報では編集できずに編集ページに戻ってくる' do
      # ログイン
      sign_in(@task.user)
      # マイページのタスクをクリック
      find_link(href: "/tasks/#{@task.id}").click
      # タスク編集ボタンをクリック
      find_link(href: "/tasks/#{@task.id}/edit").click
      # フォームに値を入力
      fill_in 'task_title', with: ''
      fill_in 'task_purpose', with: ''
      fill_in 'task_goal', with: ''
      # 更新をクリック
      expect { find("input[name='commit']").click }.to change { Task.count }.by(0)
      # ページ遷移せず編集ページに戻ってくる
      expect(current_path).to eq "/tasks/#{@task.id}"
    end
  end
end

RSpec.describe 'タスク削除', type: :system do
  before do
    @task = FactoryBot.create(:task)
  end

  context 'タスク削除ができるとき' do
    it 'タスク詳細ページの削除ボタンをクリックすると削除できマイページへ遷移する' do
      # ログイン
      sign_in(@task.user)
      # マイページのタスクをクリック
      find_link(href: "/tasks/#{@task.id}").click
      # タスク削除ボタンをクリック
      find("button[data-target='#taskDestroyModal']").click
      # モーダルの削除ボタンをクリック
      expect { find_link('削除', href: "/tasks/#{@task.id}").click }.to change { Task.count }.by(-1)
      # トップページへ遷移
      expect(current_path).to eq root_path
      # タスクが存在しないことを確認
      expect(page).to have_no_content(@task.title)
    end
  end
end
