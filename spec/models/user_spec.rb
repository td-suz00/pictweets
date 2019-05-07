require 'rails_helper'
describe User do
  describe '#create' do
    # nicknameとemail、passwordとpassword_confirmationが存在すれば登録できること
    it "is valid with a nickname,email,password,password_confirmation" do
      user = build(:user)
      expect(user).to be_valid
    end

    # nicknameが空では登録できないこと
    it "is invalid without a nickname" do
      user = build(:user, nickname: nil)
      user.valid?
      expect(user.errors[:nickname]).to include("can't be blank")
    end

    # emailが空では登録できないこと
    it "is invalid without a email" do
      user = build(:user, email: nil)
      user.valid?
      expect(user.errors[:email]).to include("can't be blank")
    end

    # passwordが空では登録できないこと
    it "is invalid without a password" do
      user = build(:user, password: nil)
      user.valid?
      expect(user.errors[:password]).to include("can't be blank")
    end

    # passwordが存在してもpassword_confirmationが空では登録できないこと
    it "is invalid without password_confirmation although with a password" do
      user = build(:user, password_confirmation: "")
      user.valid?
      binding.pry
      expect(user.errors[:password_confirmation]).to include("doesn't match Password")
    end

    # nicknameが7文字以上であれば登録できないこと
    it "is invalid with over 7letters nickname" do
      user = build(:user, nickname: "hogehog")
      user.valid?
      expect(user.errors[:nickname][0]).to include("is too long")exit
    end

    # nicknameが6文字以下では登録できること
    it "is valid within under 6letters nickname" do
      user = build(:user, nickname: "hogeho")
      expect(user).to be_valid
    end

    # 重複したemailが存在する場合登録できないこと
    it "is invalid with a duplicate email address" do 
      # はじめにユーザーを登録
      user = create(:user)
      # 同じemailの値をもつユーザーのインスタンスを生成
      another_user = build(:user, email: user.email)
      another_user.valid?
      expect(another_user.errors[:email]).to include("has already been taken")
    end

    # passwordが6文字以上であれば登録できること
    it "is valid within over 6letters password" do
      user = build(:user, password: "123456", password_confirmation: "123456")
      expect(user).to be_valid
    end

    # passwordが5文字以下であれば登録できないこと
    it "is invalid with under 5letters password" do
      user = build(:user, password: "12345")
      user.valid?
      expect(user.errors[:password][0]).to include("is too short")
    end

  end
end
