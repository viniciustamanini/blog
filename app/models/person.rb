class Person < ApplicationRecord
  has_many :educations, dependent: :destroy
  has_many :certificates, dependent: :destroy
  has_many :professional_experiences, dependent: :destroy
  has_many :skills, dependent: :destroy

  accepts_nested_attributes_for :educations, :certificates, :professional_experiences, :skills, allow_destroy: true

  scope :sorted, -> { order(arel_table[:id]) }
end
