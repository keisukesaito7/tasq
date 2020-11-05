require 'rails_helper'

RSpec.describe "ゲストユーザーログイン", type: :system do
  context 'ゲストユーザーでログインできる' do
    it 'トップページのゲストログインボタンでログインできる' do
      # トップページへアクセス
      visit root_path
      # ゲストログインボタンを確認
      expect(page).to have_content("ゲストログイン")
      # ログインボタンをクリック
      find_link("ゲストログイン", href: users_guest_sign_in_path).click
      # トップページへの遷移を確認
      expect(current_path).to eq root_path
      # ヘッダーにログインユーザーの名前があることを確認
      expect(page).to have_content("テストユーザー")
      # ヘッダーにゲストログイン、ログイン、新規登録のボタンがないことを確認
      expect(page).to have_no_content("ゲストログイン")
      expect(page).to have_no_content("ログイン")
      expect(page).to have_no_content("新規登録")
    end
  end
end
