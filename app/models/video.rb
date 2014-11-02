class Video
  include Mongoid::Document

  embedded_in :playlist

  field :vid, type: String
  field :title, type: String
  field :thumbnail, type: String
  field :duration, type: Integer

  validates_uniqueness_of :vid
  validates_presence_of :vid, :title, :thumbnail, :duration
end
