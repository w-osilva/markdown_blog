module ApplicationHelper
  def flash_key(key)
    case key
      when  'alert' then 'warning'
      when  'error' then 'danger'
      when 'notice' then 'success'
      else key
    end
  end
end
