namespace :users do
  desc "Remove users who we can't get access to"
  task clear_expired: :environment do
    User.all.find_each do |user|
      user.refesh_spotify_token!

      if user.spotify_token_expired?
        puts "Removing: #{user}"
        user.destroy!
      end
    end
  end
end
