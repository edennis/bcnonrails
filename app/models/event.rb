#require "geocodable"
class Event < ActiveRecord::Base
  geocoded_by :location, :latitude  => :lat, :longitude => :lng

  validates_presence_of :date, :title, :location

  scope :next, :order => 'date desc'

  after_validation :geocode, :if => :location_changed?
  after_create :deliver_event_to_bcnonrails!


  def deliver_event_to_bcnonrails!
    Notifier.event_to_bcnonrails(self).deliver
  end
end

