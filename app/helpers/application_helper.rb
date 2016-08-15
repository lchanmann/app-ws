module ApplicationHelper
  def coderay text, lang = :sql
    CodeRay.scan(text, lang).div.html_safe
  end
end
