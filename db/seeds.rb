User.create!(email: "hoge1@hoge.com",
             password:              "aaaa1111",
             password_confirmation: "aaaa1111")

5.times do |n|
  email = "hoge#{n+2}@hoge.com"
  User.create!(email: email,
               password:              "aaaa1111",
               password_confirmation: "aaaa1111")
end

Product.create!(name: "atom",
                content: "最高かよ",
                user_id: 1)

Product.create!(name: "slack",
                content: "慣れると使いやすい",
                user_id: 2)

AdminUser.create!(email: 'hoge1@hoge.com', password: 'aaaa1111', password_confirmation: 'aaaa1111')
