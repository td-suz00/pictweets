# Rails.application.routes.draw do
#   devise_for :users
#   root   'tweets#index'                         #ルートパスにアクセスした際にツイート一覧画面へ
#   get    'tweets'           => 'tweets#index'   #ツイート一覧画面
#   get    'tweets/new'       => 'tweets#new'     #ツイート投稿画面
#   post   'tweets'           => 'tweets#create'  #ツイート投稿機能
#   delete 'tweets/:id'       => 'tweets#destroy' #ツイート削除機能
#   patch  'tweets/:id'       => 'tweets#update'  #ツイート更新機能
#   get    'tweets/:id/edit'  => 'tweets#edit'    #ツイート編集機能
#   get    'users/:id'        => 'users#show'     #Mypageへのルーティング
#   get    'tweets/:id'       => 'tweets#show'    #ツイート詳細画面へのルーティング
# end

Rails.application.routes.draw do
  devise_for :users
  root   'tweets#index'                 #ルートパスにアクセスした際にツイート一覧画面へ
  resources :tweets do #tweetsコントローラに対してのresourcesメソッド（基本７アクションのルーティング）
    resources :comments, only: [:create]
  end
  resources :users, only: [:show]       #usersコントローラに対してのresourcesメソッド
end
