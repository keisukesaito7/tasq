require 'rails_helper'

RSpec.describe "メッセージ新規投稿", type: :system do
  before do
    @task = FactoryBot.create(:task)
    @message = FactoryBot.build(:message)
  end

  context 'メッセージ新規投稿ができるとき' do
    it '正しい情報が入力されれば投稿されログが更新される' do
      # ログイン
      sign_in(@task.user)
      # マイページのタスクをクリック
      find_link(href: "/tasks/#{@task.id}").click
      # フォームにメッセージを入力
      fill_in "message_text", with: @message.text
      # コメントボタンをクリック
      expect{ find("input[name='commit']").click }.to change{ Message.count }.by(1)
      # ページがリロードされる
      expect(current_path).to eq task_path(@task)
      # 投稿したメッセージがあるか確認
      expect(page).to have_content(@message.text)
    end
  end
end
