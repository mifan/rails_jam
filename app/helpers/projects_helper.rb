require 'digest/md5'

module ProjectsHelper
  def project_cover(project)
    photos = project.photos
    return photos[0].attachment.url(:thumb) if photos.size > 0
    return '/images/default_thumb.jpg'
  end

  def author_avstar(email)
    "http://www.gravatar.com/avatar/#{Digest::MD5.hexdigest(email)}?s=30"
  end
end
