require 'rails_helper'

RSpec.describe Like, type: :model do
  before do
    @like = FactoryBot.build(:like)
  end

  describe 'いいね' do
    context 'いいねができるとき' do
      it 'まだいいねをしていないコミットにはいいねができる' do
        expect(@like).to be_valid
      end
    end

    context 'いいねができないとき' do
      it '同一ユーザーは既にいいねをしたコミットにいいねができない' do
        @like.save
        @like_repeat = FactoryBot.build(:like)
        @like_repeat.user = @like.user
        @like_repeat.task = @like.task
        @like_repeat.commit = @like.commit
        @like_repeat.valid?
        expect(@like_repeat.errors.full_messages).to include("コミットはすでに存在します")
      end
      it 'ユーザーが紐付いていないといいねできない' do
        @like.user = nil
        @like.valid?
        expect(@like.errors.full_messages).to include("ユーザーを入力してください")
      end
      it 'タスクが紐付いていないといいねできない' do
        @like.task = nil
        @like.valid?
        expect(@like.errors.full_messages).to include("タスクを入力してください")
      end
      it 'コミットが紐付いていないといいねできない' do
        @like.commit = nil
        @like.valid?
        expect(@like.errors.full_messages).to include("コミットを入力してください")
      end
    end
  end
end
