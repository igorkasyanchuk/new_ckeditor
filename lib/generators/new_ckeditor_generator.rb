class NewCkeditorGenerator < Rails::Generators::Base
  source_root File.expand_path("../../", __dir__)

  def init
    ['balloon', 'classic', 'inline'].each do |f|
      copy_file "app/views/new_ckeditor/shared/_#{f}.html.erb", File.join('app/views/new_ckeditor/shared/', "_#{f}.html.erb")
    end
  end

end