namespace :playlists do
  desc 'Shuffle all the playlists'
  task shuffle_all: :environment do
    Playlist.shuffle_all
  end
end
