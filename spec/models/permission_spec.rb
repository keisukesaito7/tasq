require 'rails_helper'

RSpec.describe Permission, type: :model do
  before do
    @permission = FactoryBot.build(:permission)
  end

  describe '許可証の発行' do
    context '許可証の発行がうまくいくとき' do
      it 'userとtaskがどちらも紐付いていれば保存できる' do
        expect(@permission).to be_valid
      end
    end

    context '許可証の発行がうまくいかないとき' do
      it 'userが紐付いていないと保存できない' do
        @permission.user = nil
        @permission.valid?
        expect(@permission.errors.full_messages).to include('ユーザーを入力してください')
      end
      it 'taskが紐付いていないと保存できない' do
        @permission.task = nil
        @permission.valid?
        expect(@permission.errors.full_messages).to include('タスクを入力してください')
      end
      it 'user_idおよびtask_idが重複していると保存できない' do
        @permission.save
        another_permission = FactoryBot.build(:permission)
        another_permission.user_id = @permission.user_id
        another_permission.task_id = @permission.task_id
        another_permission.valid?
        expect(another_permission.errors.full_messages).to include('ユーザーは既に許可されています')
      end
    end
  end
end
