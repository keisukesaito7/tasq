require 'rails_helper'

RSpec.describe "タスク閲覧許可", type: :system do
  before do
    @task = FactoryBot.create(:task)
    @reviewer = FactoryBot.create(:user)
  end

  context 'タスク閲覧許可ができるとき' do
    it 'ユーザーが存在すればタスク閲覧を許可でき、許可されたユーザーのマイページにタスクが表示され、クリックするとタスクを閲覧できる' do
      # タスクオーナーでログイン
      sign_in(@task.user)
      # マイページのタスクをクリック
      find_link(href: "/tasks/#{@task.id}").click
      # レビュアー検索ボタンをクリック
      find("button[data-target='#collapseUserIdForm']").click
      # フォームにユーザーIDを入力
      fill_in "permission_user_id", with: @reviewer.id
      # 許可をクリック
      expect{ find("input[value='許可']").click }.to change{ Permission.count }.by(1)
      # レビュアー名が追加されたことを確認
      expect(page).to have_content(@reviewer.nickname)
      # ログアウトのためドロップダウンメニューをクリック
      find("button[data-toggle='dropdown']").click
      # ログアウトのリンクをクリック
      find_link("ログアウト", href: "/users/sign_out").click
      # レビュアーでログイン
      sign_in(@reviewer)
      # 閲覧許可されたタスクがマイページに存在することを確認
      expect(page).to have_content(@task.title)
      expect(page).to have_content(@task.user.nickname)
      # タスクをクリックすると詳細ページに遷移できる
      find_link(href: "/tasks/#{@task.id}").click
      expect(current_path).to eq task_path(@task)
    end
  end
  
end
