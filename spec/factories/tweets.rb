FactoryBot.define do
  factory :tweet do
    text {"hello!"}
    image {"hoge.png"}
# tweetのリソースひとつひとつのcreated_atはランダムに生成
    created_at { Faker::Time.between(2.days.ago, Time.now, :all) }
    user
  end
end
