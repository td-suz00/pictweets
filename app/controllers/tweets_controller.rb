class TweetsController < ApplicationController

  #indexアクションとshowアクション以外は先にmove_to_indexアクションの実行（定義は一番下）
  before_action :move_to_index, except: [:index, :show]

  def index
    #最新のツイートが一番上に来るように表示させる & 1ページに表示されるツイートの情報を5件にする
    #n+1問題対策として、includesメソッドを使用
    @tweets = Tweet.includes(:user).page(params[:page]).per(5).order("created_at DESC")
    #ビューにわたすテーブルはインスタンス変数
  end

  def new
  end

  def create
    #引数はtweet_paramsメソッドの返り値
    Tweet.create(image: tweet_params[:image], text: tweet_params[:text], user_id: current_user.id)
  end

  def destroy
    tweet = Tweet.find(params[:id])
    #ビューにわたす必要のないテーブルはただの変数でok
    tweet.destroy if tweet.user_id == current_user.id
  end

  def edit
    @tweet = Tweet.find(params[:id])
  end

  def update
    tweet = Tweet.find(params[:id])
    if tweet.user_id == current_user.id
      tweet.update(tweet_params)
    end
  end

  def show
    @tweet = Tweet.find(params[:id])
    @comments = @tweet.comments.includes(:user)
  end

  private
  def tweet_params
    params.permit(:image, :text)
  end

  def move_to_index
    # ログインしていなかった場合、「index」アクションを実行する
    redirect_to action: :index unless user_signed_in?
  end

end
