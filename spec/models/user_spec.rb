require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録がうまくいくとき' do
      it '全ての値が記入されれば保存できる' do
        expect(@user).to be_valid
      end
    end

    context '新規登録がうまくいかないとき' do
      it 'nicknameが空だと保存できない' do
        @user.nickname = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("ニックネームを入力してください")
      end
      it 'nicknameが11文字以上だと保存できない' do
        @user.nickname = 'abcdeabcde1'
        @user.valid?
        expect(@user.errors.full_messages).to include('ニックネームは10文字以内で入力してください')
      end
      it 'emailが空だと保存できない' do
        @user.email = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("メールアドレスを入力してください")
      end
      it 'emailが重複した場合は保存できない' do
        new_user = FactoryBot.build(:user)
        new_user.email = @user.email
        @user.save
        new_user.valid?
        expect(new_user.errors.full_messages).to include('メールアドレスはすでに存在します')
      end
      it 'passwordが空だと保存できない' do
        @user.password = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードを入力してください")
      end
      it 'passwordが5文字以下だと保存できない' do
        @user.password = 'aaaaa'
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードは6文字以上で入力してください')
      end
      it 'password_confirmationが空だと保存できない' do
        @user.password_confirmation = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワード（確認用）とパスワードの入力が一致しません")
      end
      it 'password_confirmationがpasswordと一致しないと保存できない' do
        @user.password_confirmation = 'aaaaaa'
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワード（確認用）とパスワードの入力が一致しません")
      end
    end
  end
end
