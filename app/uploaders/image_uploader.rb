# encoding: utf-8

class ImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  @@sizes = {
    "2000" => 2048,
    "1500" => 1500,
    "1000" => 1024,
    "500" => 512,
    "250" => 256,
    "100" => 128
  }
  storage :file
  after :remove, :delete_empty_upstream_dirs
  process convert: 'jpg'
  def store_dir
    "#{Rails.root}/system/uploads/users/#{model.user.id.to_s.downcase}/#{model.class.to_s.downcase.pluralize}/#{model.id}"
  end

  def default_url
    '/images/fallback/' + [mounted_as, version_name, 'default.png'].compact.join('_')
  end

  def crop(x,y,w,h)
    convert = MiniMagick::Tool::Convert.new do |convert|
      convert << current_path
      convert.crop "#{w}x#{h}+#{x}+#{y}"
      convert.repage.+
      convert << current_path
    end
    recreate_versions!
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

    Rail.logger.debug current_path
  end

  def resize_to_min(s)
    manipulate! do |img|
      img.resize s.to_s + 'x' + s.to_s + '^^'
    end
  end
  versions.each do |vname, v|
    @@sizes.each do |sname, s|
      name = "#{vname}_#{sname}"
      version name, from_version: vname do
        process resize_to_min: s
      end
    end
  end
  @@sizes.each do |xname,s|
    n = "p#{xname}"
    version n do
      process resize_to_min: s
    end
  end
  def extension_white_list
  end

  def filename
    'img.jpg'
  end

  def delete_empty_upstream_dirs
    path = ::File.expand_path(store_dir, root)
    Dir.delete(path) # fails if path not empty dir
    rescue SystemCallError
      true # nothing, the dir is not empty
  end
end
