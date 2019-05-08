require 'rails_helper'

feature 'tweet', type: :feature do
  let(:user) { create(:user) }

  scenario 'post tweet' do
    # ログイン前には投稿ボタンがないか
    visit root_path
    expect(page).to have_no_content('投稿する')


    # ログインできるか、ログイン後には投稿ボタンがあるか
    visit new_user_session_path
    # let(:user)で作成したuserのemail、idがuser_passwordのフォームにはuserのpasswordを入力
    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: user.password
    # ログインボタンをクリック
    find('input[name = "commit"]').click
    # ルートに移動したことを確かめ
    expect(current_path).to eq root_path
    # 投稿ボタンが表示されることを確認
    expect(page).to have_content("投稿する")


    # 投稿が保存されるか
    expect{
      click_link("投稿する")
      expect(current_path).to eq new_tweet_path
      fill_in 'text', with: 'https://s.eximg.jp/expub/feed/Papimami/2016/Papimami_83279/Papimami_83279_1.png'
      fill_in 'image', with: 'test' 
      find('input[type = "submit"]').click
    }.to change(Tweet, :count).by(1)
  end

end
