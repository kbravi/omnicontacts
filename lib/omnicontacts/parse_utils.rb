module OmniContacts
  module ParseUtils

    # return has of birthday day, month and year
    def birthday_format month, day, year
      return {:day => day.to_i, :month => month.to_i, :year => year.to_i}if year && month && day
      return {:day => day.to_i, :month => month.to_i, :year => nil} if !year && month && day
      return nil if (!year && !month) || (!year && !day)
    end

    # normalize the name
    def normalize_name name
      return nil if name.nil?
      name.chomp!
      name = name.split(' ').map(&:capitalize).join(' ')
      name.squeeze!(' ')
      name.strip!
      return name
    end

    # create a full name given the individual first and last name
    def full_name first_name, last_name
      return "#{first_name} #{last_name}" if first_name && last_name
      return "#{first_name}" if first_name && !last_name
      return "#{last_name}" if !first_name && last_name
      return nil
    end

    # create a username/name from a given email
    def email_to_name username_or_email
      username_or_email = username_or_email.split('@').first if username_or_email.include?('@')
      if group = (/(?<first>[a-z|A-Z]+)[\.|_](?<last>[a-z|A-Z]+)/).match(username_or_email)
        first_name = normalize_name(group[:first])
        last_name = normalize_name(group[:last])
        return first_name, last_name, "#{first_name} #{last_name}"
      end
      username = normalize_name(username_or_email)
      return username, nil, username
    end

  end
end
