ActiveSupport::Notifications.subscribe("user.created") do |name, start, finish, id, payload|
    puts "User #{payload[:id]} saved with username #{payload[:username]}"
  end