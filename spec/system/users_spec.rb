require 'rails_helper'

RSpec.describe 'ユーザー新規登録', type: :system do
  before do
    @user = FactoryBot.build(:user)
  end

  context 'ユーザー新規登録ができるとき' do
    it '正しい情報が入力されれば登録されトップページへ移動' do
      # トップページへアクセス
      visit root_path
      # 新規登録ボタンを確認
      expect(page).to have_content('新規登録')
      # 新規登録ボタンをクリック
      find_link('新規登録', href: new_user_registration_path).click
      # パスを確認
      expect(current_path).to eq new_user_registration_path
      # フォームに値を入力
      fill_in 'user_nickname', with: @user.nickname
      fill_in 'user_email', with: @user.email
      fill_in 'user_password', with: @user.password
      fill_in 'user_password_confirmation', with: @user.password_confirmation
      # 登録するを押す
      expect { find("input[name='commit']").click }.to change { User.count }.by(1)
      # トップページへの遷移を確認
      expect(current_path).to eq root_path
      # ヘッダーにログインユーザーの名前があることを確認
      expect(page).to have_content(@user.nickname)
      # ヘッダーにゲストログイン、ログイン、新規登録のボタンがないことを確認
      expect(page).to have_no_content('ゲストログイン')
      expect(page).to have_no_content('ログイン')
      expect(page).to have_no_content('新規登録')
    end
  end

  context 'ユーザー新規登録ができないとき' do
    it '誤った情報ではユーザー新規登録できずに新規登録ページへ戻ってくる' do
      # トップページへアクセス
      visit root_path
      # 新規登録ボタンを確認
      expect(page).to have_content('新規登録')
      # 新規登録ボタンをクリック
      find_link('新規登録', href: new_user_registration_path).click
      # パスを確認
      expect(current_path).to eq new_user_registration_path
      # フォームに不正な値を入力
      fill_in 'user_nickname', with: ''
      fill_in 'user_email', with: ''
      fill_in 'user_password', with: ''
      fill_in 'user_password_confirmation', with: ''
      # 登録するを押しても登録されない
      expect { find("input[name='commit']").click }.to change { User.count }.by(0)
      # ページ遷移せず新規登録ページに戻される
      expect(current_path).to eq '/users'
    end
  end
end

RSpec.describe 'ログイン', type: :system do
  before do
    @user = FactoryBot.create(:user)
  end

  context 'ログインができるとき' do
    it '正しい情報が入力されればログインできトップページへ移動' do
      # トップページへアクセス
      visit root_path
      # ログインボタンを確認
      expect(page).to have_content('ログイン')
      # ログインボタンをクリック
      find_link('ログイン', href: new_user_session_path).click
      # パスを確認
      expect(current_path).to eq new_user_session_path
      # フォームに値を入力
      fill_in 'user_email', with: @user.email
      fill_in 'user_password', with: @user.password
      # ログインを押す
      find("input[name='commit']").click
      # トップページへの遷移を確認
      expect(current_path).to eq root_path
      # ヘッダーにログインユーザーの名前があることを確認
      expect(page).to have_content(@user.nickname)
      # ヘッダーにゲストログイン、ログイン、新規登録のボタンがないことを確認
      expect(page).to have_no_content('ゲストログイン')
      expect(page).to have_no_content('ログイン')
      expect(page).to have_no_content('新規登録')
    end
  end

  context 'ログインができないとき' do
    it '誤った情報ではログインできずにログインページへ戻ってくる' do
      # トップページへアクセス
      visit root_path
      # ログインボタンを確認
      expect(page).to have_content('ログイン')
      # ログインボタンをクリック
      find_link('ログイン', href: new_user_session_path).click
      # パスを確認
      expect(current_path).to eq new_user_session_path
      # フォームに値を入力
      fill_in 'user_email', with: ''
      fill_in 'user_password', with: ''
      # ログインを押す
      find("input[name='commit']").click
      # ページ遷移せずログインページに戻される
      expect(current_path).to eq '/users/sign_in'
    end
  end
end

RSpec.describe 'アカウント情報編集', type: :system do
  before do
    @user = FactoryBot.create(:user)
    @new_user_info = FactoryBot.build(:user)
  end

  context 'アカウント情報が編集できるとき' do
    it '正しい情報が入力されれば編集できマイページへ移動' do
      # ログインする
      sign_in(@user)
      # ドロップダウンメニューをクリック
      find("button[data-toggle='dropdown']").click
      # アカウント情報編集をクリック
      find_link('アカウント情報編集', href: edit_user_registration_path).click
      # 新しい情報を入力する
      fill_in 'user_nickname', with: @new_user_info.nickname
      fill_in 'user_email', with: @new_user_info.email
      fill_in 'user_password', with: @new_user_info.password
      fill_in 'user_password_confirmation', with: @new_user_info.password_confirmation
      # 現在のパスワードを入力
      fill_in 'user_current_password', with: @user.password
      # 変更するをクリック。カウントが変わらないことを確認
      expect { find("input[name='commit']").click }.to change { User.count }.by(0)
      # マイページへの遷移を確認
      expect(current_path).to eq user_profile_path(@user)
      # 変更された情報が記載されているか確認
      expect(page).to have_content(@new_user_info.nickname)
      expect(page).to have_content(@new_user_info.email)
    end
  end

  context 'アカウント情報が編集できないとき' do
    it '誤った情報では更新できずに編集ページへ戻ってくる' do
      # ログインする
      sign_in(@user)
      # ドロップダウンメニューをクリック
      find("button[data-toggle='dropdown']").click
      # アカウント情報編集をクリック
      find_link('アカウント情報編集', href: edit_user_registration_path).click
      # 誤った情報を入力する
      fill_in 'user_nickname', with: ''
      fill_in 'user_email', with: ''
      # 現在のパスワードを入力
      fill_in 'user_current_password', with: @user.password
      # 変更するをクリック。カウントが変わらないことを確認
      expect { find("input[name='commit']").click }.to change { User.count }.by(0)
      # ページ遷移せず編集ページに戻される
      expect(current_path).to eq '/users'
    end
  end
end

RSpec.describe 'マイページへ遷移', type: :system do
  before do
    @user = FactoryBot.create(:user)
  end

  context 'マイページへ遷移できるとき' do
    it 'ログインしてマイページへ遷移するとnicknameとemailを確認できる' do
      # ログインする
      sign_in(@user)
      # ドロップダウンメニューをクリック
      find("button[data-toggle='dropdown']").click
      # マイページをクリック
      find_link('マイページ', href: user_profile_path(@user)).click
      # ログインユーザーの情報が記載されているか確認
      expect(page).to have_content(@user.nickname)
      expect(page).to have_content(@user.email)
    end
  end
end

RSpec.describe 'アカウント削除', type: :system do
  before do
    @user = FactoryBot.create(:user)
  end

  context 'アカウントが削除できるとき' do
    it 'ログインしてマイページへ遷移し退会ボタンをクリックすると退会できる' do
      # ログインする
      sign_in(@user)
      # ドロップダウンメニューをクリック
      find("button[data-toggle='dropdown']").click
      # マイページをクリック
      find_link('マイページ', href: user_profile_path(@user)).click
      # 退会するをクリック
      find_link('退会する', href: '#').click
      # 削除をクリックするとユーザーが削除される
      expect { find_link('削除', href: '/users').click }.to change { User.count }.by(-1)
      # トップページへ遷移
      expect(current_path).to eq root_path
      # 非ログイン状態であることを確認（ログインボタンの確認）
      expect(page).to have_content('ログイン')
    end
  end
end
