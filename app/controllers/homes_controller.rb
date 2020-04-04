# frozen_string_literal: true

class HomesController < ApplicationController
  # ログイン前のホーム画面のため認証をスキップ
  skip_before_action :authenticate_user!

  def index
  end
end
