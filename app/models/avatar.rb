class Avatar
  include ActiveModel::Model
  URL_STUB = "/images/avatars"
  DIRECTORY = File.join("public", "images", "avatars")
  IMG_SIZE = '"240x300>"'
  THUMB_SIZE = '"50x64>"'
  def initialize(user, image = nil)
    @user = user
    @image = image
    Dir.mkdir(DIRECTORY) unless File.directory?(DIRECTORY)
  end
  def exists?
    File.exists? (File.join(DIRECTORY, filename))
  end
  alias exist? exists?
  def url
    "#{URL_STUB}/#{filename}"
  end
  def thumbnail_url
    "#{URL_STUB}/#{thumbnail_name}"
  end
  def filename
    "#{@user.screen_name}.png"
  end
  def thumbnail_name
    "#{@user.screen_name}_thumbnail.png"
  end
  def convert
    if ENV["OS"] =~ /Windows/
      "magick convert"
    else
      "/usr/bin/convert"
    end
  end
  def save
    valid_file? and successful_conversion?
  end
  def valid_file?
   if @image.size.zero?
     errors.add_to_base("Please enter an image filename")
     return false
   end
   unless @image.content_type =~ /^image/
     errors.add(:image, "is not a recognized format")
     return false
   end
   if @image.size > 1.megabyte
     errors.add(:image, "can't be bigger than 1 megabyte")
     return false
   end
   return true
 end
 def delete
  [filename, thumbnail_name].each do |name|
  image = "#{DIRECTORY}/#{name}"
  File.delete(image) if File.exists?(image)
  end
end
  def successful_conversion?
    source = File.join("tmp", "#{@user.screen_name}_full_size")
    full_size = File.join(DIRECTORY, filename)
    thumbnail = File.join(DIRECTORY, thumbnail_name)
    File.open(source, "wb") { |f| f.write(@image.read) }
    img = system("#{convert} #{source} -resize #{IMG_SIZE} #{full_size}")
    thumb = system("#{convert} #{source} -resize #{THUMB_SIZE} #{thumbnail}")
    File.delete(source) if File.exists?(source)
    unless img and thumb
      errors[:base]<<"File upload failed: Try a different image"
      return false
    end
    return true
  end
end
