require './lib/notify'

notify = Notify.new(ENV['TOKEN'])

if ARGV[0] == 'clear'
  File.exists?("/buddy/notify/chat_id") ? File.delete("/buddy/notify/chat_id") : nil
else
  chat_id = File.exists?("/buddy/notify/chat_id") ? File.read("/buddy/notify/chat_id") : nil
  puts "Chat ID: #{chat_id}"
  chat = notify.notify(ARGV[0], chat_id: chat_id)

  File.open("/buddy/notify/chat_id", "w") { |file| file.puts chat.ts }
end
