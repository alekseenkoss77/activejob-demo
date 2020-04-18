require 'rails_helper'

RSpec.describe PhotosArchiveService do
  let(:category) { FactoryBot.create(:category, title: 'Test') }

  after { FileUtils.remove_dir(Rails.root.join('public', 'archives'), true) }

  describe '#new' do
    context 'when category does not exist' do
      it 'raises exception' do
        expect { described_class.new(nil) }
          .to raise_exception(ActiveRecord::RecordNotFound)
      end
    end
  end

  describe '#filename' do
    it 'returns ZIP filename as a parameterized category title' do
      service = described_class.new(category.id)
      expect(service.filename).to eq("test.zip")
    end
  end

  describe '#archive_path' do
    it 'returns path to ZIP archive in filesystem' do
      service = described_class.new(category.id)
      
      expect(service.archive_path)
        .to eq(Rails.root.join('public', 'archives', 'test.zip'))
    end
  end

  describe '#perform' do
    let!(:photo1) { FactoryBot.create(:photo, category: category) }

    it 'creates ZIP archive with photos' do
      service = described_class.new(category.id)
      service.perform
      
      Zip::File.open(service.archive_path) do |zip_file|
        expect(zip_file.entries.size).to eq(1)
        expect(zip_file.entries[0].name).to eq("#{photo1.title.parameterize}.jpg")
      end
    end
  end
end
