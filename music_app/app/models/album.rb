# == Schema Information
#
# Table name: albums
#
#  id         :integer          not null, primary key
#  band_id    :integer          not null
#  title      :string           not null
#  year       :integer          not null
#  album_type :string           default("Live"), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Album < ApplicationRecord
    validates :title, :year, :album_type, presence: true
    validates :album_type, inclusion: { in: %w(Live Studio), message: "needs to be either Live or Studio" }

    belongs_to :band
end
