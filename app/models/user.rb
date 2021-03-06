# frozen_string_literal: true

require "open-uri"

class User < ApplicationRecord
  # ユーザー名の正規表現
  NAME_REGEX = /\A([a-z\d]+-)*[a-z\d]+\Z/.freeze

  # 郵便番号の正規表現
  POSTCODE_REGEX = /\A\d{3}-\d{4}\Z/.freeze

  devise :database_authenticatable, :registerable, :validatable, :omniauthable, omniauth_providers: %i[github], authentication_keys: [:login]

  # 郵便番号XXX-YYYYに対して以下の値を格納
  # XXXをforward_postcodeに設定
  # YYYをbackward_postcodeに設定
  attr_writer :forward_postcode, :backward_postcode

  # ユーザー名、メールアドレスどちらでもログインできるようにする
  attr_accessor :login

  # 郵便番号のバリデーション
  # 入力値がある場合のみバリデーションを行う
  validates :postcode, format: { with: POSTCODE_REGEX }, if: :postcode_present?

  # ユーザー名のバリデーション
  # 英数字とハイフンのみを許可する。ハイフンは先頭と最後に使用することができない。また、連続したハイフンも使用できない。
  # 文字数は3文字以上、30文字以内とする
  validates :username, uniqueness: { case_sensitive: false }, format: { with: NAME_REGEX }, length: { minimum: 3, maximum: 30 }

  # バリデーション前に郵便番号を設定
  before_validation :set_postcode

  # プロフィールアイコン
  has_one_attached :profile_icon

  # ユーザーが投稿した書籍一覧
  has_many :books, dependent: :destroy

  # ユーザーが投稿した日報一覧
  has_many :reports, dependent: :destroy

  # ユーザーが投稿したコメント一覧
  has_many :comments, dependent: :destroy

  has_many :friendships, foreign_key: "follower_id"
  has_many :reverse_friendships, class_name: "Friendship", foreign_key: "followed_id"
  has_many :following, through: :friendships, source: :followed, class_name: "User"
  has_many :followers, through: :reverse_friendships, class_name: "User"

  # 郵便番号の前方部分の値
  def forward_postcode
    @forward_postcode ||= postcode.present? ? postcode.split("-").first : nil
  end

  # 郵便番号の後方部分の値
  def backward_postcode
    @backward_postcode ||= postcode.present? ? postcode.split("-").last : nil
  end

  # ユーザー名かメールアドレスでユーザーを検索する。
  # ref. https://github.com/heartcombo/devise/wiki/How-To:-Allow-users-to-sign-in-using-their-username-or-email-address
  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["username = :value OR lower(email) = lower(:value)", { value: login }]).first
    else
      where(conditions).first
    end
  end

  def self.find_for_github_oauth(auth)
    user = User.where(provider: auth.provider, uid: auth.uid).first
    unless user
      user = User.new(
        username: auth.info.nickname,
        uid: auth.uid,
        provider: auth.provider,
        email: auth.info.email,
        password: Devise.friendly_token[0, 20]
      )

      user.profile_icon.attach(io: github_profile_icon(auth.info.image), filename: "github_profile_icon")
      user.save
    end
    user
  end

  def self.create_unique_string
    SecureRandom.uuid
  end

  def self.create_unique_email
    create_unique_string + "@example.com"
  end

  # GitHubの認証情報にプロフィールアイコンが設定済みの場合は、そのアイコンをプロフィールアイコンに設定
  # 存在しない場合は、デフォルトアイコンをプロフィールアイコンに設定
  def self.github_profile_icon(profile_image_url)
    if profile_image_url.present?
      open(profile_image_url)
    else
      File.open("app/assets/images/person_noimage.png")
    end
  end

  def follow!(user)
    following << user
  end

  def unfollow!(user)
    friendships.find_by!(followed_id: user.id).destroy
  end

  def following?(user)
    following.include?(user)
  end

  def can_follow_action?(name, user)
    return true if name == :follow! && !current_user.following?(user)
    name == :unfollow! && current_user.following?(user)
  end

  private
    # 郵便番号を設定
    def set_postcode
      # フォームデータから郵便番号を組み立てる
      self.postcode = (forward_postcode.blank? && backward_postcode.blank?) ? nil : "#{forward_postcode}-#{backward_postcode}"
    end

    # 郵便番号が設定されているか
    def postcode_present?
      postcode.present?
    end


    private_class_method :github_profile_icon
end
