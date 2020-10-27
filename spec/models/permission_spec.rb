require 'rails_helper'

RSpec.describe Permission, type: :model do
  before do
    @permission = FactoryBot.build(:permission)
  end

  describe "permissions#create" do
    it 'userとtaskがどちらも紐付いていれば保存できる' do
      expect(@permission).to be_valid
    end

    it 'userが紐付いていないと保存できない' do
      @permission.user = nil
      @permission.valid?
      expect(@permission.errors.full_messages).to include("User must exist")
    end

    it 'taskが紐付いていないと保存できない' do
      @permission.task = nil
      @permission.valid?
      expect(@permission.errors.full_messages).to include("Task must exist")
    end

    it 'user_idおよびtask_idが重複していると保存できない' do
      @permission.save
      another_permission = FactoryBot.build(:permission)
      another_permission.user_id = @permission.user_id
      another_permission.task_id = @permission.task_id
      another_permission.valid?
      expect(another_permission.errors.full_messages).to include("User has already been taken")
    end
  end
end
