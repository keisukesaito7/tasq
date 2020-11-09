require 'rails_helper'

RSpec.describe 'ゲストユーザーログイン', type: :system do
  context 'ゲストユーザー１でログインできる' do
    it 'トップページのゲスト１ログインボタンでログインできる' do
      # トップページへアクセス
      visit root_path
      # ゲストログインボタンを確認
      expect(page).to have_content('ゲスト１ログイン')
      # ログインボタンをクリック
      find_link('ゲスト１ログイン', href: users_guest_sign_in_path).click
      # トップページへの遷移を確認
      expect(current_path).to eq root_path
      # ヘッダーにログインユーザーの名前があることを確認
      expect(page).to have_content('guest1')
      # ヘッダーにログイン、新規登録のボタンがないことを確認
      expect(page).to have_no_content('ログイン')
      expect(page).to have_no_content('新規登録')
    end
  end

  context 'ゲストユーザー２でログインできる' do
    it 'トップページのゲスト２ログインボタンでログインできる' do
      # トップページへアクセス
      visit root_path
      # ゲストログインボタンを確認
      expect(page).to have_content('ゲスト２ログイン')
      # ログインボタンをクリック
      find_link('ゲスト２ログイン', href: users_guest_beta_sign_in_path).click
      # トップページへの遷移を確認
      expect(current_path).to eq root_path
      # ヘッダーにログインユーザーの名前があることを確認
      expect(page).to have_content('guest2')
      # ヘッダーにログイン、新規登録のボタンがないことを確認
      expect(page).to have_no_content('ログイン')
      expect(page).to have_no_content('新規登録')
    end
  end
end
