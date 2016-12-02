require 'pg'
require 'securerandom'
require 'date'

class Message

  def self.create(text)
    # SecureRandom.urlsafe_base64 works more than a second. What's this?!!!
    link = SecureRandom.urlsafe_base64
    connection.exec('INSERT INTO messages (safe_link, text, max_count, max_date) VALUES ($1, $2, $3, $4)',
                    [link, text, 1, '9999-12-31 00:00:00'])

    find_by_link link
  end

  def self.find_by_link(link)
    connection.exec('SELECT * FROM messages WHERE safe_link = $1', [link]).first
  end

  def self.delete_by_link(link)
    connection.exec('DELETE FROM messages WHERE safe_link = $1', [link])
  end

  private
  def self.connection
    @connection ||= PG.connect(host: 'localhost', port: 5432, dbname: 'messages_development', user: 'Messages', password: 'messages')
  end
end