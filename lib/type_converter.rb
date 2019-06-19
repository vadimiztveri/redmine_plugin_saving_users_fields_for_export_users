class TypeConverter
  def self.run(user, property, type)
    value = user.send(property)

    case type
    when :date
      value&.strftime('%d.%m.%Y')
    when :boolean
      value ? 'Да' : 'Нет'
    when :status
      get_status(value)
    when :notification
      get_notification(value)
    when :type
      get_type(value)
    when :groups
      user.groups.map(&:lastname).join(', ')
    else
      user.send(property)
    end
  end

  private

  def self.get_notification(notification)
    case notification
    when "all"
      'Все'
    when "only_my_events"
      'Только предназначенные мне'
    when "none"
      'Нет'
    when "only_assigned"
      'Только о назначениях'
    else
      ''
    end
  end

  def self.get_status(status_code)
    case status_code
    when 0
      'Анонимный'
    when 1
      'Активный'
    when 1
      'Зарегистрирован'
    when 3
      'Заблокирован'
    else
      ''
    end
  end
end
