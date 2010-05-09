module ProjectsHelper
  def project_cover(project)
    photos = project.photos
    return photos[0].attachment.url(:thumb) if photos.size > 0
    return '/images/default_thumb.jpg'
  end
end
