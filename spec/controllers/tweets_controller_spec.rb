require 'rails_helper'

describe TweetsController do
  describe 'GET #new' do
    it "renders the :new template" do
# 擬似的にnewアクションを動かすリクエストを行うコード
      get :new
# メソッド(引数).to 返り値
# responseとは、example内でリクエストが行われた後の遷移先のビューの情報を持つインスタンス
      expect(response).to render_template :new
    end
  end

  describe 'GET #edit' do
    it "assigns the requested tweet to @tweet" do
# tweetをデータベースに保存
      tweet = create(:tweet)]

# httpメソッドはget
# idというキーのバリューに先ほど作成したインスタンスのidをセットすること
      get :edit, params: { id: tweet }
      expect(assigns(:tweet)).to eq tweet
    end

    it "renders the :edit template" do
      tweet = create(:tweet)
      get :edit, params: { id: tweet }
      expect(response).to render_template :edit
    end
  end

  describe 'GET #index' do
    it "populates an array of tweets ordered by created_at DESC" do
      tweets = create_list(:tweet, 3)
      get :index
      expect(assigns(:tweets)).to match(tweets.sort{ |a, b| b.created_at <=> a.created_at } )
    end

    it "renders the :index template" do
      get :index
      expect(response).to render_template :index
    end
  end

end

#解説
#newアクションの時と同様、リクエストした後にexpectメソッドにresponseを渡し、render_templateマッチャを利用すれば良いでしょう。しかし、今回はリクエストの際にidの値が必要です。そのために、15行目でデータベースにレコードを作成しています。
#また、16行目のようにparams: { id: tweet }とすることで、データベースに作成されたレコードのid番号をidキーに対してのバリューとしてセットすることができます。
