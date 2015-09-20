# encoding: utf-8

class ImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  @@sizes = {
    '2000' => 2048,
    '1500' => 1500,
    '1000' => 1024,
    '500' => 512,
    '250' => 256,
    '100' => 128
  }

  storage :file

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def default_url
    '/images/fallback/' + [mounted_as, version_name, 'default.png'].compact.join('_')
  end

  version :square do
    process :make_square
  end

  def make_square
    manipulate! do |img|
      size = img.dimensions.min
      img.combine_options do |i|
        i.gravity "Center"
        i.crop "#{size}x#{size}+0+0"
      end
    end
  end

  def resize_to_min(s)
    manipulate! do |img|
      img.resize s.to_s + 'x' + s.to_s + '^^'
    end
  end
  versions.each do |vname, _v|
    @@sizes.each do |sname, s|
      name = "#{vname}_#{sname}"
      version name, from_version: vname do
        process resize_to_min: s
      end
    end
  end

  def extension_white_list
  end

  def filename
    'avatar.jpg' if original_filename
  end
end
