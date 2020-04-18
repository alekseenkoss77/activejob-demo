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
