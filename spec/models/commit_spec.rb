require 'rails_helper'

RSpec.describe Commit, type: :model do
  before do
    @commit = FactoryBot.build(:commit)
  end

  describe 'コミット新規投稿' do
    context '新規投稿がうまくいくとき' do
      it '全ての値が入力されると保存できる' do
        expect(@commit).to be_valid
      end
    end

    context '新規投稿がうまくいかないとき' do
      it 'contentが空だと保存できない' do
        @commit.content = nil
        @commit.valid?
        expect(@commit.errors.full_messages).to include('コミット内容を入力してください')
      end
      it 'userが紐付いていないと保存できない' do
        @commit.user = nil
        @commit.valid?
        expect(@commit.errors.full_messages).to include('ユーザーを入力してください')
      end
      it 'taskが紐付いていないと保存できない' do
        @commit.task = nil
        @commit.valid?
        expect(@commit.errors.full_messages).to include('タスクを入力してください')
      end
    end
  end
end
