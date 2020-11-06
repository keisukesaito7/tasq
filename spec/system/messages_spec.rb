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

  context 'メッセージ新規投稿ができないとき' do
    it '誤った情報では投稿できずにタスク詳細ページに戻ってくる' do
      # ログイン
      sign_in(@task.user)
      # マイページのタスクをクリック
      find_link(href: "/tasks/#{@task.id}").click
      # フォームにメッセージを入力
      fill_in "message_text", with: ""
      # コメントボタンをクリック。保存されない
      expect{ find("input[name='commit']").click }.to change{ Message.count }.by(0)
      # メッセージログが更新されない
      expect(current_path).to eq "/tasks/#{@task.id}/messages"
      expect(page).to have_no_content(@message.text)
    end
  end
end

RSpec.describe "メッセージ削除", type: :system do
  before do
    @task = FactoryBot.create(:task)
    # taskオーナーとしてメッセージを作成
    @message = Message.create(text: Faker::Lorem.sentence, user_id: @task.user_id, task_id: @task.id)
  end

  context 'メッセージ削除ができるとき' do
    it 'メッセージの削除ボタンをクリックすると削除できタスク詳細ページへ遷移する' do
      # ログイン
      sign_in(@task.user)
      # マイページのタスクをクリック
      find_link(href: "/tasks/#{@task.id}").click
      # メッセージ削除ボタンをクリック
      expect{ find("svg[data-linkId='message-destroy']").click }.to change{ Message.count }.by(-1)
      # タスク詳細ページへ遷移
      expect(current_path).to eq task_path(@task)
      # メッセージが存在しないことを確認
      expect(page).to have_no_content(@message.text)
    end
  end
end
