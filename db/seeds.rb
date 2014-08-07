# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

susan = User.create(username: "Susan", password: "123456")
brad = User.create(username: "Brad", password: "123456")
mike = User.create(username: "Mike", password: "123456")

sub = Sub.create(mod_id: 1, title: "Voles", description: "VOLES!!")

post = Post.create(sub_ids: [sub.id], author_id: 2, title: "Cute vole",
                content: "Look at this vole, it's so cute")

500.times do
  Comment.create(post_id: 1, author_id: 3, content: "I LOVE VOLES.")
end