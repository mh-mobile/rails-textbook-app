# frozen_string_literal: true

module UserDecorator
  PROFILE_ICON_CLASS_NAME = "profile_icon"

  # プロフィールアイコンを表示する
  # アイコンが存在しない場合は、デフォルトのアイコンを表示する
  def profile_icon_tag
    if profile_icon.attached?
      image_tag profile_icon, class: PROFILE_ICON_CLASS_NAME
    else
      image_tag "/assets/person_noimage.png", class: PROFILE_ICON_CLASS_NAME
    end
  end
end
