require 'rails_helper'

RSpec.describe Task, type: :model do
  before do
    @task = FactoryBot.build(:task)
  end

  describe 'tasks#create' do
    it '全ての値が入力されれば保存できる' do
      expect(@task).to be_valid
    end

    it 'titleが空と保存できない' do
      @task.title = nil
      @task.valid?
      expect(@task.errors.full_messages).to include("Title can't be blank")
    end

    it 'purposeが空だと保存できない' do
      @task.purpose = nil
      @task.valid?
      expect(@task.errors.full_messages).to include("Purpose can't be blank")
    end

    it 'goalが空だと保存できない' do
      @task.goal = nil
      @task.valid?
      expect(@task.errors.full_messages).to include("Goal can't be blank")
    end

    it 'userが紐づいていないと保存できない' do
      @task.user = nil
      @task.valid?
      expect(@task.errors.full_messages).to include("User must exist")
    end
  end
end
