# frozen_string_literal: true

# ルーティングのユーザー名の正規表現
ROUTING_USERNAME = /([a-z\d]+-)*[a-z\d]+/

# ユーザーモデルのユーザー名の正規表現
USERMODEL_USERNAME_REGEX = /\A([a-z\d]+-)*[a-z\d]+\Z/

# ユーザーモデルの郵便番号の正規表現
USERMODEL_POSTCODE_REGEX = /\A\d{3}-\d{4}\Z/
