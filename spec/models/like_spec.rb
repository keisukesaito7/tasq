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
  end
end
