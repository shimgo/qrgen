require 'rqrcode'
require 'rqrcode_png'
require 'csv'
require 'fileutils'

PNG_SIZE    = 200
QR_SIZE     = 3 # 1..40
LEVEL       = :h # l, m, q, h
OUTPUT_BASE = "output"

file_path = ARGV[0]
input_base_name = File.basename(file_path, ".csv")
FileUtils.rm_rf(File.join(OUTPUT_BASE, input_base_name))
Dir.mkdir(File.join(OUTPUT_BASE, input_base_name))

def saveQR(content, input_base_name = "")
  qr = RQRCode::QRCode.new(content, size: QR_SIZE, level: LEVEL)
  png = qr.to_img
  png.resize(PNG_SIZE, PNG_SIZE).save(File.join(OUTPUT_BASE, input_base_name, "#{content}.png"))
end

CSV.foreach(file_path) do |row|
  saveQR(row.first, input_base_name)
end
