# rails_helper.rb内の記述を読み込むことで共通の設定を有効
require 'rails_helper'
# describeは、直後のdo ~ endまでのテストのまとまり

# -----------------------------------------------------------------------

# 1.nicknameとemail、passwordとpassword_confirmationが存在すれば登録できること
# 2.nicknameが空では登録できないこと

# -----------------------------------------------------------------------

describe User do
  describe '#create' do
# 2行目のitはexampleと呼ばれる実際に動作するテストコードのまとまり(""の中にはそのexampleの説明)
    it "is invalid without a nickname" do
# テストしたいプロパティを持ったuserクラスのインスタンスを新規作成する
      user = build(:user, nickname: nil)
# 作成したインスタンスがバリデーションによって保存ができない状態かチェックする
      user.valid?
# nicknameが空の場合はcan't be blankというエラーが出る
      expect(user.errors[:nickname]).to include("can't be blank")
    end

# -----------------------------------------------------------------------

# 3.emailが空では登録できないこと

# -----------------------------------------------------------------------

    it "is invalid without a nickname" do
      user = build(:user, email: nil)
      user.valid?
      expect(user.errors[:email]).to include("can't be blank")
    end

# -----------------------------------------------------------------------

# 4.passwordが空では登録できないこと

# -----------------------------------------------------------------------

    it "is invalid without a password" do
      user = build(:user, password: nil)
      user.valid?
      expect(user.errors[:password]).to include("can't be blank")
    end

# -----------------------------------------------------------------------

# 5.passwordが存在してもpassword_confirmationが空では登録できないこと

# -----------------------------------------------------------------------

    it "is invalid without a password_confirmation although with a password" do
      user = build(:user, password_confirmation: "")
      user.valid?
      expect(user.errors[:password_confirmation]).to include("doesn't match Password")
    end

# -----------------------------------------------------------------------

# 8.重複したemailが存在する場合登録できないこと

# -----------------------------------------------------------------------

    it "is invalid with a duplicate email address" do
      user = create(:user)
      another_user = build(:user, email: user.email)
      another_user.valid?
      expect(another_user.errors[:email]).to include("has already been taken")
    end

# -----------------------------------------------------------------------

# 6.nicknameが7文字以上であれば登録できないこと

# -----------------------------------------------------------------------

    it "is invalid with a nickname that has more than 7 characters " do
      user = build(:user, nickname: "aaaaaaaa")
      user.valid?
      expect(user.errors[:nickname][0]).to include("is too long")
    end

# -----------------------------------------------------------------------

# 7.nicknameが6文字以下では登録できること

# -----------------------------------------------------------------------

    it "is valid with a nickname that has less than 6 characters " do
      user = build(:user, nickname: "aaaaaa")
      expect(user).to be_valid
    end

# -----------------------------------------------------------------------

# 9.passwordが6文字以上であれば登録できること
# 10.passwordが5文字以下であれば登録できないこと

# -----------------------------------------------------------------------

    it "is invalid with a password that has less than 5 characters " do
      user = build(:user, password: "00000", password_confirmation: "00000")
      user.valid?
      expect(user.errors[:password][0]).to include("is too short")
    end

  end
end
