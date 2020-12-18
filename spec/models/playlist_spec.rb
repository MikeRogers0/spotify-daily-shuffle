require 'rails_helper'

RSpec.describe Playlist, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
  let(:instance) { described_class.new }
  let(:playlist_api) { double :playlist_api }

  describe '#track_uris' do
    subject { instance.track_uris }

    let(:all_tracks) do
      {
        'items' => [
          {
            'track' => {
              'id' => '1M2zeYn9S4zorVjz05oZw1',
              'uri' => 'spotify:track:1M2zeYn9S4zorVjz05oZw1'
            }
          },
          { 'track' => nil }
        ],
        'total' => 2
      }
    end

    before do
      allow(instance).to receive(:playlist_api).and_return(playlist_api)
      allow(playlist_api).to receive(:all_tracks).and_return(all_tracks)
    end

    it { is_expected.to eq(['spotify:track:1M2zeYn9S4zorVjz05oZw1']) }
  end
end
