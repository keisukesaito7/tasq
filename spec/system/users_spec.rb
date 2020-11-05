require 'rails_helper'

RSpec.describe "ユーザー新規登録", type: :system do
  before do
    @user = FactoryBot.build(:user)
  end

  context 'ユーザー新規登録ができるとき' do
    it '正しい情報が入力されれば登録されトップページへ移動' do
      # トップページへアクセス
      visit root_path
      # 新規登録ボタンを確認
      expect(page).to have_content("新規登録")
      # 新規登録ボタンをクリック
      find_link("新規登録", href: new_user_registration_path).click
      # パスを確認
      expect(current_path).to eq new_user_registration_path
      # フォームに値を入力
      fill_in "user_nickname", with: @user.nickname
      fill_in "user_email", with: @user.email
      fill_in "user_password", with: @user.password
      fill_in "user_password_confirmation", with: @user.password_confirmation
      # 登録するを押す
      expect{ find("input[name='commit']").click }.to change{ User.count }.by(1)
      # トップページへの遷移を確認
      expect(current_path).to eq root_path
      # ヘッダーにログインユーザーの名前があることを確認
      expect(page).to have_content(@user.nickname)
      # ヘッダーにゲストログイン、ログイン、新規登録のボタンがないことを確認
      expect(page).to have_no_content("ゲストログイン")
      expect(page).to have_no_content("ログイン")
      expect(page).to have_no_content("新規登録")
    end
  end

  context 'ユーザー新規登録ができないとき' do
    it '誤った情報ではユーザー新規登録できずに新規登録ページへ戻ってくる' do
      # トップページへアクセス
      visit root_path
      # 新規登録ボタンを確認
      expect(page).to have_content("新規登録")
      # 新規登録ボタンをクリック
      find_link("新規登録", href: new_user_registration_path).click
      # パスを確認
      expect(current_path).to eq new_user_registration_path
      # フォームに不正な値を入力
      fill_in "user_nickname", with: ""
      fill_in "user_email", with: ""
      fill_in "user_password", with: ""
      fill_in "user_password_confirmation", with: ""
      # 登録するを押しても登録されない
      expect{ find("input[name='commit']").click }.to change{ User.count }.by(0)
      # ページ遷移せず新規登録ページに戻される
      expect(current_path).to eq '/users'
    end
  end
end

RSpec.describe "ログイン", type: :system do
  before do
    @user = FactoryBot.create(:user)
  end

  context 'ログインができるとき' do
    it '正しい情報が入力されればログインできトップページへ移動' do
      # トップページへアクセス
      visit root_path
      # ログインボタンを確認
      expect(page).to have_content("ログイン")
      # ログインボタンをクリック
      find_link("ログイン", href: new_user_session_path).click
      # パスを確認
      expect(current_path).to eq new_user_session_path
      # フォームに値を入力
      fill_in "user_email", with: @user.email
      fill_in "user_password", with: @user.password
      # ログインを押す
      find("input[name='commit']").click
      # トップページへの遷移を確認
      expect(current_path).to eq root_path
      # ヘッダーにログインユーザーの名前があることを確認
      expect(page).to have_content(@user.nickname)
      # ヘッダーにゲストログイン、ログイン、新規登録のボタンがないことを確認
      expect(page).to have_no_content("ゲストログイン")
      expect(page).to have_no_content("ログイン")
      expect(page).to have_no_content("新規登録")
    end
  end

  context 'ログインができないとき' do
    it '誤った情報ではログインできずにログインページへ戻ってくる' do
      # トップページへアクセス
      visit root_path
      # ログインボタンを確認
      expect(page).to have_content("ログイン")
      # ログインボタンをクリック
      find_link("ログイン", href: new_user_session_path).click
      # パスを確認
      expect(current_path).to eq new_user_session_path
      # フォームに値を入力
      fill_in "user_email", with: ""
      fill_in "user_password", with: ""
      # ログインを押す
      find("input[name='commit']").click
      # ページ遷移せずログインページに戻される
      expect(current_path).to eq '/users/sign_in'
    end
  end
end
