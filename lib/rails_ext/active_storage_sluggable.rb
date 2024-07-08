module ActiveStorage::Sluggable
  extend ActiveSupport::Concern

  included do
    before_create :set_slug
  end

  def slug_url(host: ActiveStorage::Current.host)
    Rails.application.routes.url_helpers.action_text_markdown_upload_url(slug, host: host)
  end

  private
    def set_slug
      self.slug = "#{slug_basename}-#{SecureRandom.alphanumeric(6)}.#{slug_extension}"
    end

    def slug_basename
      File.basename(slug_filename, ".*").parameterize
    end

    def slug_extension
      File.extname(slug_filename).delete(".").parameterize
    end

    def slug_filename
      slug.presence || filename.to_s
    end
end

ActiveSupport.on_load :active_storage_attachment do
  ActiveStorage::Attachment.include ActiveStorage::Sluggable
end
