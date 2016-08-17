module ApplicationHelper
  def coderay text, lang = :sql
    sanitize CodeRay.scan(text, lang).div, tags: %w(div span pre)
  end
end
