require 'rails_helper'

RSpec.describe Task, type: :model do
  before do
    @task = FactoryBot.build(:task)
  end

  describe 'タスク新規投稿' do
    context '新規投稿がうまくいくとき' do
      it '全ての値が入力されれば保存できる' do
        expect(@task).to be_valid
      end
    end

    context '新規投稿がうまくいかないとき' do      
      it 'titleが空と保存できない' do
        @task.title = nil
        @task.valid?
        expect(@task.errors.full_messages).to include("タイトルを入力してください")
      end
      it 'purposeが空だと保存できない' do
        @task.purpose = nil
        @task.valid?
        expect(@task.errors.full_messages).to include("目的を入力してください")
      end
      it 'goalが空だと保存できない' do
        @task.goal = nil
        @task.valid?
        expect(@task.errors.full_messages).to include("ゴールを入力してください")
      end
      it 'userが紐づいていないと保存できない' do
        @task.user = nil
        @task.valid?
        expect(@task.errors.full_messages).to include('ユーザーを入力してください')
      end
    end
  end
end
