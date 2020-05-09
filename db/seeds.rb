# frozen_string_literal: true

author_books = {
  "mh-mobile": [
    {
      title: "リファクタリング:Rubyエディション",
      author: "ジェイ・フィールド",
      memo: "リファクタリングを学ぶ良書"
    },
    {
      title: "メタプログラミングRuby",
      author: "Paolo Perrotta",
      memo: "メタプログラミングの良書"
    }
  ],
  "hiro": [
    {
      title: "Effective Ruby",
      author: "Peter J.Jones",
      memo: "Ruby中級者向け"
    },
    {
      title: "RubyでつくるRuby ゼロから学びなおすプログラミング言語入門",
      author: "遠藤 侑介",
      memo: "言語の自作を学ぶのに良いかも",
    }
  ],
  "hanako": [
    {
      title: "エリック・エヴァンスのドメイン駆動設計",
      author: "Eric Evans",
      memo: "良い設計を行うために読みたい"
    }
  ],
  "taro": [
    {
      title: "現場で使える Ruby on Rails 5速習実践ガイド",
      author: "大場 寧子",
      memo: "現場で使える知識を身に付けるのに良い"
    }
  ]
}

author_reports = {
  "mh-mobile": [
    {
      title: "gitを勉強しました",
      learning_date: "2020-05-09",
      description: "git pushしてGithubにプッシュできました"
    },
    {
      title: "nginxが難しい",
      learning_date: "2020-05-10",
      description: "nginxが起動できました。"
    }
  ],
  "hiro": [
    {
      title: "Rails入門",
      learning_date: "2020-05-08",
      description: "Railsのscaffoldを使いました"
    },
    {
      title: "Railsでメモアプリ作成",
      learning_date: "2020-05-09",
      description: "CRUDの簡易アプリを作りました",
    }
  ],
  "hanako": [
    {
      title: "自作サービスの作成#1",
      learning_date: "2020-05-11",
      description: "サービス案を検討しました。"
    }
  ],
  "taro": [
    {
      title: "npmパッケージの作成",
      learning_date: "2020-05-13",
      description: "オリジナルのnpmパッケージを公開しました"
    }
  ]
}

author_books.keys.each do |username|
  password = "QjT7QeyjUDUYz2Fy"
  user = User.new(
    username: "#{username}",
    email: "#{username}@example.com",
    password: password,
    password_confirmation: password,
    uid: User.create_unique_string
    )
  user.save!
  author_books[username].each do |book_data|
    Book.create!(title: book_data[:title],
                author: book_data[:author],
                memo: book_data[:memo],
                user_id: user.id)
  end
end

author_reports.keys.each do |username|
  user = User.find_by(username: username)
  author_reports[username].each do |report_data|
    Report.create!(title: report_data[:title],
                learning_date: report_data[:learning_date],
                description: report_data[:description],
                user_id: user.id)
  end
end

# コメント作成
hiro_comment = "はじめまして"
hanako_comment = "すばらしいです"
mh_comment = "ありがとうございます！"

hiro = User.find_by(username: "hiro")
hanako = User.find_by(username: "hanako")
mh = User.find_by(username: "mh-mobile")

comment_datas = [
  {
    user_id: hiro.id,
    comment: hiro_comment
  },
  {
    user_id: hanako.id,
    comment: hanako_comment
  },
  {
    user_id: mh.id,
    comment: mh_comment
  }
]

mh_books = mh.books
mh_reports = mh.reports

mh_books.each do |book|
  comment_datas.each do |data|
    comment = Comment.new(
      content: "#{data[:comment]}[to:book/#{book.id}]",
      user_id: data[:user_id],
      commentable_type: "Book",
      commentable_id: book.id
    )
    comment.save!
  end
end

mh_reports.each do |report|
  comment_datas.each do |data|
    comment = Comment.new(
      content: "#{data[:comment]}[to:report/#{report.id}]",
      user_id: data[:user_id],
      commentable_type: "Report",
      commentable_id: report.id
    )
    comment.save!
  end
end
