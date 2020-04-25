# frozen_string_literal: true

require_relative "config/application"
Rails.application.load_tasks

task default: :json_data

desc "generate test data"
task :test_data do
    User.destroy_all

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
                        user_id: user.id
                    )
        end
    end
end
