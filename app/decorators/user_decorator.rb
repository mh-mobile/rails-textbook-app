# frozen_string_literal: true

module UserDecorator
  PROFILE_ICON_CLASS_NAME = "profile_icon"

  # プロフィールアイコンを表示する
  # アイコンが存在しない場合は、デフォルトのアイコンを表示する
  def profile_icon_tag
    if profile_icon.attached?
      image_tag profile_icon, class: PROFILE_ICON_CLASS_NAME
    else
      image_tag asset_path("person_noimage.png"), class: PROFILE_ICON_CLASS_NAME
    end
  end

  # フォロー用のタグを生成する。
  # 既にフォロー済みのボタンは、フォロー解除のリクエストを発行するFollowingボタンを表示する。
  # フォローしていない場合は、フォローのリクエストを発行するFollowボタンを表示する。
  def follow_tag(user)
    if following?(user)
      title = "Following"
      path = unfollow_user_path(username: user.username)
      class_names = ["button", "is-link", "is-active"]
      method = :delete
    else
      title = "Follow"
      path = follow_user_path(username: user.username)
      class_names = ["button", "is-light"]
      method = :post
    end

    # フォロー・アンフォローにリンク生成
    link_to(title, path, method: method, remote: true, class: class_names)
  end
end
