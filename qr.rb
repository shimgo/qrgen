require 'rqrcode'
require 'rqrcode_png'
require 'csv'
require 'fileutils'
require 'barby/barcode/code_128'
require 'barby/barcode/codabar'
require 'barby/outputter/png_outputter'
require 'rghost'
require 'rghost_barcode'

PNG_SIZE    = 200
QR_SIZE     = 3 # 1..40
LEVEL       = :h # l, m, q, h
OUTPUT_BASE = "output"

file_path = ARGV[0]
type = ARGV[1]
input_base_name = File.basename(file_path, ".csv")
FileUtils.rm_rf(File.join(OUTPUT_BASE, input_base_name))
Dir.mkdir(File.join(OUTPUT_BASE, input_base_name))

def saveQR(content, input_base_name = "")
  qr = RQRCode::QRCode.new(content, size: QR_SIZE, level: LEVEL)
  png = qr.to_img
  png.resize(PNG_SIZE, PNG_SIZE).save(File.join(OUTPUT_BASE, input_base_name, "#{content}.png"))
end

def savecCode128(content, input_base_name = "")
  barcode = Barby::Code128B.new(content)
  File.open(File.join(OUTPUT_BASE, input_base_name, "#{content}.png"), 'wb'){|f| f.write barcode.to_png(:height => 25, :margin => 2, dim: 5) }

end

def saveCodabar(content, input_base_name = "")
  barcode = Barby::Codabar.new("B#{content}D")
  File.open(File.join(OUTPUT_BASE, input_base_name, "#{content}.png"), 'wb'){|f| f.write barcode.to_png(:height => 25, :margin => 2, dim: 5) }
end

CSV.foreach(file_path) do |row|
  case type
  when "qr" then
    saveQR(row.first, input_base_name)
  when "codabar" then
    saveCodabar(row.first, input_base_name)
  when "code128" then
    savecCode128(row.first, input_base_name)
  end
end
