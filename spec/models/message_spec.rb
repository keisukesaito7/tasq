require 'rails_helper'

RSpec.describe Message, type: :model do
  before do
    @message = FactoryBot.build(:message)
  end

  describe 'メッセージ新規投稿' do
    context '新規投稿がうまくいくとき' do
      it '全ての値が入力されると保存できる' do
        expect(@message).to be_valid
      end
    end

    context '新規投稿がうまくいかないとき' do
      it 'textが空だと保存できない' do
        @message.text = nil
        @message.valid?
        expect(@message.errors.full_messages).to include('メッセージを入力してください')
      end
      it 'userが紐付いていないと保存できない' do
        @message.user = nil
        @message.valid?
        expect(@message.errors.full_messages).to include('ユーザーを入力してください')
      end
      it 'taskが紐付いていないと保存できない' do
        @message.task = nil
        @message.valid?
        expect(@message.errors.full_messages).to include('タスクを入力してください')
      end
    end
  end
end
