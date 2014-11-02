class Playlist
  include Mongoid::Document

  embeds_many :videos

  field :uri, type: String
  field :protected, type: Boolean, default: false
  field :key, type: String

  validates_uniqueness_of :uri
  validates_presence_of :uri
end
