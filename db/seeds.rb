%w(
  Food & Drinks
  Cinema
  Travel
  Games
  Cars
).each { |item| Category.create!(title: item) } unless Category.any?

category = Category.find_by(title: 'Travel')

Dir.foreach(Rails.root.join("tmp", "images")) do |filename|
  next if File.directory?(filename)

  Photo.transaction do
    record = category.photos.create!(
      title: Faker::Movies::StarWars.wookiee_sentence,
      author: Faker::Movies::StarWars.character
    )

    record.file.attach(
      io: File.open(Rails.root.join("tmp", "images", filename)),
      filename: filename
    )
  end
end

unless VisitorStat.any?
  items = []

  300_000.times do |idx|
    items << [
      Faker::Internet.ip_v4_address,
      Faker::Address.city,
      Faker::Address.country,
      Faker::Internet.user_agent,
      rand(5...100),
      rand(60..40000),
      Time.now,
      Time.now
    ]

    if (idx > 0 && idx % 1000 == 0)
      values = items.map do |item|
        item = item.map { |i| i.is_a?(Integer) ? i : ActiveRecord::Base.connection.quote(i) }.join(",")
        "(#{ item })"
      end

      sql = "INSERT INTO #{VisitorStat.table_name} (ip_address, city, country, user_agent, visits, time_spent, created_at, updated_at) VALUES #{values.join(', ')}"

      res = ActiveRecord::Base.connection.execute(sql)
      items = []

      p "Inserted #{res}"
    end
  end
end
