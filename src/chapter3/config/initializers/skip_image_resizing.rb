# rails tutorial リスト 13.68 テストでエラーなしだったがチュートリアル通りにファイル設置
if Rails.env.test?
  CarrierWave.configure do |config|
    config.enable_processing = false
  end
end
