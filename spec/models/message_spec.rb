require 'rails_helper'

RSpec.describe Message, type: :model do
  before do
    @message = FactoryBot.build(:message)
  end

  describe 'messages#create' do
    it '全ての値が入力されると保存できる' do
      expect(@message).to be_valid
    end

    it 'textが空だと保存できない' do
      @message.text = nil
      @message.valid?
      expect(@message.errors.full_messages).to include("Text can't be blank")
    end

    it 'userが紐付いていないと保存できない' do
      @message.user = nil
      @message.valid?
      expect(@message.errors.full_messages).to include('User must exist')
    end

    it 'taskが紐付いていないと保存できない' do
      @message.task = nil
      @message.valid?
      expect(@message.errors.full_messages).to include('Task must exist')
    end
  end
end
