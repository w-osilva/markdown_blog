module ApplicationHelper
  def flash_key(key)
    case key
      when 'alert' then 'warning'
      when 'error' then 'danger'
      when 'notice' then 'success'
      else key
    end
  end

  def root_url
    request.base_url
  end
end
