require 'rails_helper'

RSpec.describe Commit, type: :model do
  before do
    @commit = FactoryBot.build(:commit)
  end

  describe 'commit#create' do
    it '全ての値が入力されると保存できる' do
      expect(@commit).to be_valid
    end

    it 'contentが空だと保存できない' do
      @commit.content = nil
      @commit.valid?
      expect(@commit.errors.full_messages).to include("Content can't be blank")
    end

    it 'userが紐付いていないと保存できない' do
      @commit.user = nil
      @commit.valid?
      expect(@commit.errors.full_messages).to include("User must exist")
    end

    it 'taskが紐付いていないと保存できない' do
      @commit.task = nil
      @commit.valid?
      expect(@commit.errors.full_messages).to include("Task must exist")
    end
  end
end
